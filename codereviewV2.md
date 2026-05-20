# Code Review Report — Pooch Flutter Native

**Date:** 2026-05-15 | **Reviewer:** GitHub Copilot (Claude Sonnet 4.6)

---

## Executive Summary

| Severity    | Count  |
| ----------- | ------ |
| 🔴 CRITICAL | 2      |
| 🟠 HIGH     | 11     |
| 🟡 MEDIUM   | 16     |
| 🟢 LOW      | 4      |
| **Total**   | **33** |

### Top 3 Most Critical Issues

1. **`pubspec.yaml` line 119** — `.env` file declared as a Flutter asset, bundling all API keys and secrets into the app binary where they can be extracted trivially by decompiling the APK/IPA.
2. **`app.dart` + `service_locator.dart`** — Factory-registered feature BLoCs are resolved inside `StatelessWidget.build()` via `BlocProvider.value(...)`. On any rebuild (locale/theme change), new instances are created while old ones are never closed, causing memory leaks and stale event subscriptions.
3. **`error_interceptor.dart` + `auth_token_manager.dart`** — Server-side token revocation (401 on an otherwise non-expired token) only prints a debug log; the revoked token continues to be sent on every subsequent request until it naturally expires.

### Overall Code Health Rating

> **🟡 Needs Work**

The architecture foundations (BLoC pattern, secure token storage, DI structure, route guard) are correctly identified and partially implemented. However a critical security flaw (.env in assets), widespread BlocBuilder ignoring `buildWhen`, multiple stale-state issues from feature BLoCs at root scope, and zero test coverage drag the rating down significantly.

---

## Detailed Findings

---

**[SECTION 4 — SECURITY] Finding #1**
**Severity:** 🔴 CRITICAL
**File:** `pubspec.yaml` (line 119)
**Issue:** The `.env` file is listed as a Flutter asset, causing all secrets to be bundled verbatim inside the APK/IPA binary.
**Detail:** Any user can run `apktool d app-release.apk` (Android) or unzip the IPA (iOS) and read `assets/.env` directly. This exposes `API_BASE_URL`, `GOOGLE_PLACES_API_KEY`, `API_KEY`, `SERVER_CLIENT_ID`, and any other values you add to the file. The `.gitignore` does list `.env` (though the entry appears split across formatting lines — worth verifying) but gitignore has no bearing on this runtime exposure.

**Current code:**

```yaml
assets:
  - .env # ← entire file ships inside binary
  - assets/translations/en/
```

**Recommended fix:**
Remove `.env` from the assets list. Instead, inject secrets at build time using `--dart-define` or `--dart-define-from-file` (Flutter 3.7+) and read them with `const String.fromEnvironment(...)`. For CI/CD, pass them through environment variables — they are compiled into the binary as constants that cannot be accessed by static asset extraction tools.

```yaml
# pubspec.yaml — REMOVE the .env line entirely
assets:
  - assets/translations/en/
  - assets/translations/ar/
```

```dart
// app_config.dart
static Future<void> init() async {
  apiBaseUrl = const String.fromEnvironment('API_BASE_URL',
      defaultValue: 'https://dev-api.pooch.app');
  googlePlacesApiKey = const String.fromEnvironment('GOOGLE_PLACES_API_KEY');
  serverClientId = const String.fromEnvironment('SERVER_CLIENT_ID');
  // ... etc.
}
```

```sh
# Build command
flutter build apk --dart-define-from-file=.env
```

---

**[SECTION 4 — SECURITY] Finding #2**
**Severity:** 🔴 CRITICAL
**File:** `lib/core/config/app_config.dart` (line 43)
**Issue:** A real Google OAuth `serverClientId` is hardcoded as a fallback value directly in Dart source code committed to the repository.
**Detail:** Even if `.env` is never committed, this fallback ensures the client ID is always in the source tree. Any developer or attacker with repository access has the credential.

**Current code:**

```dart
serverClientId =
    dotenv.env['SERVER_CLIENT_ID'] ??
    '811126899873-3talsukdajq84tsv18shac7j14rjo20r.apps.googleusercontent.com';
```

**Recommended fix:**

```dart
serverClientId = const String.fromEnvironment('SERVER_CLIENT_ID');
// Let it be null/empty; Google Sign-In will fail with a clear error
// rather than silently using credentials that don't belong to this build.
```

---

**[SECTION 2 — ARCHITECTURE] Finding #3**
**Severity:** 🟠 HIGH
**File:** `lib/app.dart` (lines 60–86)
**Issue:** Factory-registered BLoCs are resolved inside `StatelessWidget.build()` via `BlocProvider.value(...)`, leaking every old instance when the widget rebuilds.
**Detail:** `PoochCareApp` is a `StatelessWidget`. Flutter can call `build()` again for hot reloads, locale changes, and theme changes. `BlocProvider.value(...)` does **not** manage BLoC lifecycle — it never calls `close()`. Each `getIt<BuyPetLandingBloc>()`, `getIt<ClinicBloc>()`, `getIt<SubscribedClinicsBloc>()`, etc. (all registered as `registerFactory`) creates a brand-new instance. The previous instance stays alive with open event queues and possibly live stream subscriptions. Confirmed factories leaking this way: `BuyPetLandingBloc`, `ClinicBloc`, `SubscribedClinicsBloc`, `CartBloc`, `AddressBloc`, `OrderBloc`, `CouponsBloc`.

**Current code:**

```dart
// app.dart — inside PoochCareApp.build()
BlocProvider<BuyPetLandingBloc>.value(
  value: getIt<BuyPetLandingBloc>()   // new instance every build
    ..add(const FetchRecentlyViewedOnly()),
),
BlocProvider<ClinicBloc>.value(value: getIt<ClinicBloc>()), // new instance every build
```

**Recommended fix:**
Decide whether each BLoC is truly needed at the root level. True app-wide BLoCs should be `registerLazySingleton`. For genuine screen-scoped BLoCs that do not need to be app-wide, remove them from `MultiBlocProvider` altogether and use `BlocProvider(create: ...)` within the relevant route.

```dart
// For BLoCs that are actually app-wide:
// service_locator.dart
getIt.registerLazySingleton<BuyPetLandingBloc>(
  () => BuyPetLandingBloc(getIt<BuyPetRepository>()),
);
// Remove ClinicBloc / SubscribedClinicsBloc from root; provide them at route level.
```

---

**[SECTION 2 — ARCHITECTURE] Finding #4**
**Severity:** 🟠 HIGH
**File:** `lib/app.dart` (lines 56–86) & `lib/core/di/service_locator.dart` (line 420)
**Issue:** Twelve feature-scoped BLoCs are elevated to app-lifetime scope in the root `MultiBlocProvider`, causing stale state to persist across navigation.
**Detail:** `CartBloc`, `AddressBloc`, `OrderBloc`, `OrderDetailBloc`, `CouponsBloc`, `AppointmentBloc`, `ClinicBloc`, `SubscribedClinicsBloc`, `MedicalHistoryBloc`, `BuyPetLandingBloc`, `WishlistBloc`, and `AccessoriesBloc` manage per-screen state (loading, error, items lists). Placing them at root means: (a) a user who opens "order details", navigates away, and returns sees the previous order's data flicker before the new load completes; (b) errors from one screen session leak into the next. Only BLoCs that represent globally shared data (`AuthStoreBloc`, `ThemeStoreBloc`, `CartStoreBloc`, etc.) belong at root.

**Recommended fix:**
Remove feature BLoCs from root `MultiBlocProvider`. Wrap individual screens (or feature sub-routes) with their own `BlocProvider(create: ...)` via an `AutoRoute` wrapper widget. For example:

```dart
// Instead of root provider, create a wrapper for the order feature:
@RoutePage()
class OrderShellScreen extends StatelessWidget {
  const OrderShellScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrderBloc>(),
      child: const AutoRouter(),
    );
  }
}
```

---

**[SECTION 1 — LOGICAL BUGS] Finding #5**
**Severity:** 🟠 HIGH
**File:** `lib/app.dart` (line 93)
**Issue:** `WidgetsBinding.instance.addPostFrameCallback` is called inside `ScreenUtilInit.builder`, which fires on every rebuild, causing duplicate wishlist and cart count API calls.
**Detail:** `ScreenUtilInit.builder` is called whenever `ScreenUtilInit` rebuilds (orientation changes, system font-scale changes, theme changes). Each call to that builder function re-registers a post-frame callback that fires `FetchWishlistCountEvent` and `FetchCartCountEvent` if the user is authenticated.

**Current code:**

```dart
// app.dart — inside ScreenUtilInit.builder
builder: (context, child) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final authState = context.read<AuthStoreBloc>().state;
    if (authState.isAuthenticated) {
      context.read<WishlistBloc>().add(FetchWishlistCountEvent());
      context.read<CartBloc>().add(const FetchCartCountEvent());
    }
  });
  return MultiBlocListener( ...
```

**Recommended fix:**
Move the initial-fetch logic into the `BlocListener<AuthStoreBloc>` that already exists below, or perform it once in a `StatefulWidget.initState`. If keeping it in the builder, gate it with a flag:

```dart
// In the AuthStoreBloc listener that already handles auth state changes,
// add initial fetch on first authenticated state:
BlocListener<AuthStoreBloc, AuthStoreState>(
  listenWhen: (prev, curr) =>
      prev.isAuthenticated != curr.isAuthenticated,
  listener: (context, state) {
    if (state.isAuthenticated) {
      context.read<WishlistBloc>().add(FetchWishlistCountEvent());
      context.read<CartBloc>().add(const FetchCartCountEvent());
    }
    // ... logout logic
  },
),
```

---

**[SECTION 5 — ERROR HANDLING] Finding #6**
**Severity:** 🟠 HIGH
**File:** `lib/core/network/error_interceptor.dart` (line 14) & `lib/features/auth/services/auth_token_manager.dart` (line 29)
**Issue:** A server-side 401 (token revoked, not merely expired) is only logged in debug mode; the revoked token is re-sent on every subsequent request until the client-side expiry timestamp elapses.
**Detail:** `AuthTokenManager.getValidAccessToken()` checks the locally stored expiry timestamp. If the server revokes a token early (admin action, concurrent login on another device), the client-side timestamp says the token is still valid, so `_isExpired` returns `false` and the stored revoked token is returned. `ErrorInterceptor` receives the 401 but only `debugPrint`s it — there is no retry with a refreshed token, and no forced logout. The user experiences silent API failures for up to `apiTimeoutSeconds` until every in-flight request times out.

**Current code:**

```dart
// error_interceptor.dart
case DioExceptionType.badResponse:
  final statusCode = err.response?.statusCode;
  if (statusCode == 401) {
    if (kDebugMode) {
      debugPrint('Unauthorized - token expired'); // only logs; takes no action
    }
  }
  break;
```

**Recommended fix:**
Add a Dio interceptor that intercepts 401 responses, forces a refresh, and retries the original request once. If the refresh fails, trigger `SessionResetService.clearSessionData()`:

```dart
@override
Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
  if (err.response?.statusCode == 401 && err.requestOptions.extra['_retried'] != true) {
    final newToken = await getIt<AuthTokenManager>().forceRefresh();
    if (newToken != null) {
      final retryOptions = err.requestOptions
        ..headers['Authorization'] = 'Bearer $newToken'
        ..extra['_retried'] = true;
      try {
        final response = await getIt<Dio>().fetch(retryOptions);
        return handler.resolve(response);
      } catch (_) {}
    }
    await getIt<SessionResetService>().clearSessionData();
  }
  handler.next(err);
}
```

---

**[SECTION 1 — LOGICAL BUGS] Finding #7**
**Severity:** 🟠 HIGH
**File:** `lib/core/services/notification_service.dart` (line 157)
**Issue:** `messaging.onTokenRefresh.listen(...)` adds a new subscription on each call to `refreshNotificationToken()` without storing or cancelling the previous one.
**Detail:** `refreshNotificationToken()` is presumably called on sign-in. After re-login scenarios (sign out → sign in), a second listener is added without the first being cancelled. N logins → N concurrent update-token API calls per FCM token refresh event.

**Current code:**

```dart
Future<void> refreshNotificationToken() async {
  final dio = getIt<Dio>();
  String deviceId = '';
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.onTokenRefresh.listen((newToken) async { // new listener every call
      try {
        // ... PUT /user/notification-token
      } catch (e) { }
    });
  } catch (e, s) { ... }
}
```

**Recommended fix:**

```dart
StreamSubscription<String>? _tokenRefreshSub;

Future<void> refreshNotificationToken() async {
  await _tokenRefreshSub?.cancel();
  _tokenRefreshSub = FirebaseMessaging.instance.onTokenRefresh.listen(
    (newToken) async {
      try {
        final deviceId = await getDeviceId();
        await getIt<Dio>().put('/user/notification-token', data: {
          'notificationToken': newToken,
          'deviceId': deviceId,
          'deviceType': Platform.isAndroid ? 'Android' : 'iOS',
        });
      } catch (e, s) {
        CrashlyticsService.recordError(e, s);
      }
    },
  );
}
```

---

**[SECTION 5 — ERROR HANDLING] Finding #8**
**Severity:** 🟠 HIGH
**File:** `lib/main.dart` (line 22)
**Issue:** `Firebase.initializeApp()` is called without a try/catch, crashing the app with an unhandled exception when initialization fails.
**Detail:** If `google-services.json` / `GoogleService-Info.plist` is misconfigured, or if Firebase's CDN is unreachable on first-run, `initializeApp()` throws. Since this is before `runApp()`, Flutter's default error handler does not catch it gracefully — the app shows a blank/red screen with no user-friendly message.

**Current code:**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // can throw PlatformException
```

**Recommended fix:**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e, s) {
    // Log to local file/console; app can still run without Firebase (degraded mode)
    debugPrint('Firebase init failed: $e');
  }
  // ...
}
```

---

**[SECTION 5 — ERROR HANDLING] Finding #9**
**Severity:** 🟠 HIGH
**File:** `lib/core/services/image_picker_service.dart` (line 241)
**Issue:** `_requestPermission` handles `isDenied` but silently returns `false` for `isPermanentlyDenied`, leaving the user with no camera/gallery access and no explanation or path to fix it.
**Detail:** Once a user taps "Never ask again" on Android (or "Don't Allow" → second denial on iOS), `status.isDenied` is `false` and `status.isPermanentlyDenied` is `true`. The function returns `false`, the image picker silently does nothing, and the user has no feedback.

**Current code:**

```dart
Future<bool> _requestPermission(PickerSourceType source) async {
  final permission = await _getPermission(source);
  final status = await permission.status;
  if (status.isGranted) return true;
  if (status.isDenied) {
    final result = await permission.request();
    return result.isGranted;
  }
  return false; // isPermanentlyDenied → silently fails
}
```

**Recommended fix:**

```dart
Future<bool> _requestPermission(PickerSourceType source) async {
  final permission = await _getPermission(source);
  final status = await permission.status;
  if (status.isGranted) return true;
  if (status.isDenied) {
    return (await permission.request()).isGranted;
  }
  if (status.isPermanentlyDenied || status.isRestricted) {
    CustomSnackbar.show(
      'camera_permission_permanently_denied'.tr(),
      SnackbarType.error,
      action: SnackBarAction(
        label: 'open_settings'.tr(),
        onPressed: openAppSettings,
      ),
    );
  }
  return false;
}
```

---

**[SECTION 4 — SECURITY] Finding #10**
**Severity:** 🟠 HIGH
**File:** `lib/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart` (line 103)
**Issue:** `dart:developer`'s `log()` (not `kDebugMode`-gated) outputs the full Google Places API URL including the API key.
**Detail:** Unlike `debugPrint`, `dart:developer`'s `log()` is not stripped in release builds and its output is available on the `dart.developer` VM service log channel. Proxy tools (e.g., mitmproxy) and profiling tools on device can capture it.

**Current code:**

```dart
log('Google Places API URL: $url'); // url contains &key=<YOUR_API_KEY>
```

**Recommended fix:**

```dart
if (kDebugMode) {
  debugPrint('Google Places API: autocomplete triggered for "$query"');
  // Never log the full URL containing the key
}
```

---

**[SECTION 4 — SECURITY] Finding #11**
**Severity:** 🟠 HIGH
**File:** `lib/core/network/dio_client.dart` (line 11)
**Issue:** No certificate pinning or custom `BadCertificateCallback` is configured on the Dio HTTP client; the app is vulnerable to MITM attacks on untrusted networks.
**Detail:** Without pinning, a device with a custom CA certificate (enterprise proxy, user-installed root cert, or attacker-controlled) can intercept all API traffic including authentication tokens.

**Recommended fix:**

```dart
// In DioClient constructor, add after creating the Dio instance:
(dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    (client) {
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) {
    // Pin against your server's public key SHA-256 hash
    const expectedFingerprint = 'AA:BB:CC:...';
    return cert.sha1.toHex() == expectedFingerprint;
  };
  return client;
};
```

For a more complete solution consider the `ssl_pinning_plugin` package.

---

**[SECTION 7 — DEPENDENCIES] Finding #12**
**Severity:** 🟠 HIGH
**File:** `lib/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart` (line 7)
**Issue:** The `http` package is used in a single widget to call Google Places, completely bypassing the centralized `DioClient` with all its interceptors (auth, logging, error handling, locale headers).
**Detail:** This Places call has no retry logic, no structured error reporting to Crashlytics, no response model validation, and silent `catch (_) {}` on failure. Also means maintaining two HTTP clients.

**Current code:**

```dart
import 'package:http/http.dart' as http;
// ...
final res = await http.get(Uri.parse(url));
final data = json.decode(res.body);
```

**Recommended fix:**
Either use `getIt<Dio>()` directly (with `skipAuth: true` extra) or create a dedicated `PlacesApiService` backed by `DioClient`. Remove `http` from `pubspec.yaml`.

---

**[SECTION 1 — LOGICAL BUGS] Finding #13**
**Severity:** 🟡 MEDIUM
**File:** `lib/features/ecommerce/data/models/cart/cart_item_model.dart` (multiple lines)
**Issue:** All monetary values (`subTotal`, `deliveryFee`, `tax`, `total`, `finalPrice`, `minimumOrderAmount`, `maximumDiscountAmount`, `totalDiscountApplied`) are typed as `double`, which can produce floating-point precision errors when summing currency values.
**Detail:** `double` arithmetic in IEEE 754 is notoriously imprecise for decimal sums. `0.1 + 0.2 == 0.30000000000000004` is the canonical example. Displaying a cart total of "19.9999999" instead of "20.00" is a user-facing bug in financial context.

**Current code:**

```dart
final double? subTotal;
final double? deliveryFee;
final double? tax;
final double? total;
```

**Recommended fix:**
Treat monetary values as integers (smallest currency unit, e.g., fils/piastres) from API to display layer and only convert to display string at the last moment, or use the `decimal` package:

```dart
// Option A: integer cents
final int? subTotalFils; // 2000 = 20.00 SAR

// Option B: use decimal package
import 'package:decimal/decimal.dart';
final Decimal? subTotal;

// Display helper
String formatCurrency(Decimal? amount) =>
    amount == null ? '—' : NumberFormat.currency(symbol: 'SAR ').format(amount.toDouble());
```

---

**[SECTION 3 — PERFORMANCE] Finding #14**
**Severity:** 🟡 MEDIUM
**File:** `lib/app.dart` + all feature screens
**Issue:** 132 `BlocBuilder` instances across the app have no `buildWhen` predicate, causing entire widget subtrees to rebuild on every state change regardless of relevance.
**Detail:** `BlocBuilder<CartBloc, CartState>` without `buildWhen` rebuilds whenever **any** field in `CartState` changes — including internal `actionId` counters, `addingProductIds` lists, and `errorMessage` fields that may not affect the rendered output. In screens with nested BlocBuilders this creates rebuild cascades.

**Recommended fix:**
For common read-only display BlocBuilders, switch to `BlocSelector` which only rebuilds when the selected value changes:

```dart
// Before
BlocBuilder<CartBloc, CartState>(
  builder: (ctx, state) => CartBadge(count: state.cartCount),
)

// After — only rebuilds when cartCount changes
BlocSelector<CartBloc, CartState, int>(
  selector: (state) => state.cartCount,
  builder: (ctx, count) => CartBadge(count: count),
)
```

For builders that genuinely need full state but should be selective:

```dart
BlocBuilder<CartBloc, CartState>(
  buildWhen: (prev, curr) => prev.status != curr.status || prev.cartItems != curr.cartItems,
  builder: (ctx, state) => ...,
)
```

---

**[SECTION 3 — PERFORMANCE] Finding #15**
**Severity:** 🟡 MEDIUM
**File:** Multiple screens (lines noted below)
**Issue:** `ListView(children: [...])` is used in at least six screens, eagerly instantiating all children in memory instead of building lazily on demand.
**Detail:** Affected files:

- `lib/features/ecommerce/presentation/view/buy_pet/buy_pet_landing_screen.dart` (line 86)
- `lib/features/ecommerce/presentation/view/buy_pet/wishlist_screen.dart` (line 116)
- `lib/features/ecommerce/presentation/view/buy_pet/buy_pet_detail_screen.dart` (line 339)
- `lib/features/ecommerce/presentation/view/buy_pet/common_pet_listing_screen.dart` (line 178)
- `lib/features/insight/presentation/view/vets/find_vet_clinics_screen.dart` (line 109)
- `lib/features/invites/view/my_invites/my_invites_list_view.dart` (line 159)

**Recommended fix:**

```dart
// Before
ListView(
  children: items.map((item) => ItemCard(item: item)).toList(),
)

// After
ListView.builder(
  itemCount: items.length,
  itemBuilder: (ctx, i) => ItemCard(item: items[i]),
)
```

---

**[SECTION 3 — PERFORMANCE] Finding #16**
**Severity:** 🟡 MEDIUM
**File:** `lib/app.dart` (line 176)
**Issue:** The entire `MaterialApp.router` is wrapped in a `BlocBuilder<SettingsBloc, SettingsState>` without `buildWhen`, causing a full `MaterialApp` rebuild on any `SettingsState` emission.
**Detail:** `SettingsBloc` is used to respond to language-preference sync events. Any settings state change (including async language save operations with intermediate loading states) triggers a complete `MaterialApp` rebuild — routes, theme, everything.

**Current code:**

```dart
BlocBuilder<SettingsBloc, SettingsState>(
  builder: (context, settingsState) {
    return MaterialApp.router( // entire app rebuilt
```

**Recommended fix:**
`MaterialApp.router` doesn't need `SettingsBloc` at all since locale is driven by `EasyLocalization` and theme by `ThemeStoreBloc`. Remove the `BlocBuilder` wrapper entirely:

```dart
// The MaterialApp.router locale/theme is already driven by EasyLocalization + ThemeStoreBloc
return MaterialApp.router(
  scaffoldMessengerKey: scaffoldMessengerKey,
  theme: AppTheme.light(),
  darkTheme: AppTheme.dark(),
  themeMode: themeMode,
  locale: context.locale,
  supportedLocales: context.supportedLocales,
  localizationsDelegates: context.localizationDelegates,
  routerConfig: appRouter.config(),
  builder: (context, child) => GlobalLoaderOverlay(child: child!),
);
```

---

**[SECTION 8 — LOCALIZATION] Finding #17**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/utils/date_time_formattter.dart` (lines 95, 96, 135, 137, 139, 145, 152, 159, 164, 248, 250)
**Issue:** Every `DateFormat(...)` call throughout the date formatter utility is created without a locale argument, so Arabic users always see English-locale formatted dates.
**Detail:** `DateFormat('MMM d')` always formats as `"Jan 5"` rather than `"٥ يناير"` for Arabic locale. Similarly `'EEEE'` prints `"Monday"` not `"الاثنين"`. This contradicts the app's Arabic (`ar`) support.

**Current code:**

```dart
final datePart = DateFormat('MMM d').format(local);      // always English
final timePart = DateFormat('h:mm a').format(local);     // always English
return DateFormat('EEE, d MMM').format(date);            // always English
```

**Recommended fix:**
Thread the current locale into the formatter functions:

```dart
String formatDateShort(DateTime date, {String locale = 'en'}) {
  return DateFormat('EEE, d MMM', locale).format(date);
}

// Usage with EasyLocalization:
formatDateShort(myDate, locale: context.locale.languageCode)
```

Alternatively, store the current language code in a lightweight service and inject it:

```dart
final locale = getIt<LocalizationService>().currentLanguage;
final datePart = DateFormat('MMM d', locale).format(local);
```

---

**[SECTION 1 — LOGICAL BUGS] Finding #18**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/services/notification_service.dart` (line 150)
**Issue:** `static StreamController.broadcast()` instances `_refreshHomeController` and `_appointmentEndedController` accumulate listeners because callers subscribe but never store the `StreamSubscription` for cancellation.
**Detail:** Widgets or screens that call `NotificationService.refreshHomeStream.listen(...)` inside `initState` without storing the subscription and cancelling it in `dispose()` create permanent listeners. Since these controllers are static singletons they outlive the widgets.

**Recommended fix:**
Enforce subscription management at the API surface by returning the `StreamSubscription` to callers; or use a `StreamController.broadcast()` with `onListen`/`onCancel` hooks for reference counting. At minimum document that callers must cancel:

```dart
// Document clearly and provide a helper:
static StreamSubscription<String> listenToHomeRefresh(
    void Function(String) onData) {
  return _refreshHomeController.stream.listen(onData);
}
// Callers:
late StreamSubscription<String> _refreshSub;
@override
void initState() {
  _refreshSub = NotificationService.listenToHomeRefresh(_onRefresh);
}
@override
void dispose() {
  _refreshSub.cancel();
  super.dispose();
}
```

---

**[SECTION 2 — ARCHITECTURE] Finding #19**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/di/service_locator.dart` (line 484)
**Issue:** `SecureStorageService` is registered with `registerSingleton` (immediate instantiation) near the **end** of `setupDI()`, after all services that depend on it are registered.
**Detail:** Although this works today because lazy singletons aren't instantiated until first use (and first use occurs after the full `setupDI()` completes), if any registered lazy singleton is ever promoted to eager (`registerSingleton`), it will throw because `SecureStorageService` hasn't been registered yet. This is a maintenance trap.

**Current code:**

```dart
// ~line 484 — very end of setupDI()
getIt.registerSingleton<SecureStorageService>(SecureStorageService());
// But LocalizationService (which uses SecureStorageService) was registered ~line 240
getIt.registerLazySingleton<LocalizationService>(
  () => LocalizationService(getIt<SecureStorageService>()), // resolved at first use
);
```

**Recommended fix:**
Register `SecureStorageService` at the **top** of `setupDI()`, before any service that depends on it:

```dart
void setupDI() {
  // 1. Infrastructure first
  getIt.registerSingleton<SecureStorageService>(SecureStorageService());
  getIt.registerLazySingleton<TokenStorage>(TokenStorage.new);
  // 2. Then services that depend on infrastructure...
```

---

**[SECTION 2 — ARCHITECTURE] Finding #20**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/di/service_locator.dart` (line 415)
**Issue:** `ClinicBloc` and `SubscribedClinicsBloc` are registered as `registerFactory` in get_it but then provided at app root via `BlocProvider.value(value: getIt<ClinicBloc>())` in `app.dart`. This means every call to `getIt<ClinicBloc>()` from a screen creates a **different** instance than the one in the widget tree.
**Detail:** Any screen that calls `BlocProvider.of<ClinicBloc>(context)` gets the root-level instance. But a screen that calls `getIt<ClinicBloc>()` directly gets a freshly created, empty instance. This creates two shadow instances with diverged state.

**Recommended fix:**
Either (a) change to `registerLazySingleton` if the BLoC must be app-wide, or (b) remove from root `MultiBlocProvider` and let screens manage their own instance via `BlocProvider(create: (_) => getIt<ClinicBloc>())`.

---

**[SECTION 4 — SECURITY] Finding #21**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/services/notification_service.dart` (line 1)
**Issue:** The file-level `// ignore_for_file:` directive suppresses `inference_failure_on_function_invocation`, `unused_catch_stack`, and `unused_local_variable` — masking real runtime risks.
**Detail:** `inference_failure_on_function_invocation` can hide calls that return `dynamic` where a typed return was expected; `unused_catch_stack` encourages `catch (e, s)` with `s` never passed to Crashlytics, meaning stack traces are silently dropped.

**Current code:**

```dart
// ignore_for_file: avoid_redundant_argument_values, constant_identifier_names,
//   unused_catch_stack, inference_failure_on_function_invocation, unused_local_variable
```

**Recommended fix:**
Address each lint violation individually rather than suppressing globally. For `unused_catch_stack`, ensure every catch that takes a stack trace passes it to `CrashlyticsService.recordError(e, s)`.

---

**[SECTION 5 — ERROR HANDLING] Finding #22**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart` (lines 57–63, 103–109)
**Issue:** All exceptions in Google Places autocomplete and place-details calls are swallowed silently with `catch (_) {}`.
**Detail:** Network failures, JSON decode errors, HTTP 400/403 from Google (quota exceeded, invalid API key) all result in an empty results list with no feedback to the user. Quota-exceeded errors will be particularly difficult to debug in production.

**Current code:**

```dart
try {
  final res = await http.get(Uri.parse(url));
  final data = json.decode(res.body);
  // ...
} catch (_) {
  resultsNotifier.value = []; // silent failure
}
```

**Recommended fix:**

```dart
try {
  final res = await http.get(Uri.parse(url));
  if (res.statusCode != 200) {
    CrashlyticsService.recordError(
      'Places API error: ${res.statusCode} ${res.body}',
      StackTrace.current,
    );
    return;
  }
  final data = json.decode(res.body) as Map<String, dynamic>;
  if (data['status'] != 'OK' && data['status'] != 'ZERO_RESULTS') {
    CrashlyticsService.recordError('Places API status: ${data['status']}', StackTrace.current);
    return;
  }
  // ...
} catch (e, s) {
  CrashlyticsService.recordError(e, s);
  resultsNotifier.value = [];
}
```

---

**[SECTION 6 — CODE QUALITY] Finding #23**
**Severity:** 🟡 MEDIUM
**File:** `lib/features/ecommerce/data/models/buy_pet/product_model.dart` (line 118) & `lib/features/ecommerce/data/models/buy_pet/product_detail_model.dart` (line 234)
**Issue:** `_readDouble` and `_readNullableDouble` helper functions are duplicated verbatim between two files.
**Detail:** Copy-paste drift risk: if one is fixed for a bug (e.g., locale-aware `double.parse` for Arabic number strings), the other will not be, leading to inconsistent parsing behavior across product and product-detail flows.

**Recommended fix:**
Extract to a shared parsing utility:

```dart
// lib/core/utils/type_parsers.dart
double readDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value.trim()) ?? 0.0;
  return 0.0;
}

double? readNullableDouble(dynamic value) {
  if (value == null) return null;
  return readDouble(value);
}
```

---

**[SECTION 7 — DEPENDENCIES] Finding #24**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/widgets/global_loader_overlay.dart` (line 4) + `pubspec.yaml`
**Issue:** The `provider` package is used solely for a global loading overlay widget (`GlobalLoaderOverlay`) while the rest of the app uses `flutter_bloc`. This is an unnecessary secondary state-management dependency.
**Detail:** `LoaderService` is a `ChangeNotifier` (implying `provider` is mandatory). This could trivially be replaced with a `Cubit` or a `ValueNotifier` + `ListenableBuilder`, eliminating the `provider` dependency entirely.

**Recommended fix:**

```dart
// Replace ChangeNotifier with a simple Cubit
class LoaderCubit extends Cubit<bool> {
  LoaderCubit() : super(false);
  void show({Widget? custom}) => emit(true);
  void hide() => emit(false);
}

// GlobalLoaderOverlay
BlocBuilder<LoaderCubit, bool>(
  builder: (ctx, isLoading) {
    if (!isLoading) return child!;
    return Stack(children: [child!, const AppLoader()]);
  },
)
```

---

**[SECTION 7 — DEPENDENCIES] Finding #25**
**Severity:** 🟡 MEDIUM
**File:** `pubspec.yaml`
**Issue:** Two calendar rendering packages — `syncfusion_flutter_calendar` and `calendar_view` — are both present without clear justification in the code reviewed.
**Detail:** `syncfusion_flutter_calendar` requires a Syncfusion license for commercial apps. Using both adds ~2–4 MB to the binary, duplicates calendar widget trees, and means two different APIs to learn and maintain. It is also a known breaking-change package between major versions.

**Recommended fix:**
Audit usage across the app (`grep -rn "SfCalendar\|CalendarView" lib/`). If both are genuinely used for distinct features, document the justification. Otherwise consolidate onto one. If `syncfusion_flutter_calendar` is kept, ensure a valid commercial license is in place.

---

**[SECTION 6 — CODE QUALITY] Finding #26**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/utils/date_time_formattter.dart` (filename)
**Issue:** The filename contains a typo — `formattter` with three `t`s — and the file contains unnecessary `!` non-null assertions suppressed by inline ignores.
**Detail:** Three separate `// ignore: unnecessary_non_null_assertion` comments at lines 213, 233, 246 suggest the `!` operators were added to silence errors rather than address the underlying nullable type issue.

**Recommended fix:**
Rename to `date_time_formatter.dart`, update all imports, and replace forced unwraps with null-aware alternatives:

```dart
// Before (line ~213):
final time = dateTime!.hour; // ignore: unnecessary_non_null_assertion

// After:
if (dateTime == null) return null;
final time = dateTime.hour;
```

---

**[SECTION 2 — ARCHITECTURE] Finding #27**
**Severity:** 🟡 MEDIUM
**File:** `lib/router/app_router.dart` (line 409)
**Issue:** `AppFlowGuard` makes synchronous navigation decisions by reading `_authStoreBloc.state` directly, without accounting for the brief window between `HydratedBloc` registration and first state hydration.
**Detail:** `HydratedBloc` restores persisted state lazily — the state is only read from storage when the BLoC is first created. Since `AuthStoreBloc` is a `registerLazySingleton`, it's created when `app.dart.build()` first calls `getIt<AuthStoreBloc>()`. The `AppFlowGuard` constructor also calls `getIt<AuthStoreBloc>()` (via `appRouter` which is in `router_service.dart`). If `appRouter` is instantiated before the first `build()` frame (e.g., at app startup before the BLoC providers are established), the guard sees the un-hydrated initial state (`isAuthenticated: false`) and may incorrectly redirect a returning logged-in user to the intro screen.

**Recommended fix:**
Add a `splashCompleted` or hydration-completed guard:

```dart
@override
void onNavigation(NavigationResolver resolver, StackRouter router) {
  final state = _authStoreBloc.state;
  // Only act once hydration is complete, indicated by any persisted field being set
  if (!state.splashCompleted && !state.introCompleted && !state.isAuthenticated) {
    // Still at initial (possibly pre-hydration) state; defer to splash screen
    resolver.next();
    return;
  }
  // ... rest of guard logic
}
```

---

**[SECTION 8 — LOCALIZATION] Finding #28**
**Severity:** 🟡 MEDIUM
**File:** `lib/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart` (line 81)
**Issue:** The `title = 'Search Address'` default parameter and other UI strings in this bottom sheet are hardcoded English strings never passed through `.tr()`.
**Detail:** This widget is shown to users when adding a delivery address — a high-visibility, user-facing screen. Arabic users will see raw English text "Search Address".

**Recommended fix:**

```dart
// Bottom sheet call site or widget declaration:
title: 'search_address'.tr(),
// Add to assets/translations/ar/common.json:
// "search_address": "ابحث عن العنوان"
```

---

**[SECTION 6 — CODE QUALITY] Finding #29**
**Severity:** 🟢 LOW
**File:** `lib/core/di/service_locator.dart`
**Issue:** `setupDI()` is a 553-line monolithic function registering every dependency across every feature in the app.
**Detail:** This conflicts with the feature-based directory structure (`lib/features/auth/`, `lib/features/ecommerce/`, etc.). Adding, removing, or refactoring a feature requires editing this one file, increasing merge conflict risk and reducing discoverability.

**Recommended fix:**
Split into feature-scoped registration extensions:

```dart
// lib/features/ecommerce/di/ecommerce_injection.dart
extension EcommerceInjection on GetIt {
  void registerEcommerceFeature() {
    registerLazySingleton<CartApiService>(() => CartApiService(get<Dio>()));
    registerLazySingleton<CartRepository>(() => CartRepositoryImpl(get<CartApiService>()));
    registerFactory<CartBloc>(() => CartBloc(get<CartRepository>(), get<OrderRepository>()));
    // ...
  }
}

// service_locator.dart
void setupDI() {
  getIt
    ..registerInfrastructure()
    ..registerAuthFeature()
    ..registerEcommerceFeature()
    ..registerInsightFeature();
    // ...
}
```

---

**[SECTION 2 — ARCHITECTURE] Finding #30**
**Severity:** 🟢 LOW
**File:** App-wide (`lib/main.dart`)
**Issue:** No global `BlocObserver` is registered anywhere in the codebase.
**Detail:** Without a `BlocObserver`, there is no centralized visibility into BLoC transitions in staging/production — errors in BLoC `onError` are silently ignored (they don't surface to Crashlytics), and debugging BLoC-related issues in production requires reproducing locally.

**Recommended fix:**

```dart
// main.dart, before runApp():
Bloc.observer = AppBlocObserver();

// lib/core/observers/app_bloc_observer.dart
class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    CrashlyticsService.recordError(error, stackTrace,
        reason: 'BLoC error in ${bloc.runtimeType}');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> t) {
    if (kDebugMode) {
      debugPrint('[${bloc.runtimeType}] ${t.currentState.runtimeType} → ${t.nextState.runtimeType}');
    }
    super.onTransition(bloc, t);
  }
}
```

---

**[SECTION 6 — CODE QUALITY] Finding #31**
**Severity:** 🟢 LOW
**File:** `lib/app.dart` (line 44)
**Issue:** `// ignore: prefer_const_constructors_in_immutables` suppresses a lint that has a trivially correct fix.
**Detail:** The comment exists because `PoochCareApp({super.key})` uses `key` but the constructor is not `const`. This is easily made `const`.

**Current code:**

```dart
// ignore: prefer_const_constructors_in_immutables
PoochCareApp({super.key});
```

**Recommended fix:**

```dart
const PoochCareApp({super.key}); // remove the ignore
```

---

**[SECTION 6 — CODE QUALITY] Finding #32**
**Severity:** 🟢 LOW
**File:** `test/widget_test.dart`
**Issue:** The test directory contains only the default Flutter counter widget test — zero test coverage for any BLoC, repository, or feature widget.
**Detail:** All Store BLoCs (including `AuthStoreBloc` with `fromJson`/`toJson` that could silently break on schema drift), all repository layers, all feature BLoCs, and all critical UI flows (login, cart, checkout) have no tests.

**Recommended fix (see Refactoring Roadmap):** Add progressive test coverage starting with `AuthStoreBloc`, `CartBloc`, and `AuthTokenManager` as the highest-value targets.

---

**[SECTION 7 — DEPENDENCIES] Finding #33**
**Severity:** 🟢 LOW
**File:** `pubspec.yaml` + `lib/main.dart`
**Issue:** `device_preview` is listed as a dev dependency but it is imported and used in a commented-out call in `main.dart`, indicating it may be occasionally uncommented and accidentally shipped.
**Detail:**

```dart
// runApp(DevicePreview(enabled: true, builder: (context) => PoochCareApp()));
```

If this is accidentally uncommented in a release build, device simulation UI leaks into production.

**Recommended fix:**
Gate all `device_preview` usage behind `kDebugMode` or a `const bool.fromEnvironment('DEVICE_PREVIEW')` flag so it cannot be shipped regardless of whether the comment is removed.

---

## Quick Wins

_(Under 30 minutes each)_

1. **Remove `.env` from `pubspec.yaml` assets list** — switch to `--dart-define-from-file=.env` in build scripts. Immediate CRITICAL security fix.
2. **Delete the hardcoded `serverClientId` fallback** in `lib/core/config/app_config.dart` (line 43) — replace with empty string / `null`.
3. **Wrap `Firebase.initializeApp()`** in `lib/main.dart` (line 22) with `try/catch`.
4. **Register `SecureStorageService` at the top** of `setupDI()` before any dependent services.
5. **Add `AppBlocObserver`** in `main.dart` and hook `onError` to `CrashlyticsService`.
6. **Make `PoochCareApp` constructor `const`** — remove the suppress comment.
7. **Move `addPostFrameCallback`** out of `ScreenUtilInit.builder` into the existing `BlocListener<AuthStoreBloc>` handler.
8. **Add `buildWhen`** to the `BlocBuilder<SettingsBloc, SettingsState>` that wraps `MaterialApp.router` — or better, remove it entirely (the SettingsBloc isn't needed at that level).
9. **Store and cancel `messaging.onTokenRefresh.listen`** subscription in `refreshNotificationToken()`.
10. **Add `isPermanentlyDenied` branch** to `_requestPermission` in `lib/core/services/image_picker_service.dart` with an `openAppSettings()` call.
11. **Remove `log('Google Places API URL: $url')`** from `lib/core/widgets/bottom_sheet/address/address_search_bottom_sheet.dart` (line 103).
12. **Rename `date_time_formattter.dart`** to `date_time_formatter.dart` and update imports.
13. **Extract `_readDouble`/`_readNullableDouble`** into a shared `lib/core/utils/type_parsers.dart`.

---

## Refactoring Roadmap

| Priority | Task                                                                                                                                                                                                               | Effort | Impact                |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------ | --------------------- |
| 1        | **Migrate secrets from `.env` asset to `--dart-define`** — update all CI/CD pipelines and remove `flutter_dotenv` if no longer needed                                                                              | **S**  | 🔴 Security           |
| 2        | **Retrofit Dio interceptor with 401-retry logic** — add `_retried` flag in request extras, integrate with `AuthTokenManager.forceRefresh()`                                                                        | **M**  | 🟠 Resilience         |
| 3        | **Lift-and-shift feature BLoCs out of root `MultiBlocProvider`** — create AutoRoute shell screens for `ecommerce`, `insight`, `community` feature groups, each providing their own BLoC scope                      | **L**  | 🟠 Architecture       |
| 4        | **Fix factory-BLoC-in-`StatelessWidget.build()` leaks** — convert `BuyPetLandingBloc`, `WishlistBloc`, `CartBloc` (etc.) to `registerLazySingleton` if genuinely shared, and remove from root builder call pattern | **M**  | 🟠 Memory             |
| 5        | **Replace `double` with integer-cents or `Decimal` for all monetary model fields** — update JSON parsing, display formatters, and arithmetic throughout ecommerce feature                                          | **L**  | 🟡 Correctness        |
| 6        | **Pass locale to all `DateFormat(...)` calls** — thread locale from `EasyLocalization` context or a `LocalizationService.currentLocale` singleton                                                                  | **S**  | 🟡 Localization       |
| 7        | **Add `BlocSelector`/`buildWhen` to the highest-traffic 132 `BlocBuilder` instances** — prioritise `CartBloc`, `AuthStoreBloc`, `WishlistBloc`, `ThemeStoreBloc`                                                   | **M**  | 🟡 Performance        |
| 8        | **Migrate `address_search_bottom_sheet.dart` HTTP calls to `DioClient`** — create `PlacesApiService` backed by Dio; remove `http` package                                                                          | **S**  | 🟡 Maintainability    |
| 9        | **Split `service_locator.dart`** into per-feature registration extensions                                                                                                                                          | **M**  | 🟢 Maintainability    |
| 10       | **Replace `provider`/`ChangeNotifier` in `GlobalLoaderOverlay`** with a `Cubit`, remove `provider` from `pubspec.yaml`                                                                                             | **S**  | 🟢 Dependency hygiene |
| 11       | **Add BLoC unit tests** — starting with `AuthStoreBloc` (`fromJson`/`toJson` schema drift), `CartBloc` (optimistic update rollback), `AuthTokenManager` (refresh dedup, expiry parsing)                            | **XL** | 🟢 Quality            |
| 12       | **Implement certificate pinning** on `DioClient` for auth and payment endpoints                                                                                                                                    | **M**  | 🟠 Security           |

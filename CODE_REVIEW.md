# Pooch Flutter Native — Full Codebase Code Review

**Reviewer:** GitHub Copilot (Senior Flutter/Dart Engineer)  
**Date:** 2026-05-14  
**Scope:** Entire `lib/` directory (~991 Dart files)  
**Branch:** `dev_surya`

---

## Table of Contents

1. [Logical Bugs](#1-logical-bugs)
2. [Code Quality](#2-code-quality)
3. [Performance Issues](#3-performance-issues)
4. [Flutter/Dart Best Practices](#4-flutterdart-best-practices)
5. [Error Handling](#5-error-handling)
6. [Summary Table](#6-summary-table)
7. [Top 3 Priority Fixes](#7-top-3-priority-fixes)

---

## 1. LOGICAL BUGS

---

### BUG-01 — `WishlistBloc._onToggle`: Rollback restores wrong count

**Location:** `lib/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart` · `_onToggle`  
**Severity:** 🔴 Critical

**Issue:**  
When removing from wishlist and the API call fails, the rollback emits `wishlistCount: state.wishlistCount - 1` again — **decrementing twice** instead of restoring the original value. Similarly, when adding to wishlist and the call fails, the rollback emits `wishlistCount: state.wishlistCount + 1` — **incrementing again** instead of restoring.

```dart
// REMOVE pathway — optimistic emit already decremented count:
emit(state.copyWith(wishlistCount: state.wishlistCount - 1, ...));
try {
  await repository.removeFromWishlist(...);
} catch (_) {
  // ❌ BUG: should be state.wishlistCount + 1 to restore
  emit(state.copyWith(wishlistCount: (state.wishlistCount - 1), ...));
}

// ADD pathway — optimistic emit already incremented count:
emit(state.copyWith(wishlistCount: state.wishlistCount + 1, ...));
try {
  await repository.addToWishlist(...);
} catch (_) {
  // ❌ BUG: should be state.wishlistCount - 1 to restore
  emit(state.copyWith(wishlistCount: state.wishlistCount + 1, ...));
}
```

**Also:** Both rollback cases have swapped `actionMessage` strings — remove-failure says "Failed to add to wishlist" and add-failure says "Failed to remove from wishlist".

**Fix:**

```dart
// REMOVE pathway — rollback:
emit(state.copyWith(
  wishlistIds: restoredIds,
  wishlistCount: state.wishlistCount + 1,   // ✅ restore
  actionMessage: 'Failed to remove from wishlist',  // ✅ correct
  actionId: state.actionId + 1,
));

// ADD pathway — rollback:
emit(state.copyWith(
  wishlistIds: restoredIds,
  wishlistCount: state.wishlistCount - 1,   // ✅ restore
  actionMessage: 'Failed to add to wishlist',  // ✅ correct
  actionId: state.actionId + 1,
));
```

---

### BUG-02 — `AuthStoreBloc._onUserSignedIn`: `primaryIdentifier` from new user is lost on first sign-in

**Location:** `lib/core/store/auth/auth_store_bloc.dart` · `_onUserSignedIn`  
**Severity:** 🔴 Critical

**Issue:**  
The code reads `primaryIdentifier` from the **existing** (old) user in state and applies it to the newly signed-in user:

```dart
void _onUserSignedIn(UserSignedIn event, Emitter<AuthStoreState> emit) {
  final primaryIdentifier = state.user?.primaryIdentifier; // ← null on first login
  emit(state.copyWith(
    user: event.user.copyWith(primaryIdentifier: primaryIdentifier), // ← overwrites new value with null
    isAuthenticated: true,
  ));
}
```

On first login, `state.user` is `null`, so `primaryIdentifier` is `null`. The newly arriving `event.user.primaryIdentifier` is discarded and the user is stored with `null` — causing the `AppFlowGuard` logic that branches on `isEmail = primaryIden == 'email'` to always evaluate as `false`.

**Fix:**

```dart
void _onUserSignedIn(UserSignedIn event, Emitter<AuthStoreState> emit) {
  // Prefer the incoming identifier; fall back to the cached one only when
  // the incoming one is absent (e.g. partial profile merge from dashboard).
  final incomingIdentifier = event.user.primaryIdentifier;
  final cachedIdentifier = state.user?.primaryIdentifier;
  final resolvedIdentifier = incomingIdentifier ?? cachedIdentifier;

  emit(state.copyWith(
    user: event.user.copyWith(primaryIdentifier: resolvedIdentifier),
    isAuthenticated: true,
  ));
}
```

---

### BUG-03 — `app.dart`: `addPostFrameCallback` registered inside `ScreenUtilInit.builder`

**Location:** `lib/app.dart` · `PoochCareApp.build` → `ScreenUtilInit.builder`  
**Severity:** 🔴 Critical

**Issue:**  
`WidgetsBinding.instance.addPostFrameCallback` is called inside the `builder` callback of `ScreenUtilInit`. Because `builder` is re-invoked on every rebuild of the widget (e.g., theme changes), a **new** post-frame callback is registered on every rebuild, causing `WishlistBloc` and `CartBloc` to fire `FetchWishlistCountEvent` and `FetchCartCountEvent` multiple times.

```dart
// ❌ Inside ScreenUtilInit.builder — called on every rebuild
builder: (context, child) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final authState = context.read<AuthStoreBloc>().state;
    if (authState.isAuthenticated) {
      context.read<WishlistBloc>().add(FetchWishlistCountEvent());
      context.read<CartBloc>().add(const FetchCartCountEvent());
    }
  });
  ...
}
```

**Fix:** Move this to a `StatefulWidget.initState`.

```dart
class PoochCareApp extends StatefulWidget {
  const PoochCareApp({super.key});
  @override
  State<PoochCareApp> createState() => _PoochCareAppState();
}

class _PoochCareAppState extends State<PoochCareApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final authState = context.read<AuthStoreBloc>().state;
      if (authState.isAuthenticated) {
        context.read<WishlistBloc>().add(FetchWishlistCountEvent());
        context.read<CartBloc>().add(const FetchCartCountEvent());
      }
    });
  }
  // rest of build ...
}
```

---

### BUG-04 — `service_locator.dart`: `CartBloc`, `OrderBloc`, `AddressBloc`, `CouponsBloc`, `OrderDetailBloc` registered as `Factory` but consumed as singletons in `MultiBlocProvider`

**Location:** `lib/core/di/service_locator.dart` + `lib/app.dart`  
**Severity:** 🔴 Critical

**Issue:**  
These blocs are registered via `registerFactory`, meaning every call to `getIt<CartBloc>()` creates a **new** instance. But `app.dart` passes them via `BlocProvider<CartBloc>.value(value: getIt<CartBloc>())`. Since `PoochCareApp` uses `BlocSelector<ThemeStoreBloc, ...>` which rebuilds on theme change, each theme toggle causes `getIt<CartBloc>()` etc. to be called again — returning a freshly constructed bloc, discarding all the previous state (cart count, items, etc.) and leaking the old closed bloc.

```dart
// service_locator.dart
getIt.registerFactory<CartBloc>(...);     // ❌ should be registerLazySingleton
getIt.registerFactory<OrderBloc>(...);    // ❌
getIt.registerFactory<AddressBloc>(...);  // ❌
getIt.registerFactory<CouponsBloc>(...);  // ❌
getIt.registerFactory<OrderDetailBloc>(...); // ❌
```

**Fix:** Change to `registerLazySingleton` for blocs that are placed in the root `MultiBlocProvider`:

```dart
getIt.registerLazySingleton<CartBloc>(
  () => CartBloc(getIt<CartRepository>(), getIt<OrderRepository>()),
);
getIt.registerLazySingleton<OrderBloc>(
  () => OrderBloc(getIt<OrderRepository>(), getIt<CartRepository>()),
);
getIt.registerLazySingleton<AddressBloc>(
  () => AddressBloc(getIt<CartRepository>()),
);
getIt.registerLazySingleton<CouponsBloc>(
  () => CouponsBloc(getIt<CartRepository>(), getIt<AccessoriesRepository>()),
);
getIt.registerLazySingleton<OrderDetailBloc>(
  () => OrderDetailBloc(getIt<OrderRepository>()),
);
```

---

### BUG-05 — `AuthBloc._initGoogleSignIn`: unawaited async call in constructor

**Location:** `lib/features/auth/presentation/bloc/auth_bloc.dart` · constructor  
**Severity:** 🟠 Major

**Issue:**  
`_initGoogleSignIn()` is called in the constructor but is not awaited. If a user triggers Google login before the initialization completes, `_googleSignIn.attemptLightweightAuthentication()` may throw because the instance is not yet initialized.

```dart
AuthBloc(...) : ... {
  // ...
  _initGoogleSignIn(); // ← unawaited Future
}

Future<void> _initGoogleSignIn() async {
  await GoogleSignIn.instance.initialize(serverClientId: AppConfig.serverClientId);
}
```

**Fix:** Track initialization state and wait for it before proceeding in `_onGoogleLoginRequested`:

```dart
late final Future<void> _googleSignInReady;

AuthBloc(...) : ... {
  // ...
  _googleSignInReady = _initGoogleSignIn();
}

Future<void> _onGoogleLoginRequested(...) async {
  emit(state.copyWith(status: AuthStatus.loading, ...));
  try {
    await _googleSignInReady; // ← ensure initialized first
    GoogleSignInAccount? account = await _googleSignIn.attemptLightweightAuthentication();
    // ...
  }
}
```

---

### BUG-06 — `login_screen.dart`: `async` listener called without `await`

**Location:** `lib/features/auth/presentation/view/login_screen.dart` · `BlocListener listener`  
**Severity:** 🟠 Major

**Issue:**  
`_blocListener` is declared `async` but invoked without `await` inside the `BlocListener.listener` callback. This means the future is dropped, and the `if (!context.mounted) return;` guard inside `_blocListener` may execute after the widget is disposed — causing potential widget-tree access on a dead context.

```dart
listener: (context, state) {
  _blocListener(state, context); // ❌ unawaited async call
},

void _blocListener(AuthState state, BuildContext context) async {
  // ...
  await authStoreBloc.stream.firstWhere((s) => s.isAuthenticated);
  if (!context.mounted) return;  // ← too late if widget is already gone
  context.router.replaceAll([const HomeRoute()]);
}
```

**Fix:** Either make the listener a proper async closure or restructure to avoid async operations inside bloc listeners:

```dart
listener: (context, state) async {
  await _blocListener(state, context);
},
```

---

### BUG-07 — `otp_screen.dart` · `onOtpVerificationSuccess`: potential infinite await

**Location:** `lib/features/auth/presentation/view/otp_screen.dart` · `onOtpVerificationSuccess`  
**Severity:** 🟠 Major

**Issue:**  
`await authStoreBloc.stream.firstWhere(...)` and `await userProfileBloc.stream.firstWhere(...)` have no timeout. If the condition is never met (e.g., a network failure prevents `_authStore` from ever emitting `isAuthenticated: true`), or if the bloc is closed while waiting, this will produce an unhandled `StateError` and the screen will hang forever.

```dart
await authStoreBloc.stream.firstWhere(
  (element) => element.splashCompleted && element.introCompleted && element.isAuthenticated,
);
// ↑ No timeout, no error handling — can hang forever
```

**Fix:**

```dart
try {
  await authStoreBloc.stream.firstWhere(
    (s) => s.splashCompleted && s.introCompleted && s.isAuthenticated,
  ).timeout(const Duration(seconds: 10));
} on TimeoutException {
  if (!mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Login timed out. Please try again.')),
  );
  return;
}
```

---

### BUG-08 — `NotificationService`: static `StreamController` closing in instance `dispose()`

**Location:** `lib/core/services/notification_service.dart` · `dispose()`  
**Severity:** 🟠 Major

**Issue:**  
`_trackOrderUpdateController`, `_refreshHomeController`, and `_appointmentEndedController` are **static** fields, but `dispose()` is an **instance** method. Since `NotificationService` is a singleton, calling `dispose()` closes the static stream controllers permanently. Any subsequent attempt to add events to these controllers (e.g., on app resume) will throw `Bad state: Cannot add event after closing`.

```dart
// Static controllers
static final _trackOrderUpdateController = StreamController<Map<String, String>>.broadcast();
static final _refreshHomeController = StreamController<String>.broadcast();
static final _appointmentEndedController = StreamController<String>.broadcast();

// Instance dispose — closes the static controllers
void dispose() {
  _trackOrderUpdateController.close(); // ❌ permanent — can't be re-opened
  _refreshHomeController.close();
  _appointmentEndedController.close();
}
```

**Fix:** Either make all three instance-level (since it's a singleton, equivalent), or expose a static `disposeAll()` and document it as "called only at app termination":

```dart
static void disposeAll() {
  _trackOrderUpdateController.close();
  _refreshHomeController.close();
  _appointmentEndedController.close();
}
```

---

### BUG-09 — `AppFlowGuard`: navigation called on a completed resolve

**Location:** `lib/router/app_router.dart` · `AppFlowGuard.onNavigation`  
**Severity:** 🟡 Minor

**Issue:**  
In the `!isPetOnboarded` branch, `router.replaceAll(...)` is called followed by `resolver.next(false)`. This is correct. But in the `!isOnboarded` branch, `router.replaceAll([CreateParentProfileRoute()])` is called with a **non-const constructor** — `CreateParentProfileRoute()` instead of `const CreateParentProfileRoute()`. While not a crash, it creates a new object every call when `const` would suffice and is more efficient.

```dart
router.replaceAll([CreateParentProfileRoute()]); // ❌ missing const
```

**Fix:**

```dart
router.replaceAll([const CreateParentProfileRoute()]);
```

---

### BUG-10 — `PaginationBloc._performFetch`: `emit` called after `isClosed` race condition

**Location:** `lib/core/pagination/pagination_bloc.dart` · `_performFetch`  
**Severity:** 🟡 Minor

**Issue:**  
There is no guard against the bloc being closed between the `await _fetchPage(...)` call and the subsequent `emit(...)` call. In rapid navigation scenarios (user opens and immediately closes a screen), the bloc may be disposed mid-fetch. While `flutter_bloc` does swallow `emit` calls after close, it logs an assertion error in debug mode and wastes a completed network call.

**Fix:** Add a standard guard:

```dart
final PaginationResult<T> response = await _fetchPage(...);
if (isClosed) return; // ← add this

emit(state.copyWith(...));
```

---

## 2. CODE QUALITY

---

### QUALITY-01 — `app_router.dart`: `BuyPetLandingRoute` registered twice

**Location:** `lib/router/app_router.dart`  
**Severity:** 🟠 Major

**Issue:**  
`BuyPetLandingRoute` appears both as a child of `ServeTabRoute` and as a top-level standalone route. Auto Route may silently use one or the other depending on context, causing unexpected navigation behavior:

```dart
// Inside ServeTabRoute children:
AutoRoute(page: BuyPetLandingRoute.page, initial: true),

// As top-level standalone:
AutoRoute(page: BuyPetLandingRoute.page),  // ← duplicate
```

**Fix:** Remove the top-level duplicate registration. If a standalone deep-link is needed, add a distinct `path` to disambiguate.

---

### QUALITY-02 — `NotificationService`: massive dead (commented-out) code

**Location:** `lib/core/services/notification_service.dart`  
**Severity:** 🟠 Major

**Issue:**  
The file contains hundreds of lines of commented-out code — old navigation logic, old bloc registrations, and entire feature branches. This:

- Obscures the active logic
- Increases cognitive load significantly
- Makes it harder to onboard new developers

**Fix:**  
Delete all commented-out code blocks. Use Git history (`git log -p notification_service.dart`) to recover removed features if needed. The dead code should never live in source — that's what version control is for.

---

### QUALITY-03 — Production router exposes test/debug screens

**Location:** `lib/router/app_router.dart`  
**Severity:** 🟠 Major

**Issue:**  
Routes like `TestDesignRoute`, `AppButtonRoute`, `AppTextInputRoute`, `AppDisplayRoute`, `AppDesignRoute`, `AppNudgesRoute`, `AppListRoute`, `AppListItemRoute`, `AppGridRoute`, `AppFormRoute`, `AppTopTabBarRoute`, `AppTopChipTabBarRoute` are registered in the production router. Any user who discovers the URL schema can navigate to these screens in production.

**Fix:**  
Wrap all test routes with a compile-time flag:

```dart
if (kDebugMode) ...[
  AutoRoute(page: TestDesignRoute.page),
  AutoRoute(page: AppButtonRoute.page),
  // ...
],
```

---

### QUALITY-04 — Magic strings throughout auth flow

**Location:** Multiple files — `auth_bloc.dart`, `otp_screen.dart`, auth repository  
**Severity:** 🟠 Major

**Issue:**  
Auth type strings (`'login'`, `'register'`), notification data keys (`'nav'`, `'tipId'`, `'eventId'`, `'orderId'`, `'appointmentId'`), and notification channel IDs (`'high_importance_channel'`) are scattered across multiple files as raw string literals. Any typo causes a silent failure.

```dart
// otp_screen.dart
if (otpResult.type == 'register') { ... }
if (otpResult.type == 'login') { ... }

// notification_service.dart
if (message.data['type'] == 'order_status_change') { ... }
```

**Fix:**  
Extract to constants:

```dart
abstract class AuthType {
  static const String login = 'login';
  static const String register = 'register';
}

abstract class NotificationKeys {
  static const String nav = 'nav';
  static const String orderId = 'orderId';
  static const String tipId = 'tipId';
  // ...
}

abstract class NotificationChannels {
  static const String highImportance = 'high_importance_channel';
}
```

---

### QUALITY-05 — `HomeScreen._drawerItem` rebuilt as instance field with closures

**Location:** `lib/features/home/presentation/view/home_screen.dart` · `_HomeScreenState`  
**Severity:** 🟡 Minor

**Issue:**  
`_drawerItem` is declared as a `final List<DrawerItem>` instance field in `_HomeScreenState`. Because it's initialized inline with lambda expressions, it cannot be `const`, but it's recreated fresh for each `_HomeScreenState` creation. More importantly, a number of drawer children have `onPressed: (context) { log('...'); }` — these are placeholder stubs with no implementation and no TODO markers, making it invisible to an automated sweep to find incomplete features.

**Fix:**

- Mark all no-op handlers with `// TODO: implement X`:

```dart
onPressed: (context) {
  // TODO: implement Virtual Accessories navigation
},
```

- Move the list to a static method or extract it to a dedicated drawer builder file.

---

### QUALITY-06 — `GlobalUpdateBus` registered but effectively unused

**Location:** `lib/core/di/service_locator.dart` + `lib/core/sync/global_update_bus.dart`  
**Severity:** 🔵 Suggestion

**Issue:**  
`GlobalUpdateBus<dynamic>` is registered as a singleton in `setupDI()` but is never accessed via `getIt<GlobalUpdateBus>()` anywhere in the scanned codebase. The class itself is clean, but an unused DI registration adds noise and confusion.

**Fix:**  
Either wire it up as intended (as a cross-feature event bus), or remove the registration and the class until needed.

---

### QUALITY-07 — `AuthRepository.login` and `verifyOtp` — unused legacy methods

**Location:** `lib/features/auth/repository/auth_repository.dart`  
**Severity:** 🔵 Suggestion

**Issue:**  
`login(email, password)` and `sendOtp(phone)` and `verifyOtp(phone, otp)` exist in `AuthRepository` but are never called from any bloc or screen. These are the old password-based and simple OTP methods, superseded by `loginWithOtp`, `verifyOtpCode`, etc.

**Fix:**  
Remove dead repository methods. If they must be kept for future backward-compatibility, annotate with `@Deprecated(...)`.

---

## 3. PERFORMANCE ISSUES

---

### PERF-01 — `NotificationService.initLocalNotifications`: Android notification channel created twice

**Location:** `lib/core/services/notification_service.dart` · `initLocalNotifications`  
**Severity:** 🟠 Major

**Issue:**  
`androidPlugin?.createNotificationChannel(channel)` is called **twice** — once before `initialize()` and once inline after it. While not crashing (Android silently ignores duplicate channel creation), it performs an unnecessary platform channel call on every app start.

```dart
await androidPlugin?.createNotificationChannel(channel); // ← called here

await _flutterLocalNotificationsPlugin.initialize(...);

await _flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel); // ← called again ❌
```

**Fix:** Remove the second `createNotificationChannel` call. One call after init is sufficient per Android documentation.

---

### PERF-02 — Missing `const` constructors in widget subtrees

**Location:** Multiple widget files  
**Severity:** 🟡 Minor

**Issue:**  
Across many widget files, leaf widgets that could be declared `const` are not. For example, in `otp_screen.dart`:

```dart
// ❌
const SizedBox(width: 48),            // ✅ already has const
const Spacer(),                        // ✅ already has const
SnackBar(content: Text('Enter the 4 digit OTP.')), // ❌ missing const
```

While individually small, across 991 files in a complex widget tree, missing `const` means the Flutter framework cannot short-circuit diffing for these nodes.

**Fix:**  
Run `flutter analyze` and address all `prefer_const_constructors` lint warnings from the configured `analysis_options.yaml`.

---

### PERF-03 — `HomeBloc._onHomeDataRequested`: error swallows all exception types silently

**Location:** `lib/features/home/presentation/bloc/home_bloc.dart` · `_onHomeDataRequested`  
**Severity:** 🟡 Minor (also Error Handling)

**Issue:**  
The catch clause is `catch (_)` — the exception is discarded entirely. Dio network errors, `ApiException`, parse failures are all silenced with the same generic message `'Unable to load dashboard data.'`. This makes server-side issues invisible during development and impossible to diagnose in production without Crashlytics.

```dart
} catch (_) {
  emit(state.copyWith(
    status: HomeStatus.error,
    errorMessage: 'Unable to load dashboard data.',
  ));
}
```

**Fix:**

```dart
} catch (e, st) {
  CrashlyticsService.recordError(e, st); // always log to crash reporting
  final message = e is ApiException ? e.message : 'Unable to load dashboard data.';
  emit(state.copyWith(status: HomeStatus.error, errorMessage: message));
}
```

---

### PERF-04 — `app.dart`: `PoochCareApp` is `StatelessWidget` with mutable side effects in `build`

**Location:** `lib/app.dart`  
**Severity:** 🟡 Minor

**Issue:**  
`PoochCareApp` is a `StatelessWidget`, yet its `build` method contains `WidgetsBinding.instance.addPostFrameCallback`. Stateless widgets should have pure, side-effect-free build methods. The interaction between `BlocSelector` rebuilds and repeated callback registration is subtle and hard for future maintainers to reason about.

**Fix:**  
Convert `PoochCareApp` to a `StatefulWidget` and move all side effects to `initState` (see BUG-03 fix above).

---

## 4. FLUTTER/DART BEST PRACTICES

---

### PRACTICE-01 — `BuildContext` used across async gaps in multiple screens

**Location:** `otp_screen.dart`, `login_screen.dart`  
**Severity:** 🟠 Major

**Issue:**  
Throughout the auth screens, `BuildContext` is used after `await` calls without proper `mounted` checks immediately after each `await`:

```dart
// otp_screen.dart - _verifyOtp()
final deviceId = await notificationService.getDeviceId(); // ← async gap
// no mounted check here
context.read<AuthBloc>().add(...); // ← could access dead context
```

```dart
// otp_screen.dart - _handleRegisterOtpSuccess()
final accepted = await showAcceptInviteBottomSheet(...); // ← async gap
if (accepted == null || !listenerContext.mounted) {
  return; // ← checks listenerContext.mounted but continues using `context`
}
authStoreBloc.add(...);
if (!mounted) return; // ← late check
context.router.replaceAll([...]); // ← could this already be unmounted?
```

**Fix:**  
Add an explicit `if (!mounted) return;` immediately after **every** `await` that is followed by `context.*` usage:

```dart
final deviceId = await notificationService.getDeviceId();
if (!mounted) return; // ← add immediately here
final fcmToken = await notificationService.getDeviceToken() ?? '';
if (!mounted) return; // ← and here
context.read<AuthBloc>().add(...);
```

---

### PRACTICE-02 — `AuthBloc._onLogoutRequested`: no error handling

**Location:** `lib/features/auth/presentation/bloc/auth_bloc.dart` · `_onLogoutRequested`  
**Severity:** 🟡 Minor

**Issue:**  
Logout calls `_repository.logout()` and `_sessionResetService.clearSessionData()` without a `try/catch`. If either fails (e.g., network timeout on the logout API call), the user remains authenticated in state despite intending to log out.

```dart
Future<void> _onLogoutRequested(...) async {
  await _repository.logout();               // ← can throw
  await _sessionResetService.clearSessionData(); // ← can also throw
  emit(state.copyWith(status: AuthStatus.initial, ...));
}
```

**Fix:**

```dart
Future<void> _onLogoutRequested(...) async {
  try {
    await _repository.logout();
  } catch (e, st) {
    CrashlyticsService.recordError(e, st);
    // best-effort logout: continue even if the API call fails
  }
  await _sessionResetService.clearSessionData();
  emit(state.copyWith(status: AuthStatus.initial, clearError: true));
}
```

---

### PRACTICE-03 — `NotificationService.refreshNotificationToken`: creates a new listener each call

**Location:** `lib/core/services/notification_service.dart` · `refreshNotificationToken`  
**Severity:** 🟡 Minor

**Issue:**  
Each call to `refreshNotificationToken()` calls `messaging.onTokenRefresh.listen(...)` which creates a new `StreamSubscription` that is **never cancelled**. If this method is called multiple times, multiple listeners accumulate and each token refresh triggers all of them simultaneously:

```dart
Future<void> refreshNotificationToken() async {
  final _dio = getIt<Dio>();
  // ...
  messaging.onTokenRefresh.listen((newToken) async { // ← new subscription each call
    await _dio.put('/user/notification-token', data: {...});
  });
}
```

**Fix:**  
Store and cancel the subscription:

```dart
StreamSubscription<String>? _tokenRefreshSubscription;

Future<void> refreshNotificationToken() async {
  await _tokenRefreshSubscription?.cancel();
  _tokenRefreshSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    // ...
  });
}
```

---

### PRACTICE-04 — `OtpScreen._secondsRemaining` initialized to 26 (magic number)

**Location:** `lib/features/auth/presentation/view/otp_screen.dart`  
**Severity:** 🟡 Minor

**Issue:**  
The OTP resend timer is initialized to `26` seconds — a magic number with no explanation. The number is also reset to `26` in `_startResendTimer`. If the product requirement changes to 30 or 60 seconds, this must be changed in multiple places.

```dart
int _secondsRemaining = 26; // ← why 26?
// ...
_secondsRemaining = 26; // ← duplicated
```

**Fix:**

```dart
static const int _kResendOtpCooldownSeconds = 30; // or 60

int _secondsRemaining = _kResendOtpCooldownSeconds;
// ...
_secondsRemaining = _kResendOtpCooldownSeconds;
```

---

### PRACTICE-05 — `ErrorInterceptor`: 401 handler does nothing

**Location:** `lib/core/network/error_interceptor.dart` · `onError`  
**Severity:** 🟡 Minor

**Issue:**  
When a `401 Unauthorized` response is received, `ErrorInterceptor` only logs a debug message and passes the error through. The `AuthInterceptor` + `AuthTokenManager` combination handles token refresh on the way **out** (before request), but there is no retry logic after a 401 response comes **back** (e.g., when the token expires mid-flight before `AuthInterceptor` caught it). The interceptor should at least signal `AuthStoreBloc` if the refresh path also fails.

```dart
case DioExceptionType.badResponse:
  if (statusCode == 401) {
    if (kDebugMode) debugPrint('Unauthorized - token expired'); // ← debug only, no action
  }
```

**Fix:** This is partially mitigated by `AuthTokenManager._expireSession()`, but the token refresh only happens **before** the request. If the backend returns a 401 for a valid-looking token, there's no retry. Consider adding a `RetryInterceptor` or documenting why the current approach is sufficient.

---

### PRACTICE-06 — `_firebaseMessagingBackgroundHandler` missing `Firebase.initializeApp()`

**Location:** `lib/core/services/notification_service.dart`  
**Severity:** 🟡 Minor

**Issue:**  
Firebase documentation requires that top-level background message handlers call `await Firebase.initializeApp()` because they execute in a separate Dart isolate. The current handler is empty which silently works _by accident_ — but if future logic is added, it will crash:

```dart
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Empty — works by accident; WidgetsFlutterBinding not guaranteed
}
```

**Fix:**

```dart
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // handle message...
}
```

---

## 5. ERROR HANDLING

---

### ERROR-01 — `_verifyOtp`: empty catch silently discards device ID errors

**Location:** `lib/features/auth/presentation/view/otp_screen.dart` · `_verifyOtp`  
**Severity:** 🟡 Minor

**Issue:**

```dart
try {
  deviceId = await notificationService.getDeviceId();
  fcmToken = await notificationService.getDeviceToken() ?? '';
  // ignore: empty_catches
} catch (e) {}
```

The `// ignore: empty_catches` annotation explicitly suppresses the lint rule but the underlying risk remains — if `getDeviceId()` throws on a specific device model (e.g., ANDROID_ID unavailable), the device ID silently becomes `''` and FCM token registration fails silently too. This should at least log to Crashlytics.

**Fix:**

```dart
try {
  deviceId = await notificationService.getDeviceId();
  fcmToken = await notificationService.getDeviceToken() ?? '';
} catch (e, st) {
  CrashlyticsService.recordError(e, st); // log but don't block OTP
}
```

---

### ERROR-02 — `CartBloc._onFetchCartCount`: silently swallows all errors

**Location:** `lib/features/ecommerce/presentation/bloc/cart/cart_bloc.dart` · `_onFetchCartCount`  
**Severity:** 🟡 Minor

**Issue:**

```dart
} catch (_) {
  // Silently ignore errors for count fetch
}
```

Silent failures mean the cart badge count may show `0` or a stale number without any indication to the user or developer. The comment acknowledges this is intentional, but errors should still be logged.

**Fix:**

```dart
} catch (e, st) {
  CrashlyticsService.recordError(e, st);
  // Don't emit failure state — badge count mismatch is non-critical
}
```

---

### ERROR-03 — `SessionResetService.clearSessionData`: `HydratedBloc.storage.clear()` is fire-and-forget for individual blocs

**Location:** `lib/core/services/session_reset_service.dart` · `clearSessionData`  
**Severity:** 🟡 Minor

**Issue:**  
`await HydratedBloc.storage.clear()` wipes all persisted state atomically. The subsequent individual `_authStore.add(UserSignedOut())`, `_petsStore.add(PetsCleared())` etc. are dispatched asynchronously. If the app is killed between the storage clear and the dispatching of events, the stores may still hold stale in-memory data on reactive screens that rebuild from them. On next app launch, the state reconstruction from `fromJson` will return `null` (cleared), so HydratedBloc will use the initial state — that's correct, but **in the same session**, components depending on the blocs adding their cleared events are in a race.

**Fix:** Ensure the order is: first clear events, then clear storage:

```dart
// Dispatch clears first so in-memory blocs reflect cleared state
_authStore.add(const UserSignedOut());
_petsStore.add(const PetsCleared());
// ... other clears ...

// Then clear persisted storage
await HydratedBloc.storage.clear();
await _tokenStorage.clear();
await storage.clearAll();
await _clearImageCache();
```

---

### ERROR-04 — `PaginationBloc._performFetch`: error message uses `e.toString()` directly

**Location:** `lib/core/pagination/pagination_bloc.dart` · `_performFetch`  
**Severity:** 🔵 Suggestion

**Issue:**

```dart
} catch (e) {
  emit(state.copyWith(errorMessage: e.toString()));
}
```

`e.toString()` on a `DioException` emits the entire Dio internal message (including stack trace snippets and URLs) directly into UI state — potentially exposing API endpoint structure to end users via error toasts/banners.

**Fix:**

```dart
} catch (e, st) {
  CrashlyticsService.recordError(e, st);
  final friendlyMessage = e is ApiException
      ? e.message
      : 'Something went wrong. Please try again.';
  emit(state.copyWith(
    isLoading: false,
    isFetchingMore: false,
    isRefreshing: false,
    errorMessage: friendlyMessage,
  ));
}
```

---

## 6. Summary Table

| Category                    | 🔴 Critical | 🟠 Major | 🟡 Minor | 🔵 Suggestion | Total  |
| --------------------------- | ----------- | -------- | -------- | ------------- | ------ |
| Logical Bugs                | 4           | 3        | 3        | 0             | **10** |
| Code Quality                | 0           | 3        | 2        | 2             | **7**  |
| Performance                 | 0           | 1        | 3        | 0             | **4**  |
| Flutter/Dart Best Practices | 0           | 1        | 5        | 0             | **6**  |
| Error Handling              | 0           | 0        | 3        | 1             | **4**  |
| **TOTAL**                   | **4**       | **8**    | **16**   | **3**         | **31** |

---

## 7. Top 3 Priority Fixes

### 🥇 Priority 1 — BUG-04: Fix Factory vs Singleton mismatch for root-level Blocs

`CartBloc`, `OrderBloc`, `AddressBloc`, `CouponsBloc`, and `OrderDetailBloc` are registered as `registerFactory` but placed in the root `MultiBlocProvider` via `.value`. On any theme toggle or root rebuild, `getIt<CartBloc>()` returns a **brand-new** instance, silently replacing the running one. This means the cart count resets to 0, any pending add-to-cart operations are lost, and the old bloc leaks. This is the highest-risk bug because it manifests silently with no crash — only subtle data loss.

**Action:** `lib/core/di/service_locator.dart` — change the 5 affected blocs from `registerFactory` → `registerLazySingleton`.

---

### 🥈 Priority 2 — BUG-01: Fix Wishlist Rollback Count Bugs

The cart count badge shown to users will drift in the wrong direction on every failed wishlist API call. After enough failures, it can show a negative count or a wildly incorrect number. Users who experience flaky networks (common on mobile) will have a permanently broken wishlist counter until they restart the app. The fix is a two-line change per pathway.

**Action:** `lib/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart` — correct the +/- direction and the action messages in both rollback branches.

---

### 🥉 Priority 3 — BUG-02: Fix `primaryIdentifier` overwrite on first sign-in

Every new user who signs in via OTP or social login will have their `primaryIdentifier` wiped to `null` by `AuthStoreBloc._onUserSignedIn`. The `AppFlowGuard` then branches incorrectly — treating all users as if their identifier is `null` — meaning `isEmail` is always `false`, and the wrong onboarding inputs (phone vs email) are pre-populated. This is a data-correctness bug that silently corrupts UX for every new registration.

**Action:** `lib/core/store/auth/auth_store_bloc.dart` · `_onUserSignedIn` — prefer `event.user.primaryIdentifier` and only fall back to the cached value.

---

_End of Code Review — Pooch Flutter Native_

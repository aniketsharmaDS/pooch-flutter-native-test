import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/store/appointments/appointments_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_state.dart';
import 'package:poochcare/core/store/cart/cart_store_bloc.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_bloc.dart';
import 'package:poochcare/core/store/onboarding/onboarding_journey_store_event.dart';
import 'package:poochcare/core/store/pets/pets_store_bloc.dart';
import 'package:poochcare/core/store/products/products_store_bloc.dart';
import 'package:poochcare/core/store/theme/theme_store_bloc.dart';
import 'package:poochcare/core/store/theme/theme_store_state.dart';
import 'package:poochcare/core/store/videos/videos_store_bloc.dart';
import 'package:poochcare/core/theme/app_theme.dart';
import 'package:poochcare/core/widgets/feedback/app_snack_bar.dart';
import 'package:poochcare/core/widgets/global_loader_overlay.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/address_bloc/address_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/cart/cart_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/coupons/coupons_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/order_details/order_details_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/orders/order_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_event.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/wishlist/wishlist_state.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_bloc.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:poochcare/features/settings/presentation/bloc/settings_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';
import 'package:poochcare/main.dart';
import 'package:poochcare/router/app_router.dart';
import 'package:poochcare/router/router_service.dart';

class PoochCareApp extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  PoochCareApp({super.key});

  // final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        // Store Blocs — app-lifetime singletons
        BlocProvider<AuthStoreBloc>.value(value: getIt<AuthStoreBloc>()),
        BlocProvider<OnboardingJourneyStoreBloc>.value(
          value: getIt<OnboardingJourneyStoreBloc>(),
        ),
        BlocProvider<PetsStoreBloc>.value(value: getIt<PetsStoreBloc>()),
        BlocProvider<AppointmentsStoreBloc>.value(
          value: getIt<AppointmentsStoreBloc>(),
        ),
        BlocProvider<BuyPetLandingBloc>.value(
          value: getIt<BuyPetLandingBloc>()
            ..add(const FetchRecentlyViewedOnly()),
        ),
        BlocProvider<WishlistBloc>.value(value: getIt<WishlistBloc>()),
        BlocProvider<CartBloc>.value(value: getIt<CartBloc>()),
        BlocProvider<AddressBloc>.value(value: getIt<AddressBloc>()),
        BlocProvider<OrderBloc>.value(value: getIt<OrderBloc>()),

        BlocProvider<OrderDetailBloc>.value(value: getIt<OrderDetailBloc>()),
        BlocProvider<CouponsBloc>.value(value: getIt<CouponsBloc>()),
        BlocProvider<CartStoreBloc>.value(value: getIt<CartStoreBloc>()),
        BlocProvider<ThemeStoreBloc>.value(value: getIt<ThemeStoreBloc>()),
        BlocProvider<SettingsBloc>.value(value: getIt<SettingsBloc>()),
        BlocProvider<ClinicBloc>.value(value: getIt<ClinicBloc>()),
        BlocProvider<SubscribedClinicsBloc>.value(
          value: getIt<SubscribedClinicsBloc>(),
        ),
        BlocProvider<AppointmentBloc>.value(value: getIt<AppointmentBloc>()),
        BlocProvider<MedicalHistoryBloc>.value(
          value: getIt<MedicalHistoryBloc>(),
        ),
        BlocProvider<ProductsStoreBloc>.value(
          value: getIt<ProductsStoreBloc>(),
        ),

        // BlocProvider<CommunityStoreBloc>.value(
        //   value: getIt<CommunityStoreBloc>(),
        // ),
        BlocProvider<VideosStoreBloc>.value(value: getIt<VideosStoreBloc>()),
        // ✅ User Profile (lazy singleton, available app-wide)
        BlocProvider<UserProfileBloc>.value(value: getIt<UserProfileBloc>()),
      ],
      child: BlocSelector<ThemeStoreBloc, ThemeStoreState, ThemeMode>(
        selector: (ThemeStoreState state) => state.themeMode,
        builder: (BuildContext context, ThemeMode themeMode) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              // I want to trigger wishlist sync here when the app starts, so that if user has any changes from other devices, it will be reflected here.
              // App starts → wishlistIds empty
              // Fetch → fills wishlistIds
              // Badge becomes correct
              // context.read<WishlistBloc>().add(FetchWishlistCountEvent());

              // WidgetsBinding.instance.addPostFrameCallback((_) {
              //   final authState = context.read<AuthStoreBloc>().state;

              //   if (authState.isAuthenticated) {
              //     context.read<WishlistBloc>().add(FetchWishlistCountEvent());
              //     context.read<CartBloc>().add(const FetchCartCountEvent());
              //   }
              // });
              return MultiBlocListener(
                listeners: [
                  BlocListener<AuthStoreBloc, AuthStoreState>(
                    listenWhen: (previous, current) =>
                        previous.isAuthenticated != current.isAuthenticated,
                    listener: (context, state) {
                      // if (!state.isAuthenticated) {
                      //   _appRouter.replaceAll([const LoginRoute()]);
                      // }
                      if (!state.isAuthenticated) {
                        context.read<OnboardingJourneyStoreBloc>().add(
                          const OnboardingJourneyCleared(),
                        );
                        // 🔥 CLEAR OLD USER DATA
                        context.read<WishlistBloc>().add(ResetWishlistEvent());
                        context.read<CartBloc>().add(const ResetCartEvent());

                        appRouter.replaceAll([const LoginRoute()]);
                      } else {
                        context.read<WishlistBloc>().add(
                          FetchWishlistCountEvent(),
                        );
                      }
                    },
                  ),
                  BlocListener<UserProfileBloc, UserProfileState>(
                    listenWhen: (previous, current) {
                      return previous.profile?.languagePreference !=
                          current.profile?.languagePreference;
                    },

                    listener: (context, state) async {
                      final language = state.profile?.languagePreference;

                      if (language == null || language.trim().isEmpty) {
                        return;
                      }

                      final currentLanguage = context.locale.languageCode;

                      if (currentLanguage == language) {
                        return;
                      }

                      await context.setLocale(Locale(language));
                      Intl.defaultLocale = language; // ADD THIS

                      if (!context.mounted) {
                        return;
                      }

                      context.read<SettingsBloc>().add(
                        SyncLanguageLocally(language),
                      );
                    },
                  ),
                  BlocListener<WishlistBloc, WishlistState>(
                    listenWhen: (prev, curr) => prev.actionId != curr.actionId,
                    listener: (context, state) {
                      if (state.actionMessage != null) {
                        AppSnackBar.show(
                          state.actionMessage!,
                          type: state.actionMessage!.contains('Failed')
                              ? SnackbarType.error
                              : SnackbarType.success,
                        );
                      }
                    },
                  ),
                ],
                child: MaterialApp.router(
                  scaffoldMessengerKey: scaffoldMessengerKey,
                  title: 'Pooch',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.light(),
                  darkTheme: AppTheme.dark(),
                  themeMode: themeMode,
                  locale: context.locale,
                  supportedLocales: context.supportedLocales,
                  localizationsDelegates: context.localizationDelegates,
                  // home: const CouponsScreen(),
                  routerConfig: appRouter.config(),
                  // This is Old One before TextScaler
                  // builder: (context, child) =>
                  //     GlobalLoaderOverlay(child: child!),
                  //
                  // This is New One with TextScaler added to hadle the font scaling issue.
                  // We are clamping the text scaler to a max of 1.2 to prevent the UI from breaking.
                  builder: (context, child) {
                    Intl.defaultLocale = context.locale.toString();
                    final mq = MediaQuery.of(context);
                    final scaler = mq.textScaler;
                    final clampedScaler = scaler.clamp(
                      minScaleFactor: 0.95,
                      maxScaleFactor: 1.2,
                    );
                    return MediaQuery(
                      data: mq.copyWith(textScaler: clampedScaler),
                      child: GlobalLoaderOverlay(child: child!),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

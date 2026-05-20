import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/utils/url_utils.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_event.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_state.dart';
import 'package:poochcare/features/auth/presentation/widgets/accept_invite_bottom_sheet.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Keep this switch for future use:
  // true  -> block on splash API failure and show retry/error UI
  // false -> bypass failures and continue app flow
  static const bool _requireSplashApiSuccess = false;

  late final AuthBloc _authBloc;
  late final SecureStorageService _secureStorageService;

  bool _isTransitioning = false;
  bool _isLoadingSplashData = true;
  String? _splashError;

  @override
  void initState() {
    super.initState();
    _authBloc = getIt<AuthBloc>()..add(const AuthStarted());
    _secureStorageService = getIt<SecureStorageService>();
    _startSplashFlow();
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  Future<void> _startSplashFlow() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }
    _authBloc.add(const FetchUserSplashRequested());
  }

  Future<void> _onSplashApiSuccess(Map<String, dynamic> splashData) async {
    if (_isTransitioning) {
      return;
    }
    _isTransitioning = true;

    try {
      await _secureStorageService.writeUserSplashData(splashData);
      await _cacheSplashImages(splashData);
      await _completeSplash();
    } catch (_) {
      await _handleSplashFailure(
        'Unable to process splash data. Please retry.',
      );
    }
  }

  Future<void> _handleSplashFailure(String message) async {
    if (!_requireSplashApiSuccess) {
      _splashError = null;
      _isLoadingSplashData = false;
      if (_isTransitioning) {
        return;
      }
      _isTransitioning = true;
      await _completeSplash();
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isLoadingSplashData = false;
      _splashError = message;
    });
    _isTransitioning = false;
  }

  Future<void> _cacheSplashImages(Map<String, dynamic> splashData) async {
    final dynamic splashListRaw = splashData['splash_list'];
    if (splashListRaw is! List<dynamic>) {
      return;
    }

    final List<String> imageUrls = splashListRaw
        .whereType<Map<String, dynamic>>()
        .map((item) => resolveNetworkImageUrl(item['imageUrl']?.toString()))
        .whereType<String>()
        .where((url) => url.isNotEmpty)
        .toList(growable: false);

    for (final String imageUrl in imageUrls) {
      if (!mounted) {
        return;
      }
      try {
        log('imageUrl: $imageUrl');
        await precacheImage(CachedNetworkImageProvider(imageUrl), context);
      } catch (_) {
        // Keep splash flow resilient even when one image cache fails.
      }
    }
  }

  Future<void> _completeSplash() async {
    if (!mounted) {
      return;
    }
    final authStore = context.read<AuthStoreBloc>();
    if (!authStore.state.splashCompleted) {
      authStore.add(const SplashCompleted());
      await authStore.stream.firstWhere((state) => state.splashCompleted);
      if (!mounted) {
        return;
      }
    }

    await _handleInviteSheetIfRequired();
    if (!mounted) {
      return;
    }
    if (authStore.state.user?.hasBoughtPet == true &&
        authStore.state.user?.isPetOnboarded == true &&
        authStore.state.user?.isOnboarded == false) {
      context.router.replaceAll([CreateParentProfileRoute()]);
    } else {
      context.router.replaceAll([const HomeRoute()]);
    }
  }

  void _retrySplashContentFetch() {
    setState(() {
      _isLoadingSplashData = true;
      _splashError = null;
    });
    _authBloc.add(const FetchUserSplashRequested());
  }

  Future<void> _handleInviteSheetIfRequired() async {
    final authStore = context.read<AuthStoreBloc>();
    final authState = authStore.state;
    final user = authState.user;

    final shouldShowInviteSheet =
        authState.isAuthenticated &&
        user != null &&
        !user.isPetOnboarded &&
        !user.isOnboarded &&
        !authState.inviteSheetSkipped;

    if (!shouldShowInviteSheet) {
      return;
    }

    final inviteBloc = getIt<InviteBloc>();
    try {
      final accepted = await showAcceptInviteBottomSheet(
        context: context,
        inviteBloc: inviteBloc,
        emailOrPhone: user.email?.trim().isNotEmpty == true
            ? user.email!.trim()
            : (user.phone?.trim() ?? ''),
      );

      if (!mounted || accepted == null) {
        return;
      }

      if (accepted) {
        authStore.add(const PetOnboardingCompleted());
        authStore.add(const InviteSheetSkipCleared());
      } else {
        authStore.add(const InviteSheetSkipped());
      }
    } finally {
      await inviteBloc.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (BuildContext context, AuthState state) {
        if (state.requestType != AuthRequestType.userSplash) {
          return;
        }

        if (state.status == AuthStatus.loading) {
          if (!mounted) {
            return;
          }
          setState(() {
            _isLoadingSplashData = true;
            _splashError = null;
          });
          return;
        }

        if (state.status == AuthStatus.failure) {
          _handleSplashFailure(
            state.errorMessage ?? 'Failed to load splash content.',
          );
          return;
        }

        if (state.status == AuthStatus.success &&
            state.userSplashData != null) {
          _onSplashApiSuccess(state.userSplashData!);
        }
      },
      child: AppPrimaryBgContainer(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: AppSize.cs200.h,
                width: AppSize.cs200.w,
                child: AppIcon(AppIcons.svg.generic.poochLogo),
              ),
              if (_isLoadingSplashData)
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              if (_splashError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        _splashError!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _retrySplashContentFetch,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
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
  @override
  void initState() {
    super.initState();
    _completeSplash();
  }

  Future<void> _completeSplash() async {
    await Future<void>.delayed(const Duration(seconds: 2));
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

    context.router.replaceAll([const HomeRoute()]);
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
    return AppPrimaryBgContainer(
      child: Center(
        child: SizedBox(
          height: AppSize.cs200.h,
          width: AppSize.cs200.w,
          child: AppIcon(AppIcons.svg.generic.poochLogo),
        ),
      ),
    );
  }
}

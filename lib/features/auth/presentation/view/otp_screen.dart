import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/domain/models/user.dart';
import 'package:poochcare/core/services/notification_service.dart';
import 'package:poochcare/core/services/snackbar_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_otp_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/auth/domain/models/otp_verification_result.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_event.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_state.dart';
import 'package:poochcare/features/auth/presentation/widgets/accept_invite_bottom_sheet.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class OtpScreen extends StatefulWidget implements AutoRouteWrapper {
  const OtpScreen({
    super.key,
    required this.emailOrPhone,
    required this.countryCode,
    this.type = 'register',
  });

  final String emailOrPhone;
  final String countryCode;
  final String type;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>()..add(const AuthStarted()),
        ),
        BlocProvider<InviteBloc>(create: (_) => getIt<InviteBloc>()),
        BlocProvider<UserProfileBloc>.value(value: getIt<UserProfileBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  Timer? _resendTimer;
  int _secondsRemaining = 26;
  bool _isVerifyingOtp = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
    _startResendTimer();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() {
      _secondsRemaining = 26;
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() {
          _secondsRemaining = 0;
        });
      } else {
        setState(() {
          _secondsRemaining -= 1;
        });
      }
    });
  }

  void _resendOtp() {
    context.read<AuthBloc>().add(
      SendOtpCodeRequested(emailOrPhone: widget.emailOrPhone),
    );
  }

  void _verifyOtp() async {
    FocusScope.of(context).unfocus();
    final status = context.read<AuthBloc>().state.status;
    if (_isVerifyingOtp || status == AuthStatus.loading) {
      return;
    }
    final otp = _otpController.text.trim();
    if (otp.length < 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter the 4 digit OTP.')));
      return;
    }

    String deviceId = '';
    String fcmToken = '';
    try {
      final notificationService = NotificationService();
      deviceId = await notificationService.getDeviceId();
      fcmToken = await notificationService.getDeviceToken() ?? '';
      // ignore: empty_catches
    } catch (e) {}
    final deviceType = Platform.isAndroid ? 'Android' : 'iOS';

    setState(() => _isVerifyingOtp = true);
    if (!mounted) return;
    context.read<AuthBloc>().add(
      VerifyOtpCodeRequested(
        emailOrPhone: widget.emailOrPhone,
        otpCode: otp,
        type: widget.type,
        deviceId: deviceId,
        fcmToken: fcmToken,
        deviceType: deviceType,
      ),
    );
  }

  String get _targetLabel {
    if (widget.emailOrPhone.contains('@')) {
      return widget.emailOrPhone;
    }
    return '+${widget.countryCode} - ${widget.emailOrPhone}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) =>
                previous.status != current.status ||
                previous.errorMessage != current.errorMessage,
            listener: (listenerContext, state) async {
              // Reset verifying flag when operation completes
              if (state.status != AuthStatus.loading) {
                setState(() => _isVerifyingOtp = false);
              }
              if (state.status == AuthStatus.failure &&
                  state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
              if (state.status == AuthStatus.success &&
                  state.otpResult != null) {
                await _handleOtpSuccess(listenerContext, state.otpResult!);
              }
              final resendMessage = state.otpSendResult?.message ?? '';
              if (state.status == AuthStatus.success &&
                  resendMessage.isNotEmpty) {
                CustomSnackbar.show(resendMessage, SnackbarType.success);
                _startResendTimer();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s16.w,
                vertical: AppSpacing.s16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => context.router.maybePop(),
                      ),
                      Expanded(
                        child: AppText.h1(
                          'Verify OTP',
                          textAlign: TextAlign.center,
                          fontSize: AppFontSize.fs16,
                          color: AppColors.p4_600,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                  AppSpacing.s30.hBox,
                  AppText.h1(
                    'Enter 4 digit OTP',
                    fontSize: AppFontSize.fs24,
                    color: AppColors.textPrimary,
                  ),
                  AppSpacing.s5.hBox,
                  AppText.h4(
                    'OTP has been sent to $_targetLabel',
                    color: AppColors.textPrimary,
                    fontSize: AppFontSize.fs14,
                  ),
                  AppSpacing.s16.hBox,
                  AppOtpField(
                    controller: _otpController,
                    focusNode: _focusNode,
                    onCompleted: (_) => _verifyOtp(),
                  ),
                  AppSpacing.s14.hBox,
                  if (_secondsRemaining > 0)
                    AppText.bodyS(
                      'Resend OTP in $_secondsRemaining sec',
                      color: AppColors.p4_300,
                      fontSize: AppFontSize.fs12,
                    )
                  else
                    AppButton(
                      label: 'Resend OTP',
                      variant: AppButtonVariant.text,
                      size: AppButtonSize.xSmall,
                      width: null,
                      textStyle: TextStyle(fontSize: AppFontSize.fs12),
                      height: AppSpacing.s24.h,
                      padding: EdgeInsets.zero,
                      onPressed: _resendOtp,
                      foregroundColor: AppColors.p4_300,
                    ),
                  const Spacer(),
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (prev, curr) => prev.status != curr.status,
                    builder: (context, state) {
                      return AppButton(
                        label: 'Verify OTP',
                        isLoading:
                            _isVerifyingOtp &&
                            state.status == AuthStatus.loading,
                        onPressed: state.status == AuthStatus.loading
                            ? null
                            : _verifyOtp,
                      );
                    },
                  ),
                  AppSpacing.s24.hBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleOtpSuccess(
    BuildContext listenerContext,
    OtpVerificationResult otpResult,
  ) async {
    if (otpResult.type == 'register') {
      await _handleRegisterOtpSuccess(listenerContext);
      return;
    }

    if (otpResult.type == 'login') {
      await _handleLoginOtpSuccess(listenerContext, otpResult);
    }
  }

  Future<void> _handleRegisterOtpSuccess(BuildContext listenerContext) async {
    final authStoreBloc = context.read<AuthStoreBloc>();
    final accepted = await showAcceptInviteBottomSheet(
      context: context,
      inviteBloc: context.read<InviteBloc>(),
      emailOrPhone: widget.emailOrPhone,
    );

    if (accepted == null || !listenerContext.mounted) {
      return;
    }

    if (accepted) {
      authStoreBloc.add(const PetOnboardingCompleted());
      authStoreBloc.add(const InviteSheetSkipCleared());
      if (!mounted) return;
      context.router.replaceAll([CreateParentProfileRoute()]);
      return;
    }

    authStoreBloc.add(const InviteSheetSkipped());
    if (!mounted) return;

    context.router.replaceAll([_buildOnboardingTransitionRoute()]);
  }

  Future<void> _handleLoginOtpSuccess(
    BuildContext listenerContext,
    OtpVerificationResult otpResult,
  ) async {
    final authStoreBloc = context.read<AuthStoreBloc>();
    if (_shouldShowInviteSheet(otpResult, authStoreBloc.state.user)) {
      final accepted = await showAcceptInviteBottomSheet(
        context: context,
        inviteBloc: context.read<InviteBloc>(),
        emailOrPhone: widget.emailOrPhone,
      );

      if (accepted == null || !listenerContext.mounted) {
        return;
      }

      if (accepted) {
        authStoreBloc.add(const PetOnboardingCompleted());
        authStoreBloc.add(const InviteSheetSkipCleared());
        await onOtpVerificationSuccess();
        return;
      }

      authStoreBloc.add(const InviteSheetSkipped());
      if (!mounted) return;

      context.router.replaceAll([_buildOnboardingTransitionRoute()]);
      return;
    }

    await onOtpVerificationSuccess();
  }

  bool _shouldShowInviteSheet(
    OtpVerificationResult otpResult,
    User? storedUser,
  ) {
    final isPetOnboarded =
        otpResult.user.isPetOnboarded || (storedUser?.isPetOnboarded ?? false);
    final isOnboarded =
        otpResult.user.isOnboarded || (storedUser?.isOnboarded ?? false);
    return !isPetOnboarded && !isOnboarded;
  }

  OnboardingTransitionRoute _buildOnboardingTransitionRoute() {
    return OnboardingTransitionRoute(
      initialEmail: widget.emailOrPhone.contains('@')
          ? widget.emailOrPhone
          : null,
      initialPhoneNumber: widget.emailOrPhone.contains('@')
          ? null
          : widget.emailOrPhone,
      initialCountryCode: widget.emailOrPhone.contains('@')
          ? null
          : widget.countryCode,
    );
  }

  Future<void> onOtpVerificationSuccess() async {
    final authStoreBloc = context.read<AuthStoreBloc>();
    final authState = authStoreBloc.state;
    if (!(authState.splashCompleted &&
        authState.introCompleted &&
        authState.isAuthenticated)) {
      await authStoreBloc.stream
          .firstWhere(
            (element) =>
                element.splashCompleted &&
                element.introCompleted &&
                element.isAuthenticated,
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              return authStoreBloc.state;
            },
          );
    }
    if (!mounted) return;

    final userProfileBloc = context.read<UserProfileBloc>();
    userProfileBloc.add(const GetUserProfileEvent());
    userProfileBloc.add(const GetUserPetsEvent());

    await userProfileBloc.stream
        .firstWhere(
          (profileState) =>
              !profileState.isProfileLoading && !profileState.isPetsLoading,
        )
        .timeout(
          const Duration(seconds: 30),
          onTimeout: () {
            return userProfileBloc.state;
          },
        );
    if (!mounted) return;

    context.router.replaceAll([const HomeRoute()]);
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/shape_card/auth_pet_shape_header_view.dart';
import 'package:poochcare/core/widgets/texts/app_phone_email_input_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_event.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_state.dart';
import 'package:poochcare/features/auth/presentation/widgets/social_login_widget.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class LoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const LoginScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => getIt<AuthBloc>()..add(const AuthStarted()),
      child: this,
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<bool> _isInputValid = ValueNotifier(false);

  String _countryCode = '91';
  String _submittedValue = '';
  String _submittedCountryCode = '91';

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _isInputValid.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_isInputValid.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid email or phone number.')),
      );
      return;
    }

    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final value = email.isNotEmpty ? email : phone;

    if (value.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter email or phone number.')),
      );
      return;
    }

    _submittedValue = value;
    _submittedCountryCode = _countryCode;
    context.read<AuthBloc>().add(
      LoginWithOtpRequested(emailOrPhone: value, countryCode: _countryCode),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) =>
              previous.status != current.status ||
              previous.errorMessage != current.errorMessage,
          listener: (context, state) {
            _blocListener(state, context);
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s9.w),
            child: Column(
              children: [
                const AuthPetShapeHeaderView(),
                AppSpacing.s28.hBox,
                AppText.bodyM(
                  "Login to continue\non your pet's health and happiness journey.",
                  color: const Color(0xFF461A02),
                  fontSize: AppFontSize.fs16,
                  style: const TextStyle(
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.s13.hBox,
                AppPhoneEmailInputField(
                  phoneController: _phoneController,
                  emailController: _emailController,
                  countryCode: _countryCode,
                  onCountryCodeChanged: (value) {
                    _countryCode = value;
                  },
                  onValidityChanged: (isValid) {
                    if (_isInputValid.value == isValid) return;
                    _isInputValid.value = isValid;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) =>
                      _isInputValid.value ? _submit() : null,
                ),
                AppSpacing.s15.hBox,
                BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (prev, curr) =>
                      prev.status != curr.status ||
                      prev.requestType != curr.requestType,
                  builder: (context, state) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _isInputValid,
                      builder: (context, isValid, _) {
                        return AppButton(
                          label: 'Continue',
                          isLoading:
                              state.status == AuthStatus.loading &&
                              state.requestType == AuthRequestType.loginWithOtp,
                          onPressed: isValid ? _submit : null,
                        );
                      },
                    );
                  },
                ),
                AppSpacing.s20.hBox,
                AppText.bodyM(
                  'Or',
                  color: AppColors.p4_400,
                  fontSize: AppFontSize.fs12,
                ),
                AppSpacing.s10.hBox,
                const SocialLoginWidget(),
                AppSpacing.s10.hBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.bodyM(
                      "Don't have an account?",
                      fontSize: AppFontSize.fs14,
                    ),
                    AppSpacing.s8.wBox,
                    AppButton(
                      disableRippleEffect: true,
                      removePadding: true,
                      textStyle: AppTypography.h1.copyWith(
                        fontSize: AppFontSize.fs14,
                      ),
                      label: 'Create an account',
                      variant: AppButtonVariant.text,
                      size: AppButtonSize.xSmall,
                      width: null,
                      height: AppSpacing.s24.h,
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                          context.router.replace(const RegisterRoute()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _blocListener(AuthState state, BuildContext context) async {
    if (state.status == AuthStatus.failure && state.errorMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
    }
    if (state.status == AuthStatus.success && state.loginOtpResult != null) {
      final message = state.loginOtpResult?.message ?? '';
      if (message.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
      context.router.push(
        OtpRoute(
          emailOrPhone: _submittedValue,
          countryCode: _submittedCountryCode,
          type: 'login',
        ),
      );
    }
    if (state.status == AuthStatus.success && state.googleLoginResult != null) {
      final authStoreBloc = context.read<AuthStoreBloc>();
      await authStoreBloc.stream.firstWhere((s) => s.isAuthenticated);
      if (!context.mounted) return;
      final message = state.googleLoginResult?.message ?? '';
      if (message.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
      context.router.replaceAll([const HomeRoute()]);
    }
  }
}

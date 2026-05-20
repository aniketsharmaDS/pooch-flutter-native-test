import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/checkbox/app_checkbox.dart';
import 'package:poochcare/core/widgets/shape_card/auth_pet_shape_header_view.dart';
import 'package:poochcare/core/widgets/texts/app_phone_email_input_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_event.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_state.dart';
import 'package:poochcare/features/auth/presentation/widgets/social_login_widget.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget implements AutoRouteWrapper {
  const RegisterScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => getIt<AuthBloc>()..add(const AuthStarted()),
      child: this,
    );
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<bool> _isInputValid = ValueNotifier(false);

  String _countryCode = '91';
  String _submittedValue = '';
  String _submittedCountryCode = '91';
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _isInputValid.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_acceptedTerms) return;
    if (!_isInputValid.value) {
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
      RegisterRequested(emailOrPhone: value, countryCode: _countryCode),
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
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.s10.w),
            child: Column(
              children: [
                const AuthPetShapeHeaderView(),
                AppSpacing.s28.hBox,
                AppText.bodyL(
                  "Create an account to get started\non your pet's health and happiness journey.",
                  color: AppColors.p3_900,
                  textAlign: TextAlign.center,
                  style: const TextStyle(height: 1.2),
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
                      _acceptedTerms && _isInputValid.value ? _submit() : null,
                ),
                AppSpacing.s15.hBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppCheckbox(
                      borderColor: AppColors.activeColor,
                      value: _acceptedTerms,
                      onChanged: (val) {
                        setState(() => _acceptedTerms = val ?? false);
                      },
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(width: AppSpacing.s8.w),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'By signing up you agree to our ',
                              style: AppTypography.bodyS.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: AppTypography.bodyS.copyWith(
                                color: AppColors.p1,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                              state.requestType == AuthRequestType.register,
                          onPressed: _acceptedTerms && isValid ? _submit : null,
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
                      'Don\'t have an account?',
                      fontSize: AppFontSize.fs14,
                    ),
                    SizedBox(width: AppSpacing.s8.w),
                    AppButton(
                      // disableRippleEffect: false,
                      label: 'Login',
                      textStyle: AppTypography.h1.copyWith(
                        fontSize: AppFontSize.fs14,
                      ),
                      removePadding: true,
                      variant: AppButtonVariant.text,
                      size: AppButtonSize.xSmall,
                      width: null,
                      height: AppSpacing.s24.h,
                      onPressed: () => context.router.push(const LoginRoute()),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
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
    if (state.status == AuthStatus.success && state.registerResult != null) {
      final message = state.registerResult?.message ?? '';
      if (message.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
      context.router.push(
        OtpRoute(
          emailOrPhone: _submittedValue,
          countryCode: _submittedCountryCode,
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

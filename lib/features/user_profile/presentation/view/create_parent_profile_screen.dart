import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/notification_service.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/store/auth/auth_store_event.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/form_validators.dart';
import 'package:poochcare/core/widgets/bottom_sheet/invite_bottom_sheet/invite_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/app_profile_avatar.dart';
import 'package:poochcare/core/widgets/radio/app_radio_user_gender.dart';
import 'package:poochcare/core/widgets/texts/app_otp_field.dart';
import 'package:poochcare/core/widgets/texts/app_phone_email_input_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_event.dart';
import 'package:poochcare/features/auth/presentation/bloc/auth_state.dart';
import 'package:poochcare/features/invites/domain/models/invite_type.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_state.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class CreateParentProfileScreen extends StatefulWidget {
  const CreateParentProfileScreen({super.key, this.nickname});

  final String? nickname;

  @override
  State<CreateParentProfileScreen> createState() =>
      _CreateParentProfileScreenState();
}

class _CreateParentProfileScreenState extends State<CreateParentProfileScreen> {
  static const Map<String, int> _phoneLengthByDialCode = {'91': 10, '971': 9};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _identifierEmailController =
      TextEditingController();
  final TextEditingController _identifierPhoneController =
      TextEditingController();
  final ValueNotifier<String> _identifierDialCodeNotifier =
      ValueNotifier<String>('971');
  final ValueNotifier<String> _identifierEmailValueNotifier =
      ValueNotifier<String>('');
  final ValueNotifier<String> _identifierPhoneValueNotifier =
      ValueNotifier<String>('');
  final ValueNotifier<String?> _identifierInputErrorNotifier =
      ValueNotifier<String?>(null);
  String? _gender;
  String? selectedCountryCode;
  String? _verifiedOtpCode;
  String? _primaryIdentifier;

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  _RegisteredCredential _getRegisteredCredential() {
    final primary = (_primaryIdentifier ?? '').trim().toLowerCase();

    if (primary == 'email') return _RegisteredCredential.email;
    if (primary == 'phone') return _RegisteredCredential.phone;
    return _RegisteredCredential.none;
  }

  bool get _isPhoneLocked =>
      _getRegisteredCredential() == _RegisteredCredential.phone;
  bool get _isEmailLocked =>
      _getRegisteredCredential() == _RegisteredCredential.email;

  @override
  void initState() {
    super.initState();
    _initializeFromAuthStore();
  }

  void _initializeFromAuthStore() {
    final authStore = getIt<AuthStoreBloc>();
    final user = authStore.state.user;

    final phone = (user?.phone ?? '').trim();
    final email = (user?.email ?? '').trim();
    final country = (user?.countryCode ?? '').trim();
    final userNickname = (user?.name ?? '').trim();
    final primary = (user?.primaryIdentifier ?? '').trim();

    if (phone.isNotEmpty) {
      _phoneController.text = phone;
    }
    if (email.isNotEmpty) {
      _emailController.text = email;
    }
    if (userNickname.isNotEmpty) {
      _nameController.text = userNickname;
    }
    selectedCountryCode = country.isNotEmpty ? country : '971';
    _primaryIdentifier = primary.isNotEmpty ? primary : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _identifierEmailController.dispose();
    _identifierPhoneController.dispose();
    _identifierDialCodeNotifier.dispose();
    _identifierEmailValueNotifier.dispose();
    _identifierPhoneValueNotifier.dispose();
    _identifierInputErrorNotifier.dispose();
    super.dispose();
  }

  void _syncIdentifierDialogState() {
    _identifierEmailController.text = _emailController.text.trim();
    _identifierPhoneController.text = _phoneController.text.trim();
    _identifierDialCodeNotifier.value = (selectedCountryCode ?? '971').trim();
    _identifierEmailValueNotifier.value = _identifierEmailController.text
        .trim();
    _identifierPhoneValueNotifier.value = _identifierPhoneController.text
        .trim();
    _identifierInputErrorNotifier.value = null;
  }

  Future<void> _showIdentifierUpdateDialog(
    BuildContext dialogContext,
    _IdentifierUpdateType type,
  ) async {
    final isPhoneUpdate = type == _IdentifierUpdateType.phone;
    _syncIdentifierDialogState();
    final emailController = _identifierEmailController;
    final phoneController = _identifierPhoneController;
    final dialCodeNotifier = _identifierDialCodeNotifier;
    final emailValueNotifier = _identifierEmailValueNotifier;
    final phoneValueNotifier = _identifierPhoneValueNotifier;
    final inputErrorNotifier = _identifierInputErrorNotifier;

    void updatePhonePreview() {
      phoneValueNotifier.value = phoneController.text.trim();
      inputErrorNotifier.value = null;
    }

    phoneController.addListener(updatePhonePreview);

    try {
      final shouldVerify = await AppDialog.show<bool>(
        context: dialogContext,
        title: isPhoneUpdate ? 'Update phone number' : 'Update email',
        contentWidget: _buildIdentifierDialogContent(
          isPhoneUpdate: isPhoneUpdate,
          phoneController: phoneController,
          emailController: emailController,
          dialCodeNotifier: dialCodeNotifier,
          phoneValueNotifier: phoneValueNotifier,
          emailValueNotifier: emailValueNotifier,
          inputErrorNotifier: inputErrorNotifier,
        ),
        primaryLabel: 'Send OTP',
        secondaryLabel: 'Cancel',
        onPrimary: () async {
          return _handleSendOtp(
            dialogContext: dialogContext,
            isPhoneUpdate: isPhoneUpdate,
            dialCodeNotifier: dialCodeNotifier,
            emailController: emailController,
            phoneController: phoneController,
            inputErrorNotifier: inputErrorNotifier,
          );
        },
      );

      if (shouldVerify == true && mounted) {
        if (!context.mounted) {
          return;
        }
        final verified = await _showOtpDialog(
          dialogContext,
          isPhoneUpdate: isPhoneUpdate,
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          countryCode: dialCodeNotifier.value.trim(),
        );
        if (verified && mounted) {
          _applyVerifiedIdentifier(
            isPhoneUpdate: isPhoneUpdate,
            phone: phoneController.text.trim(),
            email: emailController.text.trim(),
            dialCode: dialCodeNotifier.value.trim(),
          );
        }
      }
    } finally {
      phoneController.removeListener(updatePhonePreview);
    }
  }

  Widget _buildIdentifierDialogContent({
    required bool isPhoneUpdate,
    required TextEditingController phoneController,
    required TextEditingController emailController,
    required ValueNotifier<String> dialCodeNotifier,
    required ValueNotifier<String> phoneValueNotifier,
    required ValueNotifier<String> emailValueNotifier,
    required ValueNotifier<String?> inputErrorNotifier,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isPhoneUpdate)
          ValueListenableBuilder<String>(
            valueListenable: dialCodeNotifier,
            builder: (dialogContext, dialCode, _) {
              return AppPhoneEmailInputField(
                label: 'Phone number',
                isMandatory: _isPhoneLocked,
                phoneController: phoneController,
                emailController: phoneController,
                onlyPhone: true,
                countryCode: dialCode,
                onCountryCodeChanged: (value) {
                  dialCodeNotifier.value = value;
                },
              );
            },
          )
        else
          ValueListenableBuilder<String?>(
            valueListenable: inputErrorNotifier,
            builder: (context, errorText, _) {
              return AppTextField(
                label: 'Email address',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                errorText: errorText,
                onChanged: (value) {
                  emailValueNotifier.value = value.trim();
                  inputErrorNotifier.value = null;
                },
              );
            },
          ),
        AppSpacing.s12.hBox,
        if (isPhoneUpdate)
          ValueListenableBuilder<String>(
            valueListenable: dialCodeNotifier,
            builder: (context, dialCode, _) {
              return ValueListenableBuilder<String>(
                valueListenable: phoneValueNotifier,
                builder: (context, phoneValue, _) {
                  final target = phoneValue.isEmpty
                      ? 'this phone number'
                      : '+$dialCode $phoneValue';
                  return AppText.bodyS(
                    'We will send the OTP to $target.',
                    color: AppColors.textSecondary,
                  );
                },
              );
            },
          )
        else
          ValueListenableBuilder<String>(
            valueListenable: emailValueNotifier,
            builder: (context, emailValue, _) {
              final target = emailValue.isEmpty
                  ? 'this email address'
                  : emailValue;
              return AppText.bodyS(
                'We will send the OTP to $target.',
                color: AppColors.textSecondary,
              );
            },
          ),
      ],
    );
  }

  Future<bool> _handleSendOtp({
    required BuildContext dialogContext,
    required bool isPhoneUpdate,
    required ValueNotifier<String> dialCodeNotifier,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required ValueNotifier<String?> inputErrorNotifier,
  }) async {
    final dialCode = dialCodeNotifier.value.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    final validationError = isPhoneUpdate
        ? FormValidators.phone(dialCode.isEmpty ? phone : '+$dialCode$phone')
        : FormValidators.email(email);
    if (validationError != null) {
      inputErrorNotifier.value = validationError;
      throw Exception('validation_failed');
    }

    if (isPhoneUpdate) {
      final expectedLength = _phoneLengthByDialCode[dialCode];
      if (expectedLength != null && phone.length != expectedLength) {
        inputErrorNotifier.value = 'Enter $expectedLength-digit phone number';
        throw Exception('validation_failed');
      }
    }

    final bloc = dialogContext.read<UserProfileIdentifierBloc>();
    bloc.add(
      UserProfileIdentifierOtpRequested(
        countryCode: isPhoneUpdate && dialCode.isNotEmpty ? '+$dialCode' : null,
        newEmail: isPhoneUpdate ? null : email,
        newPhone: isPhoneUpdate ? phone : null,
      ),
    );

    final resultState = await bloc.stream.firstWhere(
      (state) =>
          state.status == UserProfileIdentifierStatus.success ||
          state.status == UserProfileIdentifierStatus.failure,
    );

    if (resultState.status == UserProfileIdentifierStatus.failure) {
      ToastService.showError(
        resultState.errorMessage ?? 'Unable to send OTP. Please try again.',
      );
      throw Exception('send_otp_failed');
    }

    final message = (resultState.result?.message ?? '').trim();
    if (message.isNotEmpty) {
      ToastService.showSuccess(message);
    } else {
      ToastService.showSuccess('OTP sent successfully.');
    }

    return true;
  }

  void _applyVerifiedIdentifier({
    required bool isPhoneUpdate,
    required String phone,
    required String email,
    required String dialCode,
  }) {
    ToastService.showSuccess('OTP verified successfully.');
    setState(() {
      if (isPhoneUpdate) {
        _phoneController.text = phone;
        selectedCountryCode = dialCode;
      } else {
        _emailController.text = email;
      }
    });
  }

  Future<bool> _showOtpDialog(
    BuildContext dialogContext, {
    required bool isPhoneUpdate,
    required String email,
    required String phone,
    required String countryCode,
  }) async {
    final otpController = TextEditingController();
    final focusNode = FocusNode();
    final errorNotifier = ValueNotifier<String?>(null);

    try {
      final verified = await AppDialog.show<bool>(
        context: dialogContext,
        title: 'Verify OTP',
        contentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.bodyS(
              isPhoneUpdate
                  ? 'Enter the OTP sent to +$countryCode $phone.'
                  : 'Enter the OTP sent to $email.',
              color: AppColors.textSecondary,
            ),
            AppSpacing.s12.hBox,
            AppOtpField(
              controller: otpController,
              focusNode: focusNode,
              onChanged: (_) => errorNotifier.value = null,
            ),
            ValueListenableBuilder<String?>(
              valueListenable: errorNotifier,
              builder: (context, errorText, _) {
                if (errorText == null || errorText.trim().isEmpty) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.only(top: AppSpacing.s8.h),
                  child: AppText.bodyS(
                    errorText,
                    color: AppColors.messageError,
                  ),
                );
              },
            ),
          ],
        ),
        primaryLabel: 'Verify OTP',
        secondaryLabel: 'Cancel',
        onPrimary: () async {
          return await _verifyOtp(
            otpController,
            errorNotifier,
            dialogContext,
            isPhoneUpdate,
            phone,
            email,
          );
        },
      );
      return verified == true;
    } finally {
      otpController.dispose();
      focusNode.dispose();
      errorNotifier.dispose();
    }
  }

  Future<bool> _verifyOtp(
    TextEditingController otpController,
    ValueNotifier<String?> errorNotifier,
    BuildContext dialogContext,
    bool isPhoneUpdate,
    String phone,
    String email,
  ) async {
    final otp = otpController.text.trim();
    if (otp.length < 4) {
      errorNotifier.value = 'Enter the 4 digit OTP.';
      throw Exception('otp_invalid');
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

    // ignore: use_build_context_synchronously
    final bloc = dialogContext.read<AuthBloc>();
    bloc.add(
      VerifyOtpCodeRequested(
        emailOrPhone: isPhoneUpdate ? phone : email,
        otpCode: otp,
        type: 'reset',
        deviceId: deviceId,
        deviceType: deviceType,
        fcmToken: fcmToken,
      ),
    );

    final resultState = await bloc.stream.firstWhere(
      (state) =>
          state.status == AuthStatus.success ||
          state.status == AuthStatus.failure,
    );

    if (resultState.status == AuthStatus.failure) {
      ToastService.showError(
        resultState.errorMessage ??
            'OTP verification failed. Please try again.',
      );
      throw Exception('otp_verify_failed');
    }

    _verifiedOtpCode = otp;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileBloc>.value(
          value: getIt<UserProfileBloc>()..add(const UserProfileStarted()),
        ),
        BlocProvider<UserProfileIdentifierBloc>(
          create: (_) =>
              getIt<UserProfileIdentifierBloc>()
                ..add(const UserProfileIdentifierStarted()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>()..add(const AuthStarted()),
        ),
      ],
      child: BlocListener<UserProfileBloc, UserProfileState>(
        listenWhen: (prev, curr) =>
            prev.status != curr.status ||
            prev.errorMessage != curr.errorMessage,
        listener: (context, state) async {
          if ((state.errorMessage ?? '').trim().isNotEmpty) {
            ToastService.showError(state.errorMessage!);
            if (state.status == UserProfileStatus.failure && context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          }

          if (state.status == UserProfileStatus.success) {
            final authStoreBloc = context.read<AuthStoreBloc>();
            authStoreBloc.add(const OnBoardingComplete());
            await authStoreBloc.stream.firstWhere(
              (element) => element.user?.isOnboarded ?? false,
            );
            if (!context.mounted) {
              return;
            }
            // context.read<AuthStoreBloc>().add(const ProfileCompletionUpdated());
            context.router.push(const ConfigurePoochTransitionRoute());
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: -180,
                left: 0,
                right: -120,
                child: AppIcon(
                  AppIcons.png.profile.userProfileBg,
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                        vertical: AppSpacing.s12.h,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: AppText.h3(
                            'Create parent profile',
                            fontSize: AppFontSize.fs16,
                            color: AppColors.p4_900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final panelTopInset = AppSpacing.s50.h;
                          final avatarSize = 120.0;

                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                top: panelTopInset,
                                bottom: 0,
                                child: _GlassPanel(
                                  borderRadius: AppRadiusSize.r20.rr,
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.fromLTRB(
                                      AppSpacing.s16.w,
                                      (avatarSize / 2),
                                      AppSpacing.s16.w,
                                      AppSpacing.s24.h,
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      autovalidateMode: _autoValidateMode,
                                      child: Column(
                                        children: [
                                          FormField<String>(
                                            initialValue: _nameController.text
                                                .trim(),
                                            validator: (value) {
                                              return FormValidators.required(
                                                value,
                                                fieldName: 'name',
                                              );
                                            },
                                            builder: (field) {
                                              return AppTextField(
                                                preventSpecialCharacters: true,
                                                isMandatory: true,
                                                label: 'Enter name',
                                                controller: _nameController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                errorText: field.errorText,
                                                onChanged: (value) {
                                                  field.didChange(value);
                                                  setState(() {});
                                                },
                                              );
                                            },
                                          ),
                                          AppSpacing.s15.hBox,
                                          Stack(
                                            children: [
                                              AppPhoneEmailInputField(
                                                isOptional: !_isPhoneLocked,
                                                isMandatory: _isPhoneLocked,
                                                key: ValueKey<String>(
                                                  'phone-${selectedCountryCode ?? ''}-${_phoneController.text}',
                                                ),
                                                label: 'Phone Number',
                                                phoneController:
                                                    _phoneController,
                                                emailController:
                                                    _phoneController,
                                                onlyPhone: true,
                                                readOnly: true,
                                                enabled: !_isPhoneLocked,
                                                enableCountrySelection: false,
                                                countryCode:
                                                    selectedCountryCode ??
                                                    '971',
                                              ),
                                              if (!_isPhoneLocked)
                                                Positioned.fill(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {
                                                        _showIdentifierUpdateDialog(
                                                          context,
                                                          _IdentifierUpdateType
                                                              .phone,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          AppSpacing.s15.hBox,
                                          FormField<String>(
                                            initialValue: (_gender ?? '')
                                                .trim(),
                                            validator: (value) {
                                              return FormValidators.required(
                                                (value ?? '').trim(),
                                                fieldName: 'gender',
                                              );
                                            },
                                            builder: (field) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppRadioUserGender(
                                                    initialGender: _gender,
                                                    onGenderSelected: (value) {
                                                      setState(
                                                        () => _gender = value,
                                                      );
                                                      field.didChange(value);
                                                    },
                                                  ),
                                                  if ((field.errorText ?? '')
                                                      .trim()
                                                      .isNotEmpty)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: AppSpacing.s8.h,
                                                        left: AppSpacing.s12.w,
                                                      ),
                                                      child: AppText.bodyS(
                                                        field.errorText!,
                                                        color: AppColors
                                                            .textFieldBorderError,
                                                      ),
                                                    ),
                                                ],
                                              );
                                            },
                                          ),
                                          AppSpacing.s15.hBox,
                                          AppTextField(
                                            isMandatory: _isEmailLocked,
                                            label: 'Email id',
                                            controller: _emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            textInputAction:
                                                TextInputAction.next,
                                            optionalText: !_isEmailLocked
                                                ? 'Optional'
                                                : null,
                                            enabled: !_isEmailLocked,
                                            isReadOnly: true,
                                            onPressed: _isEmailLocked
                                                ? null
                                                : () {
                                                    _showIdentifierUpdateDialog(
                                                      context,
                                                      _IdentifierUpdateType
                                                          .email,
                                                    );
                                                  },
                                          ),
                                          AppSpacing.s15.hBox,
                                          AppTextField(
                                            label: 'Select DOB',
                                            controller: _dobController,
                                            textInputAction:
                                                TextInputAction.done,
                                            optionalText: 'Optional',
                                            isReadOnly: true,
                                            onPressed: () {
                                              final DateTime now =
                                                  DateTime.now();
                                              final DateTime initialDate =
                                                  _getDobPickerInitialDate(now);
                                              AppDatePicker.show(
                                                context: context,
                                                currentDate: now,
                                                initialDate: initialDate,
                                                lastDate: initialDate,
                                                onDateConfirmed: (date, _) {
                                                  if (date == null) return;
                                                  _dobController.text =
                                                      _formatDateForApi(date);
                                                  setState(() {});
                                                },
                                              );
                                            },
                                          ),
                                          AppSpacing.s20.hBox,
                                          BlocBuilder<
                                            UserProfileBloc,
                                            UserProfileState
                                          >(
                                            buildWhen: (prev, curr) =>
                                                prev.isUploadingProfilePicture !=
                                                    curr.isUploadingProfilePicture ||
                                                prev.status != curr.status,
                                            builder: (context, state) {
                                              final canSubmit =
                                                  !state
                                                      .isUploadingProfilePicture &&
                                                  state.status !=
                                                      UserProfileStatus.loading;
                                              return AppButton(
                                                label: 'Save & Continue',
                                                isLoading:
                                                    state.status ==
                                                    UserProfileStatus.loading,
                                                onPressed: canSubmit
                                                    ? () {
                                                        FocusScope.of(
                                                          context,
                                                        ).unfocus();

                                                        final isValid =
                                                            _formKey
                                                                .currentState
                                                                ?.validate() ??
                                                            false;
                                                        if (!isValid) {
                                                          setState(() {
                                                            _autoValidateMode =
                                                                AutovalidateMode
                                                                    .onUserInteraction;
                                                          });
                                                          return;
                                                        }

                                                        context.read<UserProfileBloc>().add(
                                                          UserProfileSubmitted(
                                                            countryCode:
                                                                selectedCountryCode ??
                                                                '',
                                                            otpCode:
                                                                _verifiedOtpCode,
                                                            name:
                                                                _nameController
                                                                    .text,
                                                            phone:
                                                                _phoneController
                                                                    .text,
                                                            email:
                                                                _emailController
                                                                    .text,
                                                            dateOfBirth:
                                                                _dobController
                                                                    .text,
                                                            gender:
                                                                _gender ?? '',
                                                          ),
                                                        );
                                                      }
                                                    : null,
                                              );
                                            },
                                          ),
                                          AppSpacing.s5.hBox,
                                          Center(
                                            child: AppButton(
                                              label: 'Add Co-Parent',
                                              variant: AppButtonVariant.text,
                                              size: AppButtonSize.small,
                                              width: null,
                                              trailingSvgAsset: AppIcons
                                                  .svg
                                                  .generic
                                                  .chevronRight,
                                              onPressed: () {
                                                InviteBottomSheet.show(
                                                  context: context,
                                                  inviteType:
                                                      InviteType.coparent,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.sizeOf(context).height * 0.2,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder<UserProfileBloc, UserProfileState>(
                    buildWhen: (prev, curr) =>
                        prev.localProfileImageFile !=
                            curr.localProfileImageFile ||
                        prev.profilePictureUrl != curr.profilePictureUrl ||
                        prev.isUploadingProfilePicture !=
                            curr.isUploadingProfilePicture,
                    builder: (context, state) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          AppProfileAvatar(
                            localImageFile: state.localProfileImageFile,
                            imageUrl: state.profilePictureUrl,
                            actionSize: 24,
                            actionIcon: AppIcons.svg.generic.camera,
                            actionPosition: ActionPosition.rightCenter,
                            onFileSelected: (file) async {
                              context.read<UserProfileBloc>().add(
                                UserProfileAvatarSelected(
                                  file: file,
                                  profileUploadingOrigin:
                                      ProfileUploadingOrigin.register,
                                ),
                              );
                            },
                          ),
                          if (state.isUploadingProfilePicture)
                            Container(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(right: 20),

                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.35),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  // strokeWidth: 2.6,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _getDobPickerInitialDate(DateTime now) {
    final raw = _dobController.text.trim();
    if (raw.isEmpty) {
      return DateTime(now.year - 7, now.month, now.day);
    }

    final parsed = _parseDateOfBirth(raw);
    if (parsed != null) {
      return parsed;
    }

    return DateTime(now.year - 7, now.month, now.day);
  }

  DateTime? _parseDateOfBirth(String raw) {
    final match = RegExp(
      r'^(\d{2})[\/\-](\d{2})[\/\-](\d{4})$',
    ).firstMatch(raw);
    if (match == null) return null;

    final day = int.tryParse(match.group(1) ?? '');
    final month = int.tryParse(match.group(2) ?? '');
    final year = int.tryParse(match.group(3) ?? '');
    if (day == null || month == null || year == null) return null;

    try {
      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  String _formatDateForApi(DateTime value) {
    final yyyy = value.year.toString().padLeft(4, '0');
    final mm = value.month.toString().padLeft(2, '0');
    final dd = value.day.toString().padLeft(2, '0');
    return '$dd/$mm/$yyyy';
  }
}

enum _IdentifierUpdateType { email, phone }

enum _RegisteredCredential { email, phone, none }

class _GlassPanel extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const _GlassPanel({required this.child, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final surface = const Color(0xffDDCDB6);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(color: surface.withValues(alpha: 0.72)),
          child: child,
        ),
      ),
    );
  }
}

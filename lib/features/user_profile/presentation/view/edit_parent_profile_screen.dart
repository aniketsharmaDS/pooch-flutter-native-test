import 'dart:io';
import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/notification_service.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/form_validators.dart';
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
import 'package:poochcare/features/user_profile/domain/models/user_profile.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_state.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';

@RoutePage()
class EditParentProfileScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const EditParentProfileScreen({super.key, required this.profile});

  final UserProfile profile;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileBloc>.value(value: getIt<UserProfileBloc>()),
        BlocProvider<UserProfileIdentifierBloc>(
          create: (_) =>
              getIt<UserProfileIdentifierBloc>()
                ..add(const UserProfileIdentifierStarted()),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>()..add(const AuthStarted()),
        ),
      ],
      child: this,
    );
  }

  @override
  State<EditParentProfileScreen> createState() =>
      _EditParentProfileScreenState();
}

class _EditParentProfileScreenState extends State<EditParentProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  String? _gender;
  String? _countryCode;

  late final String _initialName;
  late final String _initialGender;
  late final String _initialDob;
  late final String _initialPhone;
  late final String _initialEmail;
  late final String _initialCountryCode;
  late final _PrimaryIdentifier _primaryIdentifier;

  String? _verifiedOtpCode;
  bool _secondaryIdentifierUpdated = false;

  @override
  void initState() {
    super.initState();

    final normalizedCountryCode = _normalizeCountryCode(widget.profile);
    final normalizedDob = _normalizeDobForDisplay(widget.profile.dateOfBirth);

    _nameController.text = widget.profile.name.trim();
    _phoneController.text = widget.profile.phone.trim();
    _emailController.text = widget.profile.email.trim();
    _dobController.text = normalizedDob;

    _gender = widget.profile.gender.trim();
    _countryCode = normalizedCountryCode;

    _primaryIdentifier = _resolvePrimaryIdentifier();

    _initialName = _nameController.text.trim();
    _initialGender = (_gender ?? '').trim();
    _initialDob = _dobController.text.trim();
    _initialPhone = _phoneController.text.trim();
    _initialEmail = _emailController.text.trim();
    _initialCountryCode = (_countryCode ?? '').trim();

    _nameController.addListener(_onLocalFieldChanged);
    _dobController.addListener(_onLocalFieldChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<UserProfileBloc>().add(
        UserProfileEditInitialized(profile: widget.profile),
      );
    });
  }

  @override
  void dispose() {
    _nameController.removeListener(_onLocalFieldChanged);
    _dobController.removeListener(_onLocalFieldChanged);

    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();

    super.dispose();
  }

  void _onLocalFieldChanged() {
    setState(() {});
  }

  String _normalizeCountryCode(UserProfile profile) {
    final raw = profile.countryCode.trim();
    if (raw.isEmpty) return '971';
    return raw.replaceAll('+', '');
  }

  _PrimaryIdentifier _resolvePrimaryIdentifier() {
    final identifier =
        (getIt<AuthStoreBloc>().state.user?.primaryIdentifier ?? '')
            .trim()
            .toLowerCase();

    if (identifier == 'email') return _PrimaryIdentifier.email;
    if (identifier == 'phone') return _PrimaryIdentifier.phone;

    final hasPhone = widget.profile.phone.trim().isNotEmpty;
    final hasEmail = widget.profile.email.trim().isNotEmpty;

    if (hasPhone && !hasEmail) return _PrimaryIdentifier.phone;
    if (!hasPhone && hasEmail) return _PrimaryIdentifier.email;

    return _PrimaryIdentifier.phone;
  }

  String _normalizeDobForDisplay(String dob) {
    final value = dob.trim();
    if (value.isEmpty) return '';

    // ISO -> dd/MM/yyyy
    final iso = RegExp(r'^(\d{4})-(\d{2})-(\d{2})');
    final match = iso.firstMatch(value);
    if (match != null) {
      final yyyy = match.group(1) ?? '';
      final mm = match.group(2) ?? '';
      final dd = match.group(3) ?? '';
      if (yyyy.isNotEmpty && mm.isNotEmpty && dd.isNotEmpty) {
        return '$dd/$mm/$yyyy';
      }
    }

    return value;
  }

  DateTime? _parseDateOfBirth(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    final String value = raw.trim();
    final RegExp pattern = RegExp(r'^(\d{2})[\/\-](\d{2})[\/\-](\d{4})$');
    final RegExpMatch? match = pattern.firstMatch(value);
    if (match == null) {
      return null;
    }

    final int day = int.tryParse(match.group(1) ?? '') ?? 0;
    final int month = int.tryParse(match.group(2) ?? '') ?? 0;
    final int year = int.tryParse(match.group(3) ?? '') ?? 0;
    if (day <= 0 || month <= 0 || year <= 0) return null;

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

  DateTime _getInitialDobPickerDate({
    required String rawDateOfBirth,
    required DateTime now,
  }) {
    final String normalizedDob = _normalizeDobForDisplay(rawDateOfBirth);
    if (normalizedDob.isNotEmpty) {
      final DateTime? parsed = _parseDateOfBirth(normalizedDob);
      if (parsed != null) return parsed;
    }

    return DateTime(now.year - 7, now.month, now.day);
  }

  bool _isDirty(UserProfileState state) {
    final nameDirty = _nameController.text.trim() != _initialName;
    final phoneDirty = _phoneController.text.trim() != _initialPhone;
    final emailDirty = _emailController.text.trim() != _initialEmail;
    final countryCodeDirty = (_countryCode ?? '').trim() != _initialCountryCode;
    final genderDirty = (_gender ?? '').trim() != _initialGender;
    final dobDirty = _dobController.text.trim() != _initialDob;

    return nameDirty ||
        phoneDirty ||
        emailDirty ||
        countryCodeDirty ||
        genderDirty ||
        dobDirty;
  }

  Future<void> _confirmDiscardChanges() async {
    final shouldDiscard = await AppDialog.show<bool>(
      context: context,
      title: 'Discard changes?',
      content: 'Your changes will not be saved.',
      primaryLabel: 'Discard',
      secondaryLabel: 'Cancel',
      onPrimary: () async => true,
    );

    if (shouldDiscard == true && mounted) {
      context.router.pop();
    }
  }

  void _submit(UserProfileState state) {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() {
        _autoValidateMode = AutovalidateMode.always;
      });
      return;
    }

    context.read<UserProfileBloc>().add(
      UserProfileEditSubmitted(
        otp: _secondaryIdentifierUpdated
            ? (_verifiedOtpCode ?? '').trim()
            : null,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        dateOfBirth: _dobController.text.trim(),
        gender: (_gender ?? '').trim(),
        countryCode: (_countryCode ?? '').trim(),
      ),
    );
  }

  bool get _isPhonePrimary => _primaryIdentifier == _PrimaryIdentifier.phone;
  bool get _isEmailPrimary => _primaryIdentifier == _PrimaryIdentifier.email;

  Future<void> _showIdentifierUpdateDialog(
    BuildContext dialogContext,
    _IdentifierUpdateType type,
  ) async {
    final isPhoneUpdate = type == _IdentifierUpdateType.phone;
    final emailController = _createEmailController();
    final phoneController = _createPhoneController();
    final dialCodeNotifier = _createDialCodeNotifier();
    final emailValueNotifier = ValueNotifier<String>(
      emailController.text.trim(),
    );
    final phoneValueNotifier = ValueNotifier<String>(
      phoneController.text.trim(),
    );
    final inputErrorNotifier = ValueNotifier<String?>(null);

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
      emailController.dispose();
      phoneController.dispose();
      dialCodeNotifier.dispose();
      emailValueNotifier.dispose();
      phoneValueNotifier.dispose();
      inputErrorNotifier.dispose();
    }
  }

  TextEditingController _createEmailController() {
    return TextEditingController(text: _emailController.text.trim());
  }

  TextEditingController _createPhoneController() {
    return TextEditingController(text: _phoneController.text.trim());
  }

  ValueNotifier<String> _createDialCodeNotifier() {
    return ValueNotifier<String>((_countryCode ?? '971').trim());
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
        if (isPhoneUpdate)
          ValueListenableBuilder<String?>(
            valueListenable: inputErrorNotifier,
            builder: (context, errorText, _) {
              if (errorText == null || errorText.trim().isEmpty) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: EdgeInsets.only(top: AppSpacing.s6.h),
                child: AppText.bodyS(errorText, color: AppColors.messageError),
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
      _secondaryIdentifierUpdated = true;
      if (isPhoneUpdate) {
        _phoneController.text = phone;
        _countryCode = dialCode;
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
              deviceId: deviceId,
              deviceType: deviceType,
              fcmToken: fcmToken,
              type: 'reset',
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
        },
      );
      return verified == true;
    } finally {
      otpController.dispose();
      focusNode.dispose();
      errorNotifier.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status || prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        if (state.status == UserProfileStatus.failure) {
          final message = (state.errorMessage ?? '').trim();
          if (message.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          }
        }

        if (state.status == UserProfileStatus.success) {
          context.read<UserProfileBloc>().add(const UserProfileStarted());
          context.router.pop();
        }
      },
      builder: (context, state) {
        final isDirty = _isDirty(state);
        final isLoading = state.status == UserProfileStatus.loading;
        final canSubmit = !isLoading && !state.isUploadingProfilePicture;

        return PopScope(
          canPop: !isDirty,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop || !isDirty) return;
            _confirmDiscardChanges();
          },
          child: Scaffold(
            body: Stack(
              children: [
                Positioned(
                  top: -140,
                  left: 0,
                  right: -80,
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {
                                    if (isDirty) {
                                      _confirmDiscardChanges();
                                      return;
                                    }
                                    context.router.maybePop();
                                  },
                                  style: IconButton.styleFrom(
                                    foregroundColor: AppColors.textPrimary,
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(
                                      AppSpacing.s24.w,
                                      AppSpacing.s24.h,
                                    ),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: AppIcon(
                                    AppIcons.svg.generic.chevronLeft,
                                    size: AppIconSize.is16,
                                  ),
                                ),
                              ),
                              AppText.h3(
                                'Edit parent profile',
                                fontSize: AppFontSize.fs16,
                                color: AppColors.p4_900,
                              ),
                            ],
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
                                                  isMandatory: true,
                                                  label: 'Enter name',
                                                  preventSpecialCharacters:
                                                      true,
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
                                                  key: ValueKey<String>(
                                                    'phone-${_countryCode ?? ''}-${_phoneController.text}',
                                                  ),
                                                  label: 'Phone',
                                                  phoneController:
                                                      _phoneController,
                                                  emailController:
                                                      _phoneController,
                                                  onlyPhone: true,
                                                  isMandatory: _isPhonePrimary,
                                                  isOptional: !_isPhonePrimary,
                                                  readOnly: true,
                                                  enabled: !_isPhonePrimary,
                                                  enableCountrySelection: false,
                                                  countryCode:
                                                      (_countryCode ?? '971')
                                                          .trim(),
                                                ),
                                                if (!_isPhonePrimary)
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
                                                      onGenderSelected:
                                                          (value) {
                                                            setState(
                                                              () => _gender =
                                                                  value,
                                                            );
                                                            field.didChange(
                                                              value,
                                                            );
                                                          },
                                                    ),
                                                    if ((field.errorText ?? '')
                                                        .trim()
                                                        .isNotEmpty)
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                              top: AppSpacing
                                                                  .s8
                                                                  .h,
                                                              left: AppSpacing
                                                                  .s12
                                                                  .w,
                                                            ),
                                                        child: AppText.bodyS(
                                                          field.errorText ?? '',
                                                          color: AppColors
                                                              .messageError,
                                                        ),
                                                      ),
                                                  ],
                                                );
                                              },
                                            ),
                                            AppSpacing.s15.hBox,
                                            AppTextField(
                                              isMandatory: _isEmailPrimary,
                                              label: 'Email id',
                                              controller: _emailController,

                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.next,
                                              optionalText: !_isEmailPrimary
                                                  ? 'Optional'
                                                  : null,
                                              enabled: !_isEmailPrimary,
                                              isReadOnly: true,
                                              onPressed: _isEmailPrimary
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
                                                    _getInitialDobPickerDate(
                                                      rawDateOfBirth: widget
                                                          .profile
                                                          .dateOfBirth,
                                                      now: now,
                                                    );
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
                                                return AppButton(
                                                  label: 'Save Changes',
                                                  isLoading: isLoading,
                                                  onPressed: canSubmit
                                                      ? () => _submit(state)
                                                      : null,
                                                );
                                              },
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
                  top: 165,
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
                              actionSize: AppIconSize.is24,
                              actionIcon: AppIcons.svg.generic.camera,
                              actionPosition: ActionPosition.rightCenter,
                              onFileSelected: (file) async {
                                context.read<UserProfileBloc>().add(
                                  UserProfileAvatarSelected(file: file),
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
        );
      },
    );
  }
}

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

enum _IdentifierUpdateType { email, phone }

enum _PrimaryIdentifier { email, phone }

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/cards/app_notice_card.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/texts/app_phone_email_input_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/invites/domain/models/invite_type.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_event.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_state.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';

class InviteSheetSubmission {
  const InviteSheetSubmission({
    required this.inviteType,
    required this.displayName,
    required this.contact,
  });

  final InviteType inviteType;
  final String displayName;
  final String contact;
}

class InviteBottomSheet extends StatelessWidget {
  const InviteBottomSheet({
    required this.emailController,
    required this.phoneController,
    required this.nicknameController,
    required this.inputTypeNotifier,
    required this.isInputValidNotifier,
    required this.countryCodeNotifier,
    required this.selectedParentGroupId,
    this.inviteType = InviteType.coparent,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController nicknameController;
  final ValueNotifier<PhoneEmailInputType?> inputTypeNotifier;
  final ValueNotifier<bool> isInputValidNotifier;
  final ValueNotifier<String> countryCodeNotifier;
  final ValueNotifier<String?> selectedParentGroupId;
  final InviteType inviteType;

  static void show({
    required BuildContext context,
    required InviteType inviteType,
    HeaderVariant? headerVariant,
    String? title,
    ValueChanged<InviteSheetSubmission>? onInviteSent,
  }) {
    final bloc = getIt<InviteBloc>();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final nicknameController = TextEditingController();
    final isInputValidNotifier = ValueNotifier<bool>(false);
    final inputTypeNotifier = ValueNotifier<PhoneEmailInputType?>(null);
    final countryCodeNotifier = ValueNotifier<String>('971');
    final authState = context.read<AuthStoreBloc>().state;
    final selectedParentGroup = ValueNotifier<String?>(null);

    String digitsOnly(String value) {
      return value.replaceAll(RegExp(r'\D'), '');
    }

    bool isSelfInvite({
      required PhoneEmailInputType resolvedType,
      required String target,
      required String dialCode,
    }) {
      final storedEmail = authState.user?.email?.trim().toLowerCase() ?? '';
      final storedPhone = authState.user?.phone?.trim() ?? '';
      final storedCountryCode = authState.user?.countryCode?.trim() ?? '';

      if (resolvedType == PhoneEmailInputType.email) {
        return storedEmail.isNotEmpty &&
            storedEmail == target.trim().toLowerCase();
      }

      final selectedPhone = digitsOnly('${dialCode.trim()}$target');
      final storedPhoneFull = digitsOnly('$storedCountryCode$storedPhone');
      final storedPhoneLocal = digitsOnly(storedPhone);

      return selectedPhone.isNotEmpty &&
          (selectedPhone == storedPhoneFull ||
              (storedPhoneLocal.isNotEmpty &&
                  selectedPhone.endsWith(storedPhoneLocal)));
    }

    InviteSheetSubmission? buildSubmission() {
      final resolvedType =
          inputTypeNotifier.value ??
          (emailController.text.trim().contains('@')
              ? PhoneEmailInputType.email
              : (phoneController.text.trim().isNotEmpty
                    ? PhoneEmailInputType.phone
                    : null));

      if (resolvedType == null) {
        return null;
      }

      final target = resolvedType == PhoneEmailInputType.email
          ? emailController.text.trim()
          : phoneController.text.trim();

      if (target.isEmpty) {
        return null;
      }

      final nickname = nicknameController.text.trim();
      final dialCode = countryCodeNotifier.value.trim();
      final contact = resolvedType == PhoneEmailInputType.phone
          ? ((dialCode.isEmpty ? '' : '+$dialCode ') + target).trim()
          : target;

      return InviteSheetSubmission(
        inviteType: inviteType,
        displayName: nickname.isEmpty ? target : nickname,
        contact: contact,
      );
    }

    final result = AppBottomSheet.show<void>(
      headerVariant: headerVariant ?? HeaderVariant.titleInLeft,
      context: context,
      title:
          title ??
          (inviteType == InviteType.parent
              ? 'Invite Parent'
              : 'Invite Co - Parent'),
      content: InviteBottomSheet(
        inviteType: inviteType,
        selectedParentGroupId: selectedParentGroup,
        emailController: emailController,
        phoneController: phoneController,
        nicknameController: nicknameController,
        inputTypeNotifier: inputTypeNotifier,
        isInputValidNotifier: isInputValidNotifier,
        countryCodeNotifier: countryCodeNotifier,
      ),
      actions: [
        BlocProvider.value(
          value: bloc,
          child: BlocConsumer<InviteBloc, InviteState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == InviteStatus.success) {
                final submission = buildSubmission();
                if (submission != null) {
                  onInviteSent?.call(submission);
                }
                Navigator.maybePop(context);
                ToastService.showSuccess(
                  state.successMessage ?? 'Invite sent successfully.',
                );
              } else if (state.status == InviteStatus.failure) {
                ToastService.showError(
                  state.errorMessage ??
                      'Unable to send invite. Please try again.',
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, profileState) {
                  final isParentInvite = inviteType == InviteType.parent;
                  final parentGroupsData = profileState.parentGroups
                      .where(
                        (group) => isParentInvite
                            ? group.isOwner
                            : group.userRole != 'co_parent',
                      )
                      .toList(growable: false);
                  final hasParentGroups = parentGroupsData.isNotEmpty;

                  if (isParentInvite) {
                    final ownerGroupId = hasParentGroups
                        ? parentGroupsData.first.id
                        : null;
                    if (selectedParentGroup.value != ownerGroupId) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (selectedParentGroup.value != ownerGroupId) {
                          selectedParentGroup.value = ownerGroupId;
                        }
                      });
                    }
                  } else if (parentGroupsData.length == 1) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      selectedParentGroup.value = parentGroupsData.first.id;
                    });
                  }

                  return ValueListenableBuilder<String?>(
                    valueListenable: selectedParentGroup,
                    builder: (context, selectedGroupId, _) {
                      final isSelectedGroupValid =
                          selectedGroupId != null &&
                          parentGroupsData.any(
                            (group) => group.id == selectedGroupId,
                          );

                      if (selectedGroupId != null && !isSelectedGroupValid) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (selectedParentGroup.value != null &&
                              !parentGroupsData.any(
                                (group) =>
                                    group.id == selectedParentGroup.value,
                              )) {
                            selectedParentGroup.value = null;
                          }
                        });
                      }

                      return ValueListenableBuilder<bool>(
                        valueListenable: isInputValidNotifier,
                        builder: (context, isValid, _) {
                          final isLoading =
                              state.status == InviteStatus.loading;
                          final canSendInvite =
                              isValid &&
                              hasParentGroups &&
                              isSelectedGroupValid;

                          final sendInviteButton = AppButton(
                            isLoading: isLoading,
                            isDisabled: !canSendInvite,
                            label: 'Send Invite',
                            onPressed: (!canSendInvite || isLoading)
                                ? null
                                : () {
                                    final resolvedType =
                                        inputTypeNotifier.value ??
                                        (emailController.text.trim().contains(
                                              '@',
                                            )
                                            ? PhoneEmailInputType.email
                                            : (phoneController.text
                                                      .trim()
                                                      .isNotEmpty
                                                  ? PhoneEmailInputType.phone
                                                  : null));

                                    if (!isValid || resolvedType == null) {
                                      ToastService.showError(
                                        'Please enter a valid email or phone number.',
                                      );
                                      return;
                                    }

                                    if (!isSelectedGroupValid) {
                                      ToastService.showError(
                                        'Please select a parent group to continue.',
                                      );
                                      return;
                                    }

                                    final target =
                                        resolvedType ==
                                            PhoneEmailInputType.email
                                        ? emailController.text.trim()
                                        : phoneController.text.trim();
                                    final dialCode = countryCodeNotifier.value
                                        .trim();
                                    final countryCode =
                                        resolvedType ==
                                                PhoneEmailInputType.phone &&
                                            dialCode.isNotEmpty
                                        ? '+$dialCode'
                                        : null;
                                    final nickname = nicknameController.text;

                                    if (isSelfInvite(
                                      resolvedType: resolvedType,
                                      target: target,
                                      dialCode: dialCode,
                                    )) {
                                      ToastService.showError(
                                        resolvedType ==
                                                PhoneEmailInputType.email
                                            ? 'You cannot invite yourself using your own email address.'
                                            : 'You cannot invite yourself using your own phone number.',
                                      );
                                      return;
                                    }

                                    context.read<InviteBloc>().add(
                                      InviteParentEvent(
                                        parentGroupId: selectedGroupId,
                                        inviteType: inviteType,
                                        targetUserEmailOrPhone: target,
                                        countryCode: countryCode,
                                        nickname: nickname.isNotEmpty
                                            ? nickname
                                            : null,
                                      ),
                                    );
                                  },
                          );

                          if (hasParentGroups) {
                            return sendInviteButton;
                          }

                          return Stack(
                            children: [
                              sendInviteButton,
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      ToastService.showError(
                                        'please add your pet to invite someone',
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );

    result.whenComplete(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        bloc.close();
        emailController.dispose();
        phoneController.dispose();
        nicknameController.dispose();
        isInputValidNotifier.dispose();
        inputTypeNotifier.dispose();
        countryCodeNotifier.dispose();
        selectedParentGroup.dispose();
      });
    });
  }

  static const List<NoticeSectionModel> _noticeSections = [
    NoticeSectionModel(
      mainTitle: 'Co parent will be only able to access limited features -',
      pointers: [
        'Lorem ipsum dolor sit amet',
        'Lorem ipsum',
        'Lorem ipsum dolor sit amet',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            final parentGroupsData = state.parentGroups.where(
              (group) => inviteType == InviteType.parent
                  ? group.isOwner
                  : group.userRole != 'co_parent',
            );
            final groups = parentGroupsData.toList(growable: false);
            final ownerGroupId =
                inviteType == InviteType.parent && groups.isNotEmpty
                ? groups.first.id
                : null;

            if (inviteType == InviteType.parent &&
                selectedParentGroupId.value != ownerGroupId) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (selectedParentGroupId.value != ownerGroupId) {
                  selectedParentGroupId.value = ownerGroupId;
                }
              });
            }

            return parentGroupsData.length == 1
                ? Container(
                    alignment: Alignment.centerLeft,
                    height: 56.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 20.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.textFieldBorderDefault,
                      ),
                      borderRadius: BorderRadius.circular(AppRadiusSize.r16),
                    ),
                    child: AppText.h4(
                      parentGroupsData.first.name,
                      color: AppColors.p4_300,
                    ),
                  )
                : AppDropdowns(
                    hint: AppText.bodyM(
                      groups.isEmpty
                          ? 'No parent group available'
                          : 'Select Parent Group',
                    ),
                    disabledHint: AppText.bodyM('No parent group available'),
                    onChanged: (value) {
                      if (inviteType != InviteType.parent) {
                        selectedParentGroupId.value = value;
                      }
                    },
                    isExpanded: true,
                    valueListenable: selectedParentGroupId,
                    items: parentGroupsData
                        .map(
                          (e) => DropdownItem<String>(
                            value: e.id,
                            child: AppText.h4(e.name),
                          ),
                        )
                        .toList(),
                  );
          },
        ),
        SizedBox(height: 18.h),

        AppPhoneEmailInputField(
          phoneController: phoneController,
          emailController: emailController,
          onCountryCodeChanged: (code) {
            countryCodeNotifier.value = code;
          },
          onInputTypeChanged: (type) {
            inputTypeNotifier.value = type;
          },
          onValidityChanged: (isValid) {
            isInputValidNotifier.value = isValid;
          },
        ),
        // AppTextField(
        //   label: 'Email id',
        //   controller: _emailController,
        //   isMandatory: true,
        //   keyboardType: TextInputType.emailAddress,
        //   textInputAction: TextInputAction.next,
        // ),
        // SizedBox(height: 18.h),
        // AppTextField(
        //   controller: _phoneController,
        //   label: 'Phone Number',
        //   isMandatory: true,
        //   keyboardType: TextInputType.phone,
        //   textInputAction: TextInputAction.next,
        // ),
        SizedBox(height: 18.h),
        AppTextField(
          controller: nicknameController,
          label: 'Enter nickname',
          optionalText: 'Optional',
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 18.h),
        const AppNoticeCard(title: 'Please Note', sections: _noticeSections),
      ],
    );
  }
}

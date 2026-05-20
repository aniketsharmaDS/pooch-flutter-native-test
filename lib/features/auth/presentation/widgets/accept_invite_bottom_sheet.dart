import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/services/text_input_formatter_service.dart';
import 'package:poochcare/core/services/toast_service.dart';
import 'package:poochcare/core/store/auth/auth_store_bloc.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_bloc.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_event.dart';
import 'package:poochcare/features/invites/presentation/bloc/invite_bloc/invite_state.dart';

Future<bool?> showAcceptInviteBottomSheet({
  required BuildContext context,
  required InviteBloc inviteBloc,
  required String emailOrPhone,
}) async {
  final authStoreBloc = context.read<AuthStoreBloc>();
  final inviteCodeController = TextEditingController();

  void submitInviteCode() {
    final invitationCode = inviteCodeController.text.trim();
    if (invitationCode.isEmpty) {
      ToastService.showError('Please enter an invitation code.');
      return;
    }

    final storedEmail = authStoreBloc.state.user?.email?.trim() ?? '';
    final email = storedEmail.isNotEmpty
        ? storedEmail
        : (emailOrPhone.contains('@') ? emailOrPhone.trim() : '');

    inviteBloc.add(
      AcceptInviteByCodeEvent(
        invitationCode: invitationCode,
        email: email.isEmpty ? null : email,
      ),
    );
  }

  final result = await AppBottomSheet.show<bool>(
    isDismissible: false,
    enableDrag: false,
    canPop: false,
    showShadowAboveActions: true,
    headerVariant: HeaderVariant.titleInLeft,
    title: 'Do you have any invite?',
    showCloseButton: false,
    actions: [
      BlocProvider<InviteBloc>.value(
        value: inviteBloc,
        child: BlocBuilder<InviteBloc, InviteState>(
          builder: (context, state) {
            final isLoading = state.status == InviteStatus.loading;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: AppButton(
                    textStyle: AppTypography.displayL.copyWith(
                      fontSize: AppFontSize.fs14,
                    ),
                    onPressed: isLoading
                        ? null
                        : () => Navigator.pop(context, false),
                    label: 'Skip',
                    width: null,
                    size: AppButtonSize.medium,
                    variant: AppButtonVariant.outlined,
                  ),
                ),
                const SizedBox(width: AppSpacing.s10),
                Expanded(
                  child: AppButton(
                    textStyle: AppTypography.displayL.copyWith(
                      fontSize: AppFontSize.fs14,
                    ),
                    width: null,
                    isLoading: isLoading,
                    onPressed: isLoading ? null : submitInviteCode,
                    label: 'Continue',
                    size: AppButtonSize.medium,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ],
    context: context,
    content: BlocProvider<InviteBloc>.value(
      value: inviteBloc,
      child: BlocListener<InviteBloc, InviteState>(
        listenWhen: (previous, current) =>
            previous.status != current.status ||
            previous.errorMessage != current.errorMessage ||
            previous.successMessage != current.successMessage,
        listener: (sheetContext, state) async {
          if (state.status == InviteStatus.failure &&
              state.errorMessage != null) {
            ToastService.showError(state.errorMessage!);
          }

          if (state.status == InviteStatus.success) {
            Navigator.of(sheetContext).pop(true);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.s16,
            right: AppSpacing.s16,
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: AppTextField(
            inputFormatter: [UpperCaseTextFormatter()],
            label: 'Enter invite code',
            controller: inviteCodeController,
          ),
        ),
      ),
    ),
  );

  // Let modal route teardown finish before disposing the shared controller.
  await Future<void>.delayed(const Duration(milliseconds: 250));
  inviteCodeController.dispose();

  return result;
}

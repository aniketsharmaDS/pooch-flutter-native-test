import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

/// ======================================================
/// MODELS
/// ======================================================

class CommunityMessageResult {
  final String message;
  final bool isCancelled;

  CommunityMessageResult({required this.message, required this.isCancelled});
}

/// ======================================================
/// REPORT POST DIALOG
/// ======================================================

class CommunityMessageDialog {
  static Future<CommunityMessageResult?> show({required BuildContext context}) {
    return AppDialog.show<CommunityMessageResult>(
      context: context,
      title: 'Send a message to the pet parent',
      icon: Lottie.asset(AppIcons.lottie.reportFlag, repeat: false),
      primaryLabel: 'Send Message',
      secondaryLabel: 'Close',
      contentWidget: const _ReportDialogContent(),
      onPrimary: () async {
        return _ReportDialogController.instance?.submit();
      },
      onSecondary: () async {
        return _ReportDialogController.instance?.cancel();
      },
    );
  }
}

/// ======================================================
/// INTERNAL CONTROLLER (lightweight bridge)
/// ======================================================

class _ReportDialogController {
  static _ReportDialogController? instance;

  final TextEditingController reasonController = TextEditingController();

  CommunityMessageResult? submit() {
    if (reasonController.text.trim().isEmpty) {
      return CommunityMessageResult(message: '', isCancelled: false);
    }
    return CommunityMessageResult(
      message: reasonController.text.trim(),
      isCancelled: false,
    );
  }

  void dispose() {
    reasonController.dispose();
    instance = null;
  }

  CommunityMessageResult? cancel() {
    return CommunityMessageResult(message: '', isCancelled: true);
  }
}

/// ======================================================
/// CONTENT
/// ======================================================

class _ReportDialogContent extends StatefulWidget {
  const _ReportDialogContent();

  @override
  State<_ReportDialogContent> createState() => _ReportDialogContentState();
}

class _ReportDialogContentState extends State<_ReportDialogContent> {
  final controller = _ReportDialogController();

  @override
  void initState() {
    super.initState();
    _ReportDialogController.instance = controller;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// REASON TEXT FIELD
          AppTextField(
            controller: controller.reasonController,
            maxLines: 4,
            minLines: 3,
            isTextArea: true,
            height: AppSpacing.s90.h,
            label: 'Type your message here...',
          ),

          AppSpacing.s5.hBox,

          /// HELPER TEXT
          Center(
            child: AppText.support(
              'Your message will be sent to the pet parent.',
              textAlign: TextAlign.center,
              color: AppColors.textFieldLabelFocus,
            ),
          ),
        ],
      ),
    );
  }
}

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

class CommunityReportResult {
  final String reason;

  CommunityReportResult({required this.reason});
}

/// ======================================================
/// REPORT POST DIALOG
/// ======================================================

class CommunityReportDialog {
  static Future<CommunityReportResult?> show({required BuildContext context}) {
    return AppDialog.show<CommunityReportResult>(
      context: context,
      title: 'Are you sure you want to\nreport this post?',
      icon: Lottie.asset(AppIcons.lottie.reportFlag, repeat: false),
      primaryLabel: 'Report',
      secondaryLabel: 'Close',
      contentWidget: const _ReportDialogContent(),
      onPrimary: () async {
        return _ReportDialogController.instance?.submit();
      },
      onSecondary: () async {
        return _ReportDialogController.instance?.submit();
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

  CommunityReportResult? submit() {
    if (reasonController.text.trim().isEmpty) return null;

    return CommunityReportResult(reason: reasonController.text.trim());
  }

  void dispose() {
    reasonController.dispose();
    instance = null;
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
            label: 'Type a reason for reporting this post...',
            maxCount: 150,
          ),

          AppSpacing.s5.hBox,

          /// HELPER TEXT
          Center(
            child: AppText.support(
              'Your report will be reviewed and actioned by our team.',
              textAlign: TextAlign.center,
              color: AppColors.textFieldLabelFocus,
            ),
          ),
        ],
      ),
    );
  }
}

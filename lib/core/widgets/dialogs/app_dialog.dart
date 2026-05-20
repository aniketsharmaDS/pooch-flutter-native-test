import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';

// Move these methods inside _AppDialogContentState class

class AppDialog {
  static Future<T?> show<T>({
    required BuildContext context,

    /// Content
    String? title,
    String? content,
    Widget? contentWidget,
    Widget? icon,

    /// Buttons
    String primaryLabel = 'OK',
    String? secondaryLabel,

    /// Callbacks
    Future<T?> Function()? onPrimary,
    Future<T?> Function()? onSecondary,

    bool isPrimaryButtonEnabled = true,

    /// Behavior
    bool barrierDismissible = false,
  }) {
    const blurRadius = 10.0;

    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return _AppDialogContent<T>(
              title: title,
              content: content,
              contentWidget: contentWidget,
              icon: icon,
              primaryLabel: primaryLabel,
              isPrimaryButtonEnabled: isPrimaryButtonEnabled,
              secondaryLabel: secondaryLabel,
              onPrimary: onPrimary,
              onSecondary: onSecondary,
            );
          },
      transitionBuilder: (context, animation, _, child) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: animation.value * blurRadius,
                  sigmaY: animation.value * blurRadius,
                ),
                child: const SizedBox.expand(),
              ),
            ),
            FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// ======================================================
/// UI
/// ======================================================

class _AppDialogContent<T> extends StatefulWidget {
  final String? title;
  final String? content;
  final Widget? contentWidget;
  final Widget? icon;

  final String primaryLabel;
  final String? secondaryLabel;

  final bool isPrimaryButtonEnabled;

  final Future<T?> Function()? onPrimary;
  final Future<T?> Function()? onSecondary;

  const _AppDialogContent({
    this.title,
    this.content,
    this.contentWidget,
    this.icon,
    required this.primaryLabel,
    this.secondaryLabel,
    this.onPrimary,
    this.onSecondary,
    this.isPrimaryButtonEnabled = true,
  });

  @override
  State<_AppDialogContent<T>> createState() => AppDialogContentState<T>();
}

class AppDialogContentState<T> extends State<_AppDialogContent<T>> {
  static AppDialogContentState? instance;
  bool isLoading = false;

  double get _iconDiameter => 72.r;
  double get _iconRadius => _iconDiameter / 2;

  static const double _iconOverlapPercent = 0.5;

  bool isPrimaryDisabled = true;

  void updatePrimaryButton(bool enabled) {
    setState(() {
      isPrimaryDisabled = !enabled;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isPrimaryButtonEnabled) {
      isPrimaryDisabled = false;
    }
    instance = this;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    final width = media.size.width;
    final dialogWidth = (width * 0.94).clamp(320.0, 500.0);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight =
              (media.size.height - media.viewInsets.vertical) * 0.85;
          return Center(
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: dialogWidth,
                  maxHeight: maxHeight,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    if (widget.icon != null) _buildIconBorderBehindCard(),
                    _buildCard(theme, media, maxHeight),
                    if (widget.icon != null) _buildIcon(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    instance = null;
    super.dispose();
  }

  Widget _buildCard(ThemeData theme, MediaQueryData media, double maxHeight) {
    final hasIcon = widget.icon != null;
    final hasContent = widget.contentWidget != null || widget.content != null;

    return Container(
      margin: EdgeInsets.only(
        top: hasIcon ? _iconDiameter * _iconOverlapPercent : 0,
      ),
      padding: EdgeInsets.fromLTRB(
        24.w,
        hasIcon ? (_iconDiameter * (1 - _iconOverlapPercent)) + 1.h : 24.h,
        24.w,
        16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.dialogPrimaryBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.dialogPrimaryBorder),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              maxHeight - (hasIcon ? _iconDiameter * _iconOverlapPercent : 0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.title != null) ...[
                Text(
                  widget.title!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
                SizedBox(height: 16.h),
              ],

              /// Content (always scrollable and constrained)
              if (hasContent)
                widget.contentWidget != null
                    ? widget.contentWidget!
                    : Text(
                        widget.content!,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),

              if (hasContent) SizedBox(height: 24.h),

              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Positioned(
      top: 0,
      child: SizedBox(
        width: _iconDiameter,
        height: _iconDiameter,
        child: CircleAvatar(
          radius: _iconRadius,
          backgroundColor: AppColors.dialogPrimaryBackground,
          child: widget.icon,
        ),
      ),
    );
  }

  Widget _buildIconBorderBehindCard() {
    return Positioned(
      top: 0,
      child: Container(
        width: _iconDiameter,
        height: _iconDiameter,
        decoration: BoxDecoration(
          color: AppColors.dialogPrimaryBackground,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.dialogPrimaryBorder),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    final width = MediaQuery.of(context).size.width;

    final primary = SizedBox(
      height: 48.h, // ✅ stable height
      child: AppButton(
        isDisabled: isPrimaryDisabled,
        label: widget.primaryLabel,
        isLoading: isLoading,
        onPressed: _handlePrimary,
      ),
    );

    if (widget.secondaryLabel == null) {
      return SizedBox(width: double.infinity, child: primary);
    }

    final secondary = SizedBox(
      height: 48.h,
      child: AppButton(
        label: widget.secondaryLabel!,
        variant: AppButtonVariant.outlined,
        onPressed: isLoading ? null : _handleSecondary,
      ),
    );

    if (width < 360) {
      return Column(
        children: [
          SizedBox(width: double.infinity, child: secondary),
          SizedBox(height: 8.h),
          SizedBox(width: double.infinity, child: primary),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: secondary),
        SizedBox(width: 12.w),
        Expanded(child: primary),
      ],
    );
  }

  Future<void> _handlePrimary() async {
    if (isLoading) return;

    if (widget.onPrimary != null) {
      setState(() => isLoading = true);

      try {
        final result = await widget.onPrimary!();
        if (mounted) Navigator.pop(context, result);
      } catch (_) {
        if (mounted) setState(() => isLoading = false);
      }
    } else {
      Navigator.pop(context, true);
    }
  }

  Future<void> _handleSecondary() async {
    if (widget.onSecondary != null) {
      final result = await widget.onSecondary!();
      if (mounted) Navigator.pop(context, result);
    } else {
      Navigator.pop(context, false);
    }
  }
}

/*
✅ 1. Simple Info Dialog (Basic)
await AppDialog.show(
  context: context,
  title: "Info",
  content: "This is a simple message",
);

👉 Default:

Single OK button

Returns true on close

✅ 2. Confirm Dialog (Yes / No)
final result = await AppDialog.show<bool>(
  context: context,
  title: "Delete Item",
  content: "Are you sure you want to delete this?",
  primaryLabel: "Delete",
  secondaryLabel: "Cancel",
);

if (result == true) {
  // delete item
}
✅ 3. Async Action (API Call / Loading State)
await AppDialog.show(
  context: context,
  title: "Submit",
  content: "Do you want to submit?",
  primaryLabel: "Submit",
  secondaryLabel: "Cancel",
  onPrimary: () async {
    await Future.delayed(const Duration(seconds: 2)); // API call
    return true;
  },
);

👉 Automatically:

Shows loader on button

Disables secondary button

Closes after completion

✅ 4. Custom Content (Form inside Dialog)
final nameController = TextEditingController();

await AppDialog.show(
  context: context,
  title: "Enter Name",
  contentWidget: Column(
    children: [
      TextField(
        controller: nameController,
        decoration: const InputDecoration(labelText: "Name"),
      ),
    ],
  ),
  primaryLabel: "Save",
  secondaryLabel: "Cancel",
  onPrimary: () async {
    final name = nameController.text;
    if (name.isEmpty) return null;

    // save logic
    return name;
  },
);
✅ 5. Form with Validation
final formKey = GlobalKey<FormState>();
final emailController = TextEditingController();

await AppDialog.show(
  context: context,
  title: "Enter Email",
  contentWidget: Form(
    key: formKey,
    child: TextFormField(
      controller: emailController,
      decoration: const InputDecoration(labelText: "Email"),
      validator: (value) {
        if (value == null || value.isEmpty) return "Required";
        if (!value.contains("@")) return "Invalid email";
        return null;
      },
    ),
  ),
  primaryLabel: "Submit",
  secondaryLabel: "Cancel",
  onPrimary: () async {
    if (!formKey.currentState!.validate()) return null;

    return emailController.text;
  },
);
✅ 6. Dialog with Icon
await AppDialog.show(
  context: context,
  title: "Success",
  content: "Your profile has been updated!",
  icon: const Icon(Icons.check, color: Colors.green, size: 32),
);
✅ 7. Error Dialog
await AppDialog.show(
  context: context,
  title: "Error",
  content: "Something went wrong. Please try again.",
  icon: const Icon(Icons.error, color: Colors.red, size: 32),
  primaryLabel: "Retry",
  secondaryLabel: "Cancel",
);
✅ 8. Return Custom Data
final selectedOption = await AppDialog.show<String>(
  context: context,
  title: "Choose Option",
  contentWidget: Column(
    children: [
      ListTile(
        title: const Text("Option A"),
        onTap: () => Navigator.pop(context, "A"),
      ),
      ListTile(
        title: const Text("Option B"),
        onTap: () => Navigator.pop(context, "B"),
      ),
    ],
  ),
);
✅ 9. Non-dismissible Dialog (Important UX)
await AppDialog.show(
  context: context,
  title: "Processing",
  content: "Please wait...",
  barrierDismissible: false,
);
✅ 10. Full Custom UI Dialog (Advanced)
await AppDialog.show(
  context: context,
  title: "Custom Layout",
  contentWidget: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Select options:"),
      const SizedBox(height: 12),
      CheckboxListTile(
        value: true,
        onChanged: (_) {},
        title: const Text("Option 1"),
      ),
      CheckboxListTile(
        value: false,
        onChanged: (_) {},
        title: const Text("Option 2"),
      ),
    ],
  ),
  primaryLabel: "Done",
);
* */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/services/text_input_formatter_service.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

class ApplyCouponSection extends StatefulWidget {
  final Future<void> Function(String code) onApply;
  final bool? isLoading;

  const ApplyCouponSection({super.key, required this.onApply, this.isLoading});

  @override
  State<ApplyCouponSection> createState() => _ApplyCouponSectionState();
}

class _ApplyCouponSectionState extends State<ApplyCouponSection> {
  final TextEditingController _codeController = TextEditingController();

  String code = '';
  bool _localLoading = false;

  bool get isLoading => widget.isLoading ?? _localLoading;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: AppTextField(
            inputFormatter: [UpperCaseTextFormatter()],
            label: 'Enter coupon code',
            // hintText: 'Enter coupon code',
            controller: _codeController,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              setState(() {
                code = value;
              });
            },
          ),
        ),
        SizedBox(width: 10.w),
        AppButton(
          // height: 48.h,
          isLoading: isLoading,
          width: null,
          borderRadius: 16.r,
          label: 'Apply',
          isPill: false,
          size: AppButtonSize.medium,
          variant: AppButtonVariant.outlined,
          isDisabled: code.trim().isEmpty,
          onPressed: _handleApply,
        ),
      ],
    );
  }

  Future<void> _handleApply() async {
    if (isLoading || code.trim().isEmpty) return;

    if (widget.isLoading == null) {
      setState(() => _localLoading = true);
    }

    try {
      await widget.onApply(code.trim());
    } finally {
      if (mounted && widget.isLoading == null) {
        setState(() => _localLoading = false);
      }
    }
  }
}

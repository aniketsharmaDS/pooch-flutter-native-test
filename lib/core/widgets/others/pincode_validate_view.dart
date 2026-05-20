import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/ecommerce/domain/models/delivery_check.dart';

class PincodeValidateView extends StatefulWidget {
  // final Future<bool> Function(String pincode)? onCheckPincode;
  final Future<DeliveryCheck> Function(String pincode)? onCheckPincode;

  const PincodeValidateView({super.key, this.onCheckPincode});

  @override
  State<PincodeValidateView> createState() => _PincodeValidateViewState();
}

class _PincodeValidateViewState extends State<PincodeValidateView> {
  final TextEditingController _pincodeController = TextEditingController();

  String pincode = '';
  bool isLoading = false;
  bool? isValid;
  String? message;

  @override
  void dispose() {
    _pincodeController.dispose();
    super.dispose();
  }

  Future<void> _handleCheckPincode() async {
    if (isLoading) return;

    if (pincode.length != 6) {
      setState(() => isValid = false);
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        const SnackBar(content: Text('Please enter a valid 6-digit pincode')),
      );
      return;
    }

    setState(() => isLoading = true);

    // bool result = false;
    DeliveryCheck? result;
    try {
      // if (widget.onCheckPincode != null) {
      //   result = await widget.onCheckPincode!(pincode);
      // } else {
      //   await Future<dynamic>.delayed(const Duration(milliseconds: 1200));
      //   result = pincode == '400001';
      // }
      if (widget.onCheckPincode != null) {
        result = await widget.onCheckPincode!(pincode);
      } else {
        await Future<dynamic>.delayed(const Duration(milliseconds: 1200));
        result = DeliveryCheck(
          productId: '',
          pincode: pincode,
          isDeliverable: pincode == '400001',
          reason: pincode == '400001'
              ? 'Pincode service is available'
              : 'Not serviceable',
          deliveryType: '',
          maxDistance: null,
          distanceValue: null,
          distanceUnit: '',
          pincodeAddress: '',
        );
      }
    } finally {
      if (mounted) {
        // setState(() {
        //   isValid = result;
        //   isLoading = false;
        // });
        setState(() {
          isValid = result!.isDeliverable;
          message = result.reason; // ⭐ THIS IS THE KEY LINE
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color stateColor = isValid == true
        ? const Color(0xFF188C43)
        : isValid == false
        ? const Color(0xFFB3261E)
        : const Color(0xFF1B1B1B);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Text Field
              Expanded(
                child: AppTextField(
                  label: 'Enter Pin code',
                  controller: _pincodeController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    setState(() {
                      pincode = value;
                      isValid = null;
                    });
                    if (value.length == 6) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  maxCount: 6,
                  // height: AppSize.cs56,
                  // borderRadius: AppRadiusSize.r16,
                  hintFontSize: AppFontSize.fs14,
                  labelFontSize: AppFontSize.fs16,
                ),
              ),

              const SizedBox(width: 12),

              // Button
              SizedBox(
                width: AppSize.cs120,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  ),
                  child: AppButton(
                    key: ValueKey(
                      isLoading ? 'loading' : 'idle_${isValid ?? 'none'}',
                    ),
                    label: 'Check',
                    size: AppButtonSize.medium,
                    borderRadius: AppRadiusSize.r16,
                    borderWidth: 1.5,

                    variant: AppButtonVariant.outlined,
                    borderColor: stateColor,
                    isLoading: isLoading,
                    isDisabled: !isLoading && pincode.isEmpty,
                    onPressed: isLoading ? null : _handleCheckPincode,
                  ),
                ),
              ),
            ],
          ),
          if (isValid != null) ...[
            const SizedBox(height: 8),
            AppText.support(
              // isValid!
              //     ? 'Pincode service is available in your area.'
              //     : 'Sorry, this pincode is not serviceable.',
              message ?? '',
              color: isValid!
                  ? const Color(0xFF188C43)
                  : const Color(0xFFB3261E),
            ),
          ],
        ],
      ),
    );
  }
}

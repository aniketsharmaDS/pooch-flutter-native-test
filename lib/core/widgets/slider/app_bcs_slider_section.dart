// File: app_bsc_slider_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_tool_tip.dart';
import 'package:poochcare/core/widgets/slider/app_slider.dart';

class AppBscSliderSection extends StatefulWidget {
  const AppBscSliderSection({
    super.key,
    required this.value,
    required this.onChanged,
    this.focusNode,
  });

  final double value;
  final ValueChanged<double> onChanged;
  final FocusNode? focusNode;

  @override
  State<AppBscSliderSection> createState() => _AppBscSliderSectionState();
}

class _AppBscSliderSectionState extends State<AppBscSliderSection> {
  late double _value;
  late TextEditingController _controller;

  /// 🔒 Fixed config (as per your UI)
  static const double _min = 1;
  static const double _max = 9;
  // static const int _divisions = 7;

  @override
  void initState() {
    super.initState();

    _value = widget.value;
    _controller = TextEditingController(text: _value.toInt().toString());
  }

  @override
  void didUpdateWidget(covariant AppBscSliderSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != _value) {
      _value = widget.value;
      _controller.text = _value.toInt().toString();
    }
  }

  void _updateFromSlider(double v) {
    final rounded = v.roundToDouble();

    setState(() {
      _value = rounded;
      _controller.text = rounded.toInt().toString();
      _controller.selection = TextSelection.collapsed(
        offset: _controller.text.length,
      );
    });

    widget.onChanged(rounded);
  }

  void _updateFromInput(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null) return;

    final clamped = parsed.clamp(_min, _max).toDouble();

    setState(() {
      _value = clamped;
    });

    widget.onChanged(clamped);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Header
        Row(
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'BCS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2B1B14),
                    ),
                  ),
                  TextSpan(
                    text: '*',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            AppTooltip(
              message:
                  'A BCS (Body Condition Score) is essentially the "Body Mass Index" (BMI) for pets.',
              child: AppIcon(
                AppIcons.svg.generic.info,
                size: 20.r,
                // color: const Color(0xFF343330),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        /// Slider + Input
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(end: _value),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInQuart,
                builder: (context, animatedValue, child) {
                  return AppSlider(
                    value: animatedValue,
                    min: _min,
                    max: _max,
                    // divisions: _divisions,
                    onChanged: _updateFromSlider,
                    onChangeEnd: _updateFromSlider,
                    labelBuilder: (v) => v.toStringAsFixed(0),
                  );
                },
              ),
            ),

            SizedBox(width: 10.w),

            Text(
              'or',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8D6356),
              ),
            ),

            SizedBox(width: 12.w),

            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 68.w, maxWidth: 90.w),
              child: Container(
                height: 29.h,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFE2DBD8)),
                ),
                child: Center(
                  child: TextField(
                    controller: _controller,
                    focusNode: widget.focusNode, // 👈 IMP
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLength: 1,
                    onChanged: _updateFromInput,
                    buildCounter:
                        (
                          _, {
                          required currentLength,
                          required isFocused,
                          required maxLength,
                        }) => const SizedBox.shrink(),
                    cursorColor: const Color(0xFF8D6356),
                    cursorHeight: 16,
                    cursorWidth: 1.4,
                    style: const TextStyle(
                      color: Color(0xFF2B1B14),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.15,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      hintText: 'Enter here',
                      hintStyle: const TextStyle(
                        color: Color(0xFFB5A9A4),
                        fontSize: 10,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

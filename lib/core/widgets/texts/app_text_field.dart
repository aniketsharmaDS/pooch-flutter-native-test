import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_scale.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class AppTextField extends StatefulWidget {
  final String? errorText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onSubmitted;
  final bool forceValidation;
  const AppTextField({
    super.key,
    this.onPressed,
    required this.label,
    required this.controller,
    this.focusNode,
    this.obscureText = false,
    this.isMandatory = false,
    this.isReadOnly = false,
    this.optionalText,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.hintText,
    this.height = 56,
    this.borderRadius = 16,
    this.hintFontSize = 14,
    this.labelFontSize = 16,
    this.floatingFontSize = 12,
    this.prefix,
    this.isTextArea = false,
    this.maxLines = 5,
    this.minLines,
    this.maxCount,
    this.suffixWidget,
    this.isValidInput = false,
    this.enabled = true,
    this.unfocusOnTapOutside = true,
    this.errorText,
    this.validator,
    this.preventSpecialCharacters = false,
    this.onSubmitted,
    this.inputFormatter,
    this.forceValidation = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool isMandatory;
  final bool isReadOnly;
  final String? optionalText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final double height;
  final double borderRadius;
  final double hintFontSize;
  final double labelFontSize;
  final Widget? prefix;
  final bool isTextArea;
  final double floatingFontSize;
  final int maxLines;
  final int? minLines;
  final int? maxCount;
  final Widget? suffixWidget;

  /// Color logic and validation
  final bool isValidInput;
  final bool enabled;
  final bool unfocusOnTapOutside;
  final bool preventSpecialCharacters;
  final List<TextInputFormatter>? inputFormatter;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  String? _validationError;
  bool get _hasError =>
      (_validationError != null && _validationError!.isNotEmpty) ||
      (widget.errorText != null && widget.errorText!.isNotEmpty);
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final bool _ownsFocusNode;
  bool _hasBeenTouched = false;

  static const _duration = Duration(milliseconds: 240);
  static const _curve = Curves.easeOutCubic;

  bool get _shouldFloat =>
      _focusNode.hasFocus || _controller.text.trim().isNotEmpty;

  bool get _showOptionalText => (widget.optionalText ?? '').trim().isNotEmpty;
  bool get _showCounter => widget.isTextArea && widget.maxCount != null;
  bool get _hasSuffixWidget => widget.suffixWidget != null;
  bool get _effectiveShouldFloat => widget.isTextArea || _shouldFloat;
  int get _currentLength => _controller.text.length;

  @override
  void initState() {
    super.initState();
    _ownsFocusNode = widget.focusNode == null;
    _controller = widget.controller;
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_handleStateChange);
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.forceValidation && !oldWidget.forceValidation) {
      _runValidation();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleStateChange);
    _focusNode.removeListener(_handleFocusChange);
    if (_ownsFocusNode) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleStateChange() {
    if (mounted) {
      setState(() {});
    }
  }

  void _scrollToField() {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        alignment: 0.2,
      );
    });
  }

  void _handleFocusChange() {
    if (mounted) {
      if (_focusNode.hasFocus) {
        // Field is focused - mark as touched but don't validate yet
        _hasBeenTouched = true;

        _scrollToField(); // 👈 ADD THIS
      } else {
        // Field lost focus - validate now
        if (_hasBeenTouched) {
          _runValidation();
        }
      }
      setState(() {});
    }
  }

  Color get _borderColor {
    if (!_focusNode.hasFocus &&
        !_hasError &&
        !widget.isValidInput &&
        widget.enabled) {
      return AppColors.textFieldBorderDefault;
    }
    if (!widget.enabled) return AppColors.textFieldBorderDisabled;
    if (_hasError) return AppColors.textFieldBorderError;
    if (widget.isValidInput) return AppColors.textFieldBorderValid;
    if (_focusNode.hasFocus) return AppColors.textFieldBorderFocus;
    return AppColors.textFieldBorderDefault;
  }

  Color get _backgroundColor {
    if (!widget.enabled) return AppColors.textFieldBackgroundDisabled;
    if (_hasError) return AppColors.textFieldBackgroundError;
    if (widget.isValidInput) return AppColors.textFieldBackgroundValid;
    return AppColors.textFieldBackgroundDefault;
  }

  Color get _inputTextColor {
    if (!widget.enabled) return AppColors.textFieldInputTextDisabled;
    if (_hasError) return AppColors.textFieldInputTextError;
    if (widget.isValidInput) return AppColors.textFieldInputTextValid;
    return AppColors.textFieldInputTextDefault;
  }

  Color get _hintColor {
    if (!widget.enabled) return AppColors.textFieldHintDisabled;
    if (_focusNode.hasFocus) return AppColors.textFieldHintFocus;
    return AppColors.textFieldHintDefault;
  }

  Color get _labelColor {
    if (!widget.enabled) return AppColors.textFieldLabelDisabled;
    if (_hasError) return AppColors.textFieldLabelError;
    if (_focusNode.hasFocus) return AppColors.textFieldLabelDefault;
    return AppColors.textFieldLabelDefault;
  }

  Color get _optionalColor => AppColors.textFieldOptional;

  void _runValidation([String? value]) {
    if (widget.validator != null) {
      _validationError = widget.validator!(value ?? _controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final labelColor = _labelColor;
    final optionalColor = _optionalColor;
    final prefixReserve = widget.prefix == null ? 0.0 : AppSpacing.s36.w;
    final leftInset = AppSpacing.s20.w + prefixReserve;
    final contentRightInset = _showOptionalText
        ? AppSpacing.s108.w
        : _hasSuffixWidget
        ? AppSpacing.s56.w
        : AppSpacing.s20.w;
    final labelRightInset = _showOptionalText
        ? AppSpacing.s112.w
        : _hasSuffixWidget
        ? AppSpacing.s56.w
        : AppSpacing.s20.w;
    final optionalRightInset = _hasSuffixWidget
        ? AppSpacing.s56.w
        : AppSpacing.s20.w;
    final floatingLabelTopPadding = widget.height >= AppScale.h(AppSpacing.s80)
        ? AppSpacing.s12.h
        : AppSpacing.s10.h;
    final floatingInputTopPadding = widget.height >= AppScale.h(AppSpacing.s80)
        ? AppSpacing.s42.h
        : AppSpacing.s25.h;
    final inputBottomPadding = _showCounter
        ? AppSpacing.s30.h
        : AppSpacing.s12.h;
    // final labelRestingFontSize = widget.labelFontSize.sp;
    // final labelFloatingFontSize = (widget.labelFontSize * 0.625).sp;
    final optionalFontSize = widget.isTextArea
        ? AppScale.sp(AppSpacing.s12)
        : AppScale.sp(AppSpacing.s12);
    // final textAreaTitleFontSize = 16.sp;
    // final inputBottomPadding = widget.height >= 80 ? 17.0 : 10.0;
    final labelStyle = _effectiveShouldFloat
        ? AppTypography.inputLabelFloating
        : AppTypography.inputLabel;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.isReadOnly && widget.onPressed != null) {
          widget.onPressed?.call();
          return;
        }
        if (!_focusNode.hasFocus) {
          _focusNode.requestFocus();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: _duration,
            curve: _curve,
            height: AppScale.h(widget.height),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(
                AppScale.r(widget.borderRadius),
              ),
              border: Border.all(color: _borderColor),
            ),
            child: Stack(
              children: [
                if (widget.prefix != null)
                  Positioned(
                    left: AppSpacing.s14.w,
                    top: 0,
                    bottom: 0,
                    child: IgnorePointer(child: Center(child: widget.prefix!)),
                  ),
                IgnorePointer(
                  ignoring: widget.isReadOnly,
                  child: TextField(
                    onSubmitted: (value) {
                      _focusNode.unfocus();
                      if (widget.onSubmitted != null) {
                        widget.onSubmitted!(value);
                      }
                    },
                    inputFormatters:
                        widget.inputFormatter ??
                        (widget.preventSpecialCharacters
                            ? [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9\s]'),
                                ),
                              ]
                            : null),
                    obscureText: widget.obscureText,
                    enabled: widget.enabled,
                    readOnly: widget.isReadOnly,
                    onTapUpOutside: widget.unfocusOnTapOutside
                        ? (event) {
                            _focusNode.unfocus();
                          }
                        : null,
                    controller: _controller,
                    focusNode: widget.isReadOnly
                        ? FocusNode(canRequestFocus: false)
                        : _focusNode,
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    onChanged: (value) {
                      _hasBeenTouched = true;
                      _runValidation(value);
                      widget.onChanged?.call(value);
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    maxLength: widget.maxCount,
                    buildCounter:
                        (
                          context, {
                          required int currentLength,
                          required bool isFocused,
                          required int? maxLength,
                        }) {
                          return const SizedBox.shrink();
                        },
                    maxLines: widget.isTextArea ? widget.maxLines : 1,
                    minLines: widget.isTextArea ? (widget.minLines ?? 3) : 1,
                    textAlignVertical: widget.isTextArea
                        ? TextAlignVertical.top
                        : TextAlignVertical.center,
                    cursorColor: _inputTextColor,
                    cursorHeight: 16,
                    cursorWidth: 1.4,
                    style: AppTypography.inputText.copyWith(
                      color: _inputTextColor,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: _hasSuffixWidget
                          ? Align(child: widget.suffixWidget)
                          : null,
                      suffixIconConstraints: BoxConstraints(
                        minWidth: AppSpacing.s44.w,
                        maxWidth: AppSpacing.s44.w,
                        minHeight: AppSpacing.s44.h,
                        maxHeight: AppSpacing.s44.h,
                      ),
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isDense: true,
                      hintText: _effectiveShouldFloat ? widget.hintText : null,
                      hintStyle: AppTypography.inputHint.copyWith(
                        color: _hintColor,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: leftInset,
                        right: contentRightInset,
                        top: floatingInputTopPadding,
                        bottom: inputBottomPadding,
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: leftInset,
                      right: labelRightInset,
                    ),
                    child: IgnorePointer(
                      child: AnimatedAlign(
                        duration: _duration,
                        curve: _curve,
                        alignment: _effectiveShouldFloat
                            ? Alignment.topLeft
                            : Alignment.centerLeft,
                        child: AnimatedPadding(
                          duration: _duration,
                          curve: _curve,
                          padding: EdgeInsets.only(
                            top: _effectiveShouldFloat
                                ? floatingLabelTopPadding
                                : 0,
                          ),
                          child: AnimatedDefaultTextStyle(
                            duration: _duration,
                            curve: _curve,
                            style: labelStyle.copyWith(color: labelColor),

                            child: Text.rich(
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.label,
                                    style: labelStyle.copyWith(
                                      color: labelColor,
                                      fontSize: widget.floatingFontSize,
                                    ),
                                  ),
                                  if (widget.isMandatory)
                                    TextSpan(
                                      text: ' *',
                                      style: labelStyle.copyWith(
                                        color: Colors.red,
                                        fontSize: widget.floatingFontSize,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                if (_showOptionalText)
                  Positioned(
                    right: optionalRightInset,
                    top: widget.isTextArea ? floatingLabelTopPadding : 0,
                    bottom: widget.isTextArea ? null : 0,
                    child: IgnorePointer(
                      child: widget.isTextArea
                          ? _buildOptionalText(optionalColor, optionalFontSize)
                          : Center(
                              child: _buildOptionalText(
                                optionalColor,
                                optionalFontSize,
                              ),
                            ),
                    ),
                  ),
                if (_showCounter)
                  Positioned(
                    right: 16,
                    bottom: 8,
                    child: IgnorePointer(
                      child: Text(
                        '${_currentLength.clamp(0, widget.maxCount!).toInt()} of ${widget.maxCount}',
                        style: TextStyle(
                          color: AppColors.textFieldCounter,
                          fontSize: AppScale.sp(AppSpacing.s12),
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (_hasError)
            Padding(
              padding: EdgeInsets.only(left: leftInset, top: AppSpacing.s4.h),
              child: AppText.support(
                _validationError ?? widget.errorText!,
                color: AppColors.textFieldErrorText,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOptionalText(Color optionalColor, double optionalFontSize) {
    return AnimatedSwitcher(
      duration: _duration,
      switchInCurve: _curve,
      switchOutCurve: _curve,
      child: Text(
        widget.optionalText!,
        key: ValueKey(widget.optionalText),
        softWrap: false,
        overflow: TextOverflow.fade,
        style: AppTypography.bodyS.copyWith(color: AppColors.textFieldOptional),
      ),
    );
  }
}

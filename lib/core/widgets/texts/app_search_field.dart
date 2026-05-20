import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

class AppSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Duration debounceDuration;
  final bool isLoading; // ✅ ADD THIS
  final bool isReadOnly;
  final VoidCallback? onPressed;

  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'What are you looking for?',
    this.onChanged,
    this.onSubmitted,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.isLoading = false, // default
    this.isReadOnly = false,
    this.onPressed,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  Timer? _debounce;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(widget.debounceDuration, () {
      widget.onChanged?.call(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.hintText,
      controller: _controller,
      isReadOnly: widget.isReadOnly,
      onPressed: widget.onPressed,
      textInputAction: TextInputAction.search,
      onChanged: _onChanged,
      onSubmitted: widget.onSubmitted,
      enabled: !widget.isLoading, // ✅ disable typing
      suffixWidget: widget.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Padding(
              padding: EdgeInsets.only(right: AppSpacing.s6.w),
              child: AppIcon(
                AppIcons.svg.generic.search,
                size: AppIconSize.is20,
              ),
            ),
    );
  }
}

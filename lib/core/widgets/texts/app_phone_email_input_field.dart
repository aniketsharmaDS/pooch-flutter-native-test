import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/utils/form_validators.dart';
import 'package:poochcare/core/widgets/images/app_image_cached_widget.dart';

enum PhoneEmailInputType { phone, email }

class _PhoneEmailCountry {
  const _PhoneEmailCountry({
    required this.name,
    required this.dialCode,
    required this.isoCode,
    required this.flagEmoji,
    required this.nationalNumberLength,
  });

  final String name;
  final String dialCode;
  final String isoCode;
  final String flagEmoji;
  final int nationalNumberLength;

  String get flagPngUrl =>
      'https://flagcdn.com/w80/${isoCode.toLowerCase()}.png';

  factory _PhoneEmailCountry.fromJson(Map<String, dynamic> json) {
    return _PhoneEmailCountry(
      name: (json['name'] as String?) ?? '',
      dialCode: (json['dialCode'] as String?) ?? '',
      isoCode: (json['iso_code'] as String?) ?? '',
      flagEmoji: (json['flag'] as String?) ?? '',
      nationalNumberLength:
          (json['phone_number_length'] as num?)?.toInt() ??
          (json['nationalLength'] as num?)?.toInt() ??
          0,
    );
  }
}

class _PhoneEmailCountrySource {
  static List<_PhoneEmailCountry>? _cache;

  static const List<Map<String, dynamic>> _localJson = [
    {
      'name': 'India',
      'iso_code': 'IN',
      'flag_url': 'https://flagcdn.com/in.svg',
      'flag': '🇮🇳',
      'dialCode': '91',
      'phone_number_length': 10,
    },
    {
      'name': 'United Arab Emirates',
      'iso_code': 'AE',
      'flag_url': 'https://flagcdn.com/ae.svg',
      'flag': '🇦🇪',
      'dialCode': '971',
      'phone_number_length': 9,
    },
  ];

  static List<_PhoneEmailCountry> getAll() {
    return _cache ??= _decode();
  }

  static List<_PhoneEmailCountry> _decode() {
    final list = _localJson
        .whereType<Map<String, dynamic>>()
        .map((e) => _PhoneEmailCountry.fromJson(e))
        .where(
          (country) => country.name.isNotEmpty && country.dialCode.isNotEmpty,
        )
        .toList(growable: false);
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }
}

class AppPhoneEmailInputField extends StatefulWidget {
  const AppPhoneEmailInputField({
    required this.phoneController,
    required this.emailController,
    this.countryCode = '971',
    this.onlyPhone = false,
    this.isOptional = false,
    this.readOnly = false,
    this.enabled = true,
    this.enableCountrySelection = true,
    this.onCountryCodeChanged,
    this.onInputTypeChanged,
    this.onValidityChanged,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
    this.label = 'Enter Email ID or Phone no.',
    this.isMandatory = true,
    this.hintText,
    this.validator,
    this.height = 56,
    this.borderRadius = 16,
    super.key,
  });

  final TextEditingController phoneController;
  final TextEditingController emailController;
  final String countryCode;
  final bool onlyPhone;
  final bool isOptional;
  final bool readOnly;
  final bool enabled;
  final bool enableCountrySelection;
  final ValueChanged<String>? onCountryCodeChanged;
  final ValueChanged<PhoneEmailInputType>? onInputTypeChanged;
  final ValueChanged<bool>? onValidityChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction textInputAction;
  final String label;
  final bool isMandatory;
  final String? hintText;
  final String? Function(String?)? validator;
  final double height;
  final double borderRadius;

  @override
  State<AppPhoneEmailInputField> createState() =>
      _AppPhoneEmailInputFieldState();
}

class _AppPhoneEmailInputFieldState extends State<AppPhoneEmailInputField> {
  static const _duration = Duration(milliseconds: 220);
  static const _curve = Curves.easeOutCubic;
  static const _countrySelectorWidth = 81.0;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormFieldState<String>> _fieldKey =
      GlobalKey<FormFieldState<String>>();

  late final List<_PhoneEmailCountry> _countries;
  late final ValueNotifier<_PhoneEmailCountry?> _selectedCountryNotifier;

  bool _showValidation = false;
  bool _forceValidation = false;
  bool _hasText = false;
  bool _isCountryMenuOpen = false;
  bool _isProgrammaticTextChange = false;
  bool _lastIsValid = false;

  PhoneEmailInputType? _mode;
  String _dialCode = '91';

  bool get _isPhone => widget.onlyPhone || _mode == PhoneEmailInputType.phone;
  bool get _shouldFloat => _focusNode.hasFocus || _hasText;

  @override
  void initState() {
    super.initState();
    _countries = _PhoneEmailCountrySource.getAll();
    _dialCode = _countries.any((c) => c.dialCode == widget.countryCode)
        ? widget.countryCode
        : '971';
    _selectedCountryNotifier = ValueNotifier<_PhoneEmailCountry?>(
      _selectedCountryByDialCode(_dialCode),
    );

    if (widget.onlyPhone) {
      final initialPhone = widget.phoneController.text.trim();
      if (widget.emailController != widget.phoneController) {
        widget.emailController.clear();
      }
      if (initialPhone.isNotEmpty) {
        _controller.text = initialPhone;
        _hasText = true;
      }
      _mode = PhoneEmailInputType.phone;
    } else {
      final initialEmail = widget.emailController.text.trim();
      final initialPhone = widget.phoneController.text.trim();
      if (initialEmail.isNotEmpty) {
        _controller.text = initialEmail;
        _mode = PhoneEmailInputType.email;
        _hasText = true;
      } else if (initialPhone.isNotEmpty) {
        _controller.text = initialPhone;
        _mode = PhoneEmailInputType.phone;
        _hasText = true;
      }
    }

    _controller.addListener(_handleChanged);
    _focusNode.addListener(_onFocusChanged);
    _notifyValidity();
  }

  @override
  void didUpdateWidget(covariant AppPhoneEmailInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countryCode != widget.countryCode &&
        _countries.any((c) => c.dialCode == widget.countryCode)) {
      setState(() {
        _dialCode = widget.countryCode;
      });
      _selectedCountryNotifier.value = _selectedCountryByDialCode(_dialCode);
      _notifyValidity();
    }

    if (!oldWidget.onlyPhone && widget.onlyPhone) {
      final nextText = widget.phoneController.text.trim();
      if (widget.emailController != widget.phoneController) {
        widget.emailController.clear();
      }
      _setMode(PhoneEmailInputType.phone);
      _setControllerText(nextText);
      if (mounted) {
        setState(() {
          _hasText = nextText.isNotEmpty;
        });
      }
    }

    if (oldWidget.validator != widget.validator ||
        oldWidget.isMandatory != widget.isMandatory ||
        oldWidget.isOptional != widget.isOptional) {
      _notifyValidity();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    _selectedCountryNotifier.dispose();
    super.dispose();
  }

  void showValidation() {
    if (!_showValidation) {
      setState(() {
        _showValidation = true;
      });
    }
    _forceValidation = true;
    _validateAfterFrame();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      setState(() {
        if (!_showValidation) {
          _showValidation = true;
        }
      });
      return;
    }

    setState(() {
      if (_showValidation && !_forceValidation) {
        _showValidation = false;
      }
    });
  }

  void _handleChanged() {
    if (_isProgrammaticTextChange) return;
    if (!mounted) return;

    final trimmed = _controller.text.trim();
    final nextHasText = trimmed.isNotEmpty;
    if (nextHasText != _hasText) {
      setState(() {
        _hasText = nextHasText;
      });
    }

    if (trimmed.isEmpty) {
      if (!widget.onlyPhone) {
        _setMode(null);
      } else {
        _setMode(PhoneEmailInputType.phone);
      }
      widget.phoneController.clear();
      widget.emailController.clear();
      _maybeRevalidate();
      _notifyValidity();
      return;
    }

    final detected = _detectMode(trimmed);
    if (detected == null) return;

    _setMode(detected);
    if (detected == PhoneEmailInputType.phone) {
      final normalizedForApi = _normalizePhoneForApi(trimmed);
      if (_controller.text != normalizedForApi) {
        _setControllerText(normalizedForApi);
      }
      widget.emailController.clear();
      widget.phoneController.text = normalizedForApi;
    } else {
      if (widget.onlyPhone) {
        widget.emailController.clear();
        widget.phoneController.text = _normalizePhoneForApi(trimmed);
        _maybeRevalidate();
        _notifyValidity();
        return;
      }
      widget.phoneController.clear();
      widget.emailController.text = trimmed;
    }

    _maybeRevalidate();
    _notifyValidity();
  }

  void _maybeRevalidate() {
    if (_showValidation ||
        _forceValidation ||
        (_fieldKey.currentState?.errorText?.isNotEmpty ?? false)) {
      _validateAfterFrame();
    }
  }

  void _validateAfterFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final valid = _fieldKey.currentState?.validate() ?? false;
      if (valid && _forceValidation) {
        if (!mounted) return;
        setState(() {
          _forceValidation = false;
          _showValidation = false;
        });
      }
    });
  }

  void _notifyValidity() {
    final validator = widget.validator ?? _defaultValidator;
    final nextIsValid = validator(_controller.text.trim()) == null;
    if (nextIsValid == _lastIsValid) return;
    _lastIsValid = nextIsValid;
    widget.onValidityChanged?.call(nextIsValid);
  }

  PhoneEmailInputType? _detectMode(String text) {
    final value = text.trim();
    if (value.isEmpty) return null;
    if (widget.onlyPhone) return PhoneEmailInputType.phone;
    if (value.contains('@')) return PhoneEmailInputType.email;

    final normalized = value.replaceAll(RegExp(r'[\s()\-]'), '');
    if (RegExp(r'^\+?\d+$').hasMatch(normalized)) {
      final digitsOnly = normalized.replaceAll(RegExp(r'\D'), '');
      // Use country-specific max length instead of hardcoded value
      final maxPhoneLength = _getMaxPhoneLengthForCountry();
      if (digitsOnly.length > maxPhoneLength) {
        return PhoneEmailInputType.email;
      }
      return PhoneEmailInputType.phone;
    }

    if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return PhoneEmailInputType.email;
    }

    return PhoneEmailInputType.email;
  }

  void _setMode(PhoneEmailInputType? next) {
    if (_mode == next) return;
    setState(() {
      _mode = next;
    });
    if (next != null) {
      widget.onInputTypeChanged?.call(next);
    }
  }

  void _setControllerText(String value) {
    _isProgrammaticTextChange = true;
    _controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
      // composing: TextRange.empty,
    );
    _isProgrammaticTextChange = false;
  }

  _PhoneEmailCountry? _selectedCountryByDialCode(String dialCode) {
    return _countries.cast<_PhoneEmailCountry?>().firstWhere(
      (country) => country?.dialCode == dialCode,
      orElse: () => null,
    );
  }

  _PhoneEmailCountry? _selectedCountry() {
    return _selectedCountryByDialCode(_dialCode);
  }

  /// Returns the maximum valid phone length for the selected country.
  /// Falls back to 10 digits if country data is unavailable.
  int _getMaxPhoneLengthForCountry() {
    final country = _selectedCountry();
    return country?.nationalNumberLength ?? 10;
  }

  String _normalizePhoneForApi(String input) {
    final trimmed = input.trim();
    var digits = trimmed.replaceAll(RegExp(r'\D'), '');
    final hasExplicitCountryCode = RegExp(r'^\s*(\+|00)').hasMatch(trimmed);
    if (hasExplicitCountryCode && digits.startsWith(_dialCode)) {
      digits = digits.substring(_dialCode.length);
    }
    return digits;
  }

  String? _defaultValidator(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) {
      if (widget.isOptional || !widget.isMandatory) {
        return null;
      }
      return FormValidators.required(
        text,
        fieldName: widget.onlyPhone ? 'Phone' : 'Phone or Email',
      );
    }

    final detected = _detectMode(text);
    if (detected == PhoneEmailInputType.email) {
      if (widget.onlyPhone) {
        return 'Invalid phone number';
      }
      return FormValidators.email(text);
    }

    final normalized = _normalizePhoneForApi(text);
    if (normalized.isEmpty || !RegExp(r'^\d+$').hasMatch(normalized)) {
      return 'Invalid phone number';
    }

    final expectedLength = _selectedCountry()?.nationalNumberLength;
    if (expectedLength != null && expectedLength > 0) {
      if (normalized.length != expectedLength) {
        return 'Enter $expectedLength-digit phone number';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final labelColor = const Color(0xFF906556);
    final borderColor = _focusNode.hasFocus
        ? const Color(0xFFD8C8C1)
        : const Color(0xFFE2DBD8);
    final optionalTextColor = const Color(0xFF8F817C);

    final floatingLabelTopPadding = widget.height >= 80 ? 12.0 : 10.0;
    final floatingInputTopPadding = widget.height >= 80 ? 44.0 : 28.0;

    final labelRestingFontSize = 16.0;
    final labelFloatingFontSize = 10.0;
    final baseLeftPadding = _isPhone ? (_countrySelectorWidth + 10) : 20.0;
    final optionalTextReserve = widget.isOptional ? 64.0 : 0.0;

    return FormField<String>(
      key: _fieldKey,
      initialValue: _controller.text,
      autovalidateMode: _showValidation
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      validator: widget.validator ?? _defaultValidator,
      builder: (state) {
        final hasError = state.hasError;
        final errorText = state.errorText ?? '';

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.readOnly || !widget.enabled) return;
                if (!_focusNode.hasFocus) {
                  _focusNode.requestFocus();
                }
              },
              child: AnimatedContainer(
                duration: _duration,
                curve: _curve,
                height: widget.height.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(widget.borderRadius.r),
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(color: borderColor),
                ),
                child: Stack(
                  children: [
                    TextField(
                      controller: _controller,
                      textAlignVertical: TextAlignVertical.center,
                      focusNode: (widget.readOnly || !widget.enabled)
                          ? FocusNode(canRequestFocus: false)
                          : _focusNode,
                      enabled: widget.enabled,
                      readOnly: widget.readOnly,
                      inputFormatters: widget.onlyPhone
                          ? [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9+\s()\-]'),
                              ),
                              LengthLimitingTextInputFormatter(
                                _getMaxPhoneLengthForCountry(),
                              ),
                            ]
                          : null,
                      // keyboardType: _mode == PhoneEmailInputType.phone
                      //     ? TextInputType.phone
                      //     : (widget.onlyPhone
                      //           ? TextInputType.phone
                      //           : TextInputType.emailAddress),
                      // keyboardType: TextInputType.emailAddress,
                      keyboardType: widget.onlyPhone
                          ? TextInputType.phone
                          : TextInputType.emailAddress,
                      textInputAction: widget.textInputAction,
                      onSubmitted: widget.onFieldSubmitted,
                      onTapOutside: (_) => _focusNode.unfocus(),
                      autofillHints: _mode == PhoneEmailInputType.phone
                          ? const [AutofillHints.telephoneNumber]
                          : (widget.onlyPhone
                                ? const [AutofillHints.telephoneNumber]
                                : const [AutofillHints.email]),
                      onChanged: state.didChange,
                      cursorColor: const Color(0xFF8D6356),
                      cursorHeight: 16,
                      cursorWidth: 1.4,
                      style: const TextStyle(
                        color: Color(0xFF2B1B14),
                        fontSize: 14,
                        fontFamily: 'Gilroy500',
                        height: 1.15,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        isDense: true,
                        // hintText: null,
                        prefixText: _isPhone ? '+$_dialCode ' : null,
                        prefixStyle: AppTypography.bodyS.copyWith(
                          height: 1.2,
                          fontSize: AppFontSize.fs14,
                          color: const Color(0xFF5D3A2E),
                        ),
                        hintStyle: AppTypography.bodyM.copyWith(
                          color: const Color(0xFFB5A9A4),
                          fontSize: 14,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: baseLeftPadding - 4,
                          right: 20,
                          top: floatingInputTopPadding,
                        ),
                      ),
                    ),
                    Positioned(
                      // duration: _duration,
                      // curve: _curve,
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: _isPhone ? _countrySelectorWidth : 0,
                      child: IgnorePointer(
                        ignoring: !_isPhone || !widget.enableCountrySelection,
                        child: Opacity(
                          // duration: _duration,
                          // curve: _curve,
                          opacity: _isPhone ? 1 : 0,
                          child: _CountrySelectorView(
                            countries: _countries,
                            selectedDialCode: _dialCode,
                            selectedCountryListenable: _selectedCountryNotifier,
                            isOpen: _isCountryMenuOpen,
                            enabled: widget.enableCountrySelection,
                            searchController: _searchController,
                            onMenuStateChanged: (isOpen) {
                              if (_isCountryMenuOpen == isOpen) return;
                              setState(() {
                                _isCountryMenuOpen = isOpen;
                              });
                              if (!isOpen) {
                                _searchController.clear();
                              }
                            },
                            onChanged: (country) {
                              if (country == null) return;
                              setState(() {
                                _dialCode = country.dialCode;
                                if (_mode == PhoneEmailInputType.phone &&
                                    _controller.text.trim().isNotEmpty) {
                                  _showValidation = true;
                                  _forceValidation = true;
                                }
                              });
                              _selectedCountryNotifier.value = country;
                              widget.onCountryCodeChanged?.call(
                                country.dialCode,
                              );
                              _validateAfterFrame();
                              _notifyValidity();
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: baseLeftPadding,
                          right: 20,
                        ),
                        child: IgnorePointer(
                          child: AnimatedAlign(
                            duration: _duration,
                            curve: _curve,
                            alignment: _shouldFloat
                                ? Alignment.topLeft
                                : Alignment.centerLeft,
                            child: AnimatedPadding(
                              duration: _duration,
                              curve: _curve,
                              padding: EdgeInsets.only(
                                top: _shouldFloat ? floatingLabelTopPadding : 0,
                              ),
                              child: AnimatedDefaultTextStyle(
                                duration: _duration,
                                curve: _curve,
                                style: AppTypography.bodyM.copyWith(
                                  fontSize: _shouldFloat
                                      ? labelFloatingFontSize
                                      : labelRestingFontSize,
                                  color: labelColor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    right: optionalTextReserve,
                                  ),
                                  child: Text.rich(
                                    softWrap: false,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    TextSpan(
                                      children: [
                                        TextSpan(text: widget.label),
                                        if (widget.isMandatory)
                                          const TextSpan(
                                            text: '*',
                                            style: TextStyle(color: Colors.red),
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
                    ),
                    if (widget.isOptional)
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: baseLeftPadding,
                            right: 20,
                          ),
                          child: IgnorePointer(
                            child: AnimatedAlign(
                              duration: _duration,
                              curve: _curve,
                              alignment: _shouldFloat
                                  ? Alignment.topRight
                                  : Alignment.centerRight,
                              child: AnimatedPadding(
                                duration: _duration,
                                curve: _curve,
                                padding: EdgeInsets.only(
                                  top: _shouldFloat
                                      ? floatingLabelTopPadding
                                      : 0,
                                ),
                                child: AnimatedDefaultTextStyle(
                                  duration: _duration,
                                  curve: _curve,
                                  style: AppTypography.bodyM.copyWith(
                                    fontSize: _shouldFloat
                                        ? labelFloatingFontSize
                                        : labelRestingFontSize,
                                    color: optionalTextColor,
                                  ),
                                  child: Text(
                                    'Optional',
                                    maxLines: 1,
                                    style: AppTypography.bodyS.copyWith(
                                      color: AppColors.textFieldOptional,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (hasError && errorText.trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 6),
                child: Text(
                  errorText,
                  style: const TextStyle(
                    color: Color(0xFFB3261E),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CountrySelectorView extends StatelessWidget {
  const _CountrySelectorView({
    required this.countries,
    required this.selectedDialCode,
    required this.selectedCountryListenable,
    required this.isOpen,
    required this.enabled,
    required this.searchController,
    required this.onMenuStateChanged,
    required this.onChanged,
  });

  final List<_PhoneEmailCountry> countries;
  final String selectedDialCode;
  final ValueNotifier<_PhoneEmailCountry?> selectedCountryListenable;
  final bool isOpen;
  final bool enabled;
  final TextEditingController searchController;
  final ValueChanged<bool> onMenuStateChanged;
  final ValueChanged<_PhoneEmailCountry?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOpen ? const Color(0xFFF1EEED) : Colors.white,
        border: const Border(right: BorderSide(color: Color(0xFFE6E0DE))),
      ),
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<_PhoneEmailCountry>(
            isExpanded: true,
            valueListenable: selectedCountryListenable,
            items: countries
                .map(
                  (country) => DropdownItem<_PhoneEmailCountry>(
                    value: country,
                    height: 44,
                    child: _CountryDropdownRow(
                      country: country,
                      isSelected: country.dialCode == selectedDialCode,
                    ),
                  ),
                )
                .toList(growable: false),
            selectedItemBuilder: (context) {
              return countries
                  .map(
                    (country) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: _CountryFlagAvatar(country: country, size: 24),
                      ),
                    ),
                  )
                  .toList(growable: false);
            },
            onChanged: enabled ? onChanged : null,
            onMenuStateChange: enabled ? onMenuStateChanged : null,
            iconStyleData: IconStyleData(
              icon: AnimatedRotation(
                duration: const Duration(milliseconds: 180),
                turns: isOpen ? 0.5 : 0,
                // child: Assets.svg.arrowDown.svg(
                //   height: 20,
                //   width: 20,
                //   fit: BoxFit.cover,
                // ),
                child: SvgPicture.asset(
                  AppIcons.svg.generic.chevronDown,
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover,
                ),
              ),
              iconEnabledColor: const Color(0xFF7A4430),
              iconDisabledColor: const Color(0xFF7A4430),
            ),
            buttonStyleData: const ButtonStyleData(
              width: 108,
              height: 56,
              padding: EdgeInsets.only(left: 2, right: 6),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 320,
              width: MediaQuery.sizeOf(context).width - 32,
              offset: const Offset(0, -2),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F5F4),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE2DBD8)),
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(8),
                thickness: WidgetStateProperty.all(4),
                thumbColor: WidgetStateProperty.all(const Color(0xFFD1C6C1)),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.zero,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: searchController,
              searchBarWidgetHeight: 64,
              searchBarWidget: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
                child: TextFormField(
                  controller: searchController,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF2B1B14),
                    fontFamily: 'Gilroy500',
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF7E7A78),
                      fontFamily: 'Gilroy400',
                    ),
                    suffixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF5A5553),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE2DBD8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFE2DBD8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFFD1C3BE)),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                final country = item.value;
                if (country == null) return false;
                final query = searchValue.trim().toLowerCase();
                return country.name.toLowerCase().contains(query) ||
                    country.dialCode.contains(query.replaceAll('+', ''));
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _CountryDropdownRow extends StatelessWidget {
  const _CountryDropdownRow({required this.country, required this.isSelected});

  final _PhoneEmailCountry country;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          _CountryFlagAvatar(country: country, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${country.name} +${country.dialCode}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                color: const Color(0xFF2B1B14),
                fontFamily: isSelected ? 'Gilroy600' : 'Gilroy500',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryFlagAvatar extends StatelessWidget {
  const _CountryFlagAvatar({required this.country, this.size = 30});

  final _PhoneEmailCountry country;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: AppImageCachedWidget(
          imageUrl: country.flagPngUrl,
          // boxFit: BoxFit.cover,
        ),
      ),
    );
  }
}

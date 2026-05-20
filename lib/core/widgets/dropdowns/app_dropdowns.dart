import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';

class AppDropdowns<T> extends StatefulWidget {
  const AppDropdowns({
    super.key,
    required this.items,
    this.selectedItemBuilder,
    this.valueListenable,
    this.multiValueListenable,
    this.isMandatory = false,
    this.hint,
    this.disabledHint,
    this.onChanged,
    this.onMenuStateChange,
    this.style,
    this.underline,
    this.isDense = false,
    this.isExpanded = false,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.dropdownStyleData,
    this.menuItemStyleData = const MenuItemStyleData(),
    this.buttonStyleData,
    this.iconStyleData,
    this.dropdownSearchData,
    this.dropdownSeparator,
    this.customButton,
    this.openWithLongPress = false,
    this.barrierDismissible = true,
    this.barrierCoversButton = true,
    this.barrierColor,
    this.barrierLabel,
    this.openDropdownListenable,
    this.isSearchable = false,
    this.searchController,
    this.searchBarWidgetHeight = 60,
    this.searchHintText = 'Type to search',
    this.searchIcon,
    this.noResultsWidget,
    this.clearSearchOnMenuClose = true,
    this.searchMatchFn,
  }) : assert(
         valueListenable == null || multiValueListenable == null,
         'Only one of valueListenable or multiValueListenable can be used.',
       );

  final List<DropdownItem<T>>? items;
  final DropdownButton2Builder? selectedItemBuilder;
  final ValueListenable<T?>? valueListenable;
  final ValueListenable<Iterable<T>>? multiValueListenable;
  final Widget? hint;
  final Widget? disabledHint;
  final ValueChanged<T?>? onChanged;
  final OnMenuStateChangeFn? onMenuStateChange;
  final TextStyle? style;
  final Widget? underline;
  final bool isDense;
  final bool isExpanded;
  final bool isMandatory;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool? enableFeedback;
  final AlignmentGeometry alignment;
  final DropdownStyleData? dropdownStyleData;
  final MenuItemStyleData menuItemStyleData;
  final ButtonStyleData? buttonStyleData;
  final IconStyleData? iconStyleData;
  final DropdownSearchData<T>? dropdownSearchData;
  final DropdownSeparator<T>? dropdownSeparator;
  final Widget? customButton;
  final bool openWithLongPress;
  final bool barrierDismissible;
  final bool barrierCoversButton;
  final Color? barrierColor;
  final String? barrierLabel;
  final Listenable? openDropdownListenable;

  final bool isSearchable;
  final TextEditingController? searchController;
  final double searchBarWidgetHeight;
  final String searchHintText;
  final Widget? searchIcon;
  final Widget? noResultsWidget;
  final bool clearSearchOnMenuClose;
  final SearchMatchFn<T>? searchMatchFn;

  @override
  State<AppDropdowns<T>> createState() => _AppDropdownsState<T>();
}

class _AppDropdownsState<T> extends State<AppDropdowns<T>> {
  late final TextEditingController _internalSearchController;

  TextEditingController get _searchController =>
      widget.searchController ?? _internalSearchController;
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _internalSearchController = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant AppDropdowns<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchController != widget.searchController &&
        widget.clearSearchOnMenuClose &&
        mounted) {
      _searchController.clear();
    }
  }

  @override
  void dispose() {
    _internalSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double defaultMenuMaxHeight =
        MediaQuery.sizeOf(context).height * 0.42;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (widget.label != null) _buildLabel(),
        DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            items: widget.items,
            selectedItemBuilder: widget.selectedItemBuilder,
            valueListenable: widget.valueListenable,
            multiValueListenable: widget.multiValueListenable,
            hint: _buildHint(context),
            disabledHint: widget.disabledHint,
            onChanged: widget.onChanged,
            onMenuStateChange: _onMenuStateChange,
            style:
                widget.style ??
                AppTypography.bodyM.copyWith(color: AppColors.textPrimary),
            underline: widget.underline,
            isDense: widget.isDense,
            isExpanded: widget.isExpanded,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            enableFeedback: widget.enableFeedback,
            alignment: widget.alignment,
            buttonStyleData:
                widget.buttonStyleData ??
                ButtonStyleData(
                  height: AppSpacing.s56.h,
                  padding: EdgeInsets.only(right: AppSpacing.s10.w),
                  decoration: BoxDecoration(
                    color: AppColors.textFieldBackgroundDefault,
                    borderRadius: BorderRadius.circular(AppRadiusSize.r16),
                    border: Border.all(color: AppColors.textFieldBorderDefault),
                  ),
                ),
            iconStyleData:
                widget.iconStyleData ??
                IconStyleData(
                  icon: AnimatedRotation(
                    turns: _isDropdownOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: AppIcon(AppIcons.svg.generic.chevronDown, size: 16),
                  ),
                ),
            dropdownStyleData:
                widget.dropdownStyleData ??
                DropdownStyleData(
                  maxHeight: defaultMenuMaxHeight,
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.s5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSpacing.s16.r),
                  ),
                ),
            menuItemStyleData: widget.menuItemStyleData,
            dropdownSearchData: _effectiveDropdownSearchData(context),
            dropdownSeparator: widget.dropdownSeparator,
            customButton: widget.customButton,
            openWithLongPress: widget.openWithLongPress,
            barrierDismissible: widget.barrierDismissible,
            barrierCoversButton: widget.barrierCoversButton,
            barrierColor: widget.barrierColor,
            barrierLabel: widget.barrierLabel,
            openDropdownListenable: widget.openDropdownListenable,
          ),
        ),
      ],
    );
  }

  DropdownSearchData<T>? _effectiveDropdownSearchData(BuildContext context) {
    if (!widget.isSearchable) {
      return null;
    }
    if (widget.dropdownSearchData != null) {
      return widget.dropdownSearchData;
    }

    return DropdownSearchData<T>(
      searchController: _searchController,
      searchBarWidgetHeight: widget.searchBarWidgetHeight,
      searchBarWidget: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 4, right: 8, left: 8),
        child: AppTextField(
          controller: _searchController,
          label: widget.searchHintText,
          unfocusOnTapOutside: false,
          suffixWidget:
              widget.searchIcon ?? AppIcon(AppIcons.svg.generic.search),
        ),
      ),

      noResultsWidget:
          widget.noResultsWidget ??
          const SizedBox(
            height: 100,
            child: Center(child: Text('No item found!')),
          ),
      searchMatchFn:
          widget.searchMatchFn ??
          (item, searchValue) {
            final query = searchValue.trim().toLowerCase();
            if (query.isEmpty) {
              return true;
            }

            final itemText = _dropdownItemText(item).toLowerCase();
            return itemText.contains(query);
          },
    );
  }

  String _dropdownItemText(DropdownItem<T> item) {
    final child = item.child;
    if (child is Text) {
      return child.data ?? '';
    }
    if (child is AppText) {
      return child.text;
    }
    return item.value?.toString() ?? '';
  }

  void _onMenuStateChange(bool isOpen) {
    widget.onMenuStateChange?.call(isOpen);
    if (!isOpen && widget.isSearchable && widget.clearSearchOnMenuClose) {
      _searchController.clear();
    }
    setState(() {
      _isDropdownOpen = isOpen;
    });
  }

  Widget _buildHint(BuildContext context) {
    if (widget.hint != null) {
      final hint = widget.hint!;
      if (hint is Text) {
        return _buildHintText(
          hint.data ?? '',
          hint.style ??
              AppTypography.bodyM.copyWith(color: Theme.of(context).hintColor),
        );
      }
      if (hint is AppText) {
        final textStyle =
            (hint.style != null
                    ? hint.baseStyle.merge(hint.style)
                    : hint.baseStyle)
                .copyWith(
                  color: hint.color ?? hint.baseStyle.color,
                  fontSize: hint.fontSize ?? hint.baseStyle.fontSize,
                );
        return _buildHintText(hint.text, textStyle);
      }
      return hint;
    }

    return _buildHintText(
      'Select Item',
      AppTypography.bodyM.copyWith(color: Theme.of(context).hintColor),
    );
  }

  Widget _buildHintText(String text, TextStyle style) {
    if (!widget.isMandatory) {
      return Text(text, style: style);
    }

    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: text),
          const TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}

// How to use

// Simple Usage:
/*
AppErrorContainer(
  showError: _showBreedDropdownError,
  errorMessage: 'Please select a breed',
  child: AppDropdowns<String>(
    items: _dropdownItems,
    valueListenable: _selectedDropdownValue,
    onChanged: (value) {
      if (value != null) {
        setState(() {
          _showBreedDropdownError = false;
          _selectedDropdownValue.value = value;
        });
      }
    },
    isExpanded: true,
    isSearchable: true,
    searchHintText: 'Type Breed',
  ),
),
*/

// Custom Usage:
/*
AppDropdowns<String>(
  items: _dropdownItems,
  valueListenable: _selectedDropdownValue,
  onChanged: (value) {
    if (value != null) {
      setState(() {
        _showBreedDropdownError = false;
        _selectedDropdownValue.value = value;
      });
    }
  },
  isExpanded: true,
  style: const TextStyle(
    fontSize: 14,
    color: Colors.black,
    fontFamily: 'Gilroy600',
  ),
  isSearchable: true,
  searchHintText: 'Type Breed',
  hint: Text(
    'Select Item',
    style: TextStyle(
      fontSize: 14,
      fontFamily: 'Gilroy600',
      color: Theme.of(context).hintColor,
    ),
  ),
  buttonStyleData: ButtonStyleData(
    decoration: BoxDecoration(
      color: const Color(0xffFFFEFD),
      borderRadius: BorderRadius.circular(16),
    ),
    height: 56,
    padding: const EdgeInsets.only(right: 10),
  ),
  searchIcon: AppIcon(AppIcons.svg.generic.search),
  dropdownStyleData: DropdownStyleData(
    maxHeight: 300,
    padding: const EdgeInsets.only(left: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
)
*/

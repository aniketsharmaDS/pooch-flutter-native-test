import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/checkbox/app_checkbox.dart';
import 'package:poochcare/core/widgets/radio/app_circle_radio.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/core/widgets/texts/app_text_selectable.dart';

enum FilterSelectionType { single, multiple }

class FilterOptionItem {
  const FilterOptionItem({required this.id, required this.label});

  final String id;
  final String label;
}

class FilterSectionItem {
  const FilterSectionItem({
    required this.id,
    required this.title,
    required this.selectionType,
    required this.options,
    this.enableSearch = false,
    this.searchHint = 'Type to search',
  });

  final String id;
  final String title;
  final FilterSelectionType selectionType;
  final List<FilterOptionItem> options;
  final bool enableSearch;
  final String searchHint;
}

class CustomFilterResult {
  const CustomFilterResult({required this.selectedValues});

  final Map<String, Set<String>> selectedValues;
}

class AppFilterDialog extends StatefulWidget {
  const AppFilterDialog({
    required this.sections,
    this.initialSelectedValues = const {},
    this.title = 'Filters',
    this.leftPanelBackground = const Color(0xFFFEF3E6),
    super.key,
  });

  final List<FilterSectionItem> sections;
  final Map<String, Set<String>> initialSelectedValues;
  final String title;
  final Color leftPanelBackground;

  static Future<CustomFilterResult?> show(
    BuildContext context, {
    required List<FilterSectionItem> sections,
    Map<String, Set<String>> initialSelectedValues = const {},
    String title = 'Filters',
    Color leftPanelBackground = const Color(0xFFFEF3E6),
  }) {
    return showGeneralDialog<CustomFilterResult>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'custom-filter-dialog',
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, animation, secondaryAnimation) {
        return AppFilterDialog(
          sections: sections,
          initialSelectedValues: initialSelectedValues,
          title: title,
          leftPanelBackground: leftPanelBackground,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<AppFilterDialog> createState() => _AppFilterDialogState();
}

class _AppFilterDialogState extends State<AppFilterDialog>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _searchController;
  late final AnimationController _optionAnimationController;
  late final Animation<double> _optionFadeAnimation;
  late final Animation<Offset> _optionSlideAnimation;
  late final Map<String, Set<String>> _selectedValues;
  int _selectedSectionIndex = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xffFEF3E6)),
    );
    _searchController = TextEditingController();
    _selectedValues = _createInitialSelectedMap();
    _optionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    final curvedAnimation = CurvedAnimation(
      parent: _optionAnimationController,
      curve: Curves.easeOut,
    );
    _optionFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curvedAnimation);
    _optionSlideAnimation = Tween<Offset>(
      begin: const Offset(0.04, 0),
      end: Offset.zero,
    ).animate(curvedAnimation);
    _optionAnimationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _optionAnimationController.dispose();
    super.dispose();
  }

  Map<String, Set<String>> _createInitialSelectedMap() {
    final values = <String, Set<String>>{};
    for (final section in widget.sections) {
      final provided = widget.initialSelectedValues[section.id] ?? <String>{};
      values[section.id] = Set<String>.from(provided);
    }
    return values;
  }

  bool _hasAnySelection() {
    return _selectedValues.values.any((set) => set.isNotEmpty);
  }

  FilterSectionItem get _selectedSection =>
      widget.sections[_selectedSectionIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: widget.leftPanelBackground,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s16.w,
                vertical: AppSpacing.s16.h,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppText.h1(
                      widget.title,
                      fontSize: AppFontSize.fs16,
                      color: AppColors.p4_900,
                    ),
                  ),
                  // IconButton(
                  //   splashRadius: 20,
                  //   onPressed: () => Navigator.of(context).pop(),
                  //   icon: const Icon(Icons.close, size: 22),
                  // ),
                  // GestureDetector(
                  //   onTap: () => Navigator.of(context).pop(),
                  //   child: AppIcon(
                  //     AppIcons.svg.generic.close,
                  //     size: AppIconSize.is16,
                  //     color: AppColors.p4_900,
                  //   ),
                  // ),
                  AppCircleButton(
                    icon: AppIcons.svg.generic.close,
                    iconColor: (AppColors.p4_900),
                    bgColor: AppColors.transparent,
                    visualSize: AppIconSize.is20,
                    onTap: () => Navigator.of(context).pop(),
                    showShadow: false,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _buildLeftPanel(),
                  Expanded(child: _buildRightPanel()),
                ],
              ),
            ),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftPanel() {
    return Container(
      width: AppSize.cs142,
      color: widget.leftPanelBackground,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.sections.length,
        itemBuilder: (context, index) {
          final section = widget.sections[index];
          final isSelected = _selectedSectionIndex == index;
          return InkWell(
            onTap: () => _onSectionChanged(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              color: isSelected ? Colors.white : widget.leftPanelBackground,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s12.w,
                vertical: AppSpacing.s18.h,
              ),
              child: Row(
                children: [
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 160),
                    opacity: isSelected ? 1 : 0,
                    child: AppText.bodyM('\u2022 '),
                  ),
                  Expanded(
                    child: AppSelectableText(
                      text: section.title,
                      isSelected: isSelected,
                      maxLines: 2,
                      builder: (text, {style, maxLines, textAlign}) {
                        return AppText.h4(
                          text,
                          style: style,
                          maxLines: maxLines,
                          textAlign: textAlign,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRightPanel() {
    final section = _selectedSection;
    final options = _filteredOptions(section);

    return AnimatedBuilder(
      animation: _optionAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _optionFadeAnimation,
          child: SlideTransition(position: _optionSlideAnimation, child: child),
        );
      },
      child: Column(
        key: ValueKey<String>(section.id),
        children: [
          if (section.enableSearch) _buildSearchField(section),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                top: AppSpacing.s4.h,
                bottom: AppSpacing.s8.h,
              ),
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                final isSelected =
                    _selectedValues[section.id]?.contains(option.id) ?? false;
                return _buildOptionTile(
                  section: section,
                  option: option,
                  isSelected: isSelected,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(height: 1, color: Color(0xFFEAEAEA));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(FilterSectionItem section) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.s12.w,
        AppSpacing.s12.h,
        AppSpacing.s12.w,
        AppSpacing.s8.h,
      ),
      child: AppTextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.trim();
          });
        },
        label: 'Search here...',
      ),
    );
  }

  Widget _buildOptionTile({
    required FilterSectionItem section,
    required FilterOptionItem option,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onOptionTapped(section: section, option: option),
        child: SizedBox(
          height: 52.h,
          child: Row(
            children: [
              SizedBox(
                width: 42.w,
                child: Center(
                  child: section.selectionType == FilterSelectionType.multiple
                      ? IgnorePointer(
                          child: AppCheckbox(
                            borderColor: AppColors.activeColor,
                            value: isSelected,
                            onChanged: (_) {},
                          ),
                        )
                      : AppCircleRadio(
                          isSelected: isSelected,
                          label: '',
                          onTap: () =>
                              _onOptionTapped(section: section, option: option),
                        ),
                ),
              ),
              Expanded(
                child: AppSelectableText(
                  text: option.label,
                  isSelected: isSelected,
                  maxLines: 2,
                  builder: (text, {style, maxLines, textAlign}) {
                    return AppText.bodyM(
                      text,
                      style: style,
                      maxLines: maxLines,
                      textAlign: textAlign,
                    );
                  },
                ),
              ),

              AppSpacing.s12.wBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.s16.w,
        AppSpacing.s10.h,
        AppSpacing.s16.w,
        AppSpacing.s12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowPrimary,
            blurRadius: 14.r,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              label: 'Clear',
              variant: AppButtonVariant.outlined,
              onPressed: _hasAnySelection() ? _onClear : null,
            ),
          ),
          AppSpacing.s12.wBox,
          Expanded(
            child: AppButton(
              label: 'Apply',
              onPressed: _hasAnySelection() ? _onApply : null,
            ),
          ),
        ],
      ),
    );
  }

  List<FilterOptionItem> _filteredOptions(FilterSectionItem section) {
    if (!section.enableSearch) {
      return section.options;
    }
    if (_searchQuery.isEmpty) {
      return section.options;
    }
    final query = _searchQuery.toLowerCase();
    return section.options
        .where((option) => option.label.toLowerCase().contains(query))
        .toList(growable: false);
  }

  void _onSectionChanged(int index) {
    if (_selectedSectionIndex == index) return;

    setState(() {
      _selectedSectionIndex = index;
      _searchQuery = '';
      _searchController.clear();
    });

    _optionAnimationController
      ..reset()
      ..forward();
  }

  void _onOptionTapped({
    required FilterSectionItem section,
    required FilterOptionItem option,
  }) {
    final selected = _selectedValues.putIfAbsent(section.id, () => <String>{});
    setState(() {
      if (section.selectionType == FilterSelectionType.single) {
        selected
          ..clear()
          ..add(option.id);
      } else {
        if (selected.contains(option.id)) {
          selected.remove(option.id);
        } else {
          selected.add(option.id);
        }
      }
    });
  }

  // void _onClear() {
  //   setState(() {
  //     for (final section in widget.sections) {
  //       _selectedValues[section.id] = <String>{};
  //     }
  //   });
  // }

  void _onClear() {
    Navigator.of(context).pop(const CustomFilterResult(selectedValues: {}));
  }

  void _onApply() {
    final copy = <String, Set<String>>{};
    for (final entry in _selectedValues.entries) {
      copy[entry.key] = Set<String>.from(entry.value);
    }
    Navigator.of(context).pop(CustomFilterResult(selectedValues: copy));
  }
}

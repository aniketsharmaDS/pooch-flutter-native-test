import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/community/data/models/tips_category_model.dart';

class CategorySelector extends StatefulWidget {
  final List<TipsCategoryModel> categories;
  final void Function(TipsCategoryModel category)? onCategorySelected;
  final String? selectedCategoryId;

  const CategorySelector({
    super.key,
    required this.categories,
    this.onCategorySelected,
    this.selectedCategoryId,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  late int selectedIndex;
  late List<TipsCategoryModel> allCategories;

  @override
  void initState() {
    super.initState();
    _initializeCategories();
  }

  @override
  void didUpdateWidget(CategorySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCategoryId != oldWidget.selectedCategoryId ||
        widget.categories != oldWidget.categories) {
      _initializeCategories();
    }
  }

  void _initializeCategories() {
    // Add "All" at the beginning
    allCategories = [
      TipsCategoryModel(id: 'all', name: 'community.categorySelector.all'.tr()),
      ...widget.categories,
    ];

    // Find the index of the selected category
    if (widget.selectedCategoryId != null &&
        widget.selectedCategoryId!.isNotEmpty) {
      selectedIndex = allCategories.indexWhere(
        (cat) => cat.id == widget.selectedCategoryId,
      );
      if (selectedIndex == -1) {
        selectedIndex = 0;
      }
    } else {
      selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.cs50.csh,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        itemBuilder: (context, index) {
          final category = allCategories[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              if (selectedIndex == index) return;
              setState(() {
                selectedIndex = index;
              });
              widget.onCategorySelected?.call(category);
            },
            child: Container(
              color: AppColors.transparent,
              constraints: BoxConstraints(minWidth: AppSize.cs60.csw),
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s6.w),
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.s10.w,
                ).copyWith(bottom: AppSpacing.s10.h),
                constraints: BoxConstraints(minWidth: AppSize.cs40.csw),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  border: Border(
                    bottom: isSelected
                        ? BorderSide(
                            color: AppColors.p5_900,
                            width: AppSize.cs1.csh,
                          )
                        : BorderSide.none,
                  ),
                ),
                alignment: Alignment.bottomCenter,
                child: isSelected
                    ? AppText.tabLabel(
                        category.name,
                        style: AppTypography.buttonS,
                      )
                    : AppText.tabLabel(category.name),
              ),
            ),
          );
        },
      ),
    );
  }
}

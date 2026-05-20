import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

/// 🔥 GENERIC SELECTOR (Reusable Everywhere)
class GenericCategorySelector<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item) getId;
  final String Function(T item) getLabel;
  final String? selectedId;
  final void Function(T item)? onItemSelected;

  final bool includeAll;
  final T? allItem;

  final bool Function(T item)? shouldTriggerModal;
  final void Function(T item)? onTriggerModal;

  /// 🔥 NEW
  final bool isScrollable;

  const GenericCategorySelector({
    super.key,
    required this.items,
    required this.getId,
    required this.getLabel,
    this.selectedId,
    this.onItemSelected,
    this.includeAll = true,
    this.allItem,
    this.shouldTriggerModal,
    this.onTriggerModal,
    this.isScrollable = false, // default same as current
  });

  @override
  State<GenericCategorySelector<T>> createState() =>
      _GenericCategorySelectorState<T>();
}

class _GenericCategorySelectorState<T>
    extends State<GenericCategorySelector<T>> {
  late List<T> allItems;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant GenericCategorySelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.items != oldWidget.items ||
        widget.selectedId != oldWidget.selectedId) {
      _init();
    }
  }

  void _init() {
    allItems = [...widget.items];

    if (widget.includeAll && widget.allItem != null) {
      allItems.insert(0, widget.allItem as T);
    }

    selectedIndex = allItems.indexWhere(
      (item) => widget.getId(item) == widget.selectedId,
    );

    if (selectedIndex == -1) selectedIndex = 0;
  }

  void _onTap(int index, T item) {
    if (selectedIndex == index) return;

    if (widget.shouldTriggerModal?.call(item) == true) {
      widget.onTriggerModal?.call(item);
      return;
    }

    setState(() {
      selectedIndex = index;
    });

    widget.onItemSelected?.call(item);
  }

  Widget _buildItem(T item, int index, {bool expand = false}) {
    final isSelected = selectedIndex == index;

    final child = GestureDetector(
      onTap: () => _onTap(index, item),
      child: Container(
        color: AppColors.transparent,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.s10.w,
            ).copyWith(bottom: AppSpacing.s10.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: isSelected
                    ? BorderSide(
                        color: AppColors.p5_900,
                        width: AppSize.cs1.csh,
                      )
                    : BorderSide.none,
              ),
            ),
            child: isSelected
                ? AppText.tabLabel(
                    widget.getLabel(item),
                    style: AppTypography.buttonS,
                  )
                : AppText.tabLabel(widget.getLabel(item)),
          ),
        ),
      ),
    );

    /// 🔥 Expand only when NOT scrollable
    if (!widget.isScrollable && expand) {
      return Expanded(child: child);
    }

    return Container(
      constraints: BoxConstraints(minWidth: AppSize.cs60.csw),
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.s6.w),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 🔥 NON-SCROLLABLE → Equal width tabs
    if (!widget.isScrollable) {
      return SizedBox(
        height: AppSize.cs50.csh,
        child: Row(
          children: List.generate(
            allItems.length,
            (index) => _buildItem(allItems[index], index, expand: true),
          ),
        ),
      );
    }

    /// 🔥 SCROLLABLE → Current behavior
    return SizedBox(
      height: AppSize.cs50.csh,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allItems.length,
        itemBuilder: (context, index) {
          return _buildItem(allItems[index], index);
        },
      ),
    );
  }
}

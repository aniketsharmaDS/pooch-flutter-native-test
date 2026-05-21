import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';

class ChipTabItem {
  final String title;
  final String? icon;

  const ChipTabItem({required this.title, this.icon});
}

class AppTopChipTabBar extends StatefulWidget {
  const AppTopChipTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    this.initialIndex = 0,
    this.onTabChanged,
  });

  final List<ChipTabItem> tabs;
  final int initialIndex;
  final int selectedIndex;
  final ValueChanged<int>? onTabChanged;

  @override
  State<AppTopChipTabBar> createState() => _AppTopChipTabBarState();
}

class _AppTopChipTabBarState extends State<AppTopChipTabBar> {
  late int _selectedIndex;

  final ScrollController _scrollController = ScrollController();

  final List<GlobalKey> _tabKeys = [];

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex;

    _tabKeys.addAll(List.generate(widget.tabs.length, (_) => GlobalKey()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToIndex(_selectedIndex);
    });
  }

  @override
  void didUpdateWidget(covariant AppTopChipTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (oldWidget.selectedIndex != widget.selectedIndex) {
    //   _selectedIndex = widget.selectedIndex;

    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _scrollToIndex(_selectedIndex);
    //   });
    // }

    if (oldWidget.tabs.length != widget.tabs.length) {
      _tabKeys
        ..clear()
        ..addAll(List.generate(widget.tabs.length, (_) => GlobalKey()));

      if (_selectedIndex >= widget.tabs.length) {
        _selectedIndex = widget.tabs.isEmpty ? 0 : widget.tabs.length - 1;
      }
    }
  }

  void _onTap(int index) {
    setState(() => _selectedIndex = index);

    widget.onTabChanged?.call(index);

    _scrollToIndex(index);
  }

  void _scrollToIndex(int index) {
    if (index < 0 || index >= _tabKeys.length) return;

    if (!_scrollController.hasClients) return;

    final keyContext = _tabKeys[index].currentContext;

    if (keyContext == null) return;

    final RenderBox renderBox = keyContext.findRenderObject() as RenderBox;

    final position = renderBox.localToGlobal(Offset.zero);

    final double screenWidth = MediaQuery.of(context).size.width;

    final double itemWidth = renderBox.size.width;

    final double targetOffset =
        _scrollController.offset +
        position.dx -
        (screenWidth / 2) +
        (itemWidth / 2);

    _scrollController.animateTo(
      targetOffset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ChipTabBar(
          tabs: widget.tabs,
          selectedIndex: _selectedIndex,
          onTap: _onTap,
          controller: _scrollController,
          tabKeys: _tabKeys,
        ),
      ],
    );
  }
}

class _ChipTabBar extends StatelessWidget {
  const _ChipTabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
    required this.controller,
    required this.tabKeys,
  });

  final List<ChipTabItem> tabs;
  final int selectedIndex;
  final void Function(int) onTap;
  final ScrollController controller;
  final List<GlobalKey> tabKeys;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      color: AppColors.transparent,
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemCount: tabs.length,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: 6.w),
        itemBuilder: (context, index) {
          final bool isSelected = index == selectedIndex;

          return GestureDetector(
            key: tabKeys[index],
            onTap: () => onTap(index),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 100.w),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 1.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFDDC2B6).withValues(alpha: 0.29),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (tabs[index].icon != null) ...[
                      AppIcon(
                        tabs[index].icon!,
                        size: 18.sp,
                        color: isSelected ? AppColors.p5_900 : AppColors.p4,
                      ),
                      SizedBox(width: 5.w),
                    ],
                    AppText.h3(
                      tabs[index].title,
                      color: isSelected ? AppColors.p5_900 : AppColors.p4,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

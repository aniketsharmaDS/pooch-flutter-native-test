import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';

class AppDefaultRouteTabs extends StatelessWidget {
  final List<PageRouteInfo>? routes;
  final List<Widget>? children;
  final List<String> tabNames;
  final ValueChanged<int>? onTabChanged;
  final bool isScrollable;
  final EdgeInsetsGeometry? labelPadding;

  /// Use this when inside Card / Column (not full screen)
  final double? contentHeight;

  const AppDefaultRouteTabs({
    super.key,
    this.routes,
    this.children,
    required this.tabNames,
    this.contentHeight,
    this.onTabChanged,
    this.isScrollable = false,
    this.labelPadding,
  }) : assert(
         (routes != null && children == null) ||
             (routes == null && children != null),
         'Provide either routes OR children, not both',
       ),
       assert(
         (routes?.length ?? children?.length) == tabNames.length,
         'tabs and content length must match',
       );

  @override
  Widget build(BuildContext context) {
    /// =========================
    /// ROUTE MODE
    /// =========================
    if (routes != null) {
      return AutoTabsRouter.tabBar(
        physics: const NeverScrollableScrollPhysics(),
        routes: routes!,
        builder: (context, child, tabController) {
          onTabChanged?.call(tabController.index);
          return _buildLayout(
            controller: tabController,
            child: child,
            isScrollbale: isScrollable,
          );
        },
      );
    }

    /// =========================
    /// WIDGET MODE
    /// =========================
    // return DefaultTabController(
    //   length: tabNames.length,
    //   child: Builder(
    //     builder: (context) {
    //       final controller = DefaultTabController.of(context);
    //       onTabChanged?.call(controller.index);
    //       return _buildLayout(
    //         controller: controller,
    //         child: TabBarView(
    //           physics: const NeverScrollableScrollPhysics(),
    //           children: children!,
    //         ),
    //       );
    //     },
    //   ),
    // );
    return DefaultTabController(
      length: tabNames.length,
      child: _TabChangeListener(
        onTabChanged: onTabChanged,
        child: Builder(
          builder: (context) {
            final controller = DefaultTabController.of(context);

            return _buildLayout(
              isScrollbale: isScrollable,
              controller: controller,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: children!,
              ),
            );
          },
        ),
      ),
    );
  }

  /// =========================
  /// COMMON LAYOUT (NO DESIGN CHANGE)
  /// =========================
  Widget _buildLayout({
    required TabController controller,
    required Widget child,
    bool isScrollbale = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// =========================
        /// TAB BAR (UNCHANGED)
        /// =========================
        TabBar(
          dividerColor: AppColors.transparent,
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          isScrollable: isScrollbale,
          tabAlignment: isScrollbale ? TabAlignment.start : TabAlignment.fill,
          labelPadding:
              labelPadding ??
              EdgeInsets.symmetric(horizontal: AppSpacing.s12.w),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textPrimary,
          labelStyle: AppTypography.h3.copyWith(fontSize: AppFontSize.fs14),
          unselectedLabelStyle: AppTypography.bodyM,
          tabs: tabNames.map((e) => Tab(text: e)).toList(),

          /// 👇 SAME INDICATOR
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: AppColors.textPrimary,
              width: AppSize.cs1.csw,
            ),
          ),
        ),

        SizedBox(height: AppSpacing.s12.w),

        /// =========================
        /// TAB CONTENT (UNCHANGED)
        /// =========================
        if (contentHeight != null)
          SizedBox(height: contentHeight, child: child)
        else
          Expanded(child: child),
      ],
    );
  }
}

class _TabChangeListener extends StatefulWidget {
  final ValueChanged<int>? onTabChanged;
  final Widget child;

  const _TabChangeListener({required this.onTabChanged, required this.child});

  @override
  State<_TabChangeListener> createState() => _TabChangeListenerState();
}

class _TabChangeListenerState extends State<_TabChangeListener> {
  TabController? _controller;

  void _listener() {
    final controller = _controller;
    if (controller == null) return;

    if (!controller.indexIsChanging) {
      widget.onTabChanged?.call(controller.index);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newController = DefaultTabController.of(context);

    if (_controller != newController) {
      _controller?.removeListener(_listener);
      _controller = newController;
      _controller?.addListener(_listener);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/tabs/app_top_chip_tab_bar.dart';
import 'package:poochcare/router/app_router.dart';

/// =============================
/// SCREEN
/// =============================

@RoutePage()
class AppTopChipTabBarScreen extends StatefulWidget {
  const AppTopChipTabBarScreen({super.key});

  @override
  State<AppTopChipTabBarScreen> createState() => _AppTopChipTabBarScreenState();
}

class _AppTopChipTabBarScreenState extends State<AppTopChipTabBarScreen> {
  /// =============================
  /// UI
  /// =============================
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        InsightCareRoute(),
        InsightGutRoute(),
        InsightPainRoute(),
        InsightSymptomsRoute(),
        InsightVetsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          backgroundColor: AppColors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                AppTopChipTabBar(
                  tabs: [
                    ChipTabItem(title: 'Care', icon: AppIcons.svg.tabs.gut),
                    ChipTabItem(title: 'Gut', icon: AppIcons.svg.tabs.gut),
                    ChipTabItem(title: 'Pain', icon: AppIcons.svg.tabs.pain),
                    ChipTabItem(
                      title: 'Symptoms',
                      icon: AppIcons.svg.tabs.symptom,
                    ),
                    ChipTabItem(title: 'Vets', icon: AppIcons.svg.tabs.vet),
                  ],
                  selectedIndex: tabsRouter.activeIndex,
                  onTabChanged: tabsRouter.setActiveIndex,
                ),
                Expanded(child: child),
              ],
            ),
          ),
        );
      },
    );
  }
}

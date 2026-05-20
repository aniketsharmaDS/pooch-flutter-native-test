import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/tab_notifier.dart';
import 'package:poochcare/core/widgets/tabs/app_top_chip_tab_bar.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class MyPostTabScreen extends StatefulWidget {
  final int initialIndex;
  const MyPostTabScreen({super.key, this.initialIndex = 0});

  @override
  State<MyPostTabScreen> createState() => _MyPostTabScreenState();
}

class _MyPostTabScreenState extends State<MyPostTabScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(
      'Initial Tab Index: ${widget.initialIndex}',
    ); // Debug log to check the initial index
    return AutoTabsRouter(
      routes: const [
        MyPostedAllRoute(),
        MyPostedTipsGuideRoute(),
        MyPostedEventsRoute(),
        MyPostedMissingPetsRoute(),
        MyPostedFoundPetsRoute(),
      ],
      // homeIndex: 3, // 👈 THIS IS KEY
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return TabNotifier(
          activeIndex: tabsRouter.activeIndex,
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            body: SafeArea(
              child: Column(
                children: [
                  AppTopChipTabBar(
                    tabs: [
                      ChipTabItem(
                        title: 'All My Posts',
                        icon: AppIcons.svg.tabs.gut,
                      ),
                      ChipTabItem(
                        title: 'My tips & guide',
                        icon: AppIcons.svg.tabs.gut,
                      ),
                      ChipTabItem(
                        title: 'My Events',
                        icon: AppIcons.svg.tabs.pain,
                      ),
                      ChipTabItem(
                        title: 'My missing pet reports',
                        icon: AppIcons.svg.tabs.symptom,
                      ),
                      ChipTabItem(
                        title: 'My found pets',
                        icon: AppIcons.svg.tabs.vet,
                      ),
                    ],
                    selectedIndex: tabsRouter.activeIndex,
                    onTabChanged: tabsRouter.setActiveIndex,
                    initialIndex: widget.initialIndex,
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

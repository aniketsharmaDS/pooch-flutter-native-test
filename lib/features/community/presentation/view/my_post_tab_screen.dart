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
                        icon: AppIcons.svg.community.petPost,
                      ),
                      ChipTabItem(
                        title: 'My Tips & Guide',
                        icon: AppIcons.svg.community.petTipsGuide,
                      ),
                      ChipTabItem(
                        title: 'My Events',
                        icon: AppIcons.svg.community.petEvents,
                      ),
                      ChipTabItem(
                        title: 'My Missing Pet Reports',
                        icon: AppIcons.svg.community.petSearch,
                      ),
                      ChipTabItem(
                        title: 'My Found Pets',
                        icon: AppIcons.svg.community.petHouse,
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

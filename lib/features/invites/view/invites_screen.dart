import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/Tabs/app_top_tab_bar.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class InvitesScreen extends StatefulWidget {
  const InvitesScreen({super.key});

  @override
  State<InvitesScreen> createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InvitesScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [MyInvitesRoute(), NetworkInvitesRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: AppPrimaryBgContainer(
            child: SafeArea(
              child: Column(
                children: [
                  const PoochScreenAppBar(title: 'Invites'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s5,
                      ),
                      child: AppTopTabBar(
                        leftTitle: 'My Invites',
                        rightTitle: 'Network Invites',
                        leftScreen: const SizedBox.shrink(),
                        rightScreen: const SizedBox.shrink(),
                        selectedIndex: tabsRouter.activeIndex,
                        onTabChanged: tabsRouter.setActiveIndex,
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

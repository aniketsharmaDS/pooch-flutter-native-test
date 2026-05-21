import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/Tabs/app_default_tab_bar.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class ServeTabScreen extends StatelessWidget {
  const ServeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.s18),
          child: AppDefaultRouteTabs(
            tabNames: const ['Buy Pet', 'Schedule', 'Tracker', 'Fun'],
            routes: const [
              BuyPetLandingRoute(),
              ScheduleRoute(),
              ExpenseTrackerRoute(),
              FunRoute(),
            ],
          ),
        ),
      ),
    );
  }
}

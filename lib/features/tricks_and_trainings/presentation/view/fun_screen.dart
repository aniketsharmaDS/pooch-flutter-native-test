import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/action_buttons/action_card_grid.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class FunScreen extends StatelessWidget {
  const FunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionCardGrid(
          items: [
            ActionCardItem(
              title: 'Accessories',
              iconPath: AppIcons.svg.actions.consultation,
              onTap: () {
                context.router.push(AccessoriesRoute());
              },
            ),
            ActionCardItem(
              title: 'Tricks & Trainings',
              iconPath: AppIcons.svg.actions.tipsGuide,
              onTap: () {
                context.router.push(const TricksAndTrainingsLandingRoute());
              },
            ),
            ActionCardItem(
              title: 'Virtual Pet Game',
              iconPath: AppIcons.svg.actions.vaccination,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

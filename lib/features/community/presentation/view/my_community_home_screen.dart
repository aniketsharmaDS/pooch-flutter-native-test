import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/tabs/app_default_tab_bar.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class MyCommunityHomeScreen extends StatelessWidget
    implements AutoRouteWrapper {
  final int initialTabIndex;

  const MyCommunityHomeScreen({super.key, this.initialTabIndex = 0});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<TipsGuideBloc>()),
        BlocProvider.value(value: getIt<EventsBloc>()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    log(
      'Initial Tab Index: MC $initialTabIndex',
    ); // Debug log to check the initial index
    return AppPrimaryScreenContainer(
      title: 'community.title'.tr(),
      // actions: [],
      child: AppDefaultRouteTabs(
        // isScrollable: true,
        tabNames: const ['My Posts', 'Posts Under Review', 'Live Posts'],
        routes: [
          MyPostTabRoute(initialIndex: initialTabIndex),
          const MyPostReviewTabRoute(),
          const MyPostLiveTabRoute(),
        ],
      ),
    );
  }
}

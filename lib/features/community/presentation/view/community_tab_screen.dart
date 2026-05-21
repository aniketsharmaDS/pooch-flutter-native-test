import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/action_buttons/action_card_grid.dart';
import 'package:poochcare/core/widgets/list_grid/community_latest_tips_guide_hlist.dart';
import 'package:poochcare/core/widgets/list_grid/community_pet_found_hlist.dart';
import 'package:poochcare/core/widgets/list_grid/community_pet_missing_hlist.dart';
import 'package:poochcare/core/widgets/list_grid/community_upcoming_events_hlist.dart';
import 'package:poochcare/features/community/data/models/event_info_item_model.dart';
import 'package:poochcare/features/community/data/models/found_pet_model.dart';
import 'package:poochcare/features/community/data/models/missing_pet_model.dart';
import 'package:poochcare/features/community/data/models/tips_info_item_model.dart';
import 'package:poochcare/features/community/presentation/bloc/events/events_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/found_pet/found_pet_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/missing_pet/all_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/features/community/presentation/view/report_missing_pet_form_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/app_nudge_card.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class CommunityTabScreen extends StatefulWidget implements AutoRouteWrapper {
  const CommunityTabScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TipsGuideBloc>.value(value: getIt<TipsGuideBloc>()),
        BlocProvider<EventsBloc>.value(value: getIt<EventsBloc>()),
        BlocProvider<AllMissingPetsBloc>.value(
          value: getIt<AllMissingPetsBloc>(),
        ),
        BlocProvider<FoundPetBloc>.value(value: getIt<FoundPetBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<CommunityTabScreen> createState() => _CommunityTabScreenState();
}

class _CommunityTabScreenState extends State<CommunityTabScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TipsGuideBloc>().fetchInitialTips(
      type: TipsGuideType.allLatestTipsGuides,
    );
    context.read<EventsBloc>().fetchInitialEvents(
      upcoming: true,
      type: EventsType.allUpcoming,
    );
    context.read<AllMissingPetsBloc>().fetchInitialMissingPets();
    context.read<FoundPetBloc>().fetchInitialFoundPets(
      scopeType: FoundPetScopeType.allLatelyFoundPets,
    );
  }

  Future<void> _onRefresh() async {
    context.read<TipsGuideBloc>().fetchInitialTips(
      type: TipsGuideType.allLatestTipsGuides,
    );
    context.read<EventsBloc>().fetchInitialEvents(
      upcoming: true,
      type: EventsType.allUpcoming,
    );
    context.read<AllMissingPetsBloc>().fetchInitialMissingPets();
    context.read<FoundPetBloc>().fetchInitialFoundPets(
      scopeType: FoundPetScopeType.allLatelyFoundPets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActionCardGrid(
                items: [
                  ActionCardItem(
                    title: 'community.communityTabScreen.title'.tr(),
                    iconPath: AppIcons.svg.actions.community,
                    onTap: () {
                      context.router.navigate(
                        MyCommunityHomeRoute(
                          children: [
                            MyPostTabRoute(
                              // ignore: avoid_redundant_argument_values
                              initialIndex: 0,
                              children: const [MyPostedAllRoute()],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ActionCardItem(
                    title: 'community.communityTabScreen.tipsAndGuides'.tr(),
                    iconPath: AppIcons.svg.actions.tipsGuide,
                    onTap: () {
                      context.router.push(
                        MyCommunityHomeRoute(
                          children: [
                            MyPostTabRoute(
                              initialIndex: 1,
                              children: const [MyPostedTipsGuideRoute()],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ActionCardItem(
                    title: 'community.communityTabScreen.events'.tr(),
                    iconPath: AppIcons.svg.actions.events,
                    onTap: () {
                      context.router.push(
                        MyCommunityHomeRoute(
                          children: [
                            MyPostTabRoute(
                              initialIndex: 2,
                              children: const [MyPostedEventsRoute()],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ActionCardItem(
                    title: 'community.communityTabScreen.reportMissingPet'.tr(),
                    iconPath: AppIcons.svg.actions.reportMissing,
                    onTap: () {
                      context.router.navigate(
                        MyCommunityHomeRoute(
                          children: [
                            MyPostTabRoute(
                              // ignore: avoid_redundant_argument_values
                              initialIndex: 3,
                              children: const [MyPostedMissingPetsRoute()],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ActionCardItem(
                    title: 'community.communityTabScreen.reportFoundPet'.tr(),
                    iconPath: AppIcons.svg.actions.reportFound,
                    onTap: () {
                      context.router.push(
                        MyCommunityHomeRoute(
                          children: [
                            MyPostTabRoute(
                              initialIndex: 4,
                              children: const [MyPostedFoundPetsRoute()],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ActionCardItem(
                    title: 'community.communityTabScreen.chats'.tr(),
                    iconPath: AppIcons.svg.actions.chat,
                    onTap: () {
                      context.router.push(const PoochParentChatListRoute());
                    },
                  ),
                ],
              ),

              AppSpacing.s10.hBox,
              BlocBuilder<TipsGuideBloc, PaginationState<TipsInfoItemModel>>(
                builder: (context, state) {
                  return CommunityLatestTipsGuideHlist(
                    listItems:
                        (state.scopedItems[TipsGuideType
                                    .allLatestTipsGuides
                                    .name] ??
                                [])
                            .take(6)
                            .toList(),
                    // listItems: state.items
                    //     .take(6)
                    //     .toList(), // 👈 control data here
                    isLoading: state.isLoading,
                    onViewAllTap: () async {
                      context.pushRoute<bool>(
                        const AllCommunityTipsGuideListRoute(),
                      );
                      // final bloc = context.read<TipsGuideBloc>();

                      // final shouldRefresh = await context.pushRoute<bool>(
                      //   const AllCommunityTipsGuideListRoute(),
                      // );

                      // if (shouldRefresh == true) {
                      //   bloc.fetchInitialTips();
                      // }
                    },
                  );
                },
              ),
              AppSpacing.s16.hBox,
              BlocBuilder<EventsBloc, PaginationState<EventInfoItemModel>>(
                builder: (context, state) {
                  log(
                    'Current Scope: ${state.currentScope}, state.isLoading: ${state.isLoading}',
                  );
                  return CommunityUpcomingEventsHlist(
                    listItems:
                        (state.scopedItems[EventsType.allUpcoming.name] ?? [])
                            .take(6)
                            .toList(), // 👈 control data here
                    isLoading: state.isLoading,
                    onViewAllTap: () async {
                      context.pushRoute<bool>(
                        const AllCommunityEventsListRoute(),
                      );
                    },
                  );
                },
              ),
              // const CommunityUpcomingEventsHlist(),
              AppSpacing.s16.hBox,

              Padding(
                padding: EdgeInsets.all(AppSpacing.s16.w),
                child: AppNudgeCard(
                  cardTitle: 'community.communityTabScreen.reportALostPet'.tr(),
                  cardDescription:
                      'community.communityTabScreen.reportDescription'.tr(),
                  cardButtonTitle: 'community.communityTabScreen.reportNow'
                      .tr(),
                  cardBackgroundImage: AppIcons.png.nudges.reportPetPoochCardBg,
                  cardTextInverse: true,
                  cardAction: () {
                    context.pushRoute(
                      ReportMissingPetFormRoute(
                        type: ReportMissingPetFormType.create,
                      ),
                    );
                  },
                ),
              ),
              AppSpacing.s16.hBox,
              BlocBuilder<AllMissingPetsBloc, PaginationState<MissingPetModel>>(
                builder: (context, state) {
                  final secureStorage = getIt<SecureStorageService>();
                  return CommunityPetMissingHlist(
                    isLoading: state.isLoading,
                    missingPets: state.items,
                    onTap: (reportId, isAuthor) {
                      secureStorage.writeChatJourney(
                        ChatReturnType.allMissingPetsTab.name,
                      );
                      context.pushRoute<bool>(
                        MissingPetDetailsRoute(
                          // ignore: avoid_redundant_argument_values
                          listType: 'default',
                          reportId: reportId,
                          isOwnPost: isAuthor,
                        ),
                      );
                    },
                    onViewAllTap: (title) {
                      secureStorage.writeChatJourney(
                        ChatReturnType.allMissingPetList.name,
                      );
                      // context.pushRoute<bool>(AllMissingPoochListRoute());
                      context.router.navigate(AllMissingPoochListRoute());
                    },
                  );
                },
              ),
              AppSpacing.s16.hBox,
              BlocBuilder<FoundPetBloc, PaginationState<FoundPetModel>>(
                builder: (context, state) {
                  return CommunityPetFoundHlist(
                    isLoading: state.isLoading,
                    listItems:
                        (state.scopedItems[FoundPetScopeType
                                    .allLatelyFoundPets
                                    .name] ??
                                [])
                            .take(6)
                            .toList(),
                    onTap: (reportId) {
                      context.pushRoute<bool>(
                        FoundPetDetailsRoute(reportId: reportId),
                      );
                    },
                    onViewAllTap: (title) {
                      context.pushRoute<bool>(const AllFoundPoochListRoute());
                    },
                  );
                },
              ),
              AppSpacing.s16.hBox,
              AppSpacing.s80.hBox,
            ],
          ),
        ),
      ),
    );
  }
}

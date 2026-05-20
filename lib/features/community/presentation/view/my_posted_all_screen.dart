import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/pagination/pagination_state.dart';
import 'package:poochcare/core/services/secure_storage_service.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
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
import 'package:poochcare/features/community/presentation/bloc/missing_pet/my_missing_pets_bloc.dart';
import 'package:poochcare/features/community/presentation/bloc/tips/tips_guide_bloc.dart';
import 'package:poochcare/features/community/presentation/view/report_missing_pet_form_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/app_nudge_card.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class MyPostedAllScreen extends StatefulWidget implements AutoRouteWrapper {
  const MyPostedAllScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TipsGuideBloc>.value(value: getIt<TipsGuideBloc>()),
        BlocProvider<EventsBloc>.value(value: getIt<EventsBloc>()),
        BlocProvider<MyMissingPetsBloc>.value(
          value: getIt<MyMissingPetsBloc>(),
        ),
        BlocProvider<FoundPetBloc>.value(value: getIt<FoundPetBloc>()),
      ],
      child: this,
    );
  }

  @override
  State<MyPostedAllScreen> createState() => _MyPostedAllScreenState();
}

class _MyPostedAllScreenState extends State<MyPostedAllScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TipsGuideBloc>().fetchInitialTips(
      type: TipsGuideType.allMyUpcomingTipsGuides,
    );
    context.read<EventsBloc>().fetchInitialEvents(
      type: EventsType.allMyUpcomingEvents,
    );
    context.read<MyMissingPetsBloc>().fetchInitialMissingPets();
    context.read<FoundPetBloc>().fetchInitialFoundPets(
      scopeType: FoundPetScopeType.allMyLatelyFoundPets,
    );
  }

  Future<void> _onRefresh() async {
    context.read<TipsGuideBloc>().fetchInitialTips(
      type: TipsGuideType.allMyUpcomingTipsGuides,
    );
    context.read<EventsBloc>().fetchInitialEvents(
      type: EventsType.allMyUpcomingEvents,
    );
    context.read<MyMissingPetsBloc>().fetchInitialMissingPets();
    context.read<FoundPetBloc>().fetchInitialFoundPets(
      scopeType: FoundPetScopeType.allMyLatelyFoundPets,
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
              AppSpacing.s10.hBox,
              BlocBuilder<TipsGuideBloc, PaginationState<TipsInfoItemModel>>(
                builder: (context, state) {
                  return CommunityLatestTipsGuideHlist(
                    title: 'My Tips and Guide',
                    listItems: state.items
                        .take(6)
                        .toList(), // 👈 control data here
                    isLoading: state.isLoading,
                    onViewAllTap: () async {
                      AutoTabsRouter.of(context).setActiveIndex(1);
                    },
                  );
                },
              ),
              AppSpacing.s16.hBox,
              BlocBuilder<EventsBloc, PaginationState<EventInfoItemModel>>(
                builder: (context, state) {
                  return CommunityUpcomingEventsHlist(
                    title: 'My Events',
                    listItems:
                        (state.scopedItems[EventsType
                                    .allMyUpcomingEvents
                                    .name] ??
                                [])
                            .take(6)
                            .toList(), // 👈 control data here
                    isLoading: state.isLoading,
                    onViewAllTap: () async {
                      AutoTabsRouter.of(context).setActiveIndex(2);
                    },
                  );
                },
              ),
              // const CommunityUpcomingEventsHlist(),
              AppSpacing.s16.hBox,

              Padding(
                padding: EdgeInsets.all(AppSpacing.s16.w),
                child: AppNudgeCard(
                  cardTitle: 'Report a Lost Pet',
                  cardDescription:
                      'Help the community, spot your pooch and bring',
                  cardButtonTitle: 'Report Now',
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
              BlocBuilder<MyMissingPetsBloc, PaginationState<MissingPetModel>>(
                builder: (context, state) {
                  final secureStorage = getIt<SecureStorageService>();
                  return CommunityPetMissingHlist(
                    isLoading: state.isLoading,
                    missingPets: state.items,
                    onTap: (reportId, isAuthor) {
                      secureStorage.writeChatJourney(
                        ChatReturnType.allMissingPetUserTab.name,
                      );
                      context.pushRoute<bool>(
                        MissingPetDetailsRoute(
                          // ignore: avoid_redundant_argument_values
                          listType: 'default',
                          reportId: reportId,
                          isOwnPost: true,
                        ),
                      );
                    },
                    onViewAllTap: (title) {
                      secureStorage.writeChatJourney(
                        ChatReturnType.allMissingPetUserList.name,
                      );
                      AutoTabsRouter.of(context).setActiveIndex(3);
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
                                    .allMyLatelyFoundPets
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
                      AutoTabsRouter.of(context).setActiveIndex(4);
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

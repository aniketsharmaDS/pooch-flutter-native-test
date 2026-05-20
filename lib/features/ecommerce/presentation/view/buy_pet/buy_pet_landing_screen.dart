import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_state.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/featured_cats_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/featured_dogs_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/find_pooches_dialog.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/most_popular_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/recently_viewed_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/buy_or_adopt_pooch_nudge.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/help_me_find_pooch_nudge.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/join_pooch_community_nudge.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class BuyPetLandingScreen extends StatefulWidget {
  const BuyPetLandingScreen({super.key});

  @override
  State<BuyPetLandingScreen> createState() => _BuyPetLandingScreenState();
}

class _BuyPetLandingScreenState extends State<BuyPetLandingScreen> {
  bool _dialogShown = false;
  // late AutoRouteObserver _observer;

  Future<void> _showFindPoochesDialog() async {
    if (!mounted) return;

    await FindPoochesDialog.show(context: context);
    // Dialog dismisses automatically regardless of which button was clicked
    // Landing screen remains visible in the background
  }

  // @override
  // void didPopNext() {
  //   // called when coming BACK to this screen
  //   context.read<BuyPetLandingBloc>().add(const FetchRecentlyViewedOnly());
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _observer = AutoRouter.of(context).observer;
  //   _observer.subscribe(this, ModalRoute.of(context)!);
  // }

  // @override
  // void dispose() {
  //   _observer.unsubscribe(this);
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();

    // load full landing data
    context.read<BuyPetLandingBloc>().add(const FetchLandingData());
  }

  @override
  Widget build(BuildContext context) {
    // Show dialog only when this route is active and hasn't been shown yet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_dialogShown && (ModalRoute.of(context)?.isCurrent ?? false)) {
        _dialogShown = true;
        _showFindPoochesDialog();
      }
    });

    return BlocBuilder<BuyPetLandingBloc, BuyPetLandingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<BuyPetLandingBloc>().add(const FetchLandingData());
                await Future<void>.delayed(const Duration(milliseconds: 500));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.s20.h),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppSpacing.s10.hBox,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16.w,
                          ),
                          child: BuyOrAdoptPoochNudge(
                            onBuyOrAdopt: () {
                              // context.router.push(BuyPetListingRoute(
                              //     landingBloc: context
                              //         .read<BuyPetLandingBloc>(),
                              //   ));
                              context.router.push(const BuyPetListingRoute());
                            },
                          ),
                        ),
                        AppSpacing.s40.hBox,
                        RecentlyViewedSection(
                          products: state.recentlyViewed,
                          isLoading: state.isLoading,
                          error: state.recentlyViewedError,
                          onRetry: () => context.read<BuyPetLandingBloc>().add(
                            const FetchLandingData(),
                          ),
                        ),
                        AppSpacing.s40.hBox,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16.w,
                          ),
                          child: HelpMeFindPoochNudge(
                            onGetHelp: () {
                              context.router.push(const GetHelpRoute());
                            },
                          ),
                        ),
                        if (state.isLoading ||
                            state.popularError != null ||
                            state.popular.isNotEmpty) ...[
                          AppSpacing.s40.hBox,
                          MostPopularSection(
                            products: state.popular,
                            isLoading: state.isLoading,
                            error: state.popularError,
                            onRetry: () => context
                                .read<BuyPetLandingBloc>()
                                .add(const FetchLandingData()),
                          ),
                        ],
                        AppSpacing.s32.hBox,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16.w,
                          ),
                          child: JoinPoochCommunityNudge(onJoinNow: () {}),
                        ),
                        if (state.isLoading ||
                            state.featuredDogsError != null ||
                            state.featuredDogs.isNotEmpty) ...[
                          AppSpacing.s40.hBox,
                          FeaturedDogsSection(
                            products: state.featuredDogs,
                            isLoading: state.isLoading,
                            error: state.featuredDogsError,
                            onRetry: () => context
                                .read<BuyPetLandingBloc>()
                                .add(const FetchLandingData()),
                          ),
                        ],
                        if (state.isLoading ||
                            state.featuredCatsError != null ||
                            state.featuredCats.isNotEmpty) ...[
                          AppSpacing.s40.hBox,
                          FeaturedCatsSection(
                            products: state.featuredCats,
                            isLoading: state.isLoading,
                            error: state.featuredCatsError,
                            onRetry: () => context
                                .read<BuyPetLandingBloc>()
                                .add(const FetchLandingData()),
                          ),
                        ],
                        AppSpacing.s80.hBox,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

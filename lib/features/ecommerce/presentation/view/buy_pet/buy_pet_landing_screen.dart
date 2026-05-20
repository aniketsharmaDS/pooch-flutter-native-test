import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/location_permission_service.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_bloc.dart';
import 'package:poochcare/features/ecommerce/presentation/bloc/buy_pet_landing/buy_pet_landing_state.dart';
import 'package:poochcare/features/ecommerce/presentation/view/buy_pet/common_pet_listing_screen.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/common_pet_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/buy_pet/most_popular_section.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/app_nudge_card.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class BuyPetLandingScreen extends StatefulWidget {
  const BuyPetLandingScreen({super.key});

  @override
  State<BuyPetLandingScreen> createState() => _BuyPetLandingScreenState();
}

class _BuyPetLandingScreenState extends State<BuyPetLandingScreen> {
  bool _dialogShown = false;
  final service = getIt<LocationPermissionService>();
  // late AutoRouteObserver _observer;

  Future<void> _showFindPoochesDialog() async {
    await service.requestLocationPermissionFlow(context);
  }

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
                          child: AppNudgeCard(
                            cardTitle: 'Buy or adopt a pooch you love',
                            cardDescription:
                                'Find the perfect pup and give them a loving home',
                            cardButtonTitle: 'See Pets',
                            cardBackgroundImage:
                                AppIcons.png.nudges.buyAdoptPoochCardBg,
                            cardAction: () {
                              context.router.push(const BuyPetListingRoute());
                            },
                          ),
                        ),
                        // AppSpacing.s40.hBox,
                        if (state.isLoading ||
                            state.recentlyViewedError != null ||
                            state.recentlyViewed.isNotEmpty) ...[
                          CommonPetSection(
                            showTopSpacing: true,
                            title: 'Recently Viewed',

                            listingType: ListingType.recentlyViewed,

                            products: state.recentlyViewed,

                            isLoading: state.isLoading,

                            error: state.recentlyViewedError,

                            onRetry: () => context
                                .read<BuyPetLandingBloc>()
                                .add(const FetchLandingData()),
                          ),
                        ],
                        AppSpacing.s40.hBox,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.s16.w,
                          ),
                          child: AppNudgeCard(
                            cardTitle: 'Help me find or discover a Pooch',
                            cardDescription:
                                'A pooch is family - let us help you find the right one.',
                            cardButtonTitle: 'Get Help',
                            cardBackgroundImage:
                                AppIcons.png.nudges.helpDiscoverPoochCardBg,
                            cardAction: () {
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
                          child: AppNudgeCard(
                            cardTitle: 'Join the Pooch Community',
                            cardDescription:
                                'Find advice, share stories, and grow together',
                            cardButtonTitle: 'Join Now',
                            cardBackgroundImage:
                                AppIcons.png.nudges.joinPoochCommunityCardBg,
                            cardAction: () {},
                          ),
                        ),
                        if (state.isLoading ||
                            state.featuredDogsError != null ||
                            state.featuredDogs.isNotEmpty) ...[
                          AppSpacing.s40.hBox,
                          CommonPetSection(
                            title: 'Featured Dogs',

                            listingType: ListingType.featuredDogs,

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
                          CommonPetSection(
                            title: 'Featured Cats',

                            listingType: ListingType.featuredCats,

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

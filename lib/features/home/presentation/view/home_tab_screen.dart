import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/home/presentation/widgets/assist_home_header_widget.dart';
import 'package:poochcare/features/home/presentation/widgets/explore_feature_widget.dart';
import 'package:poochcare/features/home/presentation/widgets/updates_and_reminder.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_bloc.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_event.dart';
import 'package:poochcare/features/pets/presentation/bloc/pets_state.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';
import 'package:poochcare/features/user_profile/presentation/widgets/home_pets_wave_card.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class HomeTabScreen extends StatefulWidget implements AutoRouteWrapper {
  const HomeTabScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    final userProfileBloc = getIt<UserProfileBloc>()
      ..add(const GetUserPetsEvent());
    return BlocProvider<PetsBloc>(
      create: (_) => getIt<PetsBloc>(),
      child: BlocProvider<UserProfileBloc>.value(
        value: userProfileBloc,
        child: this,
      ),
    );
  }

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  String? _selectedPetId;

  final List<ExploreFeaturesModel> _exploreFeaturesList = [
    ExploreFeaturesModel(
      backgroundColor: const Color.fromARGB(255, 242, 209, 58),
      title: 'Get a pooch',
      buttonText: 'Explore now',
      imageUrl: AppIcons.png.explore.dogCat,
    ),
    ExploreFeaturesModel(
      backgroundColor: const Color(0xFF3B82F6),
      title: 'Find a vet',
      buttonText: 'Explore now',
      imageUrl: AppIcons.png.explore.nurse,
    ),
    ExploreFeaturesModel(
      backgroundColor: const Color.fromARGB(255, 241, 140, 73),
      title: 'Help & support',
      buttonText: 'Explore now',
      imageUrl: AppIcons.png.explore.helpHand,
    ),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void syncSelectedPetAndInsights(List<UserPet> pets) {
      if (pets.isEmpty) {
        if (_selectedPetId != null) {
          setState(() {
            _selectedPetId = null;
          });
        }
        return;
      }

      final String? currentSelectedPetId = _selectedPetId?.trim();
      final String nextSelectedPetId =
          (currentSelectedPetId != null &&
              pets.any((pet) => pet.id.trim() == currentSelectedPetId))
          ? currentSelectedPetId
          : pets.first.id.trim();

      if (_selectedPetId != nextSelectedPetId) {
        setState(() {
          _selectedPetId = nextSelectedPetId;
        });
      }

      context.read<PetsBloc>().add(
        GetPetInsightsEvent(petId: nextSelectedPetId),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.5,
            colors: [
              const Color(0xFFFFAA00).withValues(alpha: 0.15),
              const Color(0xFFFFAA00).withValues(alpha: 0.05),
              Colors.transparent,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: BlocListener<UserProfileBloc, UserProfileState>(
            listenWhen: (prev, curr) => prev.pets != curr.pets,
            listener: (context, state) {
              syncSelectedPetAndInsights(state.pets);
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.s10.h),
                  const AssistHeaderWidget(),
                  SizedBox(height: AppSpacing.s25.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 9.w),
                    child: BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        final activePetId =
                            _selectedPetId?.trim() ??
                            (state.pets.isNotEmpty
                                ? state.pets.first.id.trim()
                                : null);

                        return BlocBuilder<PetsBloc, PetsState>(
                          builder: (context, petState) {
                            final insightsPetId = petState.petInsightsPetId
                                ?.trim();
                            final insights =
                                activePetId != null &&
                                    insightsPetId == activePetId
                                ? petState.petInsights
                                : null;

                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // 👇 Your image (behind)
                                Positioned(
                                  top: -AppSpacing
                                      .s80
                                      .h, // adjust this to control how much shows
                                  right: 0,
                                  left: 0,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: AppSpacing.s6.w,
                                    ),
                                    child: SizedBox(
                                      height: AppSize.cs130.csh,
                                      width: AppSize.cs130.csw,
                                      child: AppIcon(
                                        AppIcons.png.generic.poochPet,
                                        // height: AppSize.cs200.csh ,
                                        // width: AppSize.cs200.csw,
                                      ),
                                    ),
                                  ),
                                ),
                                // 👇 Card on top
                                HomePetsWaveCard(
                                  pets: state.pets,
                                  selectedPetId: activePetId,
                                  healthScore:
                                      insights?.healthScore.percentage
                                          .toDouble() ??
                                      0,
                                  nutritionScore:
                                      insights?.nutritionScore.percentage
                                          .toDouble() ??
                                      0,
                                  weeklyActivityGoalsMet:
                                      insights?.weeklyActivityScore.goalsMet ??
                                      '',
                                  onPetSelected: (pet) {
                                    setState(() {
                                      _selectedPetId = pet.id.trim();
                                    });
                                    context.read<PetsBloc>().add(
                                      GetPetInsightsEvent(petId: pet.id.trim()),
                                    );
                                  },
                                  onAddTap: () {
                                    context.pushRoute(
                                      const AddPetProfileRoute(),
                                    );
                                  },
                                ),
                                Positioned(
                                  top: -AppSpacing.s10.h,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AppIcon(
                                        AppIcons.png.generic.poochPetFeet,
                                        size: 30.w,
                                        // color: const Color(0xFF1B1B1B),
                                      ),
                                      AppSpacing.s4.wBox,
                                      AppIcon(
                                        AppIcons.png.generic.poochPetFeet,
                                        size: 30.w,
                                        // color: const Color(0xFF1B1B1B),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s38),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.s9),
                    child: UpdatesAndReminder(title: 'Updates and Reminders'),
                  ),
                  const SizedBox(height: AppSpacing.s44),
                  AppText.displayL(
                    'Features you can explore',
                    style: TextStyle(
                      fontSize: AppFontSize.fs16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s14),
                  SizedBox(
                    height: 350.h,
                    width: MediaQuery.sizeOf(context).width,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(left: AppSize.cs16),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _exploreFeaturesList.length,
                      itemBuilder: (context, index) {
                        final feature = _exploreFeaturesList[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.s15),
                          child: SizedBox(
                            width: 260.w,
                            child: ExploreFeatureWidget(
                              imageHeightFromTop: index == 0
                                  ? 0
                                  : index == 1
                                  ? AppSpacing.s80
                                  : AppSpacing.s60,
                              backgroundColor: feature.backgroundColor,
                              title: feature.title,
                              buttonText: feature.buttonText,
                              imagePath: feature.imageUrl,
                              onTap: () {
                                if (index == 0) {
                                  context.router.push(
                                    const BuyPetListingRoute(),
                                  );
                                  // context.router.push(const GetHelpRoute());
                                } else if (index == 1) {
                                  // context.router.push(const VetSearchRoute());
                                  context.router.push(
                                    const FindVetClinicsRoute(),
                                  );
                                } else if (index == 2) {
                                  // context.router.push(const HelpAndSupportRoute());
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: AppSpacing.s100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExploreFeaturesModel {
  final String title;
  final String buttonText;
  final String imageUrl;
  final Color backgroundColor;

  ExploreFeaturesModel({
    required this.title,
    required this.buttonText,
    required this.imageUrl,
    required this.backgroundColor,
  });
}

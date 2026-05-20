import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/forms/medical_form/pet_selection_form_field.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_bloc.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_event.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/bloc/tricks_and_trainings_state.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/tips_section.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/training_guide_section.dart';
import 'package:poochcare/features/tricks_and_trainings/presentation/widgets/sections/videos_section.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class TricksAndTrainingsLandingScreen extends StatefulWidget {
  const TricksAndTrainingsLandingScreen({super.key});

  @override
  State<TricksAndTrainingsLandingScreen> createState() =>
      _TricksAndTrainingsLandingScreenState();
}

class _TricksAndTrainingsLandingScreenState
    extends State<TricksAndTrainingsLandingScreen> {
  final ValueNotifier<String?> selectedPetNotifier = ValueNotifier(null);
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<TricksAndTrainingsBloc>()..add(LoadTricksAndTrainings()),
      child: Builder(
        builder: (context) {
          return AppPrimaryScreenContainer(
            title: 'Tricks & Trainings',
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: AppSearchField(
                      controller: searchController,
                      onChanged: (value) {
                        // _onSearch(value);
                      },
                      onSubmitted: (value) {
                        final query = value.trim();

                        if (query.isEmpty) return;

                        context.router
                            .push(TricksAndTrainingSearchRoute(query: query))
                            .then((_) {
                              searchController.clear();
                            });
                      },
                    ),
                  ),
                  AppSpacing.s17.hBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.s16,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: PetSelectionFormField(
                        selectedPetNotifier: selectedPetNotifier,
                        variant: PetSelectionVariant.popup,
                        onPetChanged: (petId) {
                          selectedPetNotifier.value = petId;
                          context.read<TricksAndTrainingsBloc>().add(
                            LoadTricksAndTrainings(petId: petId),
                          );
                          // print('Selected pet: $petId');
                        },
                      ),
                    ),
                  ),

                  /// Sections
                  BlocBuilder<TricksAndTrainingsBloc, TricksAndTrainingsState>(
                    builder: (context, state) {
                      final hasContent =
                          state.videos.isNotEmpty ||
                          state.trainings.isNotEmpty ||
                          state.tips.isNotEmpty;

                      return Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            context.read<TricksAndTrainingsBloc>().add(
                              LoadTricksAndTrainings(
                                petId: selectedPetNotifier.value,
                              ),
                            );
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.s24,
                              ),
                              child: !state.isLoading && !hasContent
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.6,

                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,

                                          children: [
                                            AppSpacing.s16.hBox,

                                            AppText.h3('No content found'),

                                            AppSpacing.s6.hBox,

                                            AppText.bodyS(
                                              'Try selecting another pet.',
                                              color: AppColors.p5_300,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        if (state.isLoading ||
                                            state.videos.isNotEmpty) ...[
                                          VideosSection(
                                            videos: state.videos,
                                            isLoading: state.isLoading,
                                            error: state.error,
                                            petId: selectedPetNotifier.value,
                                          ),

                                          AppSpacing.s35.hBox,
                                        ],
                                        if (state.isLoading ||
                                            state.trainings.isNotEmpty) ...[
                                          TrainingGuideSection(
                                            trainings: state.trainings,
                                            isLoading: state.isLoading,
                                            error: state.error,
                                            petId: selectedPetNotifier.value,
                                          ),

                                          AppSpacing.s35.hBox,
                                        ],
                                        if (state.isLoading ||
                                            state.tips.isNotEmpty) ...[
                                          TipsSection(
                                            tips: state.tips,
                                            isLoading: state.isLoading,
                                            error: state.error,
                                            petId: selectedPetNotifier.value,
                                          ),
                                        ],
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/list_grid/app_error_view.dart';
import 'package:poochcare/core/widgets/list_items/clinic_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_state.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class AllSubscribedClinicsScreen extends StatefulWidget {
  const AllSubscribedClinicsScreen({super.key});

  @override
  State<AllSubscribedClinicsScreen> createState() =>
      _AllSubscribedClinicsScreenState();
}

class _AllSubscribedClinicsScreenState
    extends State<AllSubscribedClinicsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    // Fetch first page and force refresh
    context.read<SubscribedClinicsBloc>().add(
      const FetchSubscribedClinics(1, true),
    );
  }

  void _onScroll() {
    if (_isBottom) {
      final bloc = context.read<SubscribedClinicsBloc>();
      final state = bloc.state;
      final currentPage = state.subscribedClinicsData?.pagination.page ?? 1;
      final totalPages = state.subscribedClinicsData?.pagination.pages ?? 1;

      if (currentPage < totalPages) {
        bloc.add(FetchSubscribedClinics(currentPage + 1, false));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9); // 90% scrolled
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s20),
            child: Column(
              children: [
                const PoochScreenAppBar(title: 'Subscribed Clinics'),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<SubscribedClinicsBloc, SusbcribedClinicsState>(
                    builder: (context, state) {
                      // Loading
                      if (state.status == SubscrbedClinicsStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // Error
                      if (state.status == SubscrbedClinicsStatus.failure) {
                        return Center(
                          child: AppErrorView(
                            message: 'Failed to load clinics',
                            onRetry: () {
                              context.read<SubscribedClinicsBloc>().add(
                                const FetchSubscribedClinics(1, true),
                              );
                            },
                          ),
                        );
                      }

                      final clinics =
                          state.subscribedClinicsData?.subscriptions ?? [];

                      // Empty
                      if (clinics.isEmpty) {
                        return Center(
                          child: AppText.h3('No subscribed clinics found'),
                        );
                      }

                      // Data
                      final clinicsData = clinics.map((e) {
                        return ClinicListItemModel(
                          clinicName: e.clinic.clinicName,
                          id: e.id,
                          city: e.clinic.city,
                          image: e.clinic.clinicImage,
                          minConsultationFree:
                              '${e.remainingCallCredits}/${e.totalCallCredits} calls left',
                          clinicId: e.clinic.id,
                          petId: e.petId,
                          planId: e.plan.id,
                          subscriptionId: e.id,
                        );
                      }).toList();

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<SubscribedClinicsBloc>().add(
                            const FetchSubscribedClinics(1, true),
                          );
                        },
                        child: ListView.separated(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: clinicsData.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 16),
                          itemBuilder: (_, index) {
                            final clinic = clinicsData[index];
                            return ClinicListItemCard(
                              clinic: clinic,
                              onBookNow: () {
                                final appointmentCubit =
                                    getIt<AppointmentCubit>();

                                /// Start fresh booking flow
                                appointmentCubit.reset();

                                /// Save clinic
                                appointmentCubit.updateClinic(
                                  clinicId: clinic.clinicId,
                                );

                                /// Save pet
                                appointmentCubit.updatePet(
                                  petId: clinic.petId,
                                  petName: '',
                                  petImage: '',
                                  petNotes: '',
                                );
                                context.router.push(
                                  ClinicSlotSelectionRoute(
                                    clinicId: clinic.clinicId,
                                  ),
                                );
                              },
                              onTap: () {
                                context.router.push(
                                  ClinicDetailsRoute(clinicId: clinic.clinicId),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

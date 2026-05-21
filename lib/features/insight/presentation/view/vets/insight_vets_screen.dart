import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/document_file_type_utils.dart';
import 'package:poochcare/core/widgets/action_buttons/action_card_grid.dart';
import 'package:poochcare/core/widgets/cards/app_medical_explorer_card.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/headers/primary_widget_header.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/list_grid/pet_symptom_list.dart';
import 'package:poochcare/core/widgets/list_items/clinic_grid_item_card.dart';
import 'package:poochcare/core/widgets/list_items/clinic_list_item_card.dart';
import 'package:poochcare/core/widgets/list_items/medical_history_list_item_card.dart';
import 'package:poochcare/core/widgets/others/upcoming_appointments_view.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_bloc.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_event.dart';
import 'package:poochcare/features/ecommerce/presentation/widgets/nudges/app_nudge_card.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/features/insight/presentation/bloc/report_symptoms_bloc/report_symptoms_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/report_symptoms_bloc/report_symptoms_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/subscribed_clinics_bloc/subscribed_clinics_state.dart';
import 'package:poochcare/features/insight/presentation/widgets/state_wrapper.dart';
import 'package:poochcare/features/medical_history/domain/models/medical_history_record.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_state.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class InsightVetsScreen extends StatefulWidget {
  const InsightVetsScreen({super.key});

  @override
  State<InsightVetsScreen> createState() => _InsightVetsScreenState();
}

class _InsightVetsScreenState extends State<InsightVetsScreen> {
  int _selectedRecentReports = 0;
  int _selectedSubscribedClinics = 0;

  @override
  void initState() {
    super.initState();
    _initalLoad();
  }

  void _initalLoad() {
    context.read<SubscribedClinicsBloc>().add(
      const FetchSubscribedClinics(1, true),
    );
    context.read<AppointmentBloc>().add(const FetchAllAppointments(1, true));
    context.read<ClinicBloc>().add(const FetchPopularClinics());
    getIt<ReportSymptomsBloc>().add(const FetchSymptomsEvent());
    _requestMedicalHistory(isForceRefresh: true);
  }

  Future<void> _onRefresh() async {
    _initalLoad();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActionCardGrid(
              items: [
                ActionCardItem(
                  title: 'Consultations',
                  iconPath: AppIcons.svg.actions.consultation,
                  onTap: () {
                    //  To go to medical history with consultation tab active
                    // context.router.push(const PetMedicalHistoryRoute());
                    //  To go to  listing of clinics
                    // context.router.push( ClinicsListingRoute());
                    //  To go to  Add Consultation records
                    context.router.push<bool>(
                      AddPetMedicalRecordsTabRoute(initialTabIndex: 5),
                    );
                  },
                ),
                ActionCardItem(
                  title: 'Records',
                  iconPath: AppIcons.svg.actions.record,
                  onTap: () {
                    //  To go to medical history with consultation tab active
                    // context.router.push(const PetMedicalHistoryRoute());
                    // context.router.push<bool>(const PetMedicalHistoryRoute());
                    //  To go to  Add Medical records
                    context.router.push<bool>(
                      AddPetMedicalRecordsTabRoute(initialTabIndex: 4),
                    );
                  },
                ),
                ActionCardItem(
                  title: 'Vaccinations',
                  iconPath: AppIcons.svg.actions.vaccination,
                  onTap: () {
                    //  To go to medical history with Vaccination tab active
                    // context.router.push(const PetMedicalHistoryRoute());
                    //  To go to  Add Vacination records
                    // ignore: avoid_redundant_argument_values
                    context.router.push<bool>(
                      // ignore: avoid_redundant_argument_values
                      AddPetMedicalRecordsTabRoute(initialTabIndex: 0),
                    );
                  },
                ),
              ],
            ),
            AppSpacing.s20.hBox,
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.s16.w,
                AppSpacing.s10.h,
                AppSpacing.s17.w,
                AppSpacing.s10.h,
              ),
              child: AppNudgeCard(
                cardTitle: 'Your Vet Support, Anytime You Need It',
                cardDescription: 'Quick, trusted care for your pooch.',
                cardButtonTitle: 'Find vet clinics',
                cardBackgroundImage: AppIcons.png.nudges.vetSupportPoochCardBg,
                cardTextInverse: true,
                cardVariantVet: true,
                cardAction: () {
                  context.router.push(FindVetClinicsRoute());
                },
              ),
            ),
            AppSpacing.s20.hBox,

            PrimaryWidgetHeader(
              title: 'Your subscribed clinics',
              buttonTitle: 'View All',
              onButtonTap: () {
                context.router.push(const AllSubscribedClinicsRoute());
              },
            ),
            subscribedClinics(),

            AppSpacing.s40.hBox,

            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.s6.w,
                AppSpacing.s10.h,
                AppSpacing.s6.w,
                AppSpacing.s10.h,
              ),
              child: const UpcomingAppointmentsView(
                type: UpcomingType.calendar,
                // title: 'Calendar',
                btnLabel: 'View All',
                // title: 'Updates and Reminders',
                // btnLabel: 'VIEW ALL REMINDERS'
              ),
            ),

            AppSpacing.s30.hBox,
            PoochSymptomsList(
              onTap: (symptom) {
                context.router.push(
                  FindVetClinicsRoute(initialSymptoms: symptom),
                );
              },
            ),
            AppSpacing.s30.hBox,

            PrimaryWidgetHeader(
              title: 'Recent Reports & History',
              buttonTitle: 'View All',
              onButtonTap: () {
                context.router.push(const PetMedicalHistoryRoute());
              },
            ),
            BlocBuilder<MedicalHistoryBloc, MedicalHistoryState>(
              builder: (context, state) {
                final items = _mapMedicalHistoryItems(state.records);
                final int selectedIndex = items.isEmpty
                    ? 0
                    : _selectedRecentReports.clamp(0, items.length - 1);

                return Column(
                  children: [
                    StateWrapper(
                      isEmpty:
                          state.status == MedicalHistoryStatus.success &&
                          items.isEmpty,
                      isError: state.status == MedicalHistoryStatus.failure,
                      isLoading: state.status == MedicalHistoryStatus.loading,
                      title: 'Recent Report',
                      onRetry: () {
                        _requestMedicalHistory(isForceRefresh: true);
                      },
                      child: SizedBox(
                        height: 110.h,
                        width: MediaQuery.sizeOf(context).width,
                        child: PageView.builder(
                          itemCount: items.length,
                          onPageChanged: (value) {
                            setState(() {
                              _selectedRecentReports = value;
                            });
                          },
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s20,
                            ),
                            child: MedicalHistoryListItemCard(
                              viewType: ViewType.horizontal,
                              item: items[index],
                              onItemClick: () {
                                // To modify the modal
                                // appRouter.push(
                                //   PetMedicalDetailsRoute(
                                //     recordId: items[index].data.recordId ?? '',
                                //     appointmentId: items[index].data.appointmentId ?? '',
                                //     recordType: type == ItemType.consultation
                                //         ? MedicalHistoryRecordTypeFilter.consultation
                                //         : type == ItemType.vaccination
                                //         ? MedicalHistoryRecordTypeFilter.vaccination
                                //         : MedicalHistoryRecordTypeFilter.labReport,
                                //   ),
                                // );
                                // context.router.push(
                                //   MedicalHistoryDetailsRoute(
                                //     recordId: items[index].data.recordId,
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (items.isNotEmpty) ...[
                      AppSpacing.s15.hBox,
                      PageviewDotIndicator(
                        selectedIndex: selectedIndex,
                        totalCount: items.length,
                      ),
                    ],
                    AppSpacing.s40.hBox,

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppMedicalExplorerCard(
                              title: 'Lab Test',
                              buttonText: 'Explore Now',
                              imagePath: AppIcons.png.explore.labTest,
                              onTap: () {
                                context.router.push(
                                  AddPetMedicalRecordsTabRoute(
                                    initialTabIndex: 2,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppMedicalExplorerCard(
                              title: 'Vaccinations',
                              buttonText: 'Explore Now',
                              imagePath: AppIcons.png.explore.vaccination,
                              onTap: () {
                                context.router.push(
                                  AddPetMedicalRecordsTabRoute(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    AppSpacing.s30.hBox,

                    PrimaryWidgetHeader(
                      title: 'Popular Clinics',
                      buttonTitle: 'View All',
                      onButtonTap: () {
                        context.router.push(
                          ClinicsListingRoute(
                            clinicType: ClinicType.popular,
                            appBarTitle: 'Popular Clinics',
                          ),
                        );
                      },
                    ),
                    AppSpacing.s10.hBox,
                    BlocBuilder<ClinicBloc, ClinicState>(
                      builder: (context, clinicState) {
                        final popularClinics =
                            clinicState.popularClinicsData?.clinics ?? const [];

                        return StateWrapper(
                          isEmpty:
                              clinicState.popularClinicStatus ==
                                  PopularClinicStatus.success &&
                              popularClinics.isEmpty,
                          isError:
                              clinicState.popularClinicStatus ==
                              PopularClinicStatus.failure,
                          isLoading:
                              clinicState.popularClinicStatus ==
                              PopularClinicStatus.loading,
                          title: 'Popular Clinic',
                          onRetry: () {
                            context.read<ClinicBloc>().add(
                              const FetchPopularClinics(),
                            );
                          },
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.s16,
                            ),
                            itemCount: popularClinics.length > 2
                                ? 2
                                : popularClinics.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 10,
                                ),
                            itemBuilder: (context, index) {
                              final clinic = popularClinics[index];
                              return ClinicGridItemCard(
                                clinic: clinic,
                                onTap: () {
                                  context.router.push(
                                    ClinicDetailsRoute(clinicId: clinic.id),
                                  );
                                },
                                onSubscribe: () {
                                  selectPetAndsubscribeClinic(
                                    clinicId: clinic.id,
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            AppSpacing.s40.hBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [AppText.h2('Pooch Trusted')],
            ),
            AppSpacing.s15.hBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.s16.w),
              child: Row(
                children: [
                  InsightsFooterItem(
                    title: 'Our Vets',
                    value: '1 Lakh +',
                    imagePath: AppIcons.png.explore.nurse,
                  ),
                  SizedBox(width: AppSpacing.s5.w),
                  InsightsFooterItem(
                    title: 'Hospitals',
                    value: '20,000',
                    imagePath: AppIcons.png.generic.hospital,
                  ),
                  SizedBox(width: AppSpacing.s5.w),
                  InsightsFooterItem(
                    title: 'Our Pooch',
                    value: '100+',
                    imagePath: AppIcons.png.transitions.funPuppy,
                  ),
                ],
              ),
            ),

            AppSpacing.s80.hBox,
          ],
        ),
      ),
    );
  }

  void selectPetAndsubscribeClinic({required String clinicId}) async {
    final List<UserPet> pets = context.read<UserProfileBloc>().state.pets;
    String? petId = '';
    final appointmentCubit = getIt<AppointmentCubit>();
    if (appointmentCubit.state.petId != null) {
      petId = appointmentCubit.state.petId;
    }

    final List<Pet> petsList = pets.map((userPet) {
      return Pet(
        id: userPet.id,
        name: userPet.name,
        imageUrl: userPet.profilePicture ?? '',
        isSelected: petId == userPet.id,
      );
    }).toList();

    final result = await AppSelectPetDialog.show(
      context: context, // ✅ safe, captured before await
      pets: petsList,
      initiallySelectedPet: petsList.any((pet) => pet.isSelected)
          ? petsList.firstWhere((pet) => pet.isSelected)
          : null,
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {});
      if (!context.mounted) return;
      final appointmentCubit = getIt<AppointmentCubit>();

      /// Start fresh booking flow
      appointmentCubit.reset();

      /// Save clinic
      appointmentCubit.updateClinic(clinicId: clinicId);

      /// Save pet
      appointmentCubit.updatePet(
        petId: result.selectedPet.id,
        petName: result.selectedPet.name,
        petImage: result.selectedPet.imageUrl,
        petNotes: result.note,
      );

      context.router.push(ClinicPlanSelectionRoute(clinicId: clinicId));
    }
  }

  void _requestMedicalHistory({required bool isForceRefresh}) {
    context.read<MedicalHistoryBloc>().add(
      const FetchMedicalHistoryRecords(page: 1, limit: 5, isForceRefresh: true),
    );
  }

  List<MedicalHistoryItem> _mapMedicalHistoryItems(
    List<MedicalHistoryRecord> records,
  ) {
    return records.map(_mapMedicalHistoryItem).toList(growable: false);
  }

  MedicalHistoryItem _mapMedicalHistoryItem(MedicalHistoryRecord record) {
    return MedicalHistoryItem(
      title: _labelForRecordType(record.recordType),
      type: _itemTypeForRecordType(record.recordType),
      data: MedicalData(
        recordId: record.recordId,
        appointmentId: record.appointmentId,
        title: record.title,
        subtitle: _readableDate(record.secondaryText),
        dateTime: record.primaryText.trim().isEmpty
            ? record.tertiaryText
            : record.primaryText,
        documents: record.documents
            .map(
              (doc) => MedicalDocument(
                fileName: doc.fileName,
                fileSize: _formatDocumentSize(doc.fileSize),
                fileType: getFileTypeSmart(
                  fileName: doc.fileName,
                  fileUrl: doc.url,
                  fileType: doc.fileType,
                ).name,
                url: doc.url,
              ),
            )
            .toList(growable: false),
      ),
    );
  }

  String _labelForRecordType(String rawType) {
    final type = rawType.toLowerCase();
    if (type.contains('vacc')) {
      return 'Vaccination';
    }
    if (type.contains('lab')) {
      return 'Lab Report';
    }
    if (type.contains('document')) {
      return 'Other Documents';
    }
    if (type.contains('consult') || type.contains('diagnosis')) {
      return 'Consultation';
    }
    return 'Medical Record';
  }

  ItemType _itemTypeForRecordType(String rawType) {
    final type = rawType.toLowerCase();
    if (type.contains('vacc')) {
      return ItemType.vaccination;
    }
    if (type.contains('lab')) {
      return ItemType.labReport;
    }
    if (type.contains('consult') || type.contains('diagnosis')) {
      return ItemType.consultation;
    }
    return ItemType.prescription;
  }

  String _readableDate(String rawDate) {
    final input = rawDate.trim();
    if (input.isEmpty) {
      return '';
    }

    final parsed = DateTime.tryParse(input);
    if (parsed == null) {
      return input;
    }

    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final day = parsed.day.toString().padLeft(2, '0');
    final month = months[parsed.month - 1];
    return '$day $month ${parsed.year}';
  }

  String _formatDocumentSize(String rawSize) {
    final size = int.tryParse(rawSize.trim());
    if (size == null || size <= 0) {
      return rawSize.trim().isEmpty ? ' ' : rawSize;
    }

    const kb = 1024;
    const mb = 1024 * 1024;

    if (size >= mb) {
      final value = size / mb;
      return '${value.toStringAsFixed(value >= 10 ? 1 : 2)} MB';
    }

    if (size >= kb) {
      final value = size / kb;
      return '${value.toStringAsFixed(value >= 10 ? 1 : 2)} KB';
    }

    return '$size B';
  }

  BlocBuilder<SubscribedClinicsBloc, SusbcribedClinicsState>
  subscribedClinics() {
    return BlocBuilder<SubscribedClinicsBloc, SusbcribedClinicsState>(
      builder: (context, state) {
        final data = state.subscribedClinicsData?.subscriptions ?? [];
        final clinicsData = data.map((e) {
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
        return StateWrapper(
          isEmpty:
              state.status == SubscrbedClinicsStatus.success &&
              clinicsData.isEmpty,
          isError: state.status == SubscrbedClinicsStatus.failure,
          isLoading: state.status == SubscrbedClinicsStatus.loading,
          title: 'Subscribed Clinics',
          onRetry: () {
            context.read<AppointmentBloc>().add(
              const FetchAllAppointments(1, true),
            );
          },
          child: Column(
            children: [
              SizedBox(
                height: 90.h,
                width: MediaQuery.sizeOf(context).width,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _selectedSubscribedClinics = value;
                    });
                  },
                  itemCount: clinicsData.length > 5 ? 5 : clinicsData.length,
                  itemBuilder: (context, index) {
                    final clinic = clinicsData[index];
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.92,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.s16,
                        ),
                        child: ClinicListItemCard(
                          clinic: clinic,
                          onBookNow: () {
                            final appointmentCubit = getIt<AppointmentCubit>();

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
                        ),
                      ),
                    );
                  },
                ),
              ),
              AppSpacing.s15.hBox,

              PageviewDotIndicator(
                selectedIndex: _selectedSubscribedClinics,
                totalCount: clinicsData.length > 5 ? 5 : clinicsData.length,
              ),
            ],
          ),
        );
      },
    );
  }
}

class PageviewDotIndicator extends StatelessWidget {
  final int selectedIndex;
  final int totalCount;
  const PageviewDotIndicator({
    super.key,
    required this.selectedIndex,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainAnimation: true,
      maintainSize: true,
      maintainState: true,
      visible: totalCount > 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(totalCount, (index) {
            bool isSelected = index == selectedIndex;
            return AnimatedContainer(
              margin: const EdgeInsets.only(right: 5),
              duration: const Duration(milliseconds: 500),
              height: 8,
              width: isSelected ? 30 : 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index == selectedIndex
                    ? AppColors.black
                    : const Color.fromARGB(255, 191, 189, 183),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class InsightsFooterItem extends StatelessWidget {
  final String title;
  final String value;
  final String imagePath;

  const InsightsFooterItem({
    super.key,
    required this.title,
    required this.value,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppWaveCard(
        variant: AppCardNotchVariant.bottomRight,
        notchWidth: -20,
        child: Container(
          alignment: Alignment.center,
          height: 150.h,
          padding: const EdgeInsets.only(left: AppSpacing.s5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [AppIcon(imagePath, size: 100)],
              ),
              AppText.bodyS(title),
              AppText.h1(value),
            ],
          ),
        ),
      ),
    );
  }
}

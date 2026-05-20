import 'dart:developer' show log;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dialogs/app_select_pet_dialog.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/appointment_section_header.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/date_tabs.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/models/appointment_section.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/models/slots.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/models/week_day_timing.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/no_slots_view.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/slots_grid_view.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_card.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_slot_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/data/models/clinic_operating_hours_model.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/router/app_router.dart';

enum _DayPeriod { morning, afternoon, evening }

class _SectionMeta {
  final _DayPeriod period;
  final String title;
  final String iconPath;

  const _SectionMeta({
    required this.period,
    required this.title,
    required this.iconPath,
  });
}

class _SlotEntry {
  final DateTime start;
  final DateTime end;
  final Slots slot;

  const _SlotEntry({
    required this.start,
    required this.end,
    required this.slot,
  });
}

@RoutePage()
class ClinicSlotSelectionScreen extends StatefulWidget {
  final String clinicId;
  const ClinicSlotSelectionScreen({required this.clinicId, super.key});

  @override
  State<ClinicSlotSelectionScreen> createState() =>
      _ClinicSlotSelectionScreenState();
}

class _ClinicSlotSelectionScreenState extends State<ClinicSlotSelectionScreen> {
  static const int _daysToShow = 30;
  static const int _slotDurationInMinutes = 30;

  late final List<DateTime> _upcomingDates;

  // Replace this with API values. Input must be UTC ISO datetime strings.
  Map<int, WeekDayTiming> _getWeeklyTimings(
    ClinicOperatingHoursModel? operatingHours,
  ) {
    if (operatingHours == null) {
      return {};
    }

    final result = <int, WeekDayTiming>{};

    final weekDays = {
      'monday': DateTime.monday,
      'tuesday': DateTime.tuesday,
      'wednesday': DateTime.wednesday,
      'thursday': DateTime.thursday,
      'friday': DateTime.friday,
      'saturday': DateTime.saturday,
      'sunday': DateTime.sunday,
    };

    operatingHours.days.forEach((day, value) {
      if (value.isClosed) return;

      final weekDay = weekDays[day.toLowerCase()];

      if (weekDay == null) return;

      result[weekDay] = WeekDayTiming(
        openAtUtc: '2026-01-01T${value.openTime}:00Z',
        closeAtUtc: '2026-01-01T${value.closeTime}:00Z',
      );
    });

    return result;
  }

  final List<_SectionMeta> _sectionOrder = <_SectionMeta>[
    _SectionMeta(
      period: _DayPeriod.morning,
      title: 'Morning',
      iconPath: AppIcons.svg.generic.sunrise,
    ),
    _SectionMeta(
      period: _DayPeriod.afternoon,
      title: 'Afternoon',
      iconPath: AppIcons.svg.generic.sun,
    ),
    _SectionMeta(
      period: _DayPeriod.evening,
      title: 'Evening',
      iconPath: AppIcons.svg.generic.dawn,
    ),
  ];

  int _selectedDateIndex = 0;
  String? _selectedSlotId;
  String? _selectedPetId;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    context.read<ClinicBloc>().add(
      FetchClinicDetails(clinicId: widget.clinicId),
    );
    _upcomingDates = List<DateTime>.generate(
      _daysToShow,
      (index) =>
          DateTime(now.year, now.month, now.day).add(Duration(days: index)),
      growable: false,
    );
  }

  DateTime get _selectedDate => _upcomingDates[_selectedDateIndex];

  @override
  Widget build(BuildContext context) {
    return AppPrimaryScreenContainer(
      title: 'Select time slot',
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white_50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppRadiusSize.r16.rr),
              topRight: Radius.circular(AppRadiusSize.r16.rr),
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<ClinicBloc, ClinicState>(
            buildWhen: (previous, current) =>
                previous.clinicDetailsStatus != current.clinicDetailsStatus,
            builder: (context, state) {
              final clinicDetails = state.clinicDetailsData?.clinic;
              final subscriptionPlans =
                  state.clinicDetailsData?.subscriptionPlans ?? [];
              final totalVets = state.clinicDetailsData?.totalVets ?? 0;

              if (state.clinicDetailsStatus == ClinicDetailsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.clinicDetailsStatus == ClinicDetailsStatus.failure) {
                return Center(child: AppText.bodyS('Something went wrong!'));
              }

              final sections = _appointmentsSection;

              final paidPlans = subscriptionPlans
                  .where((e) => e.planType == 'paid')
                  .toList();

              paidPlans.sort((a, b) {
                final aPrice = double.tryParse(a.price.toString()) ?? 0;
                final bPrice = double.tryParse(b.price.toString()) ?? 0;

                return aPrice.compareTo(bPrice);
              });

              final lowestPlan = paidPlans.isNotEmpty ? paidPlans.first : null;

              final formattedPrice = lowestPlan != null
                  ? (double.parse(
                      lowestPlan.price.toString(),
                    ).toInt()).toString()
                  : '';

              final currency = lowestPlan?.currency ?? '';

              final basePrice = '$currency $formattedPrice'.trim();

              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSpacing.s16.h,
                          horizontal: AppSpacing.s11.w,
                        ),
                        child: ClinicDetailsSlotCard(
                          clinic: ClinicDetailsCardModel(
                            id: clinicDetails?.id ?? '',
                            name: clinicDetails?.clinicName ?? '',
                            image: clinicDetails?.clinicImage ?? '',
                            vetCount: '$totalVets Vets',
                            experience:
                                '${clinicDetails?.years}+ yrs experience',
                            location: clinicDetails?.city ?? '',
                            status: 'Open',
                            closingTime: '09.00 PM',
                            basePrice: basePrice,
                          ),
                          onTap: () {},
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.s1.w,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: AppButton(
                            disableRippleEffect: true,
                            width: null,
                            label: _monthYearLabel(DateTime.now()),
                            variant: AppButtonVariant.text,
                            onPressed: () {
                              // _openDateRangePicker
                            },
                            trailingSvgAsset: AppIcons.svg.generic.chevronDown,
                          ),
                        ),
                      ),

                      DateTabs(
                        dates: _upcomingDates,
                        selectedIndex: _selectedDateIndex,
                        onDateTap: (index) {
                          setState(() {
                            _selectedDateIndex = index;
                            _selectedSlotId = null;
                          });
                        },
                        getCount: _getTotalAvailableSlotsForDate,
                      ),

                      SizedBox(height: 12.h),

                      Expanded(
                        child: sections.isEmpty
                            ? const NoSlotsView()
                            : ListView.builder(
                                padding: EdgeInsets.only(
                                  bottom: _selectedSlotId != null
                                      ? AppSpacing.s56.h
                                      : AppSpacing.s25.h,
                                ),
                                itemCount: sections.length,
                                itemBuilder: (context, index) {
                                  final currentSection = sections[index];

                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(
                                          horizontal: AppSpacing.s16.w,
                                        ).add(
                                          EdgeInsets.only(
                                            bottom: AppSpacing.s16.w,
                                          ),
                                        ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppointmentSectionHeader(
                                          iconPath: currentSection.iconPath,
                                          timing: currentSection.timing,
                                          title: currentSection.title,
                                        ),

                                        SlotsGridView(
                                          appointmentsSection: currentSection,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),

                  if (_selectedSlotId != null)
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: SafeArea(
                        top: false,
                        child: AppButton(
                          label: 'Continue',
                          borderColor: AppColors.black,
                          size: AppButtonSize.medium,
                          textStyle: AppTypography.h1.copyWith(
                            fontSize: AppFontSize.fs14,
                          ),
                          onPressed: () async {
                            final List<UserPet> pets = context
                                .read<UserProfileBloc>()
                                .state
                                .pets;

                            String? petId = _selectedPetId;
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
                              initiallySelectedPet:
                                  petsList.any((pet) => pet.isSelected)
                                  ? petsList.firstWhere((pet) => pet.isSelected)
                                  : null,
                            );

                            if (!mounted) return;

                            if (result != null) {
                              _selectedPetId = result.selectedPet.id;
                              setState(() {});
                              if (!context.mounted) return;
                              final appointmentCubit =
                                  getIt<AppointmentCubit>();

                              /// Start fresh booking flow
                              appointmentCubit.reset();

                              /// Save clinic
                              appointmentCubit.updateClinic(
                                clinicId: widget.clinicId,
                              );

                              /// Save pet
                              appointmentCubit.updatePet(
                                petId: result.selectedPet.id,
                                petName: result.selectedPet.name,
                                petImage: result.selectedPet.imageUrl,
                                petNotes: result.note,
                              );

                              final selectedDateTime = DateTime.parse(
                                _selectedSlotId!,
                              );
                              appointmentCubit.updateAppointment(
                                appointmentDate: DateFormat(
                                  'yyyy-MM-dd',
                                ).format(selectedDateTime),
                                appointmentTime: _selectedSlotId,
                              );
                              context.router.push(
                                AppointmentBookingSummaryRoute(
                                  clinicId: widget.clinicId,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String _monthYearLabel(DateTime date) {
    return '${monthName(date.month)} ${date.year}';
  }

  List<AppointmentSection> get _appointmentsSection {
    final operatingHours = context
        .read<ClinicBloc>()
        .state
        .clinicDetailsData
        ?.clinic
        .operatingHours;
    final weeklyTimings = _getWeeklyTimings(operatingHours);
    final dayTiming = weeklyTimings[_selectedDate.weekday];
    if (dayTiming == null) {
      return const <AppointmentSection>[];
    }

    final localRange = dayTiming.toLocalRangeForDate(_selectedDate);
    final entries = _buildSlotEntries(
      range: localRange,
      selectedDate: _selectedDate,
      onTap: (slotId) {
        log('Tapped slot: $slotId');
        setState(() {
          _selectedSlotId = slotId;
        });
      },
      selectedSlotId: _selectedSlotId,
    );

    if (entries.isEmpty) {
      return const <AppointmentSection>[];
    }

    final grouped = <_DayPeriod, List<_SlotEntry>>{};
    for (final entry in entries) {
      final period = _periodForTime(entry.start);
      grouped.putIfAbsent(period, () => <_SlotEntry>[]).add(entry);
    }

    final formatter = DateFormat('hh:mm a');
    final sections = <AppointmentSection>[];

    for (final meta in _sectionOrder) {
      final periodEntries = grouped[meta.period];
      if (periodEntries == null || periodEntries.isEmpty) {
        continue;
      }

      final start = periodEntries.first.start;
      final end = periodEntries.last.end;

      sections.add(
        AppointmentSection(
          iconPath: meta.iconPath,
          title: meta.title,
          timing: '${formatter.format(start)} - ${formatter.format(end)}',
          slots: periodEntries
              .map((entry) => entry.slot)
              .toList(growable: false),
        ),
      );
    }

    return sections;
  }

  int _getTotalAvailableSlotsForDate(DateTime date) {
    final operatingHours = context
        .read<ClinicBloc>()
        .state
        .clinicDetailsData
        ?.clinic
        .operatingHours;
    final weeklyTimings = _getWeeklyTimings(operatingHours);
    final dayTiming = weeklyTimings[date.weekday];
    if (dayTiming == null) {
      return 0;
    }

    final localRange = dayTiming.toLocalRangeForDate(date);
    final entries = _buildSlotEntries(
      range: localRange,
      selectedDate: date,
      onTap: (_) {},
      selectedSlotId: null,
    );

    return entries.where((entry) => entry.slot.isAvailable).length;
  }

  String _formatWithOffset(DateTime dateTime) {
    final offset = dateTime.timeZoneOffset;

    final hours = offset.inHours.abs().toString().padLeft(2, '0');

    final minutes = (offset.inMinutes.abs() % 60).toString().padLeft(2, '0');

    final sign = offset.isNegative ? '-' : '+';

    final formattedOffset = '$sign$hours:$minutes';

    return '${DateFormat("yyyy-MM-ddTHH:mm:ss").format(dateTime)}$formattedOffset';
  }

  List<_SlotEntry> _buildSlotEntries({
    required DateTimeRange range,
    required DateTime selectedDate,
    required ValueChanged<String> onTap,
    required String? selectedSlotId,
  }) {
    final now = DateTime.now();
    final displayFormat = DateFormat('hh:mm a');
    final entries = <_SlotEntry>[];

    DateTime currentSlot = _roundUpToNextSlot(range.start);
    while (currentSlot.isBefore(range.end)) {
      final nextSlot = currentSlot.add(
        const Duration(minutes: _slotDurationInMinutes),
      );

      if (nextSlot.isAfter(range.end)) {
        break;
      }

      final isToday = _isSameDate(selectedDate, now);
      final isAvailable = !isToday || currentSlot.isAfter(now);

      final appointmentDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        currentSlot.hour,
        currentSlot.minute,
      );

      final slotId = _formatWithOffset(appointmentDateTime);

      entries.add(
        _SlotEntry(
          start: currentSlot,
          end: nextSlot,
          slot: Slots(
            isAvailable: isAvailable,
            isSelected: selectedSlotId == slotId,
            onTap: () => onTap(slotId),
            slotTime: displayFormat.format(currentSlot),
          ),
        ),
      );

      currentSlot = nextSlot;
    }

    return entries;
  }

  _DayPeriod _periodForTime(DateTime time) {
    if (time.hour < 12) {
      return _DayPeriod.morning;
    }
    if (time.hour < 16) {
      return _DayPeriod.afternoon;
    }
    return _DayPeriod.evening;
  }

  DateTime _roundUpToNextSlot(DateTime dateTime) {
    final remainder = dateTime.minute % _slotDurationInMinutes;
    if (remainder == 0 && dateTime.second == 0 && dateTime.millisecond == 0) {
      return DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
      );
    }

    return DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    ).add(Duration(minutes: _slotDurationInMinutes - remainder));
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class TitleDescriptionComponent extends StatelessWidget {
  final String title;
  final String description;
  const TitleDescriptionComponent({
    super.key,
    required this.description,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(child: AppText.h1(title, fontSize: AppFontSize.fs14)),
            ],
          ),
          const SizedBox(height: AppSpacing.s7),
          AppText.bodyS(
            fontSize: AppFontSize.fs12,
            variant: AppTextVariant.noEllipsis,
            description,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/appointment_section_header.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/date_tabs.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/models/appointment_section.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/models/slots.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/models/week_day_timing.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/no_slots_view.dart';
import 'package:poochcare/core/widgets/others/appointment_time_slot/slots_grid_view.dart';

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

class AppTimeSlotSelection extends StatefulWidget {
  const AppTimeSlotSelection({super.key});

  @override
  State<AppTimeSlotSelection> createState() => _AppTimeSlotSelectionState();
}

class _AppTimeSlotSelectionState extends State<AppTimeSlotSelection> {
  static const int _daysToShow = 30;
  static const int _slotDurationInMinutes = 30;

  late final List<DateTime> _upcomingDates;

  // Replace this with API values. Input must be UTC ISO datetime strings.
  final Map<int, WeekDayTiming> _weeklyTimings = {
    DateTime.monday: const WeekDayTiming(
      openAtUtc: '2026-01-05T20:00:00Z',
      closeAtUtc: '2026-01-05T19:30:00Z',
    ),
    DateTime.tuesday: const WeekDayTiming(
      openAtUtc: '2026-01-06T08:00:00Z',
      closeAtUtc: '2026-01-06T19:30:00Z',
    ),
    DateTime.wednesday: const WeekDayTiming(
      openAtUtc: '2026-01-07T08:00:00Z',
      closeAtUtc: '2026-01-07T19:30:00Z',
    ),
    DateTime.thursday: const WeekDayTiming(
      openAtUtc: '2026-01-08T08:00:00Z',
      closeAtUtc: '2026-01-08T19:30:00Z',
    ),
    DateTime.friday: const WeekDayTiming(
      openAtUtc: '2026-01-09T08:00:00Z',
      closeAtUtc: '2026-01-09T19:30:00Z',
    ),
    DateTime.saturday: const WeekDayTiming(
      openAtUtc: '2026-01-10T08:00:00Z',
      closeAtUtc: '2026-01-10T17:30:00Z',
    ),
    DateTime.sunday: const WeekDayTiming(
      openAtUtc: '2026-01-11T10:00:00Z',
      closeAtUtc: '2026-01-11T14:00:00Z',
    ),
  };

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

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
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
    final sections = _appointmentsSection;

    return Scaffold(
      backgroundColor: const Color(0xffFFFEFD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 10),
              // const ClinicSummaryCard(),
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
              SizedBox(height: 8.h),
              const Divider(color: Color(0xffEFE8E6), height: 1),
              SizedBox(height: 12.h),
              Expanded(
                child: sections.isEmpty
                    ? const NoSlotsView()
                    : ListView.builder(
                        itemCount: sections.length,
                        itemBuilder: (context, index) {
                          final currentSection = sections[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ),
    );
  }

  List<AppointmentSection> get _appointmentsSection {
    final dayTiming = _weeklyTimings[_selectedDate.weekday];
    if (dayTiming == null) {
      return const <AppointmentSection>[];
    }

    final localRange = dayTiming.toLocalRangeForDate(_selectedDate);
    final entries = _buildSlotEntries(
      range: localRange,
      selectedDate: _selectedDate,
      onTap: (slotId) {
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
    final dayTiming = _weeklyTimings[date.weekday];
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
      final slotId =
          '${selectedDate.toIso8601String()}_${currentSlot.hour}_${currentSlot.minute}';

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

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/theme/app_typography.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/home/data/api/updates_api_service.dart';
import 'package:poochcare/features/home/data/repositories/updates_repository_impl.dart';
import 'package:poochcare/features/home/domain/models/updated_and_reminder_model.dart';
import 'package:poochcare/features/home/presentation/bloc/updated_and_reminder_bloc.dart';
import 'package:poochcare/features/home/presentation/bloc/updated_and_reminder_event.dart';
import 'package:poochcare/features/home/presentation/bloc/updated_and_reminder_state.dart';

class UpdatesAndReminder extends StatefulWidget {
  final String? title;
  final String? btnLabel;

  const UpdatesAndReminder({super.key, this.title, this.btnLabel});

  @override
  State<UpdatesAndReminder> createState() => _UpdatesAndReminderState();
}

class _UpdatesAndReminderState extends State<UpdatesAndReminder> {
  late final UpdatedAndReminderBloc _bloc;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _bloc = UpdatedAndReminderBloc(
      UpdatesRepositoryImpl(UpdatesApiService(getIt<Dio>())),
    )..add(const FetchUpdatesAndRemindersEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  List<_CalendarDay> _buildUpcomingWeekDays(
    List<UpdatedAndReminderModel> items,
  ) {
    if (items.isEmpty) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      return List.generate(7, (index) {
        final date = today.add(Duration(days: index));
        return _CalendarDay(
          dateTime: date,
          day: _weekdayLabel(date.weekday),
          date: date.day.toString().padLeft(2, '0'),
        );
      });
    }

    final uniqueDates = <DateTime>{
      for (final item in items) _normalizedDate(item.dateTime),
    }.toList()..sort();

    return uniqueDates
        .map(
          (date) => _CalendarDay(
            dateTime: date,
            day: _weekdayLabel(date.weekday),
            date: date.day.toString().padLeft(2, '0'),
          ),
        )
        .toList(growable: false);
  }

  Map<DateTime, List<UpdatedAndReminderModel>> _buildAppointmentsByDate(
    List<UpdatedAndReminderModel> items,
  ) {
    final Map<DateTime, List<UpdatedAndReminderModel>> grouped = {};

    for (final item in items) {
      final dateKey = _normalizedDate(item.dateTime);
      grouped.putIfAbsent(dateKey, () => <UpdatedAndReminderModel>[]).add(item);
    }

    return grouped;
  }

  DateTime _selectedDateForDays(List<_CalendarDay> days) {
    if (days.isEmpty) {
      return _normalizedDate(DateTime.now());
    }

    final selectedDate = _selectedDate;
    if (selectedDate == null) {
      return days.first.dateTime;
    }

    for (final day in days) {
      if (_normalizedDate(day.dateTime) == _normalizedDate(selectedDate)) {
        return day.dateTime;
      }
    }

    return days.first.dateTime;
  }

  DateTime _normalizedDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  List<UpdatedAndReminderModel> _selectedDayAppointments(
    List<UpdatedAndReminderModel> items,
    List<_CalendarDay> days,
  ) {
    if (days.isEmpty) {
      return const [];
    }

    final selectedDate = _normalizedDate(_selectedDateForDays(days));
    final appointmentsByDate = _buildAppointmentsByDate(items);
    return appointmentsByDate[selectedDate] ?? const [];
  }

  String _weekdayLabel(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatedAndReminderBloc, UpdatedAndReminderState>(
      bloc: _bloc,
      builder: (context, state) {
        final days = _buildUpcomingWeekDays(state.items);
        final appointments = _selectedDayAppointments(state.items, days);
        final selectedDate = _selectedDateForDays(days);

        if (state.status == UpdatedAndReminderStatus.loading &&
            state.items.isEmpty) {
          return AppWaveCard(
            borderRadius: AppRadiusSize.r16.rr,
            notchWidth: AppSize.cs60.csw,
            notchHeight: -AppSize.cs12.csh,
            variant: AppCardNotchVariant.bottomLeft,
            backgroundColor: const Color(0xFFFFD59A).withValues(alpha: 0.29),
            padding: EdgeInsets.only(
              bottom: AppSpacing.s10.h,
              top: AppSpacing.s20.h,
            ),
            child: SizedBox(
              height: AppSize.cs350.csh,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state.status == UpdatedAndReminderStatus.failure &&
            state.items.isEmpty) {
          return AppWaveCard(
            borderRadius: AppRadiusSize.r16.rr,
            notchWidth: AppSize.cs60.csw,
            notchHeight: -AppSize.cs12.csh,
            variant: AppCardNotchVariant.bottomLeft,
            backgroundColor: const Color(0xFFFFD59A).withValues(alpha: 0.29),
            padding: EdgeInsets.only(
              bottom: AppSpacing.s10.h,
              top: AppSpacing.s20.h,
            ),
            child: SizedBox(
              height: AppSize.cs350.csh,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.bodyM(
                        state.errorMessage.isEmpty
                            ? 'Unable to load updates and reminders.'
                            : state.errorMessage,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.s12.h),
                      AppButton(
                        label: 'RETRY',
                        variant: AppButtonVariant.text,
                        width: null,
                        size: AppButtonSize.small,
                        onPressed: () {
                          _bloc.add(const FetchUpdatesAndRemindersEvent());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return AppWaveCard(
          borderRadius: AppRadiusSize.r16.rr,
          notchWidth: AppSize.cs60.csw,
          notchHeight: -AppSize.cs12.csh,
          variant: AppCardNotchVariant.bottomLeft,
          backgroundColor: const Color(0xFFFFD59A).withValues(alpha: 0.29),
          padding: EdgeInsets.only(
            bottom: AppSpacing.s10.h,
            top: AppSpacing.s20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: AppText.h3(widget.title ?? '')),
              SizedBox(height: AppSpacing.s14.h),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.s6,
                  right: AppSpacing.s6,
                ),
                child: _DaySelector(
                  days: days,
                  selectedDate: selectedDate,
                  onChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
              ),
              SizedBox(height: AppSpacing.s8.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
                child: _AppointmentCard(
                  appointments: appointments,
                  btnLabel: widget.btnLabel,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DaySelector extends StatelessWidget {
  final List<_CalendarDay> days;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onChanged;

  const _DaySelector({
    required this.days,
    required this.selectedDate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.cs60.csh,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(width: AppSpacing.s8.w),
        itemBuilder: (context, index) {
          final item = days[index];
          final isSelected = DateUtils.isSameDay(item.dateTime, selectedDate);

          return InkWell(
            borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
            onTap: () => onChanged(item.dateTime),
            child: Container(
              width: AppSize.cs60.csw,
              height: AppSize.cs60.csh,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFECBC) : Colors.white,
                borderRadius: BorderRadius.circular(AppRadiusSize.r12.rr),
                gradient: isSelected
                    ? const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.gradientPrimaryLightStart,
                          AppColors.gradientPrimaryLightEnd,
                        ],
                      )
                    : null,
              ),
              // color: isSelected ? null : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.bodyM(
                    item.day,
                    color: AppColors.textSecondary,
                    fontSize: AppFontSize.fs12,
                  ),
                  SizedBox(height: AppSpacing.s4.h),
                  AppText.displayXL(
                    item.date,
                    style: TextStyle(
                      fontSize: AppFontSize.fs14,
                      fontWeight: FontWeight.w400,
                    ),
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

class _AppointmentCard extends StatelessWidget {
  final List<UpdatedAndReminderModel> appointments;
  final String? btnLabel;

  const _AppointmentCard({required this.appointments, required this.btnLabel});

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      borderRadius: AppRadiusSize.r16.rr,
      variant: AppCardNotchVariant.bottomLeft,
      backgroundColor: Colors.white,
      notchWidth: AppSize.cs62.csw,
      notchHeight: AppSize.cs1.csh,
      padding: EdgeInsets.symmetric(
        // horizontal: AppSpacing.s15.w,
        vertical: AppSpacing.s18.h,
      ),
      child: SizedBox(
        height: AppSize.cs350.csh,
        child: Column(
          children: [
            Expanded(
              child: appointments.isEmpty
                  ? Center(
                      child: AppText.bodyM(
                        'No updates found for this date.',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var i = 0; i < appointments.length; i++) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.s15.w,
                              ),
                              child: _AppointmentTile(
                                appointment: appointments[i],
                              ),
                            ),
                            if (i != appointments.length - 1) ...[
                              SizedBox(height: AppSpacing.s10.h),
                              Divider(
                                height: AppSize.cs1.csh,
                                color: const Color(
                                  0xFF1B1B1B,
                                ).withValues(alpha: 0.08),
                              ),
                              SizedBox(height: AppSpacing.s10.h),
                            ],
                          ],
                        ],
                      ),
                    ),
            ),
            SizedBox(height: AppSize.cs24.csh),
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.s24),
              child: Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  label: btnLabel ?? 'VIEW ALL REMINDERS',
                  variant: AppButtonVariant.text,
                  width: null,
                  trailingSvgAsset: AppIcons.svg.generic.chevronRight,
                  iconSize: AppIconSize.is10.ir,
                  size: AppButtonSize.small,
                  textStyle: AppTypography.displayXL.copyWith(
                    fontSize: AppFontSize.fs11,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  final UpdatedAndReminderModel appointment;

  const _AppointmentTile({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImageFrame(
                width: 50.w,
                height: 40.h,
                imageUrl: appointment.image ?? '',
              ),
              SizedBox(width: AppSpacing.s10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      spacing: AppSpacing.s8.w,
                      runSpacing: AppSpacing.s2.h,
                      children: [
                        AppText.support(
                          appointment.time,
                          color: const Color(0xFFB3958B),
                        ),
                        if (appointment.oldTime != null)
                          AppText.support(
                            appointment.oldTime!,
                            color: const Color(0xFFCCB8B1),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Color(0xFFCCB8B1),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.s2.h),
                    AppText.h4(
                      appointment.title,
                      maxLines: 2,
                      color: AppColors.textPrimary,
                    ),
                    if (appointment.message != null) ...[
                      SizedBox(height: AppSpacing.s4.h),
                      AppText.bodyM(
                        appointment.message!,
                        maxLines: 2,
                        color: AppColors.textSecondary,
                        fontSize: AppFontSize.fs12,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.s8.w),
              Padding(
                padding: EdgeInsets.only(top: AppSpacing.s4.h),
                child: _buildTypeIcon(appointment.type),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppIcon _buildTypeIcon(String type) {
    final normalizedType = type.trim().toLowerCase();

    return AppIcon(
      normalizedType == 'appointment'
          ? AppIcons.svg.generic.injection
          : normalizedType == 'grooming'
          ? AppIcons.svg.generic.grooming
          : AppIcons.svg.generic.wallet,
      size: 27.r,
      color: const Color(0xFFD7BC97),
    );
  }
}

class _CalendarDay {
  final DateTime dateTime;
  final String day;
  final String date;

  const _CalendarDay({
    required this.dateTime,
    required this.day,
    required this.date,
  });
}

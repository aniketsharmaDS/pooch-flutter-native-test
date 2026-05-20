import 'package:flutter/material.dart';
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
import 'package:poochcare/features/home/domain/models/updated_and_reminder_model.dart';

class UpdatesAndReminder extends StatefulWidget {
  final String? title;
  final String? btnLabel;

  const UpdatesAndReminder({super.key, this.title, this.btnLabel});

  @override
  State<UpdatesAndReminder> createState() => _UpdatesAndReminderState();
}

class _UpdatesAndReminderState extends State<UpdatesAndReminder> {
  late final List<_CalendarDay> _days = _buildUpcomingWeekDays();

  int _selectedDayIndex = 0;

  late final Map<DateTime, List<UpdatedAndReminderModel>> _appointmentsByDate =
      _buildAppointmentsByDate();

  List<_CalendarDay> _buildUpcomingWeekDays() {
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

  Map<DateTime, List<UpdatedAndReminderModel>> _buildAppointmentsByDate() {
    final today = _normalizedDate(DateTime.now());
    return {
      today: [
        const UpdatedAndReminderModel(
          petName: 'Rudolph',
          title: 'Vaccination for Rudolph',
          time: '04:00 PM',
          image:
              'https://www.trupanion.com/images/trupanionwebsitelibraries/pet-blogs/golden-retriever-bridge-pose-1-.jpg?sfvrsn=8e205534_4',
          message: 'Your Vet is available at 4:30 pm.',
          type: 'appointment',
        ),
        const UpdatedAndReminderModel(
          petName: 'Cadbury',
          title: 'Rabies vaccination for Cadbury',
          time: 'Monday 4:00 PM',
          oldTime: 'Today 4:30 PM',
          image:
              'https://static.toiimg.com/imagenext/toiblogs/photo/readersblog/wp-content/uploads/2021/12/adorable-cavalier-king-charles-spaniel-puppy-royalty-dog.jpg',
          type: 'Vaccination',
        ),
        const UpdatedAndReminderModel(
          petName: 'Bella',
          title: 'Vaccination for Bella',
          time: '02:30 PM',
          image:
              'https://www.allianz.ie/blog/your-pet/pet-dental-care-is-vital/_jcr_content/root/stage/stageimage.img.82.3360.jpeg/1727883109843/cute-happy-pup.jpeg',
          type: 'payment',
        ),
        const UpdatedAndReminderModel(
          petName: 'Rudolph',
          title: 'Vaccination for Rudolph',
          time: '04:00 PM',
          image:
              'https://www.atozvet.com/wp-content/uploads/2017/07/Prevention-and-Treatment-For-Pet-Disease-Midland-TX-scaled.jpg',
          message: 'Your Vet is available at 4:30 pm.',
          type: 'appointment',
        ),
        const UpdatedAndReminderModel(
          petName: 'Rudolph',
          title: 'Vaccination for Rudolph',
          time: '04:00 PM - 12:30 PM',
          image:
              'https://www.cdc.gov/healthy-pets/media/images/2024/04/GettyImages-598175960-cute-dog-headshot.jpg',
          message: 'Your Vet is available at 4:30 pm.',
          type: 'appointment',
        ),
        const UpdatedAndReminderModel(
          petName: 'Rudolph',
          title: 'Vaccination for Rudolph',
          time: '04:00 PM - 05:00 PM',
          image:
              'https://static01.nyt.com/images/2020/05/09/multimedia/09sp-ai-pets-promo/09sp-ai-pets-promo-mediumSquareAt3X.jpg',
          message: 'Your Vet is available at 4:30 pm.',
          type: 'appointment',
        ),
        const UpdatedAndReminderModel(
          petName: 'Rudolph',
          title: 'Vaccination for Rudolph',
          time: '04:00 PM',
          image:
              'https://static01.nyt.com/images/2020/05/09/multimedia/09sp-ai-pets-promo/09sp-ai-pets-promo-mediumSquareAt3X.jpg',
          message: 'Your Vet is available at 4:30 pm.',
          type: 'appointment',
        ),
      ],
      today.add(const Duration(days: 1)): [
        const UpdatedAndReminderModel(
          petName: 'Milo',
          title: 'General checkup for Milo',
          time: '11:30 AM',
          image:
              'https://static01.nyt.com/images/2020/05/09/multimedia/09sp-ai-pets-promo/09sp-ai-pets-promo-mediumSquareAt3X.jpg',
          type: 'grooming',
        ),
      ],
      today.add(const Duration(days: 2)): [
        const UpdatedAndReminderModel(
          petName: 'Simba',
          title: 'Deworming for Simba',
          time: '03:15 PM',
          image:
              'https://static01.nyt.com/images/2020/05/09/multimedia/09sp-ai-pets-promo/09sp-ai-pets-promo-mediumSquareAt3X.jpg',
          message: 'Vet asked to share current food pattern.',
          type: 'appointment',
        ),
      ],
    };
  }

  DateTime _normalizedDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  List<UpdatedAndReminderModel> _selectedDayAppointments() {
    if (_days.isEmpty) {
      return const [];
    }

    final selectedDate = _normalizedDate(_days[_selectedDayIndex].dateTime);
    return _appointmentsByDate[selectedDate] ?? const [];
  }

  String _weekdayLabel(int weekday) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      borderRadius: AppRadiusSize.r16.rr,
      notchWidth: AppSize.cs60.csw,
      notchHeight: -AppSize.cs12.csh,
      variant: AppCardNotchVariant.bottomLeft,
      backgroundColor: const Color(0xFFFFD59A).withValues(alpha: 0.29),
      padding: EdgeInsets.only(bottom: AppSpacing.s10.h, top: AppSpacing.s20.h),
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
              days: _days,
              selectedIndex: _selectedDayIndex,
              onChanged: (index) {
                setState(() {
                  _selectedDayIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: AppSpacing.s8.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s6),
            child: _AppointmentCard(
              appointments: _selectedDayAppointments(),
              btnLabel: widget.btnLabel,
            ),
          ),
        ],
      ),
    );
  }
}

class _DaySelector extends StatelessWidget {
  final List<_CalendarDay> days;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _DaySelector({
    required this.days,
    required this.selectedIndex,
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
          final isSelected = selectedIndex == index;
          final item = days[index];

          return InkWell(
            borderRadius: BorderRadius.circular(AppRadiusSize.r16.rr),
            onTap: () => onChanged(index),
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
                        'No appointment found for this date.',
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
                imageUrl: appointment.image,
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
                  ],
                ),
              ),
              SizedBox(width: AppSpacing.s8.w),
              Padding(
                padding: EdgeInsets.only(top: AppSpacing.s4.h),
                child: AppIcon(
                  appointment.type == 'appointment'
                      ? AppIcons.svg.generic.injection
                      : appointment.type == 'grooming'
                      ? AppIcons.svg.generic.grooming
                      : AppIcons.svg.generic.wallet,
                  size: 27.r,
                  color: const Color(0xFFD7BC97),
                ),
              ),
            ],
          ),
        ],
      ),
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

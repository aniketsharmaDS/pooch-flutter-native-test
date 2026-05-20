import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/buttons/app_circle_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/dialogs/app_dialog.dart';
import 'package:poochcare/core/widgets/enums/notch_variant.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/images/app_image_frame.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_bloc.dart';
import 'package:poochcare/features/appointments/presentation/bloc/appointments_bloc/appointment_state.dart';
import 'package:poochcare/features/insight/presentation/widgets/state_wrapper.dart';
import 'package:poochcare/router/app_router.dart';

enum AppointmentStatus { normal, rescheduled, cancelled }

enum UpcomingType { calendar, upcoming }

class AppointmentModel {
  final String appointmentId;
  final DateTime dateTime;
  final String petName;
  final String title;
  final String time;
  final String? oldTime;
  final String image;
  final AppointmentStatus status;
  final String? message;
  final String type;

  const AppointmentModel({
    required this.appointmentId,
    required this.petName,
    required this.title,
    required this.time,
    this.oldTime,
    required this.image,
    required this.status,
    this.message,
    required this.type,
    required this.dateTime,
  });
}

class UpcomingAppointmentsView extends StatefulWidget {
  final String? title;
  final String? btnLabel;
  final UpcomingType type;

  const UpcomingAppointmentsView({
    super.key,
    required this.type,
    this.title,
    this.btnLabel,
  });

  @override
  State<UpcomingAppointmentsView> createState() =>
      _UpcomingAppointmentsViewState();
}

class _UpcomingAppointmentsViewState extends State<UpcomingAppointmentsView> {
  int _selectedDayIndex = 0;
  List<AppointmentModel> _selectedDayAppointments({
    required Map<DateTime, List<AppointmentModel>> appointmentsByDate,
    required List<CalendarDay> days,
  }) {
    if (days.isEmpty) {
      return const [];
    }

    final selectedDate = (days[_selectedDayIndex].dateTime);
    return appointmentsByDate[selectedDate] ?? const [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentBloc, AppointmentState>(
      listener: (context, state) {},
      builder: (context, state) {
        final days = state.days;
        final appointmentsByDate = state.appointmentsByDate;

        return StateWrapper(
          isLoading: state.status == AppointmentProgressStatus.loading,
          isError: state.status == AppointmentProgressStatus.failure,
          isEmpty: state.days.isEmpty,
          emptyWidget: const SizedBox.shrink(),
          onRetry: () {},
          title: 'Appointments',
          child: AppWaveCard(
            borderRadius: AppRadiusSize.r16.rr,
            notchWidth: AppSize.cs60.csw,
            notchHeight: -AppSize.cs12.csh,
            variant: AppCardNotchVariant.bottomLeft,
            backgroundColor: const Color(0xFFFFD59A).withValues(alpha: 0.29),
            padding: EdgeInsets.only(
              left: AppSpacing.s6.w,
              right: AppSpacing.s6.w,
              bottom: AppSpacing.s10.h,
              top: AppSpacing.s12.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ignore: prefer_single_quotes
                _CalendarHeader(title: widget.title, type: widget.type),
                SizedBox(height: AppSpacing.s16.h),
                _DaySelector(
                  days: days,
                  selectedIndex: _selectedDayIndex,
                  onChanged: (index) {
                    setState(() {
                      _selectedDayIndex = index;
                    });
                  },
                ),
                SizedBox(height: AppSpacing.s8.h),
                _AppointmentCard(
                  appointments: _selectedDayAppointments(
                    appointmentsByDate: appointmentsByDate,
                    days: days,
                  ),
                  type: widget.type,
                  btnLabel: widget.btnLabel,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final String? title;
  final UpcomingType type;
  const _CalendarHeader({required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText.h3(
        title ??
            (type == UpcomingType.calendar
                ? 'Calendar'
                : 'Upcoming Appointments'),
      ),
    );
  }
}

class _DaySelector extends StatelessWidget {
  final List<CalendarDay> days;
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
      height: AppSize.cs68.csh,
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
                        colors: [Color(0xFFFFE277), Color(0xFFFFCC3D)],
                      )
                    : null,
              ),
              // color: isSelected ? null : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.h1(
                    item.day,
                    color: AppColors.textSecondary,
                    fontSize: AppFontSize.fs14,
                  ),
                  SizedBox(height: AppSpacing.s4.h),
                  AppText.h4(item.date, fontSize: AppFontSize.fs14),
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
  final List<AppointmentModel> appointments;
  final String? btnLabel;
  final UpcomingType type;

  const _AppointmentCard({
    required this.appointments,
    required this.btnLabel,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return AppWaveCard(
      borderRadius: AppRadiusSize.r16.rr,
      variant: AppCardNotchVariant.bottomLeft,
      backgroundColor: Colors.white,
      notchWidth: AppSize.cs62.csw,
      notchHeight: AppSize.cs1.csh,
      padding: EdgeInsets.only(top: AppSpacing.s5.h),
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
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  // if require call the api to refresh the appointment status here
                                  final AppointmentModel appointment =
                                      appointments[i];
                                  final startTime = DateTime.parse(
                                    appointment.dateTime.toString(),
                                  ).toLocal();
                                  final now = DateTime.now();
                                  final threshold = startTime.subtract(
                                    const Duration(minutes: 30),
                                  );
                                  log('STTIME->startTime--->$startTime');
                                  log('STTIME->now--->$now');
                                  log('STTIME->threshold--->$threshold');
                                  // If aapointent is not started then and its within 30 mins show the dialog to user.
                                  if (now.isBefore(threshold)) {
                                    await AppDialog.show<bool>(
                                      context: context,
                                      title: 'Session has not yet started.',
                                      content:
                                          'Your session will start 30 mins before the fixed time slot, please try again in some time.',
                                      primaryLabel: 'Ok',
                                      secondaryLabel: 'Close',
                                    );
                                    return;
                                  }

                                  context.router.push(
                                    ParentVetChatRoute(
                                      appointmentId: appointment.appointmentId,
                                      enableVideoCall: true,
                                      // autoJoinVideoCall: false,
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.s15.w,
                                    vertical: AppSpacing.s15.h,
                                  ),
                                  child: Column(
                                    children: [
                                      _AppointmentTile(
                                        appointment: appointments[i],
                                      ),
                                      if (appointments[i].message != null)
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: AppSpacing.s10.h,
                                          ),
                                          child: _ChatBubble(
                                            message: appointments[i].message!,
                                          ),
                                        ),
                                      // if (i != appointments.length - 1) ...[
                                      //   SizedBox(height: AppSpacing.s10.h),
                                      //   Divider(
                                      //     height: AppSize.cs1.csh,
                                      //     color: const Color(
                                      //       0xFF1B1B1B,
                                      //     ).withValues(alpha: 0.08),
                                      //   ),
                                      // ],
                                      // SizedBox(height: AppSpacing.s10.h),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (i != appointments.length - 1) ...[
                              // SizedBox(height: AppSpacing.s10.h),
                              Divider(
                                height: AppSize.cs1.csh,
                                color: const Color(
                                  0xFF1B1B1B,
                                ).withValues(alpha: 0.08),
                              ),
                              // SizedBox(height: AppSpacing.s10.h),
                            ],
                          ],
                        ],
                      ),
                    ),
            ),
            SizedBox(height: AppSize.cs12.csh),
            if (type == UpcomingType.calendar)
              Center(
                child: AppButton(
                  label: btnLabel ?? 'VIEW ALL',
                  variant: AppButtonVariant.text,
                  width: null,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s20.w,
                    vertical: AppSpacing.s1.h,
                  ),
                  trailingSvgAsset: AppIcons.svg.generic.arrowRight,
                  iconSize: AppIconSize.is10.ir,
                  size: AppButtonSize.small,
                  onPressed: () {
                    context.router.push(const PetAppointmentsHistoryRoute());
                  },
                ),
              ),
            if (type == UpcomingType.upcoming)
              Align(
                alignment: Alignment.centerRight,
                child: AppButton(
                  label: btnLabel ?? 'VIEW ALL REMINDERS',
                  variant: AppButtonVariant.text,
                  width: null,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.s20.w,
                    vertical: AppSpacing.s1.h,
                  ),
                  trailingSvgAsset: AppIcons.svg.generic.chevronRight,
                  iconSize: AppIconSize.is10.ir,
                  size: AppButtonSize.small,
                  onPressed: () {},
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentTile extends StatelessWidget {
  final AppointmentModel appointment;

  const _AppointmentTile({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (appointment.status != AppointmentStatus.normal)
          Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.s2.w,
              bottom: AppSpacing.s8.h,
            ),
            child: _StatusBadge(status: appointment.status),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImageFrame(
              width: AppSize.cs46.csw,
              height: AppSize.cs40.csh,
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
    );
  }
}

class _ChatBubble extends StatefulWidget {
  final String message;

  const _ChatBubble({required this.message});

  @override
  State<_ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<_ChatBubble> {
  bool _showReplyField = false;
  final TextEditingController _controller = TextEditingController();

  void _toggleReply() {
    setState(() {
      _showReplyField = !_showReplyField;
    });
  }

  void _sendReply() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    // 👉 Handle send (API / state update)
    // ignore: avoid_print
    print('Reply: $text');
    _controller.clear();
    setState(() {
      _showReplyField = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFECBC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.r),
          topRight: Radius.circular(25.r),
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Message + Reply Button
          Row(
            children: [
              Expanded(
                child: AppText.bodyM(
                  widget.message,
                  maxLines: 2,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(width: AppSize.cs10.csw),
              AppButton(
                label: 'Reply',
                onPressed: _toggleReply,
                width: AppSize.cs80.csw,
                size: AppButtonSize.extraSmall,
              ),
            ],
          ),

          /// 🔹 Reply Input (Animated)
          if (_showReplyField) ...[
            SizedBox(height: AppSize.cs10.csh),
            AppTextField(
              label: 'Type reply...',
              controller: _controller,
              suffixWidget: AppCircleButton(
                icon: AppIcons.svg.generic.send,
                borderRadius: AppRadiusSize.r16.rr,
                onTap: _sendReply,
                bgColor: const Color(0xFF1B1B1B),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final AppointmentStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bgColor, textColor) = _badgeConfig(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s8.w,
        vertical: AppSpacing.s3.h,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadiusSize.r12.rr),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppFontSize.fs10,
          // fontFamily: Fonts.gilroyMedium,
          color: textColor,
        ),
      ),
    );
  }

  (String, Color, Color) _badgeConfig(AppointmentStatus value) {
    switch (value) {
      case AppointmentStatus.rescheduled:
        return (
          'Rescheduled',
          const Color(0xFFFFF4D8),
          const Color(0xFF8B6B20),
        );
      case AppointmentStatus.cancelled:
        return ('Cancelled', const Color(0xFFFFE8E8), const Color(0xFFDC4A4A));
      case AppointmentStatus.normal:
        return ('Normal', Colors.transparent, const Color(0xFF1B1B1B));
    }
  }
}

class CalendarDay {
  final DateTime dateTime;
  final String day;
  final String date;

  const CalendarDay({
    required this.dateTime,
    required this.day,
    required this.date,
  });
}

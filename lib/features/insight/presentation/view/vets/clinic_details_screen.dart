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
import 'package:poochcare/core/utils/app_extensions/string_capitalise_extension.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/clinics/clinic_details_card.dart';
import 'package:poochcare/core/widgets/others/vets/consulting_vets_container.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/features/insight/data/cubit/appointment_request_cubit.dart';
import 'package:poochcare/features/insight/data/models/clinic_details_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_operating_hours_model.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/router/app_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

enum WeekDay { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

@RoutePage()
class ClinicDetailsScreen extends StatefulWidget {
  final String clinicId;
  const ClinicDetailsScreen({required this.clinicId, super.key});

  @override
  State<ClinicDetailsScreen> createState() => _ClinicDetailsScreenState();
}

class _ClinicDetailsScreenState extends State<ClinicDetailsScreen> {
  List<String> _operatingSchedules = [];
  bool _isCalculatingOperatingHourse = true;
  @override
  void initState() {
    super.initState();
    context.read<ClinicBloc>().add(
      FetchClinicDetails(clinicId: widget.clinicId),
    );
  }

  String convertTo12Hour(String time24) {
    DateTime date = DateFormat('HH:mm').parse(time24);
    return DateFormat('hh:mm a').format(date);
  }

  void getOperatingHours({
    required Map<String, ClinicOperatingHoursDayModel>? operatingHours,
  }) {
    final weeksDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final operatingTime = operatingHours?.values.toList() ?? [];
    List<String> operatingDays = [];
    for (int i = 0; i < 7; i++) {
      bool isClosed = operatingTime[i].isClosed;
      String openTime = isClosed
          ? ''
          : convertTo12Hour(operatingTime[i].openTime);
      String closeTime = isClosed
          ? ''
          : convertTo12Hour(operatingTime[i].closeTime);
      final timing = isClosed ? 'Closed' : '$openTime - $closeTime';
      String operatingDay = '${weeksDays[i].capitalize()} $timing';
      operatingDays.add(operatingDay);
    }
    _operatingSchedules = operatingDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: BlocConsumer<ClinicBloc, ClinicState>(
            listener: (context, state) {
              if (state.clinicDetailsStatus == ClinicDetailsStatus.success) {
                getOperatingHours(
                  operatingHours:
                      state.clinicDetailsData?.clinic.operatingHours.days,
                );
                setState(() {
                  _isCalculatingOperatingHourse = false;
                });
              }
            },
            buildWhen: (previous, current) =>
                previous.clinicDetailsStatus != current.clinicDetailsStatus,
            builder: (context, state) {
              if (state.clinicDetailsStatus == ClinicDetailsStatus.loading ||
                  _isCalculatingOperatingHourse) {
                return const Center(child: CircularProgressIndicator());
              }
              final clinicDetails = state.clinicDetailsData?.clinic;
              final totalVets = state.clinicDetailsData?.totalVets ?? 0;
              final vetsData = state.clinicDetailsData?.availableVets ?? [];
              final today = getToday(weekDay: DateTime.now().weekday);
              final todayOperatingDetails =
                  clinicDetails?.operatingHours.days[today.name];
              final closeningTime = formatTo12Hour(
                todayOperatingDetails?.closeTime ?? '',
              );

              final isOpened = isClinicOpen(
                todayOperatingDetails?.closeTime ?? '',
                todayOperatingDetails?.isClosed ?? false,
              );

              if (state.clinicDetailsStatus == ClinicDetailsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.clinicDetailsStatus ==
                  ClinicDetailsStatus.failure) {
                return Center(child: AppText.bodyS('Something went wrong!'));
              }
              return Column(
                children: [
                  const PoochScreenAppBar(title: 'Clinic Details'),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadiusSize.r16),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s13,
                              ),
                              child: ClinicDetailsCard(
                                operatingSchedule: _operatingSchedules,
                                clinic: ClinicDetailsCardModel(
                                  id: clinicDetails?.id ?? '',
                                  name: clinicDetails?.clinicName ?? '',
                                  image: clinicDetails?.clinicImage ?? '',
                                  vetCount: '$totalVets Vets',
                                  experience:
                                      '${clinicDetails?.years}+ yrs experience',
                                  location: clinicDetails?.city ?? '',
                                  status: (isOpened) ? 'Open' : 'Closed',
                                  closingTime: closeningTime,
                                ),
                                onTap: () {},
                              ),
                            ),

                            TitleDescriptionComponent(
                              description: clinicDetails?.address ?? 'N/A',

                              title: 'Address',
                            ),

                            const SizedBox(height: AppSpacing.s7),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s13,
                              ),
                              child: Row(
                                children: [
                                  AppButton(
                                    height: 30,
                                    removePadding: true,
                                    padding: EdgeInsets.zero,
                                    width: null,
                                    onPressed: () =>
                                        _handleDirections(clinicDetails),
                                    textStyle: AppTypography.h3.copyWith(
                                      fontSize: AppFontSize.fs12,
                                    ),
                                    variant: AppButtonVariant.outlined,
                                    borderColor: AppColors.transparent,
                                    label: 'Directions',
                                    leadingIcon: AppIcon(
                                      AppIcons.svg.generic.paperPlaneTilt,
                                      color: AppColors.black,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.s20),
                                  AppButton(
                                    height: 30,
                                    removePadding: true,

                                    onPressed: () =>
                                        _handleShare(clinicDetails),
                                    padding: EdgeInsets.zero,
                                    textStyle: AppTypography.h3.copyWith(
                                      fontSize: AppFontSize.fs12,
                                    ),
                                    width: null,
                                    variant: AppButtonVariant.outlined,
                                    borderColor: AppColors.transparent,
                                    label: 'Share',
                                    leadingIcon: AppIcon(
                                      size: 16,
                                      AppIcons.svg.generic.shareFat,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.s35),
                            TitleDescriptionComponent(
                              description: clinicDetails?.description ?? '',

                              title: 'About The Clinic',
                            ),
                            const SizedBox(height: AppSpacing.s35),

                            TitleDescriptionComponent(
                              description:
                                  (state.clinicDetailsData?.clinicLanguage ??
                                          [])
                                      .join(', '),
                              title: 'Language',
                            ),
                            const SizedBox(height: AppSpacing.s35),

                            ConsultingVetsContainer(
                              specialities: vetsData,
                              onSpecialityTap: (speciality) {},
                            ),
                            const SizedBox(height: AppSpacing.s20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppRadiusSize.r16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Call Now',
                            variant: AppButtonVariant.outlined,
                            borderColor: AppColors.black,
                            size: AppButtonSize.medium,
                            backgroundColor: AppColors.white,
                            onPressed: () {},
                            textStyle: AppTypography.h1.copyWith(
                              fontSize: AppFontSize.fs14,
                            ),
                          ),
                        ),

                        const SizedBox(width: AppSpacing.s10),

                        Expanded(
                          child: AppButton(
                            label: 'Book Appointment',
                            borderColor: AppColors.black,
                            size: AppButtonSize.medium,
                            textStyle: AppTypography.h1.copyWith(
                              fontSize: AppFontSize.fs14,
                            ),
                            onPressed: () {
                              final appointmentCubit =
                                  getIt<AppointmentCubit>();

                              /// Start fresh booking flow
                              appointmentCubit.reset();
                              context.router.push(
                                ClinicSlotSelectionRoute(
                                  clinicId: widget.clinicId,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String formatTo12Hour(String timeString) {
    try {
      final formattedString = timeString.replaceAll('.', ':');
      DateTime tempDate = DateFormat('HH:mm').parse(formattedString);

      // 3. Format into 12-hour format (h:mm a)
      return DateFormat('h:mm a').format(tempDate);
    } catch (e) {
      return '';
    }
  }

  bool isClinicOpen(String apiClosingTime, bool isClosed) {
    if (isClosed) {
      return false;
    }
    // 1. Get current time
    final now = DateTime.now();
    final currentTotalMinutes = (now.hour * 60) + now.minute;

    final parts = apiClosingTime.split(':');
    final closingHour = int.tryParse(parts[0]) ?? 0;
    final closingMinute = int.tryParse(parts[1]) ?? 0;

    final closingTotalMinutes = (closingHour * 60) + closingMinute;

    return currentTotalMinutes < closingTotalMinutes;
  }

  Future<void> _handleDirections(ClinicDetailsApiModel? clinicDetails) async {
    if (clinicDetails == null) {
      _showSnackBar('Clinic details are unavailable.');
      return;
    }

    final mapUri = _buildMapsUri(
      latitude: clinicDetails.latitude,
      longitude: clinicDetails.longitude,
    );
    if (mapUri == null) {
      _showSnackBar('Clinic location is unavailable.');
      return;
    }

    final canOpen = await canLaunchUrl(mapUri);
    if (!canOpen) {
      _showSnackBar('Google Maps is not available on this device.');
      return;
    }

    await launchUrl(mapUri, mode: LaunchMode.externalApplication);
  }

  Future<void> _handleShare(ClinicDetailsApiModel? clinicDetails) async {
    if (clinicDetails == null) {
      _showSnackBar('Clinic details are unavailable.');
      return;
    }

    final mapUri = _buildMapsUri(
      latitude: clinicDetails.latitude,
      longitude: clinicDetails.longitude,
    );
    final shareLines = <String>[
      if (clinicDetails.clinicName.isNotEmpty) clinicDetails.clinicName,
      if (clinicDetails.address.isNotEmpty) clinicDetails.address,
      if (clinicDetails.phone.isNotEmpty) 'Phone: ${clinicDetails.phone}',
      if (clinicDetails.email.isNotEmpty) 'Email: ${clinicDetails.email}',
      if (clinicDetails.website.isNotEmpty) 'Website: ${clinicDetails.website}',
      if (mapUri != null) 'Directions: ${mapUri.toString()}',
    ];

    if (shareLines.isEmpty) {
      _showSnackBar('No clinic details to share.');
      return;
    }

    // ignore: deprecated_member_use
    await Share.share(shareLines.join('\n'), subject: 'Clinic Details');
  }

  Uri? _buildMapsUri({required String latitude, required String longitude}) {
    final lat = double.tryParse(latitude);
    final lng = double.tryParse(longitude);
    if (lat == null || lng == null) {
      return null;
    }

    return Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  WeekDay getToday({required int weekDay}) {
    switch (weekDay) {
      case 1:
        return WeekDay.monday;
      case 2:
        return WeekDay.tuesday;
      case 3:
        return WeekDay.wednesday;
      case 4:
        return WeekDay.thursday;
      case 5:
        return WeekDay.friday;
      case 6:
        return WeekDay.saturday;
      case 7:
        return WeekDay.sunday;
      default:
        return WeekDay.monday;
    }
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

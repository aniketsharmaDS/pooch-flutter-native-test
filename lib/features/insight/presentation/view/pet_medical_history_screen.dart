// ignore_for_file: prefer_single_quotes

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/utils/date_time_formattter.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/cards/app_wave_card.dart';
import 'package:poochcare/core/widgets/menus/app_popup_menu.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/upload_document_widget.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/tabs/app_default_tab_bar.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_sync_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/widgets/medical_history_filters_scope.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_state.dart';
import 'package:poochcare/router/app_router.dart';

@RoutePage()
class PetMedicalHistoryScreen extends StatefulWidget {
  const PetMedicalHistoryScreen({super.key});

  @override
  State<PetMedicalHistoryScreen> createState() =>
      _PetMedicalHistoryScreenState();
}

class _PetMedicalHistoryScreenState extends State<PetMedicalHistoryScreen> {
  late final UserProfileBloc _userProfileBloc;
  late final StreamSubscription<MedicalHistorySyncState> _syncSubscription;
  late final ValueNotifier<DateTimeRange> _selectedDateRangeNotifier;
  late final ValueNotifier<int> _activeTabIndexNotifier;
  late final ValueNotifier<int> _refreshSignalNotifier;
  final ValueNotifier<String?> _selectedPetIdNotifier = ValueNotifier<String?>(
    null,
  );

  @override
  void initState() {
    super.initState();
    _selectedDateRangeNotifier = ValueNotifier<DateTimeRange>(
      _initialMonthDateRange(),
    );
    _activeTabIndexNotifier = ValueNotifier<int>(0);
    _refreshSignalNotifier = ValueNotifier<int>(0);

    _userProfileBloc = getIt<UserProfileBloc>()..add(const GetUserPetsEvent());
    _syncSubscription = getIt<MedicalHistorySyncBloc>().stream.listen((state) {
      if (!mounted) {
        return;
      }
      _refreshSignalNotifier.value += 1;
    });
  }

  @override
  void dispose() {
    _syncSubscription.cancel();
    _selectedDateRangeNotifier.dispose();
    _activeTabIndexNotifier.dispose();
    _refreshSignalNotifier.dispose();
    _selectedPetIdNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.63;
    return BlocProvider<UserProfileBloc>.value(
      value: _userProfileBloc,
      child: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          _syncSelectedPet(state);

          return AppPrimaryScreenContainer(
            title: "Your Pooch's Medical History",
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.zero.copyWith(
                  top: AppSpacing.s16.h,
                  bottom: AppSpacing.s16.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: UploadDocumentWidget(
                        title: 'UPLOAD MEDICAL HISTORY',
                        buttonText: 'Upload',
                        customeSupport:
                            'Save medical reports, prescriptions and vaccination certificates.',
                        onUploadTap: () async {
                          await context.router.push<bool>(
                            AddPetMedicalRecordsTabRoute(),
                          );
                        },
                        onFilesChanged: (files) {
                          // log('Selected Files - $files');
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s6.w,
                      ),
                      child: AppWaveCard(
                        notchHeight: 25,
                        notchWidth: 200,
                        actionWidget: ValueListenableBuilder<String?>(
                          valueListenable: _selectedPetIdNotifier,
                          builder: (context, selectedPetId, _) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildPetMenuTrigger(state, selectedPetId),
                              ],
                            );
                          },
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _headerSection(context),
                            const SizedBox(height: 16),
                            MedicalHistoryFiltersScope(
                              selectedDateRangeNotifier:
                                  _selectedDateRangeNotifier,
                              selectedPetIdNotifier: _selectedPetIdNotifier,
                              activeTabIndexNotifier: _activeTabIndexNotifier,
                              refreshSignalNotifier: _refreshSignalNotifier,
                              child: AppDefaultRouteTabs(
                                isScrollable: true,
                                contentHeight: height,
                                tabNames: const [
                                  "All",
                                  "Consultations",
                                  "Vaccinations",
                                  "Lab Reports",
                                  "Health Records",
                                  "Other Documents",
                                ],
                                routes: const [
                                  PetMedicalAllListRoute(),
                                  PetMedicalConsultationListRoute(),
                                  PetMedicalVaccinationListRoute(),
                                  PetMedicalLabReportListRoute(),
                                  PetMedicalHealthRecordsListRoute(),
                                  PetMedicalOtherDocumentsListRoute(),
                                ],
                                onTabChanged: (index) {
                                  _activeTabIndexNotifier.value = index;
                                },
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return ValueListenableBuilder<DateTimeRange>(
      valueListenable: _selectedDateRangeNotifier,
      builder: (context, range, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppButton(
                  disableRippleEffect: true,
                  width: null,
                  label: _monthYearLabel(range.start),
                  variant: AppButtonVariant.text,
                  onPressed: _openDateRangePicker,
                  trailingSvgAsset: AppIcons.svg.generic.chevronDown,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.s8.w),
                  child: AppButton(
                    height: AppSize.cs24.h,
                    disableRippleEffect: true,
                    width: null,
                    label: _dateRangeLabel(range),
                    variant: AppButtonVariant.text,
                    size: AppButtonSize.small,
                    onPressed: _openDateRangePicker,
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: AppSpacing.s18.w),
                //   child: AppText.h4(_dateRangeLabel(range)),
                // ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _syncSelectedPet(UserProfileState state) {
    final pets = state.pets;
    if (pets.isEmpty) {
      if (_selectedPetIdNotifier.value != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            return;
          }
          _selectedPetIdNotifier.value = null;
        });
      }
      return;
    }

    final current = _selectedPetIdNotifier.value;
    final exists = current != null && pets.any((pet) => pet.id == current);
    if (exists) {
      return;
    }

    if (current == null) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _selectedPetIdNotifier.value = null;
    });
  }

  Future<void> _openDateRangePicker() async {
    final now = DateTime.now();
    await AppDatePicker.show(
      context: context,
      datePickerType: DatePickerType.range,
      initialDateRange: _selectedDateRangeNotifier.value,
      // ignore: avoid_redundant_argument_values
      firstDate: DateTime(now.year - 100, 1, 1),
      // ignore: avoid_redundant_argument_values
      lastDate: DateTime(now.year, now.month + 1, 1),
      currentDate: now,
      onDateConfirmed: (_, dateRange) {
        if (dateRange == null) {
          return;
        }
        _selectedDateRangeNotifier.value = DateTimeRange(
          start: _dateOnly(dateRange.start),
          end: _dateOnly(dateRange.end),
        );
      },
    );
  }

  DateTimeRange _initialMonthDateRange() {
    final now = DateTime.now();
    // ignore: avoid_redundant_argument_values
    final start = DateTime(now.year, now.month, 1);
    final end = DateTime(now.year, now.month + 1, 0);
    return DateTimeRange(start: start, end: end);
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  String _monthYearLabel(DateTime date) {
    return '${monthName(date.month)} ${date.year}';
  }

  String _dateRangeLabel(DateTimeRange range) {
    return '${_dayWithSuffix(range.start.day)} ${monthName(range.start.month, short: true)} - '
        '${_dayWithSuffix(range.end.day)} ${monthName(range.end.month, short: true)}.      ';
  }

  String _dayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }

    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }

  Widget _buildPetMenuTrigger(UserProfileState state, String? selectedPetId) {
    return AppPopupMenu(
      showBadge: selectedPetId != null ? true : false,
      headerTitle: 'Select Pet',
      showCloseIcon: true,
      items: _buildPetMenuItems(state),
      padding: EdgeInsets.only(right: AppSpacing.s10.w),
    );
  }

  List<AppPopupMenuItem> _buildPetMenuItems(UserProfileState state) {
    final items = <AppPopupMenuItem>[
      AppPopupMenuItem(
        title: 'All Pets',
        onTap: () => _selectedPetIdNotifier.value = null,
      ),
    ];

    items.addAll(
      state.pets.map(
        (pet) => AppPopupMenuItem(
          title: pet.name,
          onTap: () => _selectedPetIdNotifier.value = pet.id,
        ),
      ),
    );

    return items;
  }
}

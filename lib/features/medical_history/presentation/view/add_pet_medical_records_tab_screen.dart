import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/core/widgets/tabs/app_default_tab_bar.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_state.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_sync_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/view/add_pet_medical_records_form_screen.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_event.dart';

@RoutePage()
class AddPetMedicalRecordsTabScreen extends StatefulWidget {
  const AddPetMedicalRecordsTabScreen({super.key});

  @override
  State<AddPetMedicalRecordsTabScreen> createState() =>
      _AddPetMedicalRecordsTabScreenState();
}

class _AddPetMedicalRecordsTabScreenState
    extends State<AddPetMedicalRecordsTabScreen> {
  late final UserProfileBloc _userProfileBloc;
  late final MedicalHistoryFormBloc _medicalHistoryFormBloc;
  final ValueNotifier<String?> _selectedPetNotifier = ValueNotifier<String?>(
    null,
  );

  static const tabNames = [
    'Previous Vaccinations',
    'Previous diagnoses',
    'Lab Reports',
    'Current medications',
    'Health Record',
    'Clinic Visit Record',
    'Other Documents',
  ];

  @override
  void initState() {
    super.initState();
    _userProfileBloc = getIt<UserProfileBloc>()..add(const GetUserPetsEvent());
    _medicalHistoryFormBloc = getIt<MedicalHistoryFormBloc>()
      ..add(const LoadMedicalHistoryFormData());
  }

  @override
  void dispose() {
    _selectedPetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserProfileBloc>.value(value: _userProfileBloc),
        BlocProvider<MedicalHistoryFormBloc>.value(
          value: _medicalHistoryFormBloc,
        ),
      ],
      child: BlocListener<MedicalHistoryFormBloc, MedicalHistoryFormState>(
        listenWhen: (previous, current) {
          return previous.errorMessage != current.errorMessage ||
              previous.saveStatus != current.saveStatus;
        },
        listener: (context, state) {
          if (state.errorMessage != null &&
              state.errorMessage!.trim().isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }

          if (state.saveStatus == MedicalHistorySaveStatus.success) {
            getIt<MedicalHistorySyncBloc>().add(
              const MedicalHistoryRecordAdded(),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Medical record saved successfully.'),
              ),
            );

            if (context.mounted) {
              context.router.pop(true);
            }
          }
        },
        child: AppPrimaryScreenContainer(
          title: "Your Pooch's Medical History",
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: AppDefaultRouteTabs(
                    isScrollable: true,
                    tabNames: tabNames,
                    children: tabNames
                        .map(
                          (name) => AddPetMedicalRecordsFormScreen(
                            key: PageStorageKey<String>(name),
                            type: name,
                            selectedPetNotifier: _selectedPetNotifier,
                          ),
                        )
                        .toList(),
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

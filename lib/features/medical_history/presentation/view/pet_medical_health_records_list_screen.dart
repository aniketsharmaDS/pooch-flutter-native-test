import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:poochcare/core/enums/medical_history_record_type_filter.dart';
import 'package:poochcare/features/medical_history/presentation/widgets/medical_history_records_tab_list.dart';

@RoutePage()
class PetMedicalHealthRecordsListScreen extends StatelessWidget {
  const PetMedicalHealthRecordsListScreen({super.key});

  @override
  Widget build(BuildContext context) => const MedicalHistoryRecordsTabList(
    recordType: MedicalHistoryRecordTypeFilter.healthRecords,
  );
}

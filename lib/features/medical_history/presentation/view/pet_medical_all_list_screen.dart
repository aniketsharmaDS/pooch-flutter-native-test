import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:poochcare/features/medical_history/presentation/widgets/medical_history_records_tab_list.dart';

@RoutePage()
class PetMedicalAllListScreen extends StatelessWidget {
  const PetMedicalAllListScreen({super.key});

  @override
  Widget build(BuildContext context) => const MedicalHistoryRecordsTabList();
}

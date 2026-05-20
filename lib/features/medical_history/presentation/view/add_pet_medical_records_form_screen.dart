import 'package:flutter/material.dart';
import 'package:poochcare/core/widgets/forms/medical_form/clinic_visit_record_form.dart';
import 'package:poochcare/core/widgets/forms/medical_form/current_medications_form.dart';
import 'package:poochcare/core/widgets/forms/medical_form/health_record_form.dart';
import 'package:poochcare/core/widgets/forms/medical_form/lab_reports_form.dart';
import 'package:poochcare/core/widgets/forms/medical_form/other_documents_form.dart';
import 'package:poochcare/core/widgets/forms/medical_form/previous_diagnosis_form.dart';
import 'package:poochcare/core/widgets/forms/medical_form/previous_vacination_form.dart';

class AddPetMedicalRecordsFormScreen extends StatelessWidget {
  final String type;
  final ValueNotifier<String?> selectedPetNotifier;

  const AddPetMedicalRecordsFormScreen({
    super.key,
    required this.type,
    required this.selectedPetNotifier,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'Previous Vaccinations':
        return PreviousVacinationForm(selectedPetNotifier: selectedPetNotifier);
      case 'Previous diagnoses':
        return PreviousDiagnosisForm(selectedPetNotifier: selectedPetNotifier);
      case 'Lab Reports':
        return LabReportsForm(selectedPetNotifier: selectedPetNotifier);
      case 'Current medications':
        return CurrentMedicationsForm(selectedPetNotifier: selectedPetNotifier);
      case 'Health Record':
        return HealthRecordForm(selectedPetNotifier: selectedPetNotifier);
      case 'Clinic Visit Record':
        return ClinicVisitRecordForm(selectedPetNotifier: selectedPetNotifier);
      case 'Other Documents':
        return OtherDocumentsForm(selectedPetNotifier: selectedPetNotifier);
      default:
        return PreviousVacinationForm(selectedPetNotifier: selectedPetNotifier);
    }
  }
}

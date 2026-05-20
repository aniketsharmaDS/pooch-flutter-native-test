import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/document_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/forms/medical_form/form_submit_bottom_bar.dart';
import 'package:poochcare/core/widgets/forms/medical_form/pet_selection_form_field.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/upload_document_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/medical_history/domain/models/diagnosis_type.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_state.dart';
import 'package:poochcare/features/user_profile/domain/models/user_pet.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

class PreviousDiagnosisForm extends StatefulWidget {
  const PreviousDiagnosisForm({super.key, required this.selectedPetNotifier});

  final ValueNotifier<String?> selectedPetNotifier;

  @override
  State<PreviousDiagnosisForm> createState() => _PreviousDiagnosisFormState();
}

class _PreviousDiagnosisFormState extends State<PreviousDiagnosisForm>
    with AutomaticKeepAliveClientMixin<PreviousDiagnosisForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  final ValueNotifier<String?> _selectedDiagnosisCode = ValueNotifier(null);
  final _diagnosedOnController = TextEditingController();
  final _vetNameController = TextEditingController();
  final _notesController = TextEditingController();
  final _linkController = TextEditingController();
  final DocumentUploadService _documentUploadService =
      getIt<DocumentUploadService>();
  static const bool _enableRetryForFailedUploads = true;

  DateTime? _diagnosedOn;
  List<File>? selectedFiles;
  bool _isUploadingDocuments = false;
  final Map<String, UploadedDocumentFile> _uploadedDocumentsByPath =
      <String, UploadedDocumentFile>{};

  void _refreshSubmitState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _diagnosedOnController.addListener(_refreshSubmitState);
    _vetNameController.addListener(_refreshSubmitState);
    _linkController.addListener(_refreshSubmitState);
    _selectedDiagnosisCode.addListener(_refreshSubmitState);
    widget.selectedPetNotifier.addListener(_refreshSubmitState);
  }

  @override
  void dispose() {
    _diagnosedOnController.removeListener(_refreshSubmitState);
    _vetNameController.removeListener(_refreshSubmitState);
    _linkController.removeListener(_refreshSubmitState);
    _selectedDiagnosisCode.removeListener(_refreshSubmitState);
    widget.selectedPetNotifier.removeListener(_refreshSubmitState);
    _scrollController.dispose();
    _selectedDiagnosisCode.dispose();
    _diagnosedOnController.dispose();
    _vetNameController.dispose();
    _notesController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  String _resolveSpecies(List<UserPet> pets) {
    final selectedPet = widget.selectedPetNotifier.value;
    if (selectedPet == null) {
      return '';
    }

    for (final pet in pets) {
      if (pet.id == selectedPet) {
        return pet.type.toUpperCase();
      }
    }

    return '';
  }

  List<DiagnosisType> _filteredDiagnosisTypes(
    List<DiagnosisType> allTypes,
    List<UserPet> pets,
  ) {
    final species = _resolveSpecies(pets);
    if (species.isEmpty) {
      return allTypes;
    }

    return allTypes
        .where((type) => type.species == 'BOTH' || type.species == species)
        .toList(growable: false);
  }

  Future<void> _pickDate() async {
    await AppDatePicker.show(
      context: context,
      initialDate: _diagnosedOn,
      currentDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      onDateConfirmed: (date, _) {
        if (date == null) return;
        setState(() {
          _diagnosedOn = date;
          _diagnosedOnController.text =
              '${date.day}-${date.month}-${date.year}';
        });
      },
    );
  }

  String? _validateDocumentUrl(String? value) {
    final input = (value ?? '').trim();
    if (input.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(input);
    if (uri == null ||
        !uri.hasAbsolutePath ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.trim().isEmpty) {
      return 'Please enter a valid document URL.';
    }

    return null;
  }

  bool _isDocumentUrlValidOrEmpty() {
    return _validateDocumentUrl(_linkController.text) == null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final petId = widget.selectedPetNotifier.value;
    final selectedDiagnosisCode = _selectedDiagnosisCode.value;
    final selected = selectedFiles ?? const <File>[];

    if (petId == null || _diagnosedOn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete required fields.')),
      );
      return;
    }
    if (selectedDiagnosisCode == null || selectedDiagnosisCode.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select diagnosis type.')),
      );
      return;
    }

    if (_isUploadingDocuments) {
      return;
    }

    setState(() {
      _isUploadingDocuments = true;
    });

    final uploadDecision = await _documentUploadService
        .processPendingUploadsForSave(
          context: context,
          ownerId: petId,
          entityType: UploadEntityType.pets,
          purpose: UploadPurpose.diagnoses,
          selectedFiles: selected,
          uploadedFilesByPath: _uploadedDocumentsByPath,
          enableRetryForFailed: _enableRetryForFailedUploads,
        );

    if (!mounted) {
      return;
    }

    setState(() {
      _isUploadingDocuments = false;
    });

    if (!uploadDecision.shouldProceedWithSave) {
      return;
    }

    context.read<MedicalHistoryFormBloc>().add(
      SaveMedicalHistoryRecordRequested(
        type: 'previous_diagnoses',
        payload: <String, dynamic>{
          'petId': petId,
          'consultationDate': _diagnosedOn!.toIso8601String().split('T').first,
          'diagnosisType': selectedDiagnosisCode,
          'otherClinicName': _vetNameController.text.trim(),
          'documentUrls': _buildDocumentUrls(),
        },
      ),
    );
  }

  List<Map<String, dynamic>> _buildDocumentUrls() {
    final urls = _documentUploadService.buildUploadedDocumentEntries(
      selectedFiles: selectedFiles ?? <File>[],
      uploadedFilesByPath: _uploadedDocumentsByPath,
    );

    final manualUrl = _linkController.text.trim();
    if (manualUrl.isNotEmpty) {
      urls.add(<String, dynamic>{
        'url': manualUrl,
        'name': manualUrl,
        'size': '',
      });
    }

    return urls;
  }

  void _onFilesChanged(List<File> files) {
    setState(() {
      selectedFiles = files;

      final selectedPaths = files.map((f) => f.path).toSet();
      _uploadedDocumentsByPath.removeWhere(
        (path, _) => !selectedPaths.contains(path),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MedicalHistoryFormBloc, MedicalHistoryFormState>(
      builder: (context, state) {
        final pets = context.watch<UserProfileBloc>().state.pets;
        final diagnosisTypes = _filteredDiagnosisTypes(
          state.diagnosisTypes,
          pets,
        );
        final selectedPet = widget.selectedPetNotifier.value ?? '';

        final diagnosisItems = diagnosisTypes
            .map(
              (item) => DropdownItem<String>(
                value: item.code,
                height: AppSpacing.s40.h,
                child: Text(item.name),
              ),
            )
            .toList(growable: false);

        return Scaffold(
          backgroundColor: AppColors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: AppSpacing.s16.w,
                right: AppSpacing.s16.w,
                top: AppSpacing.s16.h,
                bottom: AppSpacing.s100.h,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PetSelectionFormField(
                      selectedPetNotifier: widget.selectedPetNotifier,
                      onPetChanged: (_) => _selectedDiagnosisCode.value = null,
                    ),
                    AppSpacing.s25.hBox,
                    AppDropdowns<String>(
                      items: diagnosisItems,
                      valueListenable: _selectedDiagnosisCode,
                      isExpanded: true,
                      isSearchable: true,
                      isMandatory: true,
                      hint: AppText.bodyM(
                        'Diagnosis Type',
                        color: AppColors.textFieldLabelDefault,
                      ),
                      onChanged: (v) => _selectedDiagnosisCode.value = v,
                    ),
                    AppSpacing.s25.hBox,
                    AppTextField(
                      label: 'Clinic Name',
                      controller: _vetNameController,
                      isMandatory: true,
                    ),
                    AppSpacing.s25.hBox,
                    AppTextField(
                      label: 'Select Date',
                      controller: _diagnosedOnController,
                      isReadOnly: true,
                      isMandatory: true,
                      onPressed: _pickDate,
                      suffixWidget: AppIcon(
                        AppIcons.svg.generic.calendar,
                        size: AppIconSize.is16,
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    AppTextField(
                      label: 'Enter Link',
                      controller: _linkController,
                      keyboardType: TextInputType.url,
                      validator: _validateDocumentUrl,
                    ),
                    AppSpacing.s25.hBox,
                    UploadDocumentWidget(
                      showHeader: true,
                      buttonText: 'Upload',
                      description:
                          'Upload medical reports, prescriptions and vaccination certificates.',
                      maxSizeLabel: 'Max 5MB',
                      onFilesChanged: _onFilesChanged,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: FormSubmitBottomBar(
            label: 'Submit',
            isLoading:
                state.saveStatus == MedicalHistorySaveStatus.loading ||
                _isUploadingDocuments,
            onPressed: _submit,
            isDisabled:
                state.saveStatus == MedicalHistorySaveStatus.loading ||
                _isUploadingDocuments ||
                diagnosisItems.isEmpty ||
                pets.isEmpty ||
                selectedPet.isEmpty ||
                _selectedDiagnosisCode.value == null ||
                _vetNameController.text.trim().isEmpty ||
                _diagnosedOnController.text.trim().isEmpty ||
                !_isDocumentUrlValidOrEmpty(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/document_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_icon_size.dart';
import 'package:poochcare/core/theme/app_icons.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/forms/medical_form/form_submit_bottom_bar.dart';
import 'package:poochcare/core/widgets/forms/medical_form/pet_selection_form_field.dart';
import 'package:poochcare/core/widgets/images/app_icon.dart';
import 'package:poochcare/core/widgets/input_repeater/medication_repeater_container.dart';
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/upload_document_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_state.dart';

class CurrentMedicationsForm extends StatefulWidget {
  const CurrentMedicationsForm({super.key, required this.selectedPetNotifier});

  final ValueNotifier<String?> selectedPetNotifier;

  @override
  State<CurrentMedicationsForm> createState() => _CurrentMedicationsFormState();
}

class _CurrentMedicationsFormState extends State<CurrentMedicationsForm>
    with AutomaticKeepAliveClientMixin<CurrentMedicationsForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  final _clinicNameController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _conditionReasonController = TextEditingController();
  final _notesController = TextEditingController();
  final _linkController = TextEditingController();
  final DocumentUploadService _documentUploadService =
      getIt<DocumentUploadService>();
  static const bool _enableRetryForFailedUploads = true;

  DateTime? _startDate;
  DateTime? _endDate;
  List<MedicationModel> _medications = <MedicationModel>[];
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
    _clinicNameController.addListener(_refreshSubmitState);
    _startDateController.addListener(_refreshSubmitState);
    _endDateController.addListener(_refreshSubmitState);
    _conditionReasonController.addListener(_refreshSubmitState);
    _notesController.addListener(_refreshSubmitState);
    _linkController.addListener(_refreshSubmitState);
    widget.selectedPetNotifier.addListener(_refreshSubmitState);
  }

  @override
  void dispose() {
    _clinicNameController.removeListener(_refreshSubmitState);
    _startDateController.removeListener(_refreshSubmitState);
    _endDateController.removeListener(_refreshSubmitState);
    _conditionReasonController.removeListener(_refreshSubmitState);
    _notesController.removeListener(_refreshSubmitState);
    _linkController.removeListener(_refreshSubmitState);
    widget.selectedPetNotifier.removeListener(_refreshSubmitState);
    _scrollController.dispose();
    _clinicNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _conditionReasonController.dispose();
    _notesController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  bool _hasValidDateRange() {
    if (_startDate == null || _endDate == null) {
      return true;
    }

    return !_endDate!.isBefore(_startDate!);
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

  Future<void> _pickStartDate() async {
    await AppDatePicker.show(
      context: context,
      initialDate: _startDate,
      currentDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      onDateConfirmed: (date, _) {
        if (date == null) return;
        setState(() {
          _startDate = date;
          _startDateController.text = '${date.day}-${date.month}-${date.year}';
          if (_endDate != null && date.isAfter(_endDate!)) {
            _endDate = null;
            _endDateController.clear();
          }
        });
      },
    );
  }

  Future<void> _pickEndDate() async {
    await AppDatePicker.show(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: _startDate,
      lastDate: DateTime(2100), // allow future dates
      onDateConfirmed: (date, _) {
        if (date == null) return;
        setState(() {
          _endDate = date;
          _endDateController.text = '${date.day}-${date.month}-${date.year}';
        });
      },
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

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final petId = widget.selectedPetNotifier.value;
    final selected = selectedFiles ?? const <File>[];

    if (petId == null || _startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete required fields.')),
      );
      return;
    }

    if (_endDate != null && !_hasValidDateRange()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Start date must be greater than end date.'),
        ),
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
          purpose: UploadPurpose.currentMedications,
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
        type: 'current_medications',
        payload: <String, dynamic>{
          'petId': petId,
          'medications': _medications
              .where((item) => item.name.trim().isNotEmpty)
              .map(
                (item) => <String, dynamic>{
                  'drugName': item.name.trim(),
                  'frequency': item.frequency,
                  'form': item.form,
                  'timing': item.timing,
                  'strength': item.strength,
                  'dosage': item.days,
                  'instructions': item.instructions,
                },
              )
              .toList(growable: false),
          'startDate': _formatDate(_startDate!),
          'endDate': _endDate == null ? null : _formatDate(_endDate!),
          'isCurrent': _endDate == null,
          'otherClinicName': _clinicNameController.text.trim(),
          'conditionReason': _conditionReasonController.text.trim(),
          'notes': _notesController.text.trim(),
          'documentUrls': _buildDocumentUrls(),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MedicalHistoryFormBloc, MedicalHistoryFormState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: AppSpacing.s16.h,
                bottom: AppSpacing.s100.h,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: PetSelectionFormField(
                        selectedPetNotifier: widget.selectedPetNotifier,
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: AppTextField(
                        label: 'Clinic Name',
                        controller: _clinicNameController,
                        isMandatory: true,
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: AppTextField(
                        label: 'Select Date',
                        controller: _startDateController,
                        isReadOnly: true,
                        isMandatory: true,
                        onPressed: _pickStartDate,
                        suffixWidget: AppIcon(
                          AppIcons.svg.generic.calendar,
                          size: AppIconSize.is16,
                        ),
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: AppTextField(
                        label: 'End Date',
                        controller: _endDateController,
                        isReadOnly: true,
                        isMandatory: true,
                        enabled: _startDate != null,
                        onPressed: _startDate != null ? _pickEndDate : null,
                        suffixWidget: AppIcon(
                          AppIcons.svg.generic.calendar,
                          size: AppIconSize.is16,
                        ),
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s10.w,
                      ),
                      child: MedicationRepeaterContainer(
                        onChanged: (medications) {
                          setState(() {
                            _medications = medications;
                          });
                        },
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: AppTextField(
                        label: 'Condition / Reason',
                        controller: _conditionReasonController,
                        isMandatory: true,
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: AppTextField(
                        label: 'Notes',
                        controller: _notesController,
                        isMandatory: true,
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: AppTextField(
                        label: 'Paste the document link here...',
                        controller: _linkController,
                        keyboardType: TextInputType.url,
                        validator: _validateDocumentUrl,
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16.w,
                      ),
                      child: UploadDocumentWidget(
                        showHeader: true,
                        buttonText: 'Upload',
                        description:
                            'Upload medical reports, prescriptions and vaccination certificates.',
                        maxSizeLabel: 'Max 5MB',
                        onFilesChanged: _onFilesChanged,
                      ),
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
                (widget.selectedPetNotifier.value ?? '').isEmpty ||
                _clinicNameController.text.trim().isEmpty ||
                _startDateController.text.trim().isEmpty ||
                _endDateController.text.trim().isEmpty ||
                !_hasValidDateRange() ||
                _conditionReasonController.text.trim().isEmpty ||
                _notesController.text.trim().isEmpty ||
                !_isDocumentUrlValidOrEmpty() ||
                !_medications.any((item) => item.name.trim().isNotEmpty),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

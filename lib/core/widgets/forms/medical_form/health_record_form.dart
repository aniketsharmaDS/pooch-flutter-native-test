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
import 'package:poochcare/core/widgets/others/app_date_picker/app_date_picker.dart';
import 'package:poochcare/core/widgets/others/upload_document_widget.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_state.dart';

class HealthRecordForm extends StatefulWidget {
  const HealthRecordForm({super.key, required this.selectedPetNotifier});

  final ValueNotifier<String?> selectedPetNotifier;

  @override
  State<HealthRecordForm> createState() => _HealthRecordFormState();
}

class _HealthRecordFormState extends State<HealthRecordForm>
    with AutomaticKeepAliveClientMixin<HealthRecordForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  final _clinicController = TextEditingController();
  final _dateController = TextEditingController();
  final _healthIssueController = TextEditingController();
  final _linkController = TextEditingController();
  final DocumentUploadService _documentUploadService =
      getIt<DocumentUploadService>();
  static const bool _enableRetryForFailedUploads = true;

  DateTime? _recordedOn;
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
    _clinicController.addListener(_refreshSubmitState);
    _dateController.addListener(_refreshSubmitState);
    _healthIssueController.addListener(_refreshSubmitState);
    _linkController.addListener(_refreshSubmitState);
    widget.selectedPetNotifier.addListener(_refreshSubmitState);
  }

  @override
  void dispose() {
    _clinicController.removeListener(_refreshSubmitState);
    _dateController.removeListener(_refreshSubmitState);
    _healthIssueController.removeListener(_refreshSubmitState);
    _linkController.removeListener(_refreshSubmitState);
    widget.selectedPetNotifier.removeListener(_refreshSubmitState);
    _scrollController.dispose();
    _clinicController.dispose();
    _dateController.dispose();
    _healthIssueController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    await AppDatePicker.show(
      context: context,
      initialDate: _recordedOn,
      currentDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      onDateConfirmed: (date, _) {
        if (date == null) return;
        setState(() {
          _recordedOn = date;
          _dateController.text = '${date.day}-${date.month}-${date.year}';
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
    final selected = selectedFiles ?? const <File>[];

    if (petId == null || _recordedOn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete required fields.')),
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
          purpose: UploadPurpose.otherDocuments,
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
        type: 'health_record',
        payload: <String, dynamic>{
          'petId': petId,
          'recordedDate': _recordedOn!.toIso8601String().split('T').first,
          'otherClinicName': _clinicController.text.trim(),
          'healthIssue': _healthIssueController.text.trim(),
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
    final saveStatus = context.watch<MedicalHistoryFormBloc>().state.saveStatus;

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
                ),
                AppSpacing.s25.hBox,
                AppTextField(
                  label: 'Vet/Clinic Name',
                  controller: _clinicController,
                  isMandatory: true,
                ),
                AppSpacing.s25.hBox,
                AppTextField(
                  label: 'Select Date',
                  controller: _dateController,
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
                  label: 'Health Issue / Observation',
                  controller: _healthIssueController,
                  isMandatory: true,
                ),
                AppSpacing.s25.hBox,
                AppTextField(
                  label: 'Paste document link here',
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
            saveStatus == MedicalHistorySaveStatus.loading ||
            _isUploadingDocuments,
        onPressed: _submit,
        isDisabled:
            saveStatus == MedicalHistorySaveStatus.loading ||
            _isUploadingDocuments ||
            (widget.selectedPetNotifier.value ?? '').isEmpty ||
            _clinicController.text.trim().isEmpty ||
            _dateController.text.trim().isEmpty ||
            _healthIssueController.text.trim().isEmpty ||
            !_isDocumentUrlValidOrEmpty(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

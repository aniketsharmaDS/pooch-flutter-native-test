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
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_history_form_state.dart';

class OtherDocumentsForm extends StatefulWidget {
  const OtherDocumentsForm({super.key, required this.selectedPetNotifier});

  final ValueNotifier<String?> selectedPetNotifier;

  @override
  State<OtherDocumentsForm> createState() => _OtherDocumentsFormState();
}

class _OtherDocumentsFormState extends State<OtherDocumentsForm>
    with AutomaticKeepAliveClientMixin<OtherDocumentsForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  final _documentTitleController = TextEditingController();
  final ValueNotifier<String?> _selectedIssuedBy = ValueNotifier(null);
  final _documentDateController = TextEditingController();
  final _documentLinkController = TextEditingController();
  final _notesController = TextEditingController();
  final DocumentUploadService _documentUploadService =
      getIt<DocumentUploadService>();
  static const bool _enableRetryForFailedUploads = true;

  final List<String> _issuedByList = const <String>[
    'insurance',
    'government',
    'clinic',
    'laboratory',
    'other',
  ];

  DateTime? _issuedOn;
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
    _documentTitleController.addListener(_refreshSubmitState);
    _documentDateController.addListener(_refreshSubmitState);
    _documentLinkController.addListener(_refreshSubmitState);
    _notesController.addListener(_refreshSubmitState);
    _selectedIssuedBy.addListener(_refreshSubmitState);
    widget.selectedPetNotifier.addListener(_refreshSubmitState);
  }

  @override
  void dispose() {
    _documentTitleController.removeListener(_refreshSubmitState);
    _documentDateController.removeListener(_refreshSubmitState);
    _documentLinkController.removeListener(_refreshSubmitState);
    _notesController.removeListener(_refreshSubmitState);
    _selectedIssuedBy.removeListener(_refreshSubmitState);
    widget.selectedPetNotifier.removeListener(_refreshSubmitState);
    _scrollController.dispose();
    _documentTitleController.dispose();
    _selectedIssuedBy.dispose();
    _documentDateController.dispose();
    _documentLinkController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    await AppDatePicker.show(
      context: context,
      initialDate: _issuedOn,
      currentDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      onDateConfirmed: (date, _) {
        if (date == null) return;
        setState(() {
          _issuedOn = date;
          _documentDateController.text =
              '${date.day}-${date.month}-${date.year}';
        });
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final petId = widget.selectedPetNotifier.value;
    final selected = selectedFiles ?? const <File>[];
    final hasFileUpload = selected.isNotEmpty;
    final hasDocumentLink = _documentLinkController.text.trim().isNotEmpty;

    if (petId == null || _issuedOn == null || _selectedIssuedBy.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete required fields.')),
      );
      return;
    }

    if (!hasFileUpload && !hasDocumentLink) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload a file or paste a document link.'),
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
        type: 'other_documents',
        payload: <String, dynamic>{
          'petId': petId,
          'title': _documentTitleController.text.trim(),
          'customDocumentType': 'other',
          'documentDate': _issuedOn!.toIso8601String().split('T').first,
          'issuedBy': _selectedIssuedBy.value,
          'description': _notesController.text.trim(),
          'documentUrls': _buildDocumentUrls(),
        },
      ),
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
    return _validateDocumentUrl(_documentLinkController.text) == null;
  }

  List<Map<String, dynamic>> _buildDocumentUrls() {
    final urls = _documentUploadService.buildUploadedDocumentEntries(
      selectedFiles: selectedFiles ?? <File>[],
      uploadedFilesByPath: _uploadedDocumentsByPath,
    );

    final manualUrl = _documentLinkController.text.trim();
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
                  label: 'Document Title',
                  controller: _documentTitleController,
                  isMandatory: true,
                ),
                AppSpacing.s25.hBox,
                AppTextField(
                  label: 'Select Date',
                  controller: _documentDateController,
                  isReadOnly: true,
                  isMandatory: true,
                  onPressed: _pickDate,
                  suffixWidget: AppIcon(
                    AppIcons.svg.generic.calendar,
                    size: AppIconSize.is16,
                  ),
                ),
                AppSpacing.s25.hBox,
                AppDropdowns<String>(
                  items: _issuedByList
                      .map(
                        (item) => DropdownItem<String>(
                          value: item,
                          height: AppSpacing.s40.h,
                          child: Text(item),
                        ),
                      )
                      .toList(growable: false),
                  valueListenable: _selectedIssuedBy,
                  isExpanded: true,
                  isMandatory: true,
                  hint: AppText.bodyM(
                    'Issues by source',
                    color: AppColors.textFieldLabelDefault,
                  ),
                  onChanged: (v) => _selectedIssuedBy.value = v,
                ),
                AppSpacing.s25.hBox,
                AppTextField(
                  label: 'Notes',
                  controller: _notesController,
                  isMandatory: true,
                ),
                AppSpacing.s25.hBox,
                AppTextField(
                  label: 'Paste document link here',
                  controller: _documentLinkController,
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
            _documentTitleController.text.trim().isEmpty ||
            _documentDateController.text.trim().isEmpty ||
            _selectedIssuedBy.value == null ||
            _notesController.text.trim().isEmpty ||
            !_isDocumentUrlValidOrEmpty() ||
            (selectedFiles == null || selectedFiles!.isEmpty) &&
                _documentLinkController.text.trim().isEmpty,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

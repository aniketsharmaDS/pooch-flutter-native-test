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
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_bloc.dart';

class PreviousVacinationForm extends StatefulWidget {
  const PreviousVacinationForm({super.key, required this.selectedPetNotifier});

  final ValueNotifier<String?> selectedPetNotifier;

  @override
  State<PreviousVacinationForm> createState() => _PreviousVacinationFormState();
}

class _PreviousVacinationFormState extends State<PreviousVacinationForm>
    with AutomaticKeepAliveClientMixin<PreviousVacinationForm> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  final _clinicController = TextEditingController();
  final _dateController = TextEditingController();
  final _externalLinkController = TextEditingController();

  final ValueNotifier<String?> _selectedVaccinationType = ValueNotifier(null);
  final DocumentUploadService _documentUploadService =
      getIt<DocumentUploadService>();
  static const bool _enableRetryForFailedUploads = true;

  DateTime? _vaccinationDate;
  List<File>? selectedFiles;
  bool _isUploadingDocuments = false;
  final Map<String, UploadedDocumentFile> _uploadedDocumentsByPath =
      <String, UploadedDocumentFile>{}; // key: local path

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
    _externalLinkController.addListener(_refreshSubmitState);
    _selectedVaccinationType.addListener(_refreshSubmitState);
    widget.selectedPetNotifier.addListener(_refreshSubmitState);
  }

  @override
  void dispose() {
    _clinicController.removeListener(_refreshSubmitState);
    _dateController.removeListener(_refreshSubmitState);
    _externalLinkController.removeListener(_refreshSubmitState);
    _selectedVaccinationType.removeListener(_refreshSubmitState);
    widget.selectedPetNotifier.removeListener(_refreshSubmitState);
    _scrollController.dispose();
    _clinicController.dispose();
    _dateController.dispose();
    _externalLinkController.dispose();
    _selectedVaccinationType.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _buildDocumentUrls() {
    final urls = _documentUploadService.buildUploadedDocumentEntries(
      selectedFiles: selectedFiles ?? <File>[],
      uploadedFilesByPath: _uploadedDocumentsByPath,
    );

    final manualUrl = _externalLinkController.text.trim();
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

      // Keep upload state only for currently selected files.
      final selectedPaths = files.map((f) => f.path).toSet();
      _uploadedDocumentsByPath.removeWhere(
        (path, _) => !selectedPaths.contains(path),
      );
    });
  }

  Future<void> _pickDate({
    required DateTime? initialDate,
    required ValueChanged<DateTime> onSelected,
  }) async {
    await AppDatePicker.show(
      context: context,
      initialDate: initialDate,
      currentDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      onDateConfirmed: (date, _) {
        if (date == null) return;
        onSelected(date);
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
    return _validateDocumentUrl(_externalLinkController.text) == null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final petId = widget.selectedPetNotifier.value;
    final vaccinationName = _selectedVaccinationType.value;
    final selected = selectedFiles ?? const <File>[];

    if (petId == null || vaccinationName == null || _vaccinationDate == null) {
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
          purpose: UploadPurpose.vaccination,
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

    final documentUrls = _buildDocumentUrls();

    context.read<MedicalHistoryFormBloc>().add(
      SaveMedicalHistoryRecordRequested(
        type: 'previous_vaccinations',
        payload: <String, dynamic>{
          'petId': petId,
          'vaccinationName': vaccinationName,
          'vaccinationDate': _vaccinationDate!
              .toIso8601String()
              .split('T')
              .first,
          'otherClinicName': _clinicController.text.trim(),
          'documentUrls': documentUrls,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MedicalHistoryFormBloc, MedicalHistoryFormState>(
      builder: (context, state) {
        final pets = context.watch<UserProfileBloc>().state.pets;
        String species = '';
        final selectedPet = widget.selectedPetNotifier.value ?? '';
        for (final pet in pets) {
          if (pet.id == selectedPet) {
            species = pet.type.toUpperCase();
            break;
          }
        }

        final vaccinationTypes = species.isEmpty
            ? state.vaccinationTypes
            : state.vaccinationTypes
                  .where((v) => v.species == 'BOTH' || v.species == species)
                  .toList(growable: false);

        final vaccinationItems = vaccinationTypes
            .map(
              (item) => DropdownItem<String>(
                value: item.vaccineCode,
                height: AppSpacing.s40.h,
                child: Text(item.vaccineName),
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
                      onPetChanged: (_) =>
                          _selectedVaccinationType.value = null,
                    ),
                    AppSpacing.s25.hBox,
                    AppDropdowns<String>(
                      items: vaccinationItems,
                      valueListenable: _selectedVaccinationType,
                      isExpanded: true,
                      isSearchable: true,
                      isMandatory: true,
                      hint: AppText.bodyM(
                        'Vaccination Type',
                        color: AppColors.textFieldLabelDefault,
                      ),
                      onChanged: (v) => _selectedVaccinationType.value = v,
                    ),
                    AppSpacing.s25.hBox,
                    AppTextField(
                      label: 'Clinic Name',
                      controller: _clinicController,
                      isMandatory: true,
                    ),
                    AppSpacing.s25.hBox,
                    AppTextField(
                      label: 'Vaccination Date',
                      controller: _dateController,
                      isReadOnly: true,
                      isMandatory: true,
                      onPressed: () => _pickDate(
                        initialDate: _vaccinationDate,
                        onSelected: (date) {
                          setState(() {
                            _vaccinationDate = date;
                            _dateController.text =
                                '${date.day}-${date.month}-${date.year}';
                          });
                        },
                      ),
                      suffixWidget: AppIcon(
                        AppIcons.svg.generic.calendar,
                        size: AppIconSize.is16,
                      ),
                    ),
                    AppSpacing.s25.hBox,
                    AppTextField(
                      label: 'Enter Link',
                      controller: _externalLinkController,
                      keyboardType: TextInputType.url,
                      validator: _validateDocumentUrl,
                    ),
                    AppSpacing.s25.hBox,
                    UploadDocumentWidget(
                      showHeader: true,
                      uploadedSectionTitle: 'Uploaded Documents',
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
                vaccinationItems.isEmpty ||
                pets.isEmpty ||
                selectedPet.isEmpty ||
                _selectedVaccinationType.value == null ||
                _clinicController.text.trim().isEmpty ||
                _dateController.text.trim().isEmpty ||
                !_isDocumentUrlValidOrEmpty(),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/services/document_upload_service.dart';
import 'package:poochcare/core/services/s3_upload_path_builder.dart';
import 'package:poochcare/core/theme/app_colors.dart';
import 'package:poochcare/core/theme/app_font_size.dart';
import 'package:poochcare/core/theme/app_radius_size.dart';
import 'package:poochcare/core/theme/app_spacing.dart';
import 'package:poochcare/core/widgets/appbar/pooch_screen_app_bar.dart';
import 'package:poochcare/core/widgets/buttons/app_button.dart';
import 'package:poochcare/core/widgets/dropdowns/app_dropdowns.dart';
import 'package:poochcare/core/widgets/feedback/app_snack_bar.dart';
import 'package:poochcare/core/widgets/images/app_image_picker_boxes/app_image_picker_boxes.dart';
import 'package:poochcare/core/widgets/others/upload_document_widget.dart';
import 'package:poochcare/core/widgets/screen/app_primary_bg_container.dart';
import 'package:poochcare/core/widgets/texts/app_search_field.dart';
import 'package:poochcare/core/widgets/texts/app_text.dart';
import 'package:poochcare/core/widgets/texts/app_text_field.dart';
import 'package:poochcare/features/insight/data/models/find_vet_form.dart';
import 'package:poochcare/features/insight/data/models/symptom_response.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/features/insight/presentation/bloc/report_symptoms_bloc/report_symptoms_bloc.dart';
import 'package:poochcare/features/insight/presentation/bloc/report_symptoms_bloc/report_symptoms_state.dart';
import 'package:poochcare/router/app_router.dart';

class Specialist extends Equatable {
  final String id;
  final String title;

  const Specialist({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}

@RoutePage()
class FindVetClinicsScreen extends StatefulWidget {
  final SymptomType? initialSymptoms;

  const FindVetClinicsScreen({super.key, this.initialSymptoms});

  @override
  State<FindVetClinicsScreen> createState() => _FindVetClinicsScreenState();
}

class _FindVetClinicsScreenState extends State<FindVetClinicsScreen> {
  final TextEditingController _searchController = TextEditingController();

  final TextEditingController _currentMedication = TextEditingController();

  final TextEditingController _additionalNotes = TextEditingController();

  final List<String> _symptomDurations = [
    'Less than a week',
    '2 weeks',
    '1 month',
    'More than a month',
  ];
  String? _selectedSpecialist;
  late ValueNotifier<List<SymptomType>> _selectedSymptoms;
  late ValueNotifier<String?> _selectedDuration;
  List<File?> _uploadedPhotos = [];
  List<File?> _uploadedDocuments = [];
  bool isUpladoing = false;

  @override
  void initState() {
    super.initState();
    getIt<ClinicBloc>().add(const ResetFindVetForm());
    _selectedSymptoms = widget.initialSymptoms != null
        ? ValueNotifier<List<SymptomType>>([widget.initialSymptoms!])
        : ValueNotifier<List<SymptomType>>([]);
    _selectedDuration = ValueNotifier<String?>(null);
    context.read<ClinicBloc>().add(const FetchFilterOptions());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _currentMedication.dispose();
    _additionalNotes.dispose();
    _selectedSymptoms.dispose();
    _selectedDuration.dispose();
    try {
      getIt<ClinicBloc>().add(const ResetFindVetForm());
    } catch (e) {
      log('Error resetting find vet form on dispose: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPrimaryBgContainer(
        child: SafeArea(
          child: Column(
            children: [
              const PoochScreenAppBar(title: 'Find vet clinics'),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: AppSpacing.s10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16,
                      ),
                      child: AppSearchField(
                        controller: _searchController,
                        onChanged: (value) {},
                        onSubmitted: (value) {},
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16,
                      ),
                      child: Row(
                        children: [
                          AppText.h1(
                            'Select a Specialist',
                            fontSize: AppFontSize.fs16,
                          ),
                          AppText.h3('*', color: AppColors.textFieldHintFocus),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.s10),
                    BlocBuilder<ClinicBloc, ClinicState>(
                      builder: (context, state) {
                        final specializations =
                            state.filterOptions?.specializations ?? [];
                        return SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(
                              left: AppSpacing.s16,
                            ),
                            itemCount: specializations.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final specialist = specializations[index];
                              final isSelected =
                                  _selectedSpecialist == specialist;
                              return InkWell(
                                borderRadius: BorderRadius.circular(
                                  AppRadiusSize.r15,
                                ),
                                onTap: () {
                                  setState(() {
                                    if (_selectedSpecialist == specialist) {
                                      _selectedSpecialist = null;
                                    } else {
                                      _selectedSpecialist = specialist;
                                    }
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppFontSize.fs20,
                                  ),
                                  height: 50.h,
                                  // width: 120.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.p1_50
                                        : AppColors.white,
                                    borderRadius: BorderRadius.circular(
                                      AppRadiusSize.r15,
                                    ),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.p1
                                          : AppColors.transparent,
                                    ),
                                  ),
                                  margin: const EdgeInsets.only(
                                    right: AppSpacing.s7,
                                  ),
                                  child: AppText.h1(
                                    specialist,
                                    fontSize: AppFontSize.fs16,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.s30),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.s16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.h1(
                            'Describe the Symptoms (Optional)',
                            fontSize: AppFontSize.fs16,
                          ),
                          const SizedBox(height: AppSpacing.s10),
                          BlocProvider.value(
                            value: getIt<ReportSymptomsBloc>(),
                            child: BlocBuilder<ReportSymptomsBloc, ReportSymptomsState>(
                              builder: (context, state) {
                                final symptoms =
                                    state.symptomResponse?.data?.symptomTypes ??
                                    [];
                                return AppDropdowns(
                                  selectedItemBuilder: (context) {
                                    return symptoms.map((item) {
                                      return ValueListenableBuilder<
                                        List<SymptomType>
                                      >(
                                        valueListenable: _selectedSymptoms,
                                        builder: (context, multiValue, _) {
                                          return Container(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: Text(
                                              multiValue
                                                  .where(
                                                    (item) =>
                                                        item.title != 'All',
                                                  )
                                                  .map((e) => e.title)
                                                  .join(', '),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              maxLines: 1,
                                            ),
                                          );
                                        },
                                      );
                                    }).toList();
                                  },
                                  onChanged: (value) {
                                    if (value != null) {
                                      final multiValue =
                                          _selectedSymptoms.value;
                                      final isSelected = multiValue.contains(
                                        value,
                                      );
                                      // if (value == 'All') {
                                      //   isSelected
                                      //       ? _selectedSymptoms.value = []
                                      //       : _selectedSymptoms.value =
                                      //             List.from(symptoms);
                                      // } else {
                                      _selectedSymptoms.value = isSelected
                                          ? ([...multiValue]..remove(value))
                                          : [...multiValue, value];
                                      // }
                                    }
                                  },
                                  multiValueListenable: _selectedSymptoms,

                                  isExpanded: true,
                                  hint: AppText.bodyS('Primary Symptom'),
                                  items: List.generate(symptoms.length, (
                                    index,
                                  ) {
                                    final symptom = symptoms[index];
                                    return DropdownItem(
                                      value: symptom,
                                      height: 40,
                                      closeOnTap: false,

                                      child:
                                          ValueListenableBuilder<
                                            List<SymptomType>
                                          >(
                                            valueListenable: _selectedSymptoms,
                                            builder: (context, multiValue, _) {
                                              final isSelected = multiValue
                                                  .contains(symptom);
                                              return Container(
                                                height: double.infinity,
                                                padding: const EdgeInsets.only(
                                                  right: 16.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: AppText.bodyS(
                                                        symptom.title,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 16),

                                                    if (isSelected)
                                                      const Icon(
                                                        Icons
                                                            .check_box_outlined,
                                                      )
                                                    else
                                                      const Icon(
                                                        Icons
                                                            .check_box_outline_blank,
                                                      ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: AppSpacing.s15),

                          AppDropdowns(
                            onChanged: (value) {
                              if (value != null) {
                                _selectedDuration.value = value;
                              }
                            },
                            valueListenable: _selectedDuration,
                            isExpanded: true,

                            hint: AppText.bodyS('Symptom Duration'),
                            items: List.generate(_symptomDurations.length, (
                              index,
                            ) {
                              final symptomDuration = _symptomDurations[index];
                              return DropdownItem(
                                value: symptomDuration,
                                child: AppText.bodyS(symptomDuration),
                              );
                            }),
                          ),
                          const SizedBox(height: AppSpacing.s15),
                          AppTextField(
                            label: 'Current Medication (if any)',
                            controller: _currentMedication,
                          ),
                          const SizedBox(height: AppSpacing.s15),

                          AppTextField(
                            label: 'Additional Notes',
                            controller: _additionalNotes,
                            isTextArea: true,
                            height: 100.h,
                          ),
                          const SizedBox(height: AppSpacing.s30),
                          AppText.h1(
                            'Add Photos (Optional)',
                            fontSize: AppFontSize.fs16,
                          ),
                          const SizedBox(height: AppSpacing.s10),

                          AppImagePickerBoxes(
                            onChanged: (value) {
                              _uploadedPhotos = value;
                            },
                          ),
                          const SizedBox(height: AppSpacing.s30),
                          UploadDocumentWidget(
                            headerText: 'Add Pet Documents',
                            showHeader: true,
                            buttonText: 'Upload',
                            description:
                                'Upload medical reports, prescriptions and vaccination certificates.',
                            maxSizeLabel: 'Max 5MB',
                            onFilesChanged: _onFilesChanged,
                          ),
                          const SizedBox(height: AppSpacing.s40),
                          AppButton(
                            isLoading: isUpladoing,
                            label: 'Find A Vet Clinic',
                            size: AppButtonSize.medium,
                            onPressed: () async {
                              try {
                                // 1. Upload files first
                                setState(() {
                                  isUpladoing = true;
                                });
                                final uploadedDocs = await _uploadAttachments();
                                final uploadedDocuments = mapUploadedDocs(
                                  uploadedDocs,
                                );
                                // 2. Build form with uploaded file results
                                final formData = FindVetForm(
                                  additionalNotes: _additionalNotes.text.trim(),
                                  currentMedication: _currentMedication.text
                                      .trim(),
                                  duration: _selectedDuration.value ?? '',
                                  symptoms: _selectedSymptoms.value
                                      .map((e) => e.title)
                                      .toList(),
                                  uploadedDocuments: uploadedDocuments,
                                );
                                // 3. Submit to bloc
                                if (!context.mounted) return;
                                context.read<ClinicBloc>().add(
                                  SubmitFindVetForm(formData),
                                );
                                // 4. Navigate
                                context.router.push(
                                  ClinicsListingRoute(
                                    selectedSpecialist: _selectedSpecialist,
                                  ),
                                );
                              } catch (e) {
                                debugPrint('Upload/Submit failed: $e');
                                // optionally show snackbar/toast
                                AppSnackBar.show(
                                  'Failed to submit form. Please try again.',
                                  type: SnackbarType.success,
                                );
                              } finally {
                                setState(() {
                                  isUpladoing = false;
                                });
                              }

                              // final formData = FindVetForm(
                              //   additionalNotes: _additionalNotes.text.trim(),
                              //   currentMedication: _currentMedication.text
                              //       .trim(),
                              //   duration: _selectedDuration.value ?? '',
                              //   symptoms: _selectedSymptoms.value,
                              //   uploadedDocuments: _uploadedDocuments
                              //       .whereType<File>()
                              //       .map((file) => file.path)
                              //       .toList(),
                              //   uploadedPhotos: _uploadedPhotos
                              //       .whereType<File>()
                              //       .map((file) => file.path)
                              //       .toList(),
                              // );
                              // context.read<ClinicBloc>().add(
                              //   SubmitFindVetForm(formData),
                              // );
                              // context.router.push(
                              //   ClinicsListingRoute(
                              //     selectedSpecialist: _selectedSpecialist,
                              //   ),
                              // );
                            },
                          ),
                          const SizedBox(height: AppSpacing.s30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _uploadAttachments() async {
    final allFilese = [
      ..._uploadedPhotos.whereType<File>(),
      ..._uploadedDocuments.whereType<File>(),
    ];

    final uploadService = getIt<DocumentUploadService>();

    final uploadedFilesByPath = <String, UploadedDocumentFile>{};

    final result = await uploadService.processPendingUploadsForSave(
      context: context,
      ownerId: 'tip',
      entityType: UploadEntityType.findVets,
      purpose: UploadPurpose.otherDocuments,
      selectedFiles: allFilese,
      uploadedFilesByPath: uploadedFilesByPath,
      enableRetryForFailed: false, // 👈 keeps it simple
    );

    if (!result.shouldProceedWithSave) {
      throw Exception('Upload failed');
    }

    return uploadService.buildUploadedDocumentEntries(
      selectedFiles: allFilese,
      uploadedFilesByPath: uploadedFilesByPath,
    );
  }

  List<UploadedDocument> mapUploadedDocs(List<dynamic> response) {
    return response.map((e) {
      final map = e as Map<String, dynamic>;

      return UploadedDocument(
        id:
            map['url'] as String? ??
            '', // or generate UUID if backend doesn't provide id
        fileName: map['name'] as String? ?? '',
        url: map['url'] as String? ?? '',
        type: _getFileType(map['name'] as String? ?? ''),
        fileSize: (map['size'] ?? 0).toString(),
      );
    }).toList();
  }

  String _getFileType(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();

    switch (ext) {
      case 'png':
      case 'jpg':
      case 'jpeg':
        return 'image';
      case 'pdf':
        return 'pdf';
      case 'doc':
      case 'docx':
        return 'document';
      default:
        return 'file';
    }
  }

  void _onFilesChanged(List<File> files) {
    setState(() {
      _uploadedDocuments = files;
    });
  }
}

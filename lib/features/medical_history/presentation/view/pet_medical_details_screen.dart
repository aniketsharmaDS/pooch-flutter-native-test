// file: pet_medical_details_screen.dart

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/enums/medical_history_record_type_filter.dart';
import 'package:poochcare/core/utils/document_file_type_utils.dart';
import 'package:poochcare/core/widgets/list_items/medical_history_list_item_card.dart';
import 'package:poochcare/core/widgets/screen/app_primary_screen_container.dart';
import 'package:poochcare/features/medical_history/data/models/medical_details_response_model.dart';
import 'package:poochcare/features/medical_history/data/models/medical_record_details_response_model.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_details/medical_details_bloc.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_details/medical_details_event.dart';
import 'package:poochcare/features/medical_history/presentation/bloc/medical_details/medical_details_state.dart';

@RoutePage()
class PetMedicalDetailsScreen extends StatefulWidget
    implements AutoRouteWrapper {
  const PetMedicalDetailsScreen({
    super.key,
    required this.recordId,
    required this.appointmentId,
    required this.recordType,
  });

  final String recordId;
  final String appointmentId;
  final MedicalHistoryRecordTypeFilter recordType;

  @override
  State<PetMedicalDetailsScreen> createState() =>
      _PetMedicalDetailsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MedicalDetailsBloc>(),
      child: this,
    );
  }
}

class _PetMedicalDetailsScreenState extends State<PetMedicalDetailsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDetails();
    });
  }

  Future<void> _getDetails() async {
    if (widget.appointmentId.isNotEmpty) {
      log('Fetching details for appointmentId: ${widget.appointmentId}');
      log('Fetching details for recordId-1-: ${widget.recordId}');

      context.read<MedicalDetailsBloc>().add(
        FetchAppointmentDetailsEvent(appointmentId: widget.appointmentId),
      );
    }

    if (widget.recordId.isNotEmpty) {
      log('Fetching details for recordId-2-: ${widget.recordId}');

      context.read<MedicalDetailsBloc>().add(
        FetchMedicalRecordsDetailsEvent(medicalRecordId: widget.recordId),
      );
    }
  }

  Future<void> _onRefresh() async {
    await _getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MedicalDetailsBloc, MedicalDetailsState>(
      listenWhen: (prev, curr) =>
          prev.medicalDetailsData != curr.medicalDetailsData,
      listener: (context, state) {
        final data = state.medicalDetailsData;
        if (data != null &&
            data.medicalHistoryRecords.isNotEmpty &&
            widget.recordId.isEmpty) {
          context.read<MedicalDetailsBloc>().add(
            FetchMedicalRecordsDetailsEvent(
              medicalRecordId: data.medicalHistoryRecords.first.id,
            ),
          );
        }
      },
      builder: (context, state) {
        final MedicalDetailsData? medicalAppointmentData =
            state.medicalDetailsData;
        final MedicalRecordData? medicalRecordData = state.medicalRecordsData;

        // Screen title
        String screenTitle = '';

        if (medicalAppointmentData != null &&
            medicalAppointmentData.clinic.clinicName.isNotEmpty) {
          screenTitle = medicalAppointmentData.pet.name;
        }
        if (screenTitle.isEmpty &&
            medicalRecordData != null &&
            medicalRecordData.pet != null) {
          screenTitle = medicalRecordData.pet!.name;
        }
        if (screenTitle.isEmpty) {
          screenTitle = 'Medical Details';
        }

        final isLoading =
            state.detailsStatus == MedicalDetailsStatus.loading ||
            state.recordsStatus == MedicalRecordsStatus.loading;

        return AppPrimaryScreenContainer(
          title: screenTitle,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildContent(state, medicalAppointmentData, medicalRecordData),
        );
      },
    );
  }

  Widget _buildContent(
    MedicalDetailsState state,
    MedicalDetailsData? medicalAppointmentData,
    MedicalRecordData? medicalRecordData,
  ) {
    String detailsTitle = '';

    if (medicalAppointmentData != null) {
      detailsTitle = medicalAppointmentData.clinic.clinicName;
    } else if (detailsTitle.isEmpty && medicalRecordData != null) {
      detailsTitle = medicalRecordData.diagnosis ?? '';
    }

    String subTitle = '';
    if (medicalAppointmentData != null) {
      subTitle = 'Consultaion';
    } else if (medicalRecordData != null) {
      subTitle = medicalRecordData.otherClinicName;
    }

    String dateTime = '';
    if (medicalAppointmentData != null) {
      dateTime = medicalAppointmentData.appointmentDate;
    } else if (medicalRecordData != null) {
      dateTime = medicalRecordData.recordedDate ?? '';
      if (dateTime.isEmpty) {
        dateTime = medicalRecordData.consultationDate;
      }
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MedicalHistoryListItemCard(
              onItemClick: () {
                // No action on tap in details screen as of now
              },
              item: MedicalHistoryItem(
                title: _labelForRecordType(widget.recordType.apiValue),
                type: _itemTypeForRecordType(widget.recordType.apiValue),
                data: MedicalData(
                  recordId: widget.recordId,
                  appointmentId: widget.appointmentId,
                  title: detailsTitle,
                  subtitle: subTitle,
                  dateTime: dateTime,
                  documents: (medicalRecordData?.documentUrls ?? [])
                      .map(
                        (doc) => MedicalDocument(
                          fileName: doc.name,
                          fileSize: _formatDocumentSize(doc.size ?? ''),
                          fileType: getFileTypeSmart(
                            fileName: doc.name,
                            fileUrl: doc.url,
                          ).name,
                          url: doc.url,
                        ),
                      )
                      .toList(growable: false),
                ),
              ),
            ),
            const SizedBox(height: 600),
          ],
        ),
      ),
    );
  }

  String _labelForRecordType(String rawType) {
    final type = rawType.toLowerCase();
    if (type.contains('vacc')) {
      return 'Vaccination';
    }
    if (type.contains('lab')) {
      return 'Lab Report';
    }
    if (type.contains('document')) {
      return 'Other Documents';
    }
    if (type.contains('consult') || type.contains('diagnosis')) {
      return 'Consultation';
    }
    return 'Medical Record';
  }

  ItemType _itemTypeForRecordType(String rawType) {
    final type = rawType.toLowerCase();
    if (type.contains('vacc')) {
      return ItemType.vaccination;
    }
    if (type.contains('lab')) {
      return ItemType.labReport;
    }
    if (type.contains('consult') || type.contains('diagnosis')) {
      return ItemType.consultation;
    }
    return ItemType.prescription;
  }

  String _formatDocumentSize(String rawSize) {
    final size = int.tryParse(rawSize.trim());
    if (size == null || size <= 0) {
      return rawSize.trim().isEmpty ? ' ' : rawSize;
    }

    const kb = 1024;
    const mb = 1024 * 1024;

    if (size >= mb) {
      final value = size / mb;
      return '${value.toStringAsFixed(value >= 10 ? 1 : 2)} MB';
    }

    if (size >= kb) {
      final value = size / kb;
      return '${value.toStringAsFixed(value >= 10 ? 1 : 2)} KB';
    }

    return '$size B';
  }
}

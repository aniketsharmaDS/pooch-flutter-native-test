import 'package:equatable/equatable.dart';
import 'package:poochcare/features/appointments/data/models/appointments_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_details_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_subs_plans_response_model.dart';
import 'package:poochcare/features/insight/data/models/clinic_subs_preview_response_model.dart';
import 'package:poochcare/features/insight/data/models/find_vet_form.dart';

enum ClinicStatus { initial, loading, success, failure }

enum FilterStatus { initial, loading, success, failure }

enum ClinicDetailsStatus { initial, loading, success, failure }

enum ClinicPlanStatus { initial, loading, success, failure }

enum SubsPreviewStatus { initial, loading, success, failure }

enum AppointmentDetailsStatus { initial, loading, success, failure }

enum PopularClinicStatus { initial, loading, success, failure }

class ClinicState extends Equatable {
  final ClinicStatus status;
  final FilterStatus filterStatus;
  final ClinicDetailsStatus clinicDetailsStatus;
  final ClinicPlanStatus clinicPlanStatus;
  final PopularClinicStatus popularClinicStatus;
  final FindVetForm? findVetForm;
  final ClinicListResponseModel? clinicsData;
  final ClinicDetailsResponseModel? clinicDetailsData;
  final ClinicSubsPlansResponseModel? clinicPlanResponseData;
  final ClinicAvailableFiltersModel? filterOptions;
  final SubsPreviewStatus subsPreviewStatus;
  final ClinicSubsPreviewResponseModel? clinicSubsPreviewResponseData;
  final ClinicListResponseModel? popularClinicsData;
  final AppointmentDetailsStatus appointmentDetailsStatus;
  final AppointmentApiModel? appointmentDetails;
  final String? errorMessage;
  final String? successMessage;

  const ClinicState({
    this.status = ClinicStatus.initial,
    this.errorMessage = '',
    this.successMessage = '',
    this.findVetForm,
    this.clinicsData,
    this.clinicDetailsData,
    this.clinicPlanResponseData,
    this.filterOptions,
    this.filterStatus = FilterStatus.initial,
    this.clinicDetailsStatus = ClinicDetailsStatus.initial,
    this.clinicPlanStatus = ClinicPlanStatus.initial,
    this.subsPreviewStatus = SubsPreviewStatus.initial,
    this.clinicSubsPreviewResponseData,
    this.popularClinicStatus = PopularClinicStatus.initial,
    this.popularClinicsData,
    this.appointmentDetailsStatus = AppointmentDetailsStatus.initial,
    this.appointmentDetails,
  });

  ClinicState copyWith({
    ClinicStatus? status,
    String? errorMessage,
    String? successMessage,
    FindVetForm? findVetForm,
    ClinicListResponseModel? clinicsData,
    ClinicDetailsResponseModel? clinicDetailsData,
    ClinicSubsPlansResponseModel? clinicPlanResponseData,
    ClinicAvailableFiltersModel? filterOptions,
    FilterStatus? filterStatus,
    ClinicDetailsStatus? clinicDetailsStatus,
    ClinicPlanStatus? clinicPlanStatus,
    SubsPreviewStatus? subsPreviewStatus,
    ClinicSubsPreviewResponseModel? clinicSubsPreviewResponseData,
    PopularClinicStatus? popularClinicStatus,
    ClinicListResponseModel? popularClinicsData,
    AppointmentDetailsStatus? appointmentDetailsStatus,
    AppointmentApiModel? appointmentDetails,
  }) {
    return ClinicState(
      clinicDetailsStatus: clinicDetailsStatus ?? this.clinicDetailsStatus,
      filterStatus: filterStatus ?? this.filterStatus,
      filterOptions: filterOptions ?? this.filterOptions,
      status: status ?? this.status,
      errorMessage: errorMessage,
      successMessage: successMessage,
      clinicDetailsData: clinicDetailsData ?? this.clinicDetailsData,
      clinicsData: clinicsData,
      findVetForm: findVetForm ?? this.findVetForm,
      clinicPlanStatus: clinicPlanStatus ?? this.clinicPlanStatus,
      clinicPlanResponseData:
          clinicPlanResponseData ?? this.clinicPlanResponseData,
      subsPreviewStatus: subsPreviewStatus ?? this.subsPreviewStatus,
      clinicSubsPreviewResponseData:
          clinicSubsPreviewResponseData ?? this.clinicSubsPreviewResponseData,
      popularClinicStatus: popularClinicStatus ?? this.popularClinicStatus,
      popularClinicsData: popularClinicsData ?? this.popularClinicsData,
      appointmentDetailsStatus:
          appointmentDetailsStatus ?? this.appointmentDetailsStatus,
      appointmentDetails: appointmentDetails ?? this.appointmentDetails,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    successMessage,
    findVetForm,
    clinicDetailsData,
    clinicsData,
    filterOptions,
    filterStatus,
    clinicDetailsStatus,
    clinicPlanStatus,
    clinicPlanResponseData,
    subsPreviewStatus,
    clinicSubsPreviewResponseData,
    popularClinicStatus,
    popularClinicsData,
    appointmentDetailsStatus,
    appointmentDetails,
  ];
}

import 'package:equatable/equatable.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_request_model.dart';
import 'package:poochcare/features/insight/data/models/find_vet_form.dart';

enum ClinicType { popular, normal }

sealed class ClinicEvent extends Equatable {
  const ClinicEvent();

  @override
  List<Object?> get props => [];
}

class FetchClinicsEvent extends ClinicEvent {
  final ClinicListRequestModel clinicListRequestModel;
  final ClinicType clinicType;
  const FetchClinicsEvent({
    required this.clinicListRequestModel,
    this.clinicType = ClinicType.normal,
  });

  @override
  List<Object?> get props => [clinicListRequestModel, clinicType];
}

class SubmitFindVetForm extends ClinicEvent {
  final FindVetForm findVetForm;
  const SubmitFindVetForm(this.findVetForm);

  @override
  List<Object?> get props => [findVetForm];
}

class ResetFindVetForm extends ClinicEvent {
  const ResetFindVetForm();
}

class FetchFilterOptions extends ClinicEvent {
  const FetchFilterOptions();
}

class FetchClinicDetails extends ClinicEvent {
  final String clinicId;

  const FetchClinicDetails({required this.clinicId});

  @override
  List<Object?> get props => [clinicId];
}

class FetchPopularClinics extends ClinicEvent {
  const FetchPopularClinics({this.page = 1, this.limit = 10});

  final int page;
  final int limit;

  @override
  List<Object?> get props => [page, limit];
}

class FetchClinicPlans extends ClinicEvent {
  final String clinicId;
  final String petId;

  const FetchClinicPlans({required this.clinicId, required this.petId});

  @override
  List<Object?> get props => [clinicId, petId];
}

class FetchSubsPreview extends ClinicEvent {
  final String clinicId;
  final String petId;
  final String subscriptionPlanId;
  final String consultationType;
  final String promotionId;
  final String couponCode;

  const FetchSubsPreview({
    required this.clinicId,
    required this.petId,
    required this.subscriptionPlanId,
    this.consultationType = 'video_call',
    this.promotionId = '',
    this.couponCode = '',
  });

  @override
  List<Object?> get props => [
    clinicId,
    petId,
    subscriptionPlanId,
    consultationType,
    promotionId,
    couponCode,
  ];
}

class FetchAppointmentDetails extends ClinicEvent {
  final String appointmentId;

  const FetchAppointmentDetails({required this.appointmentId});

  @override
  List<Object?> get props => [appointmentId];
}

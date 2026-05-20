import 'package:dart_mappable/dart_mappable.dart';

part 'appointment_request_model.mapper.dart';

@MappableClass()
class AppointmentRequestModel with AppointmentRequestModelMappable {
  final String? petId;
  final String? clinicId;
  final String? appointmentDate;
  final String? appointmentTime;
  final String? consultationType;
  final String? chiefComplaint;
  final String? priority;
  final int? durationMinutes;
  final String? planId;
  final String? petName;
  final String? petImage;
  final String? petNotes;

  const AppointmentRequestModel({
    this.petId,
    this.clinicId,
    this.appointmentDate,
    this.appointmentTime,
    this.consultationType,
    this.chiefComplaint,
    this.priority,
    this.durationMinutes,
    this.planId,
    this.petName,
    this.petImage,
    this.petNotes,
  });
}

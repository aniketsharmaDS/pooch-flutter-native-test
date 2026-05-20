import 'package:equatable/equatable.dart';

sealed class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllAppointments extends AppointmentEvent {
  const FetchAllAppointments(this.page, this.isForceRefresh);

  final int? page;
  final bool isForceRefresh;

  @override
  List<Object?> get props => [page, isForceRefresh];
}

class FetchCalendarAppointments extends AppointmentEvent {
  const FetchCalendarAppointments({
    required this.selectedDate,
    required this.isForceRefresh,
  });

  final String selectedDate;
  final bool isForceRefresh;

  @override
  List<Object?> get props => [selectedDate, isForceRefresh];
}

class BookAppointment extends AppointmentEvent {
  const BookAppointment({
    required this.petId,
    required this.clinicId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.consultationType,
    required this.chiefComplaint,
    this.priority = 'normal',
    this.durationMinutes = 30,
    this.findPayload,
  });

  final String petId;
  final String clinicId;
  final String appointmentDate;
  final String appointmentTime;
  final String consultationType;
  final String chiefComplaint;
  final String priority;
  final int durationMinutes;
  final Map<String, dynamic>? findPayload;

  @override
  List<Object?> get props => [
    petId,
    clinicId,
    appointmentDate,
    appointmentTime,
    consultationType,
    chiefComplaint,
    priority,
    durationMinutes,
    findPayload,
  ];
}

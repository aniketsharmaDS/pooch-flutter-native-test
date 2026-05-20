import 'package:equatable/equatable.dart';
import 'package:poochcare/core/domain/models/appointment.dart';

sealed class AppointmentsStoreEvent extends Equatable {
  const AppointmentsStoreEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class AppointmentsRefreshed extends AppointmentsStoreEvent {
  const AppointmentsRefreshed(this.appointments);

  final List<Appointment> appointments;

  @override
  List<Object?> get props => <Object?>[appointments];
}

class AppointmentUpserted extends AppointmentsStoreEvent {
  const AppointmentUpserted(this.appointment);

  final Appointment appointment;

  @override
  List<Object?> get props => <Object?>[appointment];
}

class AppointmentsCleared extends AppointmentsStoreEvent {
  const AppointmentsCleared();
}

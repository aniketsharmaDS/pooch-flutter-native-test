import 'package:equatable/equatable.dart';
import 'package:poochcare/core/domain/models/appointment.dart';

class AppointmentsStoreState extends Equatable {
  const AppointmentsStoreState({
    this.appointmentsById = const <String, Appointment>{},
    this.appointmentIds = const <String>[],
  });

  final Map<String, Appointment> appointmentsById;
  final List<String> appointmentIds;

  AppointmentsStoreState copyWith({
    Map<String, Appointment>? appointmentsById,
    List<String>? appointmentIds,
  }) {
    return AppointmentsStoreState(
      appointmentsById: appointmentsById ?? this.appointmentsById,
      appointmentIds: appointmentIds ?? this.appointmentIds,
    );
  }

  @override
  List<Object?> get props => <Object?>[appointmentsById, appointmentIds];
}

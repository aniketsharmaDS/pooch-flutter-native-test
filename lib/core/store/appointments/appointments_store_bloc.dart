import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/domain/models/appointment.dart';
import 'package:poochcare/core/store/appointments/appointments_store_event.dart';
import 'package:poochcare/core/store/appointments/appointments_store_state.dart';

class AppointmentsStoreBloc
    extends Bloc<AppointmentsStoreEvent, AppointmentsStoreState> {
  AppointmentsStoreBloc() : super(const AppointmentsStoreState()) {
    on<AppointmentsRefreshed>(_onAppointmentsRefreshed);
    on<AppointmentUpserted>(_onAppointmentUpserted);
    on<AppointmentsCleared>(_onAppointmentsCleared);
  }

  void _onAppointmentsRefreshed(
    AppointmentsRefreshed event,
    Emitter<AppointmentsStoreState> emit,
  ) {
    final Map<String, Appointment> appointmentsById = {
      for (final Appointment a in event.appointments) a.id: a,
    };
    emit(
      state.copyWith(
        appointmentsById: appointmentsById,
        appointmentIds: appointmentsById.keys.toList(),
      ),
    );
  }

  void _onAppointmentUpserted(
    AppointmentUpserted event,
    Emitter<AppointmentsStoreState> emit,
  ) {
    final Map<String, Appointment> updated = Map<String, Appointment>.from(
      state.appointmentsById,
    );
    updated[event.appointment.id] = event.appointment;
    final List<String> ids = state.appointmentIds.contains(event.appointment.id)
        ? state.appointmentIds
        : [...state.appointmentIds, event.appointment.id];
    emit(state.copyWith(appointmentsById: updated, appointmentIds: ids));
  }
}

void _onAppointmentsCleared(
  AppointmentsCleared event,
  Emitter<AppointmentsStoreState> emit,
) {
  emit(const AppointmentsStoreState());
}

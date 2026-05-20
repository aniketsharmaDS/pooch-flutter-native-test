import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/insight/data/models/appointment_request_model.dart';

class AppointmentCubit extends Cubit<AppointmentRequestModel> {
  AppointmentCubit()
    : super(
        const AppointmentRequestModel(priority: 'normal', durationMinutes: 30),
      );

  /// Update pet details
  void updatePet({
    String? petId,
    String? petName,
    String? petImage,
    String? petNotes,
  }) {
    emit(
      state.copyWith(
        petId: petId ?? state.petId,
        petName: petName ?? state.petName,
        petImage: petImage ?? state.petImage,
        petNotes: petNotes ?? state.petNotes,
      ),
    );
  }

  /// Update clinic & plan
  /// Can be called separately also
  void updateClinic({String? clinicId, String? planId}) {
    emit(
      state.copyWith(
        clinicId: clinicId ?? state.clinicId,
        planId: planId ?? state.planId,
      ),
    );
  }

  /// Update appointment slot
  void updateAppointment({String? appointmentDate, String? appointmentTime}) {
    emit(
      state.copyWith(
        appointmentDate: appointmentDate ?? state.appointmentDate,
        appointmentTime: appointmentTime ?? state.appointmentTime,
      ),
    );
  }

  /// Update consultation details
  void updateConsultation({
    String? consultationType,
    String? chiefComplaint,
    String? priority,
    int? durationMinutes,
  }) {
    emit(
      state.copyWith(
        consultationType: consultationType ?? state.consultationType,
        chiefComplaint: chiefComplaint ?? state.chiefComplaint,
        priority: priority ?? state.priority,
        durationMinutes: durationMinutes ?? state.durationMinutes,
      ),
    );
  }

  /// Generic update
  /// Use this if you want to update any field from anywhere
  void update(AppointmentRequestModel data) {
    emit(
      state.copyWith(
        petId: data.petId ?? state.petId,
        petName: data.petName ?? state.petName,
        petImage: data.petImage ?? state.petImage,
        petNotes: data.petNotes ?? state.petNotes,
        clinicId: data.clinicId ?? state.clinicId,
        planId: data.planId ?? state.planId,
        appointmentDate: data.appointmentDate ?? state.appointmentDate,
        appointmentTime: data.appointmentTime ?? state.appointmentTime,
        consultationType: data.consultationType ?? state.consultationType,
        chiefComplaint: data.chiefComplaint ?? state.chiefComplaint,
        priority: data.priority ?? state.priority,
        durationMinutes: data.durationMinutes ?? state.durationMinutes,
      ),
    );
  }

  /// Get latest booking data
  AppointmentRequestModel get bookingData => state;

  /// Reset everything
  void reset() {
    emit(
      const AppointmentRequestModel(priority: 'normal', durationMinutes: 30),
    );
  }
}

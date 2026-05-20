import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/features/insight/data/models/clinic_list_response_model.dart';
import 'package:poochcare/features/insight/data/models/find_vet_form.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_event.dart';
import 'package:poochcare/features/insight/presentation/bloc/clinic_bloc/clinic_state.dart';
import 'package:poochcare/features/insight/repository/clinics_repository.dart';

class ClinicBloc extends Bloc<ClinicEvent, ClinicState> {
  final ClinicsRepository repository;

  ClinicBloc(this.repository) : super(const ClinicState()) {
    on<FetchClinicsEvent>(_onFetchClinics);
    on<SubmitFindVetForm>(_onSubmitFindVetForm);
    on<ResetFindVetForm>(onResetFindVetForm);
    on<FetchFilterOptions>(_onFetchFilterOptions);
    on<FetchClinicDetails>(_onFetchClinicDetails);
    on<FetchClinicPlans>(_onFetchClinicPlans);
    on<FetchSubsPreview>(_onFetchSubsPreview);
    on<FetchAppointmentDetails>(_onFetchAppointmentDetails);
    on<FetchPopularClinics>(_onFetchPopularClinics);
  }

  Future<void> _onFetchClinicDetails(
    FetchClinicDetails event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(clinicDetailsStatus: ClinicDetailsStatus.loading));

    try {
      final data = await repository.getClinicDetails(clinicId: event.clinicId);
      emit(
        state.copyWith(
          clinicDetailsStatus: ClinicDetailsStatus.success,
          clinicDetailsData: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          clinicDetailsStatus: ClinicDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchFilterOptions(
    FetchFilterOptions event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(filterStatus: FilterStatus.loading));

    try {
      final data = await repository.getFilterOptions();
      emit(
        state.copyWith(filterStatus: FilterStatus.success, filterOptions: data),
      );
    } catch (e) {
      emit(
        state.copyWith(
          filterStatus: FilterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchClinics(
    FetchClinicsEvent event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(status: ClinicStatus.loading));

    try {
      final data = event.clinicType == ClinicType.normal
          ? await repository.getAllClinics(
              request: event.clinicListRequestModel,
            )
          : await repository.getPopularClinics();

      final isLoadMore = event.clinicListRequestModel.page > 1;
      if (isLoadMore && state.clinicsData != null) {
        final merged = ClinicListResponseModel(
          clinics: [...state.clinicsData!.clinics, ...data.clinics],
          pagination: data.pagination,
          appliedFilters: data.appliedFilters,
          availableFilters: data.availableFilters,
        );

        emit(state.copyWith(status: ClinicStatus.success, clinicsData: merged));
      } else {
        emit(state.copyWith(status: ClinicStatus.success, clinicsData: data));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ClinicStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSubmitFindVetForm(
    SubmitFindVetForm event,
    Emitter<ClinicState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ClinicStatus.success,
        findVetForm: event.findVetForm,
      ),
    );
  }

  Future<void> onResetFindVetForm(
    ResetFindVetForm event,
    Emitter<ClinicState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ClinicStatus.success,
        findVetForm: const FindVetForm(), // 👈 RESET HERE
      ),
    );
  }

  Future<void> _onFetchClinicPlans(
    FetchClinicPlans event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(clinicPlanStatus: ClinicPlanStatus.loading));

    try {
      final data = await repository.getClinicPlans(
        clinicId: event.clinicId,
        petId: event.petId,
      );
      emit(
        state.copyWith(
          clinicPlanStatus: ClinicPlanStatus.success,
          clinicPlanResponseData: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          clinicPlanStatus: ClinicPlanStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchSubsPreview(
    FetchSubsPreview event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(subsPreviewStatus: SubsPreviewStatus.loading));

    try {
      final data = await repository.getSubsPreview(
        clinicId: event.clinicId,
        petId: event.petId,
        subscriptionPlanId: event.subscriptionPlanId,
        consultationType: event.consultationType,
        promotionId: event.promotionId,
        couponCode: event.couponCode,
      );
      emit(
        state.copyWith(
          subsPreviewStatus: SubsPreviewStatus.success,
          clinicSubsPreviewResponseData: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          subsPreviewStatus: SubsPreviewStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchAppointmentDetails(
    FetchAppointmentDetails event,
    Emitter<ClinicState> emit,
  ) async {
    emit(
      state.copyWith(
        appointmentDetailsStatus: AppointmentDetailsStatus.loading,
      ),
    );

    try {
      final data = await repository.getAppointmentDetails(
        appointmentId: event.appointmentId,
      );
      emit(
        state.copyWith(
          appointmentDetailsStatus: AppointmentDetailsStatus.success,
          appointmentDetails: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          appointmentDetailsStatus: AppointmentDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchPopularClinics(
    FetchPopularClinics event,
    Emitter<ClinicState> emit,
  ) async {
    emit(state.copyWith(popularClinicStatus: PopularClinicStatus.loading));

    try {
      final data = await repository.getPopularClinics(
        page: event.page,
        limit: event.limit,
      );
      emit(
        state.copyWith(
          popularClinicStatus: PopularClinicStatus.success,
          popularClinicsData: data,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          popularClinicStatus: PopularClinicStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

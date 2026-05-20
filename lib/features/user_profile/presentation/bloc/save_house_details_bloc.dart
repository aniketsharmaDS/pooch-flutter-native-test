import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/save_house_details_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/save_house_details_state.dart';
import 'package:poochcare/features/user_profile/repository/user_profile_repository.dart';

class SaveHouseDetailsBloc
    extends Bloc<SaveHouseDetailsEvent, SaveHouseDetailsState> {
  SaveHouseDetailsBloc({required UserProfileRepository repository})
    : _repository = repository,
      super(const SaveHouseDetailsState()) {
    on<SaveHouseDetailsStarted>(_onStarted);
    on<SaveHouseDetailsSubmitted>(_onSubmitted);
  }

  final UserProfileRepository _repository;

  void _onStarted(
    SaveHouseDetailsStarted event,
    Emitter<SaveHouseDetailsState> emit,
  ) {
    emit(
      state.copyWith(status: SaveHouseDetailsStatus.initial, clearError: true),
    );
  }

  Future<void> _onSubmitted(
    SaveHouseDetailsSubmitted event,
    Emitter<SaveHouseDetailsState> emit,
  ) async {
    emit(
      state.copyWith(status: SaveHouseDetailsStatus.loading, clearError: true),
    );

    try {
      final result = await _repository.saveHouseDetails(
        parentName: event.parentName,
        houseName: event.houseName,
        relation: event.relation,
        isMultiplePets: event.isMultiplePets,
      );

      emit(
        state.copyWith(status: SaveHouseDetailsStatus.success, data: result),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: SaveHouseDetailsStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SaveHouseDetailsStatus.failure,
          errorMessage: 'Unable to save details. Please try again.',
        ),
      );
    }
  }
}

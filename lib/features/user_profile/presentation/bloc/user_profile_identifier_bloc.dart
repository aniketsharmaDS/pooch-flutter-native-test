import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/errors/api_exception.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_event.dart';
import 'package:poochcare/features/user_profile/presentation/bloc/user_profile_identifier_state.dart';
import 'package:poochcare/features/user_profile/repository/user_profile_repository.dart';

class UserProfileIdentifierBloc
    extends Bloc<UserProfileIdentifierEvent, UserProfileIdentifierState> {
  UserProfileIdentifierBloc({required UserProfileRepository repository})
    : _repository = repository,
      super(const UserProfileIdentifierState()) {
    on<UserProfileIdentifierStarted>(_onStarted);
    on<UserProfileIdentifierOtpRequested>(_onOtpRequested);
  }

  final UserProfileRepository _repository;

  void _onStarted(
    UserProfileIdentifierStarted event,
    Emitter<UserProfileIdentifierState> emit,
  ) {
    emit(
      state.copyWith(
        status: UserProfileIdentifierStatus.initial,
        clearError: true,
        clearData: true,
      ),
    );
  }

  Future<void> _onOtpRequested(
    UserProfileIdentifierOtpRequested event,
    Emitter<UserProfileIdentifierState> emit,
  ) async {
    emit(
      state.copyWith(
        status: UserProfileIdentifierStatus.loading,
        clearError: true,
      ),
    );

    try {
      final result = await _repository.sendOtpForIdentifier(
        countryCode: event.countryCode,
        newEmail: event.newEmail,
        newPhone: event.newPhone,
      );
      emit(
        state.copyWith(
          status: UserProfileIdentifierStatus.success,
          result: result,
        ),
      );
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: UserProfileIdentifierStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: UserProfileIdentifierStatus.failure,
          errorMessage: 'Unable to send OTP. Please try again.',
        ),
      );
    }
  }
}

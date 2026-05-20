import 'package:equatable/equatable.dart';
import 'package:poochcare/features/user_profile/domain/models/identifier_otp_send_result.dart';

enum UserProfileIdentifierStatus { initial, loading, success, failure }

class UserProfileIdentifierState extends Equatable {
  const UserProfileIdentifierState({
    this.status = UserProfileIdentifierStatus.initial,
    this.result,
    this.errorMessage,
  });

  final UserProfileIdentifierStatus status;
  final IdentifierOtpSendResult? result;
  final String? errorMessage;

  UserProfileIdentifierState copyWith({
    UserProfileIdentifierStatus? status,
    IdentifierOtpSendResult? result,
    String? errorMessage,
    bool clearError = false,
    bool clearData = false,
  }) {
    return UserProfileIdentifierState(
      status: status ?? this.status,
      result: clearData ? null : (result ?? this.result),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[status, result, errorMessage];
}

import 'package:equatable/equatable.dart';

sealed class UserProfileIdentifierEvent extends Equatable {
  const UserProfileIdentifierEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class UserProfileIdentifierStarted extends UserProfileIdentifierEvent {
  const UserProfileIdentifierStarted();
}

class UserProfileIdentifierOtpRequested extends UserProfileIdentifierEvent {
  const UserProfileIdentifierOtpRequested({
    this.countryCode,
    this.newEmail,
    this.newPhone,
  });

  final String? countryCode;
  final String? newEmail;
  final String? newPhone;

  @override
  List<Object?> get props => <Object?>[countryCode, newEmail, newPhone];
}

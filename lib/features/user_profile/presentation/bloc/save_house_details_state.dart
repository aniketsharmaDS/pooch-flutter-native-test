import 'package:equatable/equatable.dart';
import 'package:poochcare/features/user_profile/domain/models/save_house_details.dart';

enum SaveHouseDetailsStatus { initial, loading, success, failure }

class SaveHouseDetailsState extends Equatable {
  const SaveHouseDetailsState({
    this.status = SaveHouseDetailsStatus.initial,
    this.data,
    this.errorMessage,
  });

  final SaveHouseDetailsStatus status;
  final SaveHouseDetails? data;
  final String? errorMessage;

  SaveHouseDetailsState copyWith({
    SaveHouseDetailsStatus? status,
    SaveHouseDetails? data,
    String? errorMessage,
    bool clearError = false,
    bool clearData = false,
  }) {
    return SaveHouseDetailsState(
      status: status ?? this.status,
      data: clearData ? null : (data ?? this.data),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[status, data, errorMessage];
}

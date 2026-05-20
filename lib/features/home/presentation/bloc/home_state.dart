import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  const HomeState({this.status = HomeStatus.initial, this.errorMessage});

  final HomeStatus status;
  final String? errorMessage;

  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[status, errorMessage];
}

import 'package:equatable/equatable.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class HomeDataRequested extends HomeEvent {
  const HomeDataRequested();
}

class ThemeToggleRequested extends HomeEvent {
  const ThemeToggleRequested();
}

class LogoutRequested extends HomeEvent {
  const LogoutRequested();
}

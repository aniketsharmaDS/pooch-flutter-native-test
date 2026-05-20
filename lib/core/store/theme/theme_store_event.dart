import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class ThemeStoreEvent extends Equatable {
  const ThemeStoreEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ThemeToggled extends ThemeStoreEvent {
  const ThemeToggled();
}

class ThemeModeSet extends ThemeStoreEvent {
  const ThemeModeSet(this.mode);

  final ThemeMode mode;

  @override
  List<Object?> get props => <Object?>[mode];
}

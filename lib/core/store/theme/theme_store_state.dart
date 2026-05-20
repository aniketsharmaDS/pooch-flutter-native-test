import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeStoreState extends Equatable {
  const ThemeStoreState({this.themeMode = ThemeMode.light});

  final ThemeMode themeMode;

  ThemeStoreState copyWith({ThemeMode? themeMode}) {
    return ThemeStoreState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object?> get props => <Object?>[themeMode];
}

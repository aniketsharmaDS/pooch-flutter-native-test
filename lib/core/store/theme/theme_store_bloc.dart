import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poochcare/core/store/theme/theme_store_event.dart';
import 'package:poochcare/core/store/theme/theme_store_state.dart';

class ThemeStoreBloc extends Bloc<ThemeStoreEvent, ThemeStoreState> {
  ThemeStoreBloc() : super(const ThemeStoreState()) {
    on<ThemeToggled>(_onThemeToggled);
    on<ThemeModeSet>(_onThemeModeSet);
  }

  void _onThemeToggled(ThemeToggled event, Emitter<ThemeStoreState> emit) {
    final ThemeMode next = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    emit(state.copyWith(themeMode: next));
  }

  void _onThemeModeSet(ThemeModeSet event, Emitter<ThemeStoreState> emit) {
    emit(state.copyWith(themeMode: event.mode));
  }
}

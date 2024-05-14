import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Packages
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeStateInitial());

  void toggleTheme() => emit(state.selectedTheme == AppTheme.light
      ? state.copyWith(selectedTheme: AppTheme.dark)
      : state.copyWith(selectedTheme: AppTheme.light),);

  void toggleToTheme(ThemeData theme) => emit(theme == state.lightThemeData
      ? state.copyWith(selectedTheme: AppTheme.light)
      : state.copyWith(selectedTheme: AppTheme.dark),);

  ThemeData currentThemeData() => state.selectedTheme == AppTheme.light
      ? state.lightThemeData
      : state.darkThemeData;

  @Deprecated('Use state.selectedTheme instead')
  String getTheme() => '${state.selectedTheme.name}Theme';

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    return json['theme'] == 'lightTheme'
        ? ThemeState()
        : ThemeState(selectedTheme: AppTheme.dark);
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return <String, String>{'theme': '${state.selectedTheme.name}Theme'};
  }
}

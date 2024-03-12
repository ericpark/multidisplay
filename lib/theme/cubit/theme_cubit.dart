import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  static ThemeData lightTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFC3EFF2),
    ),
    useMaterial3: true,
  );
  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true);

  bool get isLight => state == lightTheme;

  bool get isDark => state == darkTheme;

  void toggleTheme() {
    emit(state == lightTheme ? darkTheme : lightTheme);
  }

  void toggleToTheme(ThemeData theme) {
    emit(theme == lightTheme ? lightTheme : darkTheme);
  }

  String getTheme() {
    return state == lightTheme ? "lightTheme" : "darkTheme";
  }

  @override
  ThemeData fromJson(Map<String, dynamic> json) {
    return json['theme'] == "lightTheme" ? lightTheme : darkTheme;
  }

  @override
  Map<String, dynamic> toJson(ThemeData state) {
    return <String, String>{
      'theme': state == lightTheme ? "lightTheme" : "darkTheme"
    };
  }
}

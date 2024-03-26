import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

const primaryColor = Color(0xFFC3EFF2);
const secondaryColor = Color(0xFF6AD996);
const accentColor = Color.fromRGBO(217, 132, 106, 1);
const deepPrimaryColor = Color(0xFF6A8CD9);
const tealGreenColor = Color(0xFF6AD9BB);
const darkGreenColor = Color.fromARGB(255, 2, 145, 0);
const darkerBlueColor = Color(0xFF6C6AD9);

class ThemeCubit extends HydratedCubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  static ThemeData lightTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: deepPrimaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surfaceTint: tealGreenColor,
    ),
    useMaterial3: true,
  ).copyWith(scaffoldBackgroundColor: Colors.grey[50]);
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

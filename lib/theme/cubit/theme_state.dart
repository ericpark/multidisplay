part of 'theme_cubit.dart';

enum AppTheme { light, dark }

extension AppThemeX on AppTheme {
  bool get isLight => this == AppTheme.light;
  bool get isDark => this == AppTheme.dark;
}

class ThemeState extends Equatable {
  ThemeState({
    this.selectedTheme = AppTheme.light,
    ThemeData? lightThemeData,
    ThemeData? darkThemeData,
  })  : lightThemeData = lightThemeData ?? lightTheme,
        darkThemeData = darkThemeData ?? darkTheme;

  final AppTheme selectedTheme;
  final ThemeData lightThemeData;
  final ThemeData darkThemeData;

  static const primaryColor = Color(0xFFC3EFF2);
  static const secondaryColor = Color(0xFF6AD996);
  static const accentColor = Color(0xFFD9846A);
  static const deepPrimaryColor = Color(0xFF6A8CD9);
  static const tealGreenColor = Color(0xFF6AD9BB);
  static const darkGreenColor = Color(0xFF029100);
  static const darkerBlueColor = Color(0xFF6C6AD9);

  static ThemeData lightTheme = ThemeData.from(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: deepPrimaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
      surfaceTint: tealGreenColor,
    ),
    useMaterial3: true,
  ).copyWith(
      scaffoldBackgroundColor: Colors.grey[200],
      textTheme: GoogleFonts.courierPrimeTextTheme(ThemeData.light().textTheme),
      primaryTextTheme:
          GoogleFonts.courierPrimeTextTheme(ThemeData.light().primaryTextTheme),
      bottomNavigationBarTheme: ThemeData.light()
          .bottomNavigationBarTheme
          .copyWith(
              selectedItemColor: deepPrimaryColor,
              unselectedItemColor: Colors.grey,),);

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true);

  ThemeData get defaultLight => lightTheme;
  ThemeData get defaultDark => darkTheme;

  ThemeState copyWith({
    AppTheme? selectedTheme,
    ThemeData? lightThemeData,
    ThemeData? darkThemeData,
  }) {
    return ThemeState(
      selectedTheme: selectedTheme ?? this.selectedTheme,
      lightThemeData: lightThemeData ?? this.lightThemeData,
      darkThemeData: darkThemeData ?? this.darkThemeData,
    );
  }

  @override
  List<Object> get props => [selectedTheme, lightThemeData, darkThemeData];
}

final class ThemeStateInitial extends ThemeState {}

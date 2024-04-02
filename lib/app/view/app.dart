import 'package:flutter/material.dart';
// Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
// Repositories
import 'package:tracking_repository/tracking_repository.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
// Project
import 'package:multidisplay/app/app.dart';
import 'package:multidisplay/theme/theme.dart';
import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/expenses/expenses.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({
    required WeatherRepository weatherRepository,
    required CalendarRepository calendarRepository,
    required TrackingRepository trackingRepository,
    super.key,
    AdaptiveThemeMode? savedThemeMode,
  })  : _weatherRepository = weatherRepository,
        _calendarRepository = calendarRepository,
        _trackingRepository = trackingRepository,
        savedThemeMode = savedThemeMode ?? AdaptiveThemeMode.system;

  final WeatherRepository _weatherRepository;
  final CalendarRepository _calendarRepository;
  final TrackingRepository _trackingRepository;
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _weatherRepository),
          RepositoryProvider.value(value: _calendarRepository),
          RepositoryProvider.value(value: _trackingRepository),
        ],
        child: MultiBlocProvider(
          /// These Blocs are provided early to allow for settings page that
          /// changes the settings in each bloc. However, many of these could
          /// be moved down further in the tree.
          providers: [
            BlocProvider<AppBloc>(
              create: (BuildContext context) => AppBloc(),
            ),
            BlocProvider<ThemeCubit>(
              create: (BuildContext context) => ThemeCubit(),
            ),
            BlocProvider<CalendarCubit>(
              create: (BuildContext context) =>
                  CalendarCubit(context.read<CalendarRepository>())..init(),
            ),
            BlocProvider<TrackingCubit>(
              create: (BuildContext context) =>
                  TrackingCubit(context.read<TrackingRepository>())..init(),
            ),
            BlocProvider<TimerBloc>(
              create: (BuildContext context) =>
                  TimerBloc(ticker: const TimerTicker()),
            ),
            BlocProvider(
              create: (context) =>
                  WeatherCubit(context.read<WeatherRepository>()),
            ),
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
            BlocProvider(
              create: (context) => ExpensesCubit(),
            ),
          ],
          child: AppView(savedThemeMode: savedThemeMode),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, AdaptiveThemeMode? savedThemeMode})
      : savedThemeMode = savedThemeMode ?? AdaptiveThemeMode.system;

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final appState = context.watch<AppBloc>().state;
      final themeState = context.watch<ThemeCubit>().state;

      // if AdaptiveThemeMode.System then ThemeState should match
      AdaptiveThemeMode initial = savedThemeMode == AdaptiveThemeMode.system
          ? AdaptiveThemeMode.system
          // else, match AdaptiveTheme to ThemeState
          : themeState.selectedTheme == AppTheme.light
              ? AdaptiveThemeMode.light
              : AdaptiveThemeMode.dark;

      return AdaptiveTheme(
        light: themeState.lightThemeData,
        dark: themeState.darkThemeData,
        initial: initial,
        builder: (theme, darkTheme) {
          return MaterialApp(
            theme: theme,
            darkTheme: darkTheme,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: pages[appState.page],
              bottomNavigationBar: BottomNavigationBar(
                items: bottomTabs,
                currentIndex: appState.page,
                showUnselectedLabels: true,
                onTap: (index) =>
                    context.read<AppBloc>().add(AppPageChanged(page: index)),
              ),
            ),
          );
        },
      );
    });
  }
}

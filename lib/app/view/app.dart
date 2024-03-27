import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

import 'package:tracking_repository/tracking_repository.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';

import 'package:multidisplay/app/app.dart';
import 'package:multidisplay/theme/theme.dart';

import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:multidisplay/timer/timer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App(
      {required WeatherRepository weatherRepository,
      required CalendarRepository calendarRepository,
      required TrackingRepository trackingRepository,
      super.key,
      AdaptiveThemeMode? savedThemeMode})
      : _weatherRepository = weatherRepository,
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
                  TimerBloc(ticker: const Ticker()),
            ),
            BlocProvider(
              create: (context) =>
                  WeatherCubit(context.read<WeatherRepository>()),
            ),
            BlocProvider(
              create: (context) => HomeCubit(),
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
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        AppBloc appBloc = context.read<AppBloc>();

        return BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, selectedTheme) {
          return AdaptiveTheme(
            light: ThemeCubit.lightTheme,
            dark: ThemeCubit.darkTheme,
            initial: savedThemeMode ?? AdaptiveThemeMode.system,
            builder: (theme, darkTheme) {
              return MaterialApp(
                theme: theme,
                home: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: pages[appBloc.state.page],
                  bottomNavigationBar: BottomNavigationBar(
                    items: bottomTabs,
                    currentIndex: appState.page,
                    selectedItemColor: theme.primaryColor,
                    unselectedItemColor: Colors.grey,
                    showUnselectedLabels: true,
                    onTap: (index) => appBloc.add(AppPageChanged(page: index)),
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }
}

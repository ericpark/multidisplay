import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/app/app.dart';
import 'package:multidisplay/auth/auth.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:multidisplay/expenses/expenses.dart';
import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/theme/theme.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:tracking_repository/tracking_repository.dart';
import 'package:weather_repository/weather_repository.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({
    required WeatherRepository weatherRepository,
    required CalendarRepository calendarRepository,
    required TrackingRepository trackingRepository,
    required AuthRepository authRepository,
    super.key,
    AdaptiveThemeMode? savedThemeMode,
  })  : _weatherRepository = weatherRepository,
        _calendarRepository = calendarRepository,
        _trackingRepository = trackingRepository,
        _authRepository = authRepository,
        savedThemeMode = savedThemeMode ?? AdaptiveThemeMode.system;

  final WeatherRepository _weatherRepository;
  final CalendarRepository _calendarRepository;
  final TrackingRepository _trackingRepository;
  final AuthRepository _authRepository;
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    final deviceType = DeviceType.getDeviceFormFactor(context);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _weatherRepository),
        RepositoryProvider.value(value: _calendarRepository),
        RepositoryProvider.value(value: _trackingRepository),
        RepositoryProvider.value(value: _authRepository),
      ],
      child: MultiBlocProvider(
        /// These Blocs are provided early to allow for settings page that
        /// changes the settings in each bloc. However, many of these could
        /// be moved down further in the tree.
        providers: [
          BlocProvider<AppBloc>(
            create: (BuildContext context) => AppBloc(deviceType: deviceType),
          ),
          BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(),
          ),
          BlocProvider<CalendarCubit>(
            create: (BuildContext context) =>
                CalendarCubit(context.read<CalendarRepository>())
                  ..init()
                  ..toggleCalendarView(
                    view: deviceType == FormFactor.mobile
                        ? CalendarView.month
                        : CalendarView.all,
                  ),
          ),
          BlocProvider<TrackingCubit>(
            create: (BuildContext context) =>
                TrackingCubit(context.read<TrackingRepository>()),
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
            create: (context) =>
                AuthCubit(context.read<AuthRepository>())..init(),
          ),
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(
            create: (context) => ExpensesCubit(),
          ),
        ],
        child: AppView(savedThemeMode: savedThemeMode),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key, AdaptiveThemeMode? savedThemeMode})
      : savedThemeMode = savedThemeMode ?? AdaptiveThemeMode.system;

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final appState = context.watch<AppBloc>().state;
        final themeState = context.watch<ThemeCubit>().state;

        // if AdaptiveThemeMode.System then ThemeState should match
        final initial = savedThemeMode == AdaptiveThemeMode.system
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
      },
    );
  }
}

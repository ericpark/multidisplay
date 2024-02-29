import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_repository/weather_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';

import 'package:multidisplay/app/app.dart';
import 'package:multidisplay/theme/theme.dart';

import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:multidisplay/expenses/expenses_page.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:multidisplay/settings/settings.dart';
import 'package:multidisplay/timer/timer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App(
      {required WeatherRepository weatherRepository,
      required CalendarRepository calendarRepository,
      super.key})
      : _weatherRepository = weatherRepository,
        _calendarRepository = calendarRepository;

  final WeatherRepository _weatherRepository;
  final CalendarRepository _calendarRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: _weatherRepository),
          RepositoryProvider.value(value: _calendarRepository),
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
                  CalendarCubit(context.read<CalendarRepository>()),
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
          child: AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  AppView({super.key});

  final List<Widget> tabs = const [
    Tab(text: "Home"),
    Tab(text: "Calendar"),
    Tab(text: "Weather"),
    Tab(text: "Expenses"),
    Tab(text: "Settings"),
  ];

  final List<Widget> pages = [
    const HomePage(),
    const CalendarPage(),
    const WeatherPage(),
    const ExpensePage(),
    BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
      return BlocProvider.value(
        value: context.read<WeatherCubit>(),
        child: const SettingsPage(),
      );
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, Color>(builder: (context, color) {
      return MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: color),
            useMaterial3: true,
          ),
          home: DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: AppBar(bottom: TabBar(tabs: tabs)),
              body: TabBarView(children: pages),
            ),
          ));
    });
  }
}

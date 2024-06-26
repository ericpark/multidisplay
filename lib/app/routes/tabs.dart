import 'package:flutter/material.dart';
// Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:multidisplay/expenses/expenses.dart';
// Project
import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/settings/settings.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/weather/weather.dart';

const List<BottomNavigationBarItem> bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.wb_sunny),
    label: 'Weather',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today),
    label: 'Calendar',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.timeline),
    label: 'Tracking',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.attach_money_outlined),
    label: 'Expenses',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Settings',
  ),
];

final List<Widget> pages = [
  const HomePage(),
  const WeatherPage(),
  const CalendarPage(),
  const TrackingPage(),
  const ExpensePage(),
  BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
    return BlocProvider.value(
      value: context.read<WeatherCubit>(),
      child: const SettingsPage(),
    );
  },),
];

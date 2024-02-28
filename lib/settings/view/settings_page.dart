import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:multidisplay/search/search.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage._();
  const SettingsPage({super.key});

  static Route<void> route(WeatherCubit weatherCubit) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: weatherCubit,
        child: const SettingsPage._(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              "Home",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.clockType != current.clockType,
            builder: (context, state) {
              return ListTile(
                title: const Text('Clock Type'),
                isThreeLine: true,
                subtitle: const Text(
                  'AM/PM vs Military',
                ),
                trailing: Switch(
                  value: state.clockType == ClockType.standard,
                  onChanged: (_) => context.read<HomeCubit>().toggleClockType(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              "Weather",
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Change City'),
            isThreeLine: true,
            subtitle: const Text(
              'Change City used for weather',
            ),
            onTap: () async {
              final city = await Navigator.of(context).push(SearchPage.route());
              //if (!mounted) return;
              // ignore: use_build_context_synchronously
              await context.read<WeatherCubit>().fetchWeather(city);
            },
            trailing: const SizedBox(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                child: Icon(Icons.search, semanticLabel: 'Search'),
              ),
            ),
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            buildWhen: (previous, current) =>
                previous.temperatureUnits != current.temperatureUnits,
            builder: (context, state) {
              return ListTile(
                title: const Text('Temperature Units'),
                isThreeLine: true,
                subtitle: const Text(
                  'Use metric measurements for temperature units.',
                ),
                trailing: Switch(
                  value: state.temperatureUnits.isCelsius,
                  onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
                ),
              );
            },
          ),
          BlocBuilder<WeatherCubit, WeatherState>(
            buildWhen: (previous, current) =>
                previous.autoRefresh != current.autoRefresh,
            builder: (context, state) {
              return ListTile(
                title: const Text('Auto Refresh data every 300 seconds'),
                isThreeLine: true,
                subtitle: const Text(
                  'Use metric measurements for temperature units.',
                ),
                trailing: Switch(
                  value: state.autoRefresh,
                  onChanged: (_) =>
                      context.read<WeatherCubit>().toggleAutoRefresh(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/home/home.dart';
import 'package:multidisplay/weather/weather.dart';

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
    return Scaffold(
      body: ListView(
        children: <Widget>[
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
        ],
      ),
    );
  }
}

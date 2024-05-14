import 'package:flutter/material.dart';

// Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project
import 'package:multidisplay/settings/settings.dart';
import 'package:multidisplay/weather/weather.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  const SettingsPage._();

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 400) {}
        return const SettingsLayoutTablet();
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherCubit weatherCubit = context.read<WeatherCubit>();
    return CurrentWeatherWidget(
      weather: weatherCubit.state.weather,
      units: weatherCubit.state.temperatureUnits,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WeatherCubit>().refreshWeather(current: true);

    return const CurrentWeatherWidget();
  }
}

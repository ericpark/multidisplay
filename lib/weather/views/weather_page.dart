import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerBloc timerBloc = context.read<TimerBloc>();
    final WeatherCubit weatherCubit = context.read<WeatherCubit>();

    weatherCubit.refreshWeather(current: true, hourly: true, daily: true);
    timerBloc.add(const TimerStarted(duration: TimerBloc.defaultDuration));

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 400) {
        return const WeatherLayoutMobile();
      }
      return const WeatherLayoutTablet();
    });
  }
}

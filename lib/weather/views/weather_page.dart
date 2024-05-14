import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<WeatherCubit>()
        .refreshWeather(current: true, hourly: true, daily: true);

    context
        .read<TimerBloc>()
        .add(const TimerStarted(duration: TimerBloc.defaultDuration));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 400) {
            return const WeatherLayoutMobile();
          }
          return const WeatherLayoutTablet();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:multidisplay/theme/theme.dart';
import 'package:multidisplay/timer/timer.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Removed BlocBuilder that returned BlocProvider.value so there isn't two instances
    TimerBloc timerBloc = context.read<TimerBloc>();
    timerBloc.add(const TimerStarted(duration: defaultDuration));
    // Possibly wrap WeatherView in bloc consumer and handle setup tasks here?
    return const WeatherContainerView();
  }
}

class WeatherContainerView extends StatelessWidget {
  const WeatherContainerView({super.key});

  @override
  Widget build(BuildContext context) {
    //Removed BlocBuilder that returned BlocProvider.value so there isn't two instances

    // Possibly wrap WeatherView in bloc consumer and handle setup tasks here?
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                //context.read<ThemeCubit>().updateTheme(state.weather);
              }
            },
            builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.initial:
                  return const WeatherEmpty();
                case WeatherStatus.loading:
                  return const WeatherLoading();
                case WeatherStatus.success:
                  return const WeatherView();
                case WeatherStatus.failure:
                  return const WeatherError();
              }
            },
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:multidisplay/theme/theme.dart';
import 'package:multidisplay/timer/timer.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherCubit weatherCubit = context.read<WeatherCubit>();
    TimerBloc timerBloc = context.read<TimerBloc>();

    return BlocConsumer<TimerBloc, TimerState>(
      listener: (timerContext, timerState) {
        switch (timerState) {
          case TimerInitial _:
            weatherCubit.refreshWeather(current: true);
            timerBloc.add(const TimerStarted(duration: defaultDuration));

          case TimerRunComplete _:
            if (!weatherCubit.state.autoRefresh) {
              break; // Break if autoRefresh is disabled.
            }
            timerBloc.add(const TimerStarted(duration: defaultDuration));
          case TimerRunInProgress _:
            if (timerState.duration % 60 != 0) {
              break; // To increase efficiency, check only every new minute
            }
            weatherCubit.handlePeriodicRefresh(timerState.duration);
          default:
            break;
        }
      },
      builder: (timerContext, timerState) {
        //timerBloc = timerContext.read<TimerBloc>();
        return Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 55,
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 30,
                    child: WeatherPopulated(
                      weather: weatherCubit.state.weather,
                      units: weatherCubit.state.temperatureUnits,
                      onRefresh: () {
                        timerBloc
                            .add(const TimerStarted(duration: defaultDuration));
                        return context
                            .read<WeatherCubit>()
                            .refreshWeather(all: true);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 70,
                    child: HourlyForecastPopulated(
                      forecast: weatherCubit.state.hourlyForecast,
                      units: weatherCubit.state.temperatureUnits,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 45,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                child: DailyForecastPopulated(
                  forecast: weatherCubit.state.dailyForecast,
                  units: weatherCubit.state.temperatureUnits,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

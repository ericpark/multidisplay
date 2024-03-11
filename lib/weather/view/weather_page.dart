import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/theme/theme.dart';
import 'package:multidisplay/timer/timer.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Removed BlocBuilder that returned BlocProvider.value so there isn't two instances

    // Possibly wrap WeatherView in bloc consumer and handle setup tasks here?
    return const WeatherView();
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  late TimerBloc timerBloc;

  @override
  void initState() {
    super.initState();
    // I think I can move this to the parent and change this class to stateless
    timerBloc = context.read<TimerBloc>();
    timerBloc.add(const TimerStarted(duration: defaultDuration));
  }

  @override
  void dispose() {
    timerBloc.add(const TimerReset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.read<ThemeCubit>().updateTheme(state.weather);
              }
            },
            builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.initial:
                  return const WeatherEmpty();
                case WeatherStatus.loading:
                  return const WeatherLoading();
                case WeatherStatus.success:
                  return BlocConsumer<TimerBloc, TimerState>(
                    listener: (timerContext, timerState) {
                      switch (timerState) {
                        case TimerInitial _:
                          context
                              .read<WeatherCubit>()
                              .refreshWeather(current: true);
                          timerBloc.add(
                              const TimerStarted(duration: defaultDuration));

                        case TimerRunComplete _:
                          if (!state.autoRefresh) {
                            break; // Break if autoRefresh is disabled.
                          }

                          context
                              .read<WeatherCubit>()
                              .refreshWeather(all: true);
                          timerBloc.add(
                              const TimerStarted(duration: defaultDuration));

                        case TimerRunInProgress _:
                          DateTime current = DateTime.now();

                          if (!state.autoRefresh) {
                            break; // Break if autoRefresh is disabled.
                          }

                          if ((current.hour == 0) && (current.minute == 1)) {
                            context.read<WeatherCubit>().refreshWeather(
                                all: true); // At 12:01 AM, fetch all
                            break;
                          }

                          if ((current.hour == 0) && (current.minute < 15)) {
                            break; // Break if first 15 minutes after midnight
                          }

                          // (60 * mins - 1) is used so the refresh times do not overlap.

                          /* Runs every 120 minutes. First time is delayed
                          * by 3999 seconds. This means if it is manually refreshed,
                          * the data isn't refreshed multiple times in a short time span
                          */
                          if ((timerState.duration + 0) % 7199 == 0) {
                            context
                                .read<WeatherCubit>()
                                .refreshWeather(daily: true, current: true);
                            break;
                          }

                          // Runs every 30 minutes
                          if (timerState.duration % 1799 == 0) {
                            context
                                .read<WeatherCubit>()
                                .refreshWeather(hourly: true, current: true);
                            break;
                          }
                          // Runs every 5 minutes
                          if (timerState.duration % 299 == 0) {
                            context
                                .read<WeatherCubit>()
                                .refreshWeather(current: true);
                            break;
                          }
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
                                    weather: state.weather,
                                    units: state.temperatureUnits,
                                    onRefresh: () {
                                      timerBloc.add(const TimerStarted(
                                          duration: defaultDuration));
                                      return context
                                          .read<WeatherCubit>()
                                          .refreshWeather(all: true);
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 70,
                                  child: HourlyForecastPopulated(
                                    forecast: state.hourlyForecast,
                                    units: state.temperatureUnits,
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
                                forecast: state.dailyForecast,
                                units: state.temperatureUnits,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                case WeatherStatus.failure:
                  return const WeatherError();
              }
            },
          ),
        ));
  }
}

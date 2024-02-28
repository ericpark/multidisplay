import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/search/search.dart';
import 'package:multidisplay/theme/theme.dart';
import 'package:multidisplay/timer/timer.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
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
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          actions: [
            IconButton(
              icon: const Icon(Icons.search, semanticLabel: 'Search'),
              onPressed: () async {
                final city =
                    await Navigator.of(context).push(SearchPage.route());
                if (!mounted) return;
                // ignore: use_build_context_synchronously
                await context.read<WeatherCubit>().fetchWeather(city);
              },
            ),
          ],
        ),
        body: Center(
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.read<ThemeCubit>().updateTheme(state.weather);
                timerBloc.add(const TimerStarted(duration: defaultDuration));
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
                        case const TimerRunComplete():
                          context.read<WeatherCubit>().refreshWeather();
                          timerBloc.add(
                              const TimerStarted(duration: defaultDuration));
                        default:
                        //print(timerState);
                      }
                    },
                    builder: (timerContext, timerState) {
                      //timerBloc = timerContext.read<TimerBloc>();
                      return Flex(
                        direction: Axis.vertical,
                        children: [
                          Expanded(
                            flex: 50,
                            child: WeatherPopulated(
                              weather: state.weather,
                              units: state.temperatureUnits,
                              onRefresh: () {
                                return context
                                    .read<WeatherCubit>()
                                    .refreshWeather();
                              },
                            ),
                          ),
                          Expanded(
                            flex: 50,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                              child: WeatherForecastPopulated(
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

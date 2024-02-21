import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/search/search.dart';
import 'package:multidisplay/theme/theme.dart';
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
              }
            },
            builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.initial:
                  return const WeatherEmpty();
                case WeatherStatus.loading:
                  return const WeatherLoading();
                case WeatherStatus.success:
                  return Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                        flex: 60,
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
                        flex: 40,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                          child: WeatherForecastPopulated(
                            forecast: state.forecast,
                            units: state.temperatureUnits,
                          ),
                        ),
                      ),
                    ],
                  );
                case WeatherStatus.failure:
                  return const WeatherError();
              }
            },
          ),
        ));
  }
}

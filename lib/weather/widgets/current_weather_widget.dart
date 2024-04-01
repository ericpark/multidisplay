import 'package:flutter/material.dart';

// Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project
import 'package:multidisplay/weather/weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget({
    this.onRefresh,
    super.key,
  });

  final ValueGetter<Future<void>>? onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          //context.read<ThemeCubit>().updateTheme(state.weather);
        }
      },
      builder: (context, state) {
        switch (state.forecastStatus["current"]!) {
          case WeatherStatus.initial:
            return const WeatherEmpty();
          case WeatherStatus.loading:
            return const SizedBox(
                width: double.infinity, child: WeatherLoading());
          case WeatherStatus.success:
            return CurrentWeatherWidgetPopulated(
                weather: state.weather,
                theme: theme,
                units: state.temperatureUnits,
                onRefresh: onRefresh);
          case WeatherStatus.failure:
            return const WeatherError();
        }
      },
    );
  }
}

class CurrentWeatherWidgetPopulated extends StatelessWidget {
  const CurrentWeatherWidgetPopulated({
    super.key,
    required this.weather,
    required this.theme,
    required this.units,
    required this.onRefresh,
  });

  final Weather weather;
  final ThemeData theme;
  final TemperatureUnits units;
  final ValueGetter<Future<void>>? onRefresh;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather.location,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: _WeatherIcon(condition: weather.condition),
                ),
                Text(
                  weather.condition.toWeatherDescription,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  weather.formattedTemperature(units),
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
                ),
                onRefresh != null
                    ? IconButton(
                        icon: const Icon(Icons.refresh),
                        iconSize: 20,
                        onPressed: onRefresh,
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.condition});

  static const _iconSize = 100.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _iconSize,
      height: _iconSize,
      child: Icon(
        condition.toWeatherIcon,
        size: _iconSize,
        applyTextScaling: true,
      ),
    );
  }
}

/*
class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primaryContainer;
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.75, 0.90, 1.0],
            colors: [
              color,
              color.brighten(),
              color.brighten(33),
              color.brighten(50),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}
*/
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
        switch (state.forecastStatus['current']!) {
          case WeatherStatus.initial:
            return const WeatherEmpty();
          case WeatherStatus.loading:
            return const SizedBox(
              width: double.infinity,
              child: WeatherCurrentLoading(),
            );
          case WeatherStatus.success:
            final now = DateTime.now();
            final previousHour = now.subtract(
              Duration(
                hours: 1,
                minutes: now.minute,
                seconds: now.second,
                milliseconds: now.millisecond,
                microseconds: now.microsecond,
              ),
            );

            final currentHour = state.hourlyForecast
                .where((hourly) => hourly.date.isAfter(previousHour))
                .take(1)
                .toList()[0];

            return CurrentWeatherWidgetPopulated(
              weather: state.weather
                  .copyWith(soilCondition: currentHour.soilCondition),
              theme: theme,
              units: state.temperatureUnits,
              onRefresh: onRefresh,
            );
          case WeatherStatus.failure:
            return const WeatherError();
        }
      },
    );
  }
}

class CurrentWeatherWidgetPopulated extends StatelessWidget {
  const CurrentWeatherWidgetPopulated({
    required this.weather,
    required this.theme,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  final Weather weather;
  final ThemeData theme;
  final TemperatureUnits units;
  final ValueGetter<Future<void>>? onRefresh;

  @override
  Widget build(BuildContext context) {
    final locationText = Text(
      weather.location,
      style: theme.textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.w200,
      ),
    );

    final weatherIconAndDetail = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _WeatherIcon(condition: weather.condition),
        ),
        Text(
          weather.condition.toWeatherDescription,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );

    final temperatureText = Text(
      weather.formattedTemperature(units),
      style: theme.textTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
    final soilConditionText = Text(
      weather.soilCondition.name,
      style: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: weather.soilCondition.name == 'muddy'
            ? FontWeight.bold
            : FontWeight.w300,
        color: weather.soilCondition.name == 'muddy'
            ? const Color.fromARGB(255, 193, 110, 2)
            : theme.textTheme.bodyMedium!.color!.withOpacity(0.5),
      ),
    );
    final updatedAtText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '''Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}''',
        ),
        if (onRefresh != null)
          IconButton(
            icon: const Icon(Icons.refresh),
            iconSize: 20,
            onPressed: onRefresh,
          )
        else
          Container(),
      ],
    );
    return SizedBox.expand(
      //width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          Widget weatherWidget;
          if (constraints.maxHeight < 200) {
            weatherWidget = _CurrentWeatherSmallLayout(
              locationText: locationText,
              weatherIconAndDetail: weatherIconAndDetail,
              temperatureText: temperatureText,
              updatedAtText: updatedAtText,
            );
          } else {
            weatherWidget = _CurrentWeatherLargeLayout(
              locationText: locationText,
              weatherIconAndDetail: weatherIconAndDetail,
              temperatureText: temperatureText,
              updatedAtText: updatedAtText,
              soilConditionText: soilConditionText,
            );
          }

          return Stack(
            children: [
              _WeatherBackground(
                weather: weather,
                height: constraints.maxHeight,
                width: constraints.maxWidth,
              ),
              Center(child: weatherWidget),
            ],
          );
        },
      ),
    );
  }
}

class _CurrentWeatherLargeLayout extends StatelessWidget {
  const _CurrentWeatherLargeLayout({
    required this.locationText,
    required this.weatherIconAndDetail,
    required this.temperatureText,
    required this.updatedAtText,
    required this.soilConditionText,
  });

  final Text locationText;
  final Column weatherIconAndDetail;
  final Text temperatureText;
  final Row updatedAtText;
  final Text soilConditionText; // Declare the optional parameter

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              locationText,
              weatherIconAndDetail,
              soilConditionText,
              const SizedBox(height: 5),
              temperatureText,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: updatedAtText,
        ),
      ],
    );
  }
}

class _CurrentWeatherSmallLayout extends StatelessWidget {
  const _CurrentWeatherSmallLayout({
    required this.locationText,
    required this.weatherIconAndDetail,
    required this.temperatureText,
    required this.updatedAtText,
  });

  final Text locationText;
  final Column weatherIconAndDetail;
  final Text temperatureText;
  final Row updatedAtText;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 40,
                child: Align(
                  child: weatherIconAndDetail,
                ),
              ),
              Expanded(
                flex: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text(''), locationText, temperatureText],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: updatedAtText,
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.condition, double? iconSize})
      : iconSize = iconSize ?? _defaultIconSize;

  static const _defaultIconSize = 100.0;

  final WeatherCondition condition;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: iconSize ?? _defaultIconSize,
      height: iconSize ?? _defaultIconSize,
      child: Icon(
        condition.toWeatherIcon,
        size: iconSize ?? _defaultIconSize,
        applyTextScaling: true,
      ),
    );
  }
}

class _WeatherBackground extends StatelessWidget {
  const _WeatherBackground({
    required this.height,
    required this.width,
    this.weather,
  });

  final Weather? weather;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    if (weather != null) {
      return SizedBox.expand(
        child: Image.asset(
          'assets/weather/${weather!.condition.name}.jpg',
          height: height,
          width: width,
          fit: BoxFit.cover,
          opacity: const AlwaysStoppedAnimation<double>(0.2),
        ),
      );
    }
    return SizedBox.expand(child: Container());
  }
}

/*extension on Color {
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
  }*/

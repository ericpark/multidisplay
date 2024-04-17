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
                width: double.infinity, child: WeatherCurrentLoading());
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
    final locationText = Text(weather.location,
        style: theme.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w200,
        ));

    final weatherIconAndDetail =
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: _WeatherIcon(condition: weather.condition),
      ),
      Text(
        weather.condition.toWeatherDescription,
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.normal,
        ),
      )
    ]);

    final temperatureText = Text(
      weather.formattedTemperature(units),
      style: theme.textTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );

    final updatedAtText = Row(
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
                updatedAtText: updatedAtText);
          } else {
            weatherWidget = _CurrentWeatherLargeLayout(
                locationText: locationText,
                weatherIconAndDetail: weatherIconAndDetail,
                temperatureText: temperatureText,
                updatedAtText: updatedAtText);
          }

          return Stack(
            children: [
              _WeatherBackground(
                weather: weather,
                height: constraints.maxHeight,
                width: constraints.maxWidth,
              ),
              Center(child: weatherWidget)
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
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              locationText,
              weatherIconAndDetail,
              temperatureText,
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 40,
                  child: Align(
                      alignment: Alignment.center,
                      child: weatherIconAndDetail)),
              Expanded(
                  flex: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [const Text(""), locationText, temperatureText],
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
    this.weather,
    required this.height,
    required this.width,
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

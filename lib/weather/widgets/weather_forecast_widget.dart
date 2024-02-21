import 'package:flutter/material.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherForecastPopulated extends StatelessWidget {
  const WeatherForecastPopulated({
    required this.forecast,
    required this.units,
    super.key,
  });

  final List<Weather> forecast;
  final TemperatureUnits units;

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 140,
              child: ForecastWidget(weather: forecast[0], units: units)),
          SizedBox(
              width: 140,
              child: ForecastWidget(weather: forecast[1], units: units)),
          SizedBox(
              width: 140,
              child: ForecastWidget(weather: forecast[2], units: units)),
          SizedBox(
              width: 140,
              child: ForecastWidget(weather: forecast[3], units: units)),
          SizedBox(
              width: 140,
              child: ForecastWidget(weather: forecast[4], units: units)),
          SizedBox(
              width: 140,
              child: ForecastWidget(weather: forecast[5], units: units)),
          SizedBox(
              width: 140,
              child: ForecastWidget(weather: forecast[6], units: units)),
        ],
      ),
    );
  }
}

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    required this.weather,
    required this.units,
    super.key,
  });

  final Weather weather;
  final TemperatureUnits units;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          //_WeatherBackground(),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 48),
                Text(
                  "${weather.date.month.toString().padLeft(2, "0")}/${weather.date.day.toString().padLeft(2, "0")}",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _WeatherIcon(condition: weather.condition),
                Text(
                  "H: ${weather.formattedTemperature("high", units)}",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "L: ${weather.formattedTemperature("low", units)}",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                )
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

  static const _iconSize = 75.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji,
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

extension on WeatherCondition {
  String get toEmoji {
    switch (this) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.snowy:
        return '🌨️';
      case WeatherCondition.unknown:
        return '❓';
    }
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
}*/
/*
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
extension on Weather {
  String formattedTemperature(String temperatureType, TemperatureUnits units) {
    if (temperatureType == "low") {
      return '''${temperatureLow.value.toStringAsPrecision(3)}°${units.isCelsius ? 'C' : 'F'}''';
    }

    return '''${temperature.value.toStringAsPrecision(3)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

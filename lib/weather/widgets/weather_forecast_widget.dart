import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    List<Widget> forecastWidgets = [];

    for (var i = 0; i < forecast.length; i++) {
      forecastWidgets.add(
        SizedBox(
            width: 140, // TODO: Update width
            child: ForecastWidget(weather: forecast[i], units: units)),
      );
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: forecastWidgets,
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
                // SPACING
                const SizedBox(height: 20),
                // DAY OF WEEK
                Text(
                  DateFormat('EEEE').format(weather.date),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                // DATE
                Text(
                  "${weather.date.month.toString().padLeft(2, "0")}/${weather.date.day.toString().padLeft(2, "0")}",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // WEATHER ICON
                _WeatherIcon(condition: weather.condition),
                // HIGH TEXT SPAN
                RichText(
                  text: TextSpan(
                      text: "H:  ",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: weather.formattedTemperature("high", units),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ]),
                ),
                // LOW TEXT SPAN
                RichText(
                  text: TextSpan(
                      text: "L:  ",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: weather.formattedTemperature("low", units),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ]),
                ),
                // SPACING
                const SizedBox(height: 20),
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

extension on Weather {
  String formattedTemperature(String temperatureType, TemperatureUnits units) {
    if (temperatureType == "low") {
      return '''${temperatureLow.value.toStringAsPrecision(3)}°${units.isCelsius ? 'C' : 'F'}''';
    }

    return '''${temperatureHigh.value.toStringAsPrecision(3)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

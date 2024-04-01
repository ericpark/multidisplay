import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multidisplay/weather/weather.dart';

class DailyForecastPopulated extends StatelessWidget {
  const DailyForecastPopulated({
    required this.forecast,
    required this.units,
    this.onRefresh,
    super.key,
  });

  final List<Weather> forecast;
  final TemperatureUnits units;
  final ValueGetter<Future<void>>? onRefresh;

  @override
  Widget build(BuildContext context) {
    List<Widget> forecastWidgets = [];

    for (var i = 0; i < forecast.length; i++) {
      forecastWidgets.add(
        Expanded(
            flex: 1,
            child: DailyForecastCell(weather: forecast[i], units: units)),
      );
    }

    return Center(
      child: Flex(
        direction: Axis.horizontal,
        children: forecastWidgets,
      ),
    );
  }
}

class DailyForecastCell extends StatelessWidget {
  const DailyForecastCell({
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                // WEATHER DESCRIPTION
                Text(
                  weather.condition.toWeatherDescription,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                // HIGH TEXT SPAN
                RichText(
                  text: TextSpan(
                      text: "high:  ",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: weather.formattedTemperature(units,
                                temperatureType: "high"),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ]),
                ),
                // LOW TEXT SPAN
                RichText(
                  text: TextSpan(
                      text: "low:  ",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: weather.formattedTemperature(units,
                                temperatureType: "low"),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ]),
                ),
                // PRECIPITATION PERCENTAGE TEXT SPAN
                RichText(
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  text: TextSpan(
                      text: "precipitation: ",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text: "${weather.precipitationProbability}%",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ]),
                ),
                RichText(
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  text: TextSpan(
                      text: "",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                            text:
                                "(${weather.precipitation.toStringAsFixed(2)} in)",
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            )),
                      ]),
                ),
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

  static const _iconSize = 50.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: SizedBox(
          width: _iconSize,
          height: _iconSize,
          child: Icon(
            condition.toWeatherIcon,
            size: _iconSize,
            applyTextScaling: true,
          ),
        ),
      ),
    );
  }
}

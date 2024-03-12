// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_icons/weather_icons.dart';

class HourlyForecastPopulated extends StatelessWidget {
  const HourlyForecastPopulated({
    required this.forecast,
    required this.units,
    super.key,
  });

  final List<Weather> forecast;
  final TemperatureUnits units;

  @override
  Widget build(BuildContext context) {
    List<Widget> forecastWidgets = [];
    DateTime now = DateTime.now();
    DateTime currentHour = DateTime.now().subtract(Duration(
        hours: 1,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond));
    List<Weather> filterHours = forecast
        .where((hourly) => hourly.date.isAfter(currentHour))
        .take(24)
        .toList();

    for (var i = 0; i < filterHours.length; i++) {
      // Show an icon for every three hours and the last one for a 24 hour period
      if ((i % 3 == 0) || (i == filterHours.length - 1)) {
        forecastWidgets.add(
          Expanded(
              flex: 1, // Evenly Distribute in size
              child:
                  HourlyForecastWidget(weather: filterHours[i], units: units)),
        );
      }
    }
    List<_ChartData> precipitationData = filterHours
        .map((hourly) => _ChartData(
            DateFormat('jm').format(hourly.date).replaceAll(":00", ""),
            hourly.precipitation))
        .toList();
    List<_ChartData> temperatureData = filterHours
        .map((hourly) => _ChartData(
            DateFormat('jm').format(hourly.date).replaceAll(":00", ""),
            hourly.temperature.value))
        .toList();

    TooltipBehavior tooltip = TooltipBehavior(enable: true);

    return Center(
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: forecastWidgets,
          ),
          Expanded(
            child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                axes: const [
                  NumericAxis(
                    name: "Precipitation",
                    opposedPosition: true,
                    title: AxisTitle(text: "precipitation (in)"),
                  ),
                ],
                tooltipBehavior: tooltip,
                primaryYAxis: NumericAxis(
                  name: "Temperature",
                  title: AxisTitle(
                    text: "Temperature (°${units.isCelsius ? 'C' : 'F'})",
                  ),
                ),
                series: <CartesianSeries<_ChartData, String>>[
                  AreaSeries<_ChartData, String>(
                    dataSource: temperatureData,
                    yAxisName: "Temperature",
                    xValueMapper: (_ChartData temperatureData, _) =>
                        temperatureData.x,
                    yValueMapper: (_ChartData temperatureData, _) =>
                        temperatureData.y,
                    name: 'Temperature',
                    color: Colors.amber[200],
                  ),
                  AreaSeries<_ChartData, String>(
                    dataSource: precipitationData,
                    yAxisName: "Precipitation",
                    xValueMapper: (_ChartData precipitationData, _) =>
                        precipitationData.x,
                    yValueMapper: (_ChartData precipitationData, _) =>
                        precipitationData.y,
                    name: 'Precipitation',
                    color: Colors.blue[200],
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class HourlyForecastWidget extends StatelessWidget {
  const HourlyForecastWidget({
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
                // HOUR
                Text(
                  DateFormat('jm').format(weather.date).replaceAll(":00", ""),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                // WEATHER ICON
                _WeatherIcon(condition: weather.condition),
                // HIGH TEXT SPAN
                Text(
                  weather.formattedTemperature(units),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  weather.soilCondition.name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
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

  static const _iconSize = 40.0;

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

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

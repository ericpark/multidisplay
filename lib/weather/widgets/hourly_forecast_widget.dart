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
    this.onRefresh,
    this.sunrise,
    this.sunset,
    super.key,
  });

  final List<Weather> forecast;
  final TemperatureUnits units;
  final DateTime? sunrise;
  final DateTime? sunset;
  final ValueGetter<Future<void>>? onRefresh;

  LinearGradient? _getHourlyGradientTransition(
      {required List<Weather> filterHours}) {
    if (sunrise == null || sunset == null) {
      return null;
    }
    final List<double> stops = <double>[];
    final List<Color> color = <Color>[];

    const totalMinutes = 24.0 * 60.0;
    const transitionMinutes = 30.0;

    final sunriseStart = (sunrise!).difference(filterHours[0].date).inMinutes;
    final sunriseEnd = sunriseStart + transitionMinutes;
    final sunsetStart = (sunset!).difference(filterHours[0].date).inMinutes;
    final sunsetEnd = sunsetStart + transitionMinutes;
    Color firstColor;
    Color secondColor;
    stops.add(0.0);

    if (sunset!.isBefore(sunrise!)) {
      firstColor = Colors.amber;
      secondColor = Colors.indigo;

      stops.add(sunsetStart / totalMinutes); // Transition
      stops.add(sunsetEnd / totalMinutes);
      stops.add(sunriseStart / totalMinutes); // Transition
      stops.add(sunriseEnd / totalMinutes);
    } else {
      firstColor = Colors.indigo;
      secondColor = Colors.amber;

      stops.add(sunriseStart / totalMinutes); // Transition
      stops.add(sunriseEnd / totalMinutes);
      stops.add(sunsetStart / totalMinutes); // Transition
      stops.add(sunsetEnd / totalMinutes);
    }

    stops.add(1.0);

    color.add(firstColor);
    color.add(firstColor); // Transition
    color.add(secondColor);
    color.add(secondColor); // Transition
    color.add(firstColor);
    color.add(firstColor);

    return LinearGradient(colors: color, stops: stops);
  }

  List<_ChartData> _hourlyTemperatureData(
      {required List<Weather> filterHours}) {
    return filterHours.map((hourly) {
      String hour = DateFormat('jm').format(hourly.date).replaceAll(":00", "");

      Color color = Colors.transparent;

      return _ChartData(hour, hourly.temperature.value, color);
    }).toList();
  }

  CartesianChartAnnotation dateToAnnotation(
      {required DateTime? date, required double maxTemp}) {
    if (date == null) {
      date = DateTime.now();
      maxTemp = maxTemp + 100;
    }

    final hour = DateFormat('jm')
        .format(date.subtract(Duration(
            hours: 0,
            minutes: date.minute,
            seconds: date.second,
            milliseconds: date.millisecond,
            microseconds: date.microsecond)))
        .replaceAll(":00", "");

    return CartesianChartAnnotation(
      widget: Text(DateFormat('jm').format(date)),
      coordinateUnit: CoordinateUnit.point,
      x: hour,
      y: (maxTemp + 3),
    );
  }

  Widget _getForecastWidgetsRow({required List<Weather> filterHours}) {
    List<Widget> forecastWidgets = [];

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
    return Flex(direction: Axis.horizontal, children: forecastWidgets);
  }

  dynamic _getTemperatureSeries({required List<Weather> filterHours}) {
    final List<_ChartData> temperatureData =
        _hourlyTemperatureData(filterHours: filterHours);
    final tempGradientColors =
        _getHourlyGradientTransition(filterHours: filterHours);

    return AreaSeries<_ChartData, String>(
      dataSource: temperatureData,
      yAxisName: "Temperature",
      xValueMapper: (_ChartData temperatureData, _) => temperatureData.x,
      yValueMapper: (_ChartData temperatureData, _) => temperatureData.y,
      gradient: tempGradientColors,
      color: tempGradientColors == null ? Colors.transparent : null,
      name: 'Temperature',
      markerSettings: const MarkerSettings(
        isVisible: true,
        color: Colors.black45,
        borderColor: Colors.transparent,
        borderWidth: 1,
        height: 5,
        width: 5,
      ),
    );
  }

  dynamic _getPrecipitationSeries({required List<Weather> filterHours}) {
    List<_ChartData> precipitationData = filterHours
        .map((hourly) => _ChartData(
            DateFormat('jm').format(hourly.date).replaceAll(":00", ""),
            hourly.precipitation,
            Colors.blue[200]!))
        .toList();

    return LineSeries<_ChartData, String>(
      dataSource: precipitationData,
      yAxisName: "Precipitation",
      xValueMapper: (_ChartData precipitationData, _) => precipitationData.x,
      yValueMapper: (_ChartData precipitationData, _) => precipitationData.y,
      name: 'Precipitation',
      color: Colors.blue[200],
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currentHour = now.subtract(Duration(
        hours: 1,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond));

    List<Weather> filterHours = forecast
        .where((hourly) => hourly.date.isAfter(currentHour))
        .take(24)
        .toList();

    // TOP ROW WIDGET
    final forecastWidgetsRow = _getForecastWidgetsRow(filterHours: filterHours);

    // TEMPERATURE GRAPH
    final temperatureSeries = _getTemperatureSeries(filterHours: filterHours);
    final temperatureAxis = NumericAxis(
      name: "Temperature",
      title: AxisTitle(
        text: "Temperature (°${units.isCelsius ? 'C' : 'F'})",
      ),
    );
    // SUNRISE AND SUNSET TIMESTAMPS
    final maxTemp = filterHours
        .reduce((curr, next) =>
            curr.temperature.value > next.temperature.value ? curr : next)
        .temperature
        .value;

    final sunsetAnnotation = dateToAnnotation(date: sunset, maxTemp: maxTemp);
    final sunriseAnnotation = dateToAnnotation(date: sunrise, maxTemp: maxTemp);

    // PRECIPITATION GRAPH
    final precipitationSeries =
        _getPrecipitationSeries(filterHours: filterHours);
    const precipitationAxis = NumericAxis(
      name: "Precipitation",
      opposedPosition: true,
      title: AxisTitle(text: "precipitation (in)"),
    );
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return Stack(
        children: [
          RefreshIndicator(
              onRefresh: onRefresh ?? () async => {},
              child: SingleChildScrollView(
                  physics: onRefresh != null
                      ? const AlwaysScrollableScrollPhysics()
                      : const NeverScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  child: SizedBox(
                      height: viewportConstraints.maxHeight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PhysicalModel(
                          color: Theme.of(context).dialogBackgroundColor,
                          elevation: 10,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          child: Center(
                            child: Column(
                              children: [
                                forecastWidgetsRow,
                                Expanded(
                                  child: SfCartesianChart(
                                    annotations: [
                                      sunsetAnnotation,
                                      sunriseAnnotation
                                    ],
                                    primaryXAxis: const CategoryAxis(),
                                    axes: const [precipitationAxis],
                                    primaryYAxis: temperatureAxis,
                                    series: <CartesianSeries<_ChartData,
                                        String>>[
                                      temperatureSeries,
                                      precipitationSeries
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))))
        ],
      );
    });
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
                Text(
                  "${(weather.precipitationProbability).toInt()}%",
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
  _ChartData(this.x, this.y, this.pointColorMapper);

  final String x;
  final double y;
  final Color? pointColorMapper;
}

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:multidisplay/weather/widgets/hourly_forecast_widget.dart';

class HourlyForecastIconsWidget extends StatelessWidget {
  const HourlyForecastIconsWidget({
    required this.filterHours,
    required this.units,
    super.key,
  });

  final List<Weather> filterHours;
  final TemperatureUnits units;

  List<Widget> _getForecastWidgetsRow({required double width}) {
    final forecastWidgets = <Widget>[];

    var hourInterval = 3;
    final maxWidgets = (filterHours.length / hourInterval).floor() + 1;
    var widgetSize = width / maxWidgets;

    if (width < 400) {
      hourInterval = 1;
      widgetSize = width / 5;
    }

    for (var i = 0; i < filterHours.length; i++) {
      /// Show an icon for every three hours and the last one for a 24-hr period
      /// Or show all 24 hours in a scrollable row with 5 showing at once.
      if ((i % hourInterval == 0) || (i == filterHours.length - 1)) {
        forecastWidgets.add(
          SizedBox(
            width: widgetSize, // Evenly Distribute in size
            child: HourlyForecastCell(weather: filterHours[i], units: units),
          ),
        );
      }
    }
    return forecastWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final scrollable = width > 400
            ? const NeverScrollableScrollPhysics()
            : const AlwaysScrollableScrollPhysics();

        final forecastWidgets = _getForecastWidgetsRow(width: width);

        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: scrollable,
            child: Row(
              children: forecastWidgets,
            ),
          ),
        );
      },
    );
  }
}

class HourlyForecastCell extends StatelessWidget {
  const HourlyForecastCell({
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
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          //_WeatherBackground(),
          Center(
            child: Column(
              children: [
                // HOUR
                Text(
                  DateFormat('jm').format(weather.date).replaceAll(':00', ''),
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
                    fontWeight: weather.soilCondition.name == 'muddy'
                        ? FontWeight.bold
                        : FontWeight.w300,
                    color: weather.soilCondition.name == 'muddy'
                        ? const Color.fromARGB(255, 193, 110, 2)
                        : theme.textTheme.bodyMedium!.color!.withOpacity(0.5),
                  ),
                ),
                Text(
                  '${weather.precipitationProbability}%',
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

  static const _iconSize = 30.0;

  final WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Align(
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

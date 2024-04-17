// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_icons/weather_icons.dart';

class HourlyForecastWidget extends StatelessWidget {
  const HourlyForecastWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          //context.read<ThemeCubit>().updateTheme(state.weather);
        }
      },
      builder: (context, state) {
        switch (state.forecastStatus["hourly"]!) {
          case WeatherStatus.initial:
            return const WeatherEmpty();
          case WeatherStatus.loading:
            return const SizedBox(
                width: double.infinity, child: WeatherHourlyLoading());
          case WeatherStatus.success:
            final sunriseAndSunset =
                context.read<WeatherCubit>().getNextSunriseAndSunset();

            return HourlyForecastPopulated(
              forecast: state.hourlyForecast,
              units: state.temperatureUnits,
              sunrise: sunriseAndSunset["sunrise"],
              sunset: sunriseAndSunset["sunset"],
            );
          case WeatherStatus.failure:
            return const WeatherError();
        }
      },
    );
  }
}

class HourlyForecastPopulated extends StatelessWidget {
  const HourlyForecastPopulated({
    required this.forecast,
    required this.units,
    this.sunrise,
    this.sunset,
    super.key,
  });

  final List<Weather> forecast;
  final TemperatureUnits units;
  final DateTime? sunrise;
  final DateTime? sunset;

  LinearGradient? _getHourlyGradientTransition(
      {required List<Weather> filterHours}) {
    if (sunrise == null || sunset == null) {
      return null;
    }
    final List<double> stops = <double>[];
    final List<Color> color = <Color>[];
    final totalMinutes = filterHours.length * 60;

    Color firstColor;
    Color secondColor;

    for (var h = 0; h < filterHours.length - 1; h++) {
      var hour = filterHours[h];
      var nextHour = filterHours[h + 1];

      firstColor = hour.temperature.color;
      secondColor = nextHour.temperature.color;

      color.add(firstColor);
      color.add(firstColor);
      color.add(secondColor);
      color.add(secondColor);

      stops.add((h * 60) / totalMinutes);
      stops.add(((h * 60) + 15) / totalMinutes);
      stops.add(((h * 60) + 45) / totalMinutes);
      stops.add(((h * 60) + 60) / totalMinutes);
    }
    return LinearGradient(colors: color, stops: stops);
  }

  dynamic _getTemperatureSeries({required List<Weather> filterHours}) {
    final List<ChartData> temperatureData = filterHours
        .map((hourly) => ChartData(
            hourly.date, hourly.temperature.value, Colors.transparent))
        .toList();
    final tempGradientColors =
        _getHourlyGradientTransition(filterHours: filterHours);

    return AreaSeries<ChartData, DateTime>(
      dataSource: temperatureData,
      yAxisName: "Temperature",
      xValueMapper: (ChartData temperatureData, _) => temperatureData.x,
      yValueMapper: (ChartData temperatureData, _) => temperatureData.y,
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
    List<ChartData> precipitationData = filterHours
        .map((hourly) =>
            ChartData(hourly.date, hourly.precipitation, Colors.blue[200]!))
        .toList();

    return SplineSeries<ChartData, DateTime>(
      dataSource: precipitationData,
      yAxisName: "Precipitation",
      xValueMapper: (ChartData precipitationData, _) => precipitationData.x,
      yValueMapper: (ChartData precipitationData, _) => precipitationData.y,
      name: 'Precipitation',
      color: Colors.blue[500],
    );
  }

  List<PlotBand> _getPlotBands({
    required List<Weather> filterHours,
    required double height,
    bool showDayNight = true,
  }) {
    final firstTransition = sunset!.isBefore(sunrise!) ? sunset! : sunrise!;
    final secondTransition = sunset!.isBefore(sunrise!) ? sunrise! : sunset!;

    const transitionMinutes = Duration(minutes: 30);
    const dayColor = Color.fromRGBO(255, 193, 7, 0.25);
    const nightColor = Color.fromRGBO(63, 81, 181, 0.35);
    const sunsetGradient =
        LinearGradient(colors: [dayColor, nightColor], stops: [0, 0.75]);
    const sunriseGradient =
        LinearGradient(colors: [nightColor, dayColor], stops: [0, 0.75]);

    final nowMarker = PlotBand(
      isVisible: true,
      start: DateTime.now(),
      end: DateTime.now(),
      text: "Now",
      verticalTextPadding: '5%',
      associatedAxisStart: 0,
      associatedAxisEnd: height - 15,
      textAngle: 0,
      borderWidth: 1,
      borderColor: Colors.grey.shade600,
      shouldRenderAboveSeries: true,
      verticalTextAlignment: TextAnchor.start,
      //horizontalTextAlignment: TextAnchor.start,
      dashArray: const <double>[10, 10],
    );

    final sunsetMarker = PlotBand(
      isVisible: true,
      start: sunset!,
      end: sunset!,
      text: "    ${DateFormat("h:mm a").format(sunset!)}",
      verticalTextPadding: '5%',
      associatedAxisStart: 0,
      associatedAxisEnd: height - 15,
      textAngle: 0,
      borderWidth: 1,
      borderColor: Colors.grey.shade600,
      shouldRenderAboveSeries: true,
      verticalTextAlignment: TextAnchor.start,
      //horizontalTextAlignment: TextAnchor.start,
      dashArray: const <double>[10, 10],
    );

    final sunriseMarker = PlotBand(
      isVisible: true,
      start: sunrise!,
      end: sunrise!,
      text: "    ${DateFormat("h:mm a").format(sunrise!)}",
      verticalTextPadding: '5%',
      associatedAxisStart: 0,
      associatedAxisEnd: height - 15,
      textAngle: 0,
      borderWidth: 1,
      borderColor: Colors.grey.shade600,
      shouldRenderAboveSeries: true,
      verticalTextAlignment: TextAnchor.start,
      //horizontalTextAlignment: TextAnchor.start,
      dashArray: const <double>[10, 10],
    );
    final firstSection = PlotBand(
      isVisible: true,
      start: filterHours[0].date,
      end: firstTransition,
      associatedAxisStart: height - 10,
      associatedAxisEnd: height,
      text: showDayNight ? (sunset!.isBefore(sunrise!) ? "day" : "night") : "",
      color: sunset!.isBefore(sunrise!) ? dayColor : nightColor,
      //verticalTextPadding: '1%',
      textAngle: 0,
      //verticalTextAlignment: TextAnchor.start,
      borderWidth: 1,
    );
    final firstTransitionSection = PlotBand(
      isVisible: true,
      start: firstTransition,
      end: firstTransition.add(transitionMinutes),
      associatedAxisStart: height - 10,
      associatedAxisEnd: height,
      text: sunset!.isBefore(sunrise!) ? "sunset" : "sunrise",
      gradient: sunset!.isBefore(sunrise!) ? sunsetGradient : sunriseGradient,
      //verticalTextPadding: '1%',
      textAngle: 0,
      //verticalTextAlignment: TextAnchor.start,
      borderWidth: 1,
      //opacity: 0.5,
    );

    final middleSection = PlotBand(
      isVisible: true,
      start: firstTransition.add(transitionMinutes),
      end: secondTransition,
      associatedAxisStart: height - 10,
      associatedAxisEnd: height,
      text: showDayNight ? (sunset!.isBefore(sunrise!) ? "night" : "day") : "",
      color: sunset!.isBefore(sunrise!) ? nightColor : dayColor,
      //verticalTextPadding: '1%',
      textAngle: 0,
      //verticalTextAlignment: TextAnchor.start,
      borderWidth: 1,
    );

    final secondTransitionSection = PlotBand(
      isVisible: true,
      start: secondTransition,
      end: secondTransition.add(transitionMinutes),
      associatedAxisStart: height - 10,
      associatedAxisEnd: height,
      text: sunset!.isBefore(sunrise!) ? "sunrise" : "sunset",
      gradient: sunset!.isBefore(sunrise!) ? sunriseGradient : sunsetGradient,
      //verticalTextPadding: '1%',
      textAngle: 0,
      //verticalTextAlignment: TextAnchor.start,
      borderWidth: 1,
      //opacity: 0.5,
    );

    final lastSection = PlotBand(
      isVisible: true,
      start: secondTransition.add(transitionMinutes),
      end: filterHours.last.date,
      associatedAxisStart: height - 10,
      associatedAxisEnd: height,
      text: showDayNight ? (sunset!.isBefore(sunrise!) ? "day" : "night") : "",
      color: sunset!.isBefore(sunrise!) ? dayColor : nightColor,
      //verticalTextPadding: '1%',
      textAngle: 0,
      //verticalTextAlignment: TextAnchor.start,
      borderWidth: 1,
    );
    return [
      nowMarker,
      sunsetMarker,
      sunriseMarker,
      firstSection,
      firstTransitionSection,
      middleSection,
      secondTransitionSection,
      lastSection,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final previousHour = now.subtract(Duration(
      hours: 1,
      minutes: now.minute,
      seconds: now.second,
      milliseconds: now.millisecond,
      microseconds: now.microsecond,
    ));

    final List<Weather> filterHours = forecast
        .where((hourly) => hourly.date.isAfter(previousHour))
        .take(25)
        .toList();

    final maxTemp = filterHours
        .reduce((curr, next) =>
            curr.temperature.value > next.temperature.value ? curr : next)
        .temperature
        .value;
    final maximumXValue = (maxTemp < 70) ? 90.0 : maxTemp + 20;

    // TEMPERATURE GRAPH
    final temperatureSeries = _getTemperatureSeries(filterHours: filterHours);
    final temperatureAxis = NumericAxis(
        name: "Temperature",
        title: AxisTitle(
          text: "Temperature (°${units.isCelsius ? 'C' : 'F'})",
        ),
        maximum: maximumXValue);

    // PRECIPITATION GRAPH
    final precipitationSeries =
        _getPrecipitationSeries(filterHours: filterHours);
    const precipitationAxis = NumericAxis(
        name: "Precipitation",
        opposedPosition: true,
        title: AxisTitle(text: "precipitation (in)"),
        minimum: 0,
        maximum: 1,
        majorGridLines: MajorGridLines(width: 0));

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        bool isMobile = constraints.maxWidth < 400;

        final plotBands = _getPlotBands(
            filterHours: filterHours,
            height: maximumXValue,
            showDayNight: !isMobile);
        return Center(
          child: Column(
            children: [
              HourlyForecastIconsWidget(filterHours: filterHours, units: units),
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    dateFormat: isMobile ? DateFormat('ha') : DateFormat('h a'),
                    intervalType: DateTimeIntervalType.hours,
                    //minimum: currentHour,
                    interval: isMobile ? 2 : 1,
                    minorTicksPerInterval: isMobile ? 1 : 0,
                    plotBands: plotBands,
                  ),
                  axes: const [precipitationAxis],
                  primaryYAxis: temperatureAxis,
                  series: <CartesianSeries<ChartData, DateTime>>[
                    temperatureSeries,
                    precipitationSeries
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

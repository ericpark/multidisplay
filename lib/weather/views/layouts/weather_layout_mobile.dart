import 'package:flutter/material.dart';
import 'package:multidisplay/weather/weather.dart';

class WeatherLayoutMobile extends StatelessWidget {
  const WeatherLayoutMobile({
    super.key,
    required this.weatherCubit,
    required this.sunriseAndSunset,
  });

  final WeatherCubit weatherCubit;
  final Map<String, DateTime> sunriseAndSunset;

  @override
  Widget build(BuildContext context) {
    return ListView(
      //direction: Axis.vertical,
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 400,
          child: CurrentWeatherWidget(
              // weather: weatherCubit.state.weather,
              // units: weatherCubit.state.temperatureUnits,
              /*onRefresh: () {
              timerBloc
                  .add(const TimerStarted(duration: defaultDuration));
              return context
                  .read<WeatherCubit>()
                  .refreshWeather(all: true);
            },*/
              ),
        ),
        SizedBox(
          height: 400,
          child: HourlyForecastPopulated(
            forecast: weatherCubit.state.hourlyForecast,
            units: weatherCubit.state.temperatureUnits,
            sunrise: sunriseAndSunset["sunrise"],
            sunset: sunriseAndSunset["sunset"],
            /*onRefresh: () {
              timerBloc
                  .add(const TimerStarted(duration: defaultDuration));
              return context
                  .read<WeatherCubit>()
                  .refreshWeather(hourly: true);
            },*/
          ),
        ),
        SizedBox(
          height: 450,
          child: DailyForecastPopulated(
            forecast: weatherCubit.state.dailyForecast,
            units: weatherCubit.state.temperatureUnits,
          ),
        ),
      ],
    );
  }
}

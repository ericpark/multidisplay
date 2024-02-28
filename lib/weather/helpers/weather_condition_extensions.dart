import 'package:multidisplay/weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

extension WeatherConditionExtensions on WeatherCondition {
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

  IconData get toWeatherIcon {
    switch (this) {
      case WeatherCondition.clear:
        return WeatherIcons.day_sunny;
      case WeatherCondition.rainy:
        return WeatherIcons.rain;
      case WeatherCondition.cloudy:
        return WeatherIcons.cloudy;
      case WeatherCondition.snowy:
        return WeatherIcons.snow;
      case WeatherCondition.unknown:
        return WeatherIcons.refresh;
    }
  }
}

import 'package:multidisplay/weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

extension WeatherConditionExtensions on WeatherCondition {
  IconData get toWeatherIcon {
    switch (this) {
      case WeatherCondition.clear:
        return WeatherIcons.day_sunny;
      case WeatherCondition.mainlyClear:
        return WeatherIcons.day_sunny;
      case WeatherCondition.partlyCloudy:
        return WeatherIcons.cloudy;
      case WeatherCondition.overcast:
        return WeatherIcons.day_sunny_overcast;
      case WeatherCondition.fog:
        return WeatherIcons.fog;
      case WeatherCondition.depositingRimeFog:
        return WeatherIcons.fog;
      case WeatherCondition.drizzleLight:
        return WeatherIcons.sprinkle;
      case WeatherCondition.drizzleModerate:
        return WeatherIcons.sprinkle;
      case WeatherCondition.drizzleDense:
        return WeatherIcons.sprinkle;
      case WeatherCondition.freezingRainLight:
        return WeatherIcons.rain_mix;
      case WeatherCondition.freezingDrizzleLight:
        return WeatherIcons.rain_mix;
      case WeatherCondition.freezingDrizzleHeavy:
        return WeatherIcons.sleet;
      case WeatherCondition.rainySlight:
        return WeatherIcons.rain;
      case WeatherCondition.rainyModerate:
        return WeatherIcons.rain;
      case WeatherCondition.rainyHeavy:
        return WeatherIcons.rain;
      case WeatherCondition.freezingRainHeavy:
        return WeatherIcons.sleet;
      case WeatherCondition.rainShowersSlight:
        return WeatherIcons.showers;
      case WeatherCondition.rainShowersModerate:
        return WeatherIcons.showers;
      case WeatherCondition.rainShowersViolent:
        return WeatherIcons.storm_showers;
      case WeatherCondition.thunderSlight:
        return WeatherIcons.thunderstorm;
      case WeatherCondition.thunderModerate:
        return WeatherIcons.thunderstorm;
      case WeatherCondition.thunderWithSlightHail:
        return WeatherIcons.thunderstorm;
      case WeatherCondition.thunderWithHeavyHail:
        return WeatherIcons.thunderstorm;
      case WeatherCondition.snowySlight:
        return WeatherIcons.snow;
      case WeatherCondition.snowyModerate:
        return WeatherIcons.snow;
      case WeatherCondition.snowyHeavy:
        return WeatherIcons.snow;
      case WeatherCondition.snowGrains:
        return WeatherIcons.snow;
      case WeatherCondition.snowShowersSlight:
        return WeatherIcons.snow;
      case WeatherCondition.snowShowersHeavy:
        return WeatherIcons.snow;
      case WeatherCondition.unknown:
        return Icons.error;
    }
  }

  String get toWeatherDescription {
    var result = name.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r" ");
    var finalResult = result[0].toUpperCase() + result.substring(1);

    return finalResult;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'daily_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeather _$DailyWeatherFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DailyWeather',
      json,
      ($checkedConvert) {
        final val = DailyWeather(
          time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
          temperature_2m_max: $checkedConvert(
              'temperature_2m_max', (v) => (v as num).toDouble()),
          temperature_2m_min: $checkedConvert(
              'temperature_2m_min', (v) => (v as num).toDouble()),
          precipitation_sum: $checkedConvert(
              'precipitation_sum', (v) => (v as num).toDouble()),
          weather_code:
              $checkedConvert('weather_code', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

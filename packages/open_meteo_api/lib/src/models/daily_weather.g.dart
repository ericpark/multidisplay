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
          sunrise:
              $checkedConvert('sunrise', (v) => DateTime.parse(v as String)),
          sunset: $checkedConvert('sunset', (v) => DateTime.parse(v as String)),
          precipitation_probability_max:
              $checkedConvert('precipitation_probability_max', (v) => v as int),
        );
        return val;
      },
    );

Map<String, dynamic> _$DailyWeatherToJson(DailyWeather instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'temperature_2m_max': instance.temperature_2m_max,
      'temperature_2m_min': instance.temperature_2m_min,
      'precipitation_sum': instance.precipitation_sum,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
      'precipitation_probability_max': instance.precipitation_probability_max,
      'weather_code': instance.weather_code,
    };

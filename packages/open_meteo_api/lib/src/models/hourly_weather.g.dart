// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'hourly_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyWeather _$HourlyWeatherFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HourlyWeather',
      json,
      ($checkedConvert) {
        final val = HourlyWeather(
          time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
          temperature_2m:
              $checkedConvert('temperature_2m', (v) => (v as num).toDouble()),
          precipitation:
              $checkedConvert('precipitation', (v) => (v as num).toDouble()),
          weather_code:
              $checkedConvert('weather_code', (v) => (v as num).toDouble()),
          soil_moisture_0_to_1cm: $checkedConvert(
              'soil_temperature_0cm', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

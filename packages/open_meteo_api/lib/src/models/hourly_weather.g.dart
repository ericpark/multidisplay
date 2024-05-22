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
          apparent_temperature: $checkedConvert(
              'apparent_temperature', (v) => (v as num).toDouble()),
          precipitation:
              $checkedConvert('precipitation', (v) => (v as num).toDouble()),
          weather_code:
              $checkedConvert('weather_code', (v) => (v as num).toDouble()),
          soil_moisture_0_to_1cm: $checkedConvert(
              'soil_moisture_0_to_1cm', (v) => (v as num).toDouble()),
          soil_moisture_1_to_3cm: $checkedConvert(
              'soil_moisture_1_to_3cm', (v) => (v as num).toDouble()),
          precipitation_probability: $checkedConvert(
              'precipitation_probability', (v) => (v as num).toInt()),
        );
        return val;
      },
    );

Map<String, dynamic> _$HourlyWeatherToJson(HourlyWeather instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'temperature_2m': instance.temperature_2m,
      'apparent_temperature': instance.apparent_temperature,
      'precipitation': instance.precipitation,
      'soil_moisture_0_to_1cm': instance.soil_moisture_0_to_1cm,
      'soil_moisture_1_to_3cm': instance.soil_moisture_1_to_3cm,
      'precipitation_probability': instance.precipitation_probability,
      'weather_code': instance.weather_code,
    };

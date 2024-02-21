// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather',
      json,
      ($checkedConvert) {
        final val = Weather(
          date: $checkedConvert(
              'date', (v) => const DateTimeConverter().fromJson(v as String)),
          location: $checkedConvert('location', (v) => v as String),
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()),
          temperatureHigh:
              $checkedConvert('temperature_high', (v) => (v as num).toDouble()),
          temperatureLow:
              $checkedConvert('temperature_low', (v) => (v as num).toDouble()),
          condition: $checkedConvert(
              'condition', (v) => $enumDecode(_$WeatherConditionEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'temperatureHigh': 'temperature_high',
        'temperatureLow': 'temperature_low'
      },
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'date': const DateTimeConverter().toJson(instance.date),
      'location': instance.location,
      'temperature': instance.temperature,
      'temperature_high': instance.temperatureHigh,
      'temperature_low': instance.temperatureLow,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};

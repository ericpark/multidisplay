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
          condition: $checkedConvert(
              'condition', (v) => $enumDecode(_$WeatherConditionEnumMap, v)),
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()),
          temperatureHigh: $checkedConvert(
              'temperature_high', (v) => (v as num?)?.toDouble()),
          temperatureLow: $checkedConvert(
              'temperature_low', (v) => (v as num?)?.toDouble()),
          precipitation:
              $checkedConvert('precipitation', (v) => (v as num?)?.toDouble()),
          soilMoisture:
              $checkedConvert('soil_moisture', (v) => (v as num?)?.toDouble()),
          soilCondition: $checkedConvert('soil_condition',
              (v) => $enumDecodeNullable(_$SoilConditionEnumMap, v)),
          sunrise: $checkedConvert(
              'sunrise', (v) => v == null ? null : DateTime.parse(v as String)),
          sunset: $checkedConvert(
              'sunset', (v) => v == null ? null : DateTime.parse(v as String)),
          precipitationProbability:
              $checkedConvert('precipitation_probability', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'temperatureHigh': 'temperature_high',
        'temperatureLow': 'temperature_low',
        'soilMoisture': 'soil_moisture',
        'soilCondition': 'soil_condition',
        'precipitationProbability': 'precipitation_probability'
      },
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'date': const DateTimeConverter().toJson(instance.date),
      'location': instance.location,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'temperature': instance.temperature,
      'temperature_high': instance.temperatureHigh,
      'temperature_low': instance.temperatureLow,
      'precipitation': instance.precipitation,
      'soil_moisture': instance.soilMoisture,
      'soil_condition': _$SoilConditionEnumMap[instance.soilCondition]!,
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
      'precipitation_probability': instance.precipitationProbability,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};

const _$SoilConditionEnumMap = {
  SoilCondition.dry: 'dry',
  SoilCondition.muddy: 'muddy',
  SoilCondition.unknown: 'unknown',
};

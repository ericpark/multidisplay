// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Temperature',
      json,
      ($checkedConvert) {
        final val = Temperature(
          value: $checkedConvert('value', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Weather',
      json,
      ($checkedConvert) {
        final val = Weather(
          condition: $checkedConvert(
              'condition', (v) => $enumDecode(_$WeatherConditionEnumMap, v)),
          lastUpdated: $checkedConvert(
              'last_updated', (v) => DateTime.parse(v as String)),
          date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
          location: $checkedConvert('location', (v) => v as String),
          temperature: $checkedConvert('temperature',
              (v) => Temperature.fromJson(v as Map<String, dynamic>)),
          temperatureHigh: $checkedConvert(
              'temperature_high',
              (v) => v == null
                  ? null
                  : Temperature.fromJson(v as Map<String, dynamic>)),
          temperatureLow: $checkedConvert(
              'temperature_low',
              (v) => v == null
                  ? null
                  : Temperature.fromJson(v as Map<String, dynamic>)),
          precipitation:
              $checkedConvert('precipitation', (v) => (v as num?)?.toDouble()),
          soilMoisture:
              $checkedConvert('soil_moisture', (v) => (v as num?)?.toDouble()),
          soilCondition: $checkedConvert('soil_condition',
              (v) => $enumDecodeNullable(_$SoilConditionEnumMap, v)),
        );
        return val;
      },
      fieldKeyMap: const {
        'lastUpdated': 'last_updated',
        'temperatureHigh': 'temperature_high',
        'temperatureLow': 'temperature_low',
        'soilMoisture': 'soil_moisture',
        'soilCondition': 'soil_condition'
      },
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'last_updated': instance.lastUpdated.toIso8601String(),
      'date': instance.date.toIso8601String(),
      'location': instance.location,
      'temperature': instance.temperature.toJson(),
      'temperature_high': instance.temperatureHigh.toJson(),
      'temperature_low': instance.temperatureLow.toJson(),
      'precipitation': instance.precipitation,
      'soil_moisture': instance.soilMoisture,
      'soil_condition': _$SoilConditionEnumMap[instance.soilCondition]!,
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

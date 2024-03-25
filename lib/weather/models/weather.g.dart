// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

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
        'lastUpdated': 'last_updated',
        'temperatureHigh': 'temperature_high',
        'temperatureLow': 'temperature_low',
        'soilMoisture': 'soil_moisture',
        'soilCondition': 'soil_condition',
        'precipitationProbability': 'precipitation_probability'
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
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
      'precipitation_probability': instance.precipitationProbability,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.mainlyClear: 'Mainly Clear',
  WeatherCondition.partlyCloudy: 'partlyCloudy',
  WeatherCondition.overcast: 'overcast',
  WeatherCondition.fog: 'fog',
  WeatherCondition.depositingRimeFog: 'depositingRimeFog',
  WeatherCondition.drizzleLight: 'drizzleLight',
  WeatherCondition.drizzleModerate: 'drizzleModerate',
  WeatherCondition.drizzleDense: 'drizzleDense',
  WeatherCondition.freezingDrizzleLight: 'freezingDrizzleLight',
  WeatherCondition.freezingDrizzleHeavy: 'freezingDrizzleHeavy',
  WeatherCondition.rainySlight: 'rainySlight',
  WeatherCondition.rainyModerate: 'rainyModerate',
  WeatherCondition.rainyHeavy: 'rainyHeavy',
  WeatherCondition.freezingRainLight: 'freezingRainLight',
  WeatherCondition.freezingRainHeavy: 'freezingRainHeavy',
  WeatherCondition.snowySlight: 'snowySlight',
  WeatherCondition.snowyModerate: 'snowyModerate',
  WeatherCondition.snowyHeavy: 'snowyHeavy',
  WeatherCondition.snowGrains: 'snowGrains',
  WeatherCondition.rainShowersSlight: 'rainShowersSlight',
  WeatherCondition.rainShowersModerate: 'rainShowersModerate',
  WeatherCondition.rainShowersViolent: 'rainShowersViolent',
  WeatherCondition.snowShowersSlight: 'snowShowersSlight',
  WeatherCondition.snowShowersHeavy: 'snowShowersHeavy',
  WeatherCondition.thunderSlight: 'thunderSlight',
  WeatherCondition.thunderModerate: 'thunderModerate',
  WeatherCondition.thunderWithSlightHail: 'thunderWithSlightHail',
  WeatherCondition.thunderWithHeavyHail: 'thunderWithHeavyHail',
  WeatherCondition.unknown: 'unknown',
};

const _$SoilConditionEnumMap = {
  SoilCondition.dry: 'dry',
  SoilCondition.muddy: 'muddy',
  SoilCondition.unknown: 'unknown',
};

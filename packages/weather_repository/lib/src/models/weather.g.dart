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
          position: $checkedConvert(
              'position',
              (v) => _$recordConvertNullable(
                    v,
                    ($jsonValue) => (
                      ($jsonValue[r'$1'] as num).toDouble(),
                      ($jsonValue[r'$2'] as num).toDouble(),
                    ),
                  )),
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
          precipitationProbability: $checkedConvert(
              'precipitation_probability', (v) => (v as num?)?.toInt()),
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
      'position': <String, dynamic>{
        r'$1': instance.position.$1,
        r'$2': instance.position.$2,
      },
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

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);

const _$SoilConditionEnumMap = {
  SoilCondition.dry: 'dry',
  SoilCondition.muddy: 'muddy',
  SoilCondition.unknown: 'unknown',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherState _$WeatherStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'WeatherState',
      json,
      ($checkedConvert) {
        final val = WeatherState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$WeatherStatusEnumMap, v) ??
                  WeatherStatus.initial),
          temperatureUnits: $checkedConvert(
              'temperature_units',
              (v) =>
                  $enumDecodeNullable(_$TemperatureUnitsEnumMap, v) ??
                  TemperatureUnits.fahrenheit),
          autoRefresh:
              $checkedConvert('auto_refresh', (v) => v as bool? ?? true),
          weather: $checkedConvert(
              'weather',
              (v) => v == null
                  ? null
                  : Weather.fromJson(v as Map<String, dynamic>)),
          dailyForecast: $checkedConvert(
              'daily_forecast',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
                  .toList()),
          hourlyForecast: $checkedConvert(
              'hourly_forecast',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'temperatureUnits': 'temperature_units',
        'autoRefresh': 'auto_refresh',
        'dailyForecast': 'daily_forecast',
        'hourlyForecast': 'hourly_forecast'
      },
    );

Map<String, dynamic> _$WeatherStateToJson(WeatherState instance) =>
    <String, dynamic>{
      'status': _$WeatherStatusEnumMap[instance.status]!,
      'temperature_units':
          _$TemperatureUnitsEnumMap[instance.temperatureUnits]!,
      'weather': instance.weather.toJson(),
      'auto_refresh': instance.autoRefresh,
      'daily_forecast': instance.dailyForecast.map((e) => e.toJson()).toList(),
      'hourly_forecast':
          instance.hourlyForecast.map((e) => e.toJson()).toList(),
    };

const _$WeatherStatusEnumMap = {
  WeatherStatus.initial: 'initial',
  WeatherStatus.loading: 'loading',
  WeatherStatus.success: 'success',
  WeatherStatus.failure: 'failure',
};

const _$TemperatureUnitsEnumMap = {
  TemperatureUnits.fahrenheit: 'fahrenheit',
  TemperatureUnits.celsius: 'celsius',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

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
          forecastStatus: $checkedConvert(
              'forecast_status',
              (v) =>
                  (v as Map<String, dynamic>?)?.map(
                    (k, e) =>
                        MapEntry(k, $enumDecode(_$WeatherStatusEnumMap, e)),
                  ) ??
                  const {
                    "current": WeatherStatus.initial,
                    "hourly": WeatherStatus.initial,
                    "daily": WeatherStatus.initial
                  }),
          temperatureUnits: $checkedConvert(
              'temperature_units',
              (v) =>
                  $enumDecodeNullable(_$TemperatureUnitsEnumMap, v) ??
                  TemperatureUnits.fahrenheit),
          autoRefresh:
              $checkedConvert('auto_refresh', (v) => v as bool? ?? true),
          position: $checkedConvert(
              'position',
              (v) => _$recordConvertNullable(
                    v,
                    ($jsonValue) => (
                      ($jsonValue[r'$1'] as num).toDouble(),
                      ($jsonValue[r'$2'] as num).toDouble(),
                    ),
                  )),
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
        'forecastStatus': 'forecast_status',
        'temperatureUnits': 'temperature_units',
        'autoRefresh': 'auto_refresh',
        'dailyForecast': 'daily_forecast',
        'hourlyForecast': 'hourly_forecast'
      },
    );

Map<String, dynamic> _$WeatherStateToJson(WeatherState instance) =>
    <String, dynamic>{
      'status': _$WeatherStatusEnumMap[instance.status]!,
      'forecast_status': instance.forecastStatus
          .map((k, e) => MapEntry(k, _$WeatherStatusEnumMap[e]!)),
      'temperature_units':
          _$TemperatureUnitsEnumMap[instance.temperatureUnits]!,
      'weather': instance.weather.toJson(),
      'auto_refresh': instance.autoRefresh,
      'daily_forecast': instance.dailyForecast.map((e) => e.toJson()).toList(),
      'hourly_forecast':
          instance.hourlyForecast.map((e) => e.toJson()).toList(),
      'position': instance.position == null
          ? null
          : {
              r'$1': instance.position!.$1,
              r'$2': instance.position!.$2,
            },
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

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);

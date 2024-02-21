import 'package:json_annotation/json_annotation.dart';

part 'daily_weather.g.dart';

@JsonSerializable()
class DailyWeather {
  DailyWeather({
    required this.time,
    required this.temperature_2m_max,
    required this.temperature_2m_min,
    required this.precipitation_sum,
    required this.weather_code,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherFromJson(json);

  final DateTime time;
  final double temperature_2m_max;
  final double temperature_2m_min;
  final double precipitation_sum;

  @JsonKey(name: 'weather_code')
  final double weather_code;
}

import 'package:json_annotation/json_annotation.dart';

part 'hourly_weather.g.dart';

@JsonSerializable()
class HourlyWeather {
  HourlyWeather({
    required this.time,
    required this.temperature_2m,
    required this.precipitation,
    required this.weather_code,
    required this.soil_moisture_0_to_1cm,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherFromJson(json);

  final DateTime time;
  final double temperature_2m;
  final double precipitation;
  final double soil_moisture_0_to_1cm;

  @JsonKey(name: 'weather_code')
  final double weather_code;
}

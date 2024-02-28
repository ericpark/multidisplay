import 'package:json_annotation/json_annotation.dart';

part 'hourly_weather.g.dart';

@JsonSerializable()
class HourlyWeather {
  HourlyWeather({
    required this.time,
    required this.temperature_2m,
    required this.apparent_temperature,
    required this.precipitation,
    required this.weather_code,
    required this.soil_moisture_0_to_1cm,
    required this.precipitation_probability,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherFromJson(json);

  final DateTime time;
  final double temperature_2m;
  final double apparent_temperature;
  final double precipitation;
  final double soil_moisture_0_to_1cm;
  final double precipitation_probability;

  @JsonKey(name: 'weather_code')
  final double weather_code;
}

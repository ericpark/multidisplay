import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'weather.g.dart';
/*
enum WeatherCondition {
  clear,
  @JsonValue("Mainly Clear")
  mainlyClear,
  partlyCloudy,
  overcast,
  fog,
  depositingRimeFog,
  drizzleLight,
  drizzleModerate,
  drizzleDense,
  freezingDrizzleLight,
  freezingDrizzleHeavy,
  rainySlight,
  rainyModerate,
  rainyHeavy,
  freezingRainLight,
  freezingRainHeavy,
  snowySlight,
  snowyModerate,
  snowyHeavy,
  snowGrains,
  rainShowersSlight,
  rainShowersModerate,
  rainShowersViolent,
  snowShowersSlight,
  snowShowersHeavy,
  thunderSlight,
  thunderModerate,
  thunderWithSlightHail,
  thunderWithHeavyHail,
  unknown,
}*/

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}

@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.date,
    required this.location,
    required this.temperature,
    required this.temperatureHigh,
    required this.temperatureLow,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @DateTimeConverter()
  final DateTime date;
  final String location;
  final double temperature;
  final double temperatureHigh;
  final double temperatureLow;
  final WeatherCondition condition;

  @override
  List<Object> get props =>
      [date, location, temperature, temperatureHigh, temperatureLow, condition];
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => DateFormat("yyyy-MM-dd").format(object);
}

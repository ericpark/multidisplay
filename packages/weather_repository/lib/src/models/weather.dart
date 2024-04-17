import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'weather.g.dart';

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
}

/*
enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  unknown,
}
*/
enum SoilCondition {
  dry,
  muddy,
  unknown,
}

@JsonSerializable()
class Weather extends Equatable {
  Weather({
    required this.date,
    required this.location,
    required this.condition,
    required this.temperature,
    (double, double)? position,
    double? temperatureHigh,
    double? temperatureLow,
    double? precipitation,
    double? soilMoisture,
    SoilCondition? soilCondition,
    DateTime? sunrise,
    DateTime? sunset,
    int? precipitationProbability,
  })  : precipitation = precipitation ?? 0.0,
        temperatureHigh = temperatureHigh ?? temperature,
        temperatureLow = temperatureLow ?? temperature,
        soilMoisture = soilMoisture ?? 0.0,
        soilCondition = soilCondition ?? SoilCondition.unknown,
        sunrise = sunrise ?? DateTime.now(),
        sunset = sunset ?? DateTime.now(),
        precipitationProbability = precipitationProbability ?? 0,
        position = position ?? (40.6501, -73.94958);

  @DateTimeConverter()
  final DateTime date;
  final String location;
  final WeatherCondition condition;
  final double temperature;
  final double temperatureHigh;
  final double temperatureLow;
  final double precipitation;
  final double soilMoisture;
  final SoilCondition soilCondition;
  final DateTime sunrise;
  final DateTime sunset;
  final int precipitationProbability;
  final (double, double) position;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object> get props => [
        date,
        location,
        condition,
        temperature,
        temperatureHigh,
        temperatureLow,
        precipitation,
        soilMoisture,
        soilCondition,
        sunrise,
        sunset,
        precipitationProbability,
        position,
      ];
}

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => DateFormat("yyyy-MM-dd").format(object);
}

class Position extends Equatable {
  const Position({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [latitude, longitude];
}

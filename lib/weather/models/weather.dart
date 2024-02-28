import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

part 'weather.g.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

@JsonSerializable()
class Temperature extends Equatable {
  const Temperature({required this.value});

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  final double value;

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);

  @override
  List<Object> get props => [value];
}

@JsonSerializable()
class Weather extends Equatable {
  const Weather({
    required this.condition,
    required this.lastUpdated,
    required this.date,
    required this.location,
    required this.temperature,
    Temperature? temperatureHigh,
    Temperature? temperatureLow,
  })  : temperatureHigh = temperatureHigh ?? temperature,
        temperatureLow = temperatureLow ?? temperature;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  factory Weather.fromRepository(weather_repository.Weather weather) {
    return Weather(
      condition: weather.condition,
      lastUpdated: DateTime.now(),
      date: weather.date,
      location: weather.location,
      temperature: Temperature(value: weather.temperature),
      temperatureHigh: Temperature(value: weather.temperatureHigh),
      temperatureLow: Temperature(value: weather.temperatureLow),
    );
  }

  static final empty = Weather(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    date: DateTime(0),
    temperature: const Temperature(value: 0),
    temperatureHigh: const Temperature(value: 0),
    temperatureLow: const Temperature(value: 0),
    location: '--',
  );

  final WeatherCondition condition;
  final DateTime lastUpdated;
  final DateTime date;
  final String location;
  final Temperature temperature;
  final Temperature temperatureHigh;
  final Temperature temperatureLow;

  @override
  List<Object> get props => [
        condition,
        lastUpdated,
        date,
        location,
        temperature,
        temperatureHigh,
        temperatureLow
      ];

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  Weather copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    DateTime? date,
    String? location,
    Temperature? temperature,
    Temperature? temperatureHigh,
    Temperature? temperatureLow,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      date: date ?? this.date,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
      temperatureHigh: temperatureHigh ?? this.temperatureHigh,
      temperatureLow: temperatureLow ?? this.temperatureLow,
    );
  }
}

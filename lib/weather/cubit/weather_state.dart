part of 'weather_cubit.dart';

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}

@JsonSerializable()
class WeatherState extends Equatable {
  WeatherState(
      {this.status = WeatherStatus.initial,
      this.temperatureUnits = TemperatureUnits.fahrenheit,
      Weather? weather,
      List<Weather>? forecast})
      : weather = weather ?? Weather.empty,
        dailyForecast = forecast ?? [Weather.empty];

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  final WeatherStatus status;
  final Weather weather; // Current Weather
  final TemperatureUnits temperatureUnits;
  final List<Weather> dailyForecast; // Daily Forecast

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    Weather? weather,
    List<Weather>? forecast,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weather: weather ?? this.weather,
      forecast: forecast ?? dailyForecast,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [status, temperatureUnits, weather, dailyForecast];
}

final class WeatherInitial extends WeatherState {}

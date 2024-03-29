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
      this.autoRefresh = true,
      Weather? weather,
      List<Weather>? dailyForecast,
      List<Weather>? hourlyForecast})
      : weather = weather ?? Weather.empty,
        dailyForecast = dailyForecast ?? [Weather.empty],
        hourlyForecast = hourlyForecast ?? [Weather.empty];

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  final WeatherStatus status;
  final TemperatureUnits temperatureUnits;
  final Weather weather; // Current Weather

  final bool autoRefresh;
  final List<Weather> dailyForecast; // Daily Forecast
  final List<Weather> hourlyForecast; // Daily Forecast

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    bool? autoRefresh,
    Weather? weather,
    List<Weather>? dailyForecast,
    List<Weather>? hourlyForecast,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      autoRefresh: autoRefresh ?? this.autoRefresh,
      weather: weather ?? this.weather,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [
        status,
        temperatureUnits,
        autoRefresh,
        weather,
        dailyForecast,
        hourlyForecast
      ];
}

final class WeatherInitial extends WeatherState {}

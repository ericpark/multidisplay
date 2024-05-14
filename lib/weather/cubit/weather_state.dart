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
      this.forecastStatus = const {
        'current': WeatherStatus.initial,
        'hourly': WeatherStatus.initial,
        'daily': WeatherStatus.initial,
      },
      this.temperatureUnits = TemperatureUnits.fahrenheit,
      this.autoRefresh = true,
      this.position,
      Weather? weather,
      List<Weather>? dailyForecast,
      List<Weather>? hourlyForecast,})
      : weather = weather ?? Weather.empty,
        dailyForecast = dailyForecast ?? [Weather.empty],
        hourlyForecast = hourlyForecast ?? [Weather.empty];

  factory WeatherState.fromJson(Map<String, dynamic> json) =>
      _$WeatherStateFromJson(json);

  final WeatherStatus status;

  /// Used to track individual data refreshes
  final Map<String, WeatherStatus> forecastStatus;
  final TemperatureUnits temperatureUnits;
  final Weather weather; // Current Weather

  final bool autoRefresh;
  final List<Weather> dailyForecast; // Daily Forecast
  final List<Weather> hourlyForecast; // Hourly Forecast
  final (double, double)? position; // Hourly Forecast

  WeatherState copyWith({
    WeatherStatus? status,
    Map<String, WeatherStatus>? forecastStatus,
    TemperatureUnits? temperatureUnits,
    bool? autoRefresh,
    Weather? weather,
    List<Weather>? dailyForecast,
    List<Weather>? hourlyForecast,
    (double, double)? position,
  }) {
    return WeatherState(
      status: status ?? this.status,
      forecastStatus: forecastStatus ?? this.forecastStatus,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      autoRefresh: autoRefresh ?? this.autoRefresh,
      weather: weather ?? this.weather,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherStateToJson(this);

  @override
  List<Object?> get props => [
        status,
        forecastStatus,
        temperatureUnits,
        autoRefresh,
        weather,
        dailyForecast,
        hourlyForecast,
        position,
      ];
}

final class WeatherInitial extends WeatherState {}

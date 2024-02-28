import 'package:equatable/equatable.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;
part 'weather_state.dart';

part 'weather_cubit.g.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = Weather.fromRepository(
        await _weatherRepository.getWeather(city),
      );
      final fetchedDailyForecasts =
          await _weatherRepository.getDailyWeatherForecast(city);
      final fetchedHourlyForecasts =
          await _weatherRepository.getHourlyWeatherForecast(city);

      final units = state.temperatureUnits;

      // Convert temperatures from F to C if needed.
      final value = units.isFahrenheit
          ? weather.temperature.value
          : weather.temperature.value.toCelsius();

      // Convert temperatures from F to C if needed.
      List<Weather> dailyForecast = [];
      for (var w in fetchedDailyForecasts) {
        Weather forecastWeather = Weather.fromRepository(w);
        double forecastWeatherTempHigh = units.isFahrenheit
            ? forecastWeather.temperatureHigh.value
            : forecastWeather.temperatureHigh.value.toCelsius();
        double forecastWeatherTempLow = units.isFahrenheit
            ? forecastWeather.temperatureLow.value
            : forecastWeather.temperatureLow.value.toCelsius();
        dailyForecast.add(forecastWeather.copyWith(
          temperatureHigh: Temperature(value: forecastWeatherTempHigh),
          temperatureLow: Temperature(value: forecastWeatherTempLow),
        ));
      }

      // Convert temperatures from F to C if needed.
      List<Weather> hourlyForecast = [];
      for (var w in fetchedHourlyForecasts) {
        Weather forecastWeather = Weather.fromRepository(w);
        double forecastWeatherTempHigh = units.isFahrenheit
            ? forecastWeather.temperatureHigh.value
            : forecastWeather.temperatureHigh.value.toCelsius();
        double forecastWeatherTempLow = units.isFahrenheit
            ? forecastWeather.temperatureLow.value
            : forecastWeather.temperatureLow.value.toCelsius();
        hourlyForecast.add(forecastWeather.copyWith(
          temperatureHigh: Temperature(value: forecastWeatherTempHigh),
          temperatureLow: Temperature(value: forecastWeatherTempLow),
        ));
      }

      emit(state.copyWith(
        status: WeatherStatus.success,
        temperatureUnits: units,
        weather: weather.copyWith(temperature: Temperature(value: value)),
        dailyForecast: dailyForecast,
        hourlyForecast: hourlyForecast,
      ));
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weather == Weather.empty) return;
    try {
      final weather = Weather.fromRepository(
        await _weatherRepository.getWeather(state.weather.location),
      );

      final fetchedDailyForecasts = await _weatherRepository
          .getDailyWeatherForecast(state.weather.location);
      final fetchedHourlyForecasts = await _weatherRepository
          .getHourlyWeatherForecast(state.weather.location);

      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value
          : weather.temperature.value.toCelsius();

      List<Weather> dailyForecast = [];
      for (var w in fetchedDailyForecasts) {
        Weather forecastWeather = Weather.fromRepository(w);
        double forecastWeatherTempHigh = units.isFahrenheit
            ? forecastWeather.temperatureHigh.value
            : forecastWeather.temperatureHigh.value.toCelsius();
        double forecastWeatherTempLow = units.isFahrenheit
            ? forecastWeather.temperatureLow.value
            : forecastWeather.temperatureLow.value.toCelsius();
        dailyForecast.add(forecastWeather.copyWith(
          temperatureHigh: Temperature(value: forecastWeatherTempHigh),
          temperatureLow: Temperature(value: forecastWeatherTempLow),
        ));
      }

      // Convert temperatures from F to C if needed.
      List<Weather> hourlyForecast = [];
      for (var w in fetchedHourlyForecasts) {
        Weather forecastWeather = Weather.fromRepository(w);
        double forecastWeatherTempHigh = units.isFahrenheit
            ? forecastWeather.temperatureHigh.value
            : forecastWeather.temperatureHigh.value.toCelsius();
        double forecastWeatherTempLow = units.isFahrenheit
            ? forecastWeather.temperatureLow.value
            : forecastWeather.temperatureLow.value.toCelsius();
        hourlyForecast.add(forecastWeather.copyWith(
          temperatureHigh: Temperature(value: forecastWeatherTempHigh),
          temperatureLow: Temperature(value: forecastWeatherTempLow),
        ));
      }
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value)),
          dailyForecast: dailyForecast,
          hourlyForecast: hourlyForecast,
        ),
      );
    } on Exception {
      emit(state);
    }
  }

  void toggleAutoRefresh() {
    final autoRefresh = state.autoRefresh;
    emit(
      state.copyWith(autoRefresh: !autoRefresh),
    );
  }

  void toggleUnits() {
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    if (!state.status.isSuccess) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    final weather = state.weather;
    if (weather != Weather.empty) {
      final temperature = weather.temperature;
      final value = units.isCelsius
          ? temperature.value.toCelsius()
          : temperature.value.toFahrenheit();
      List<Weather> dailyForecast = [];
      for (var i = 0; i < state.dailyForecast.length; i++) {
        Weather forecastWeather = state.dailyForecast[i];
        double forecastWeatherTempHigh = units.isCelsius
            ? forecastWeather.temperatureHigh.value.toCelsius()
            : forecastWeather.temperatureHigh.value.toFahrenheit();
        double forecastWeatherTempLow = units.isCelsius
            ? forecastWeather.temperatureLow.value.toCelsius()
            : forecastWeather.temperatureLow.value.toFahrenheit();
        dailyForecast.add(forecastWeather.copyWith(
          temperatureHigh: Temperature(value: forecastWeatherTempHigh),
          temperatureLow: Temperature(value: forecastWeatherTempLow),
        ));
      }
      emit(
        state.copyWith(
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value)),
          dailyForecast: dailyForecast,
        ),
      );
    }
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}

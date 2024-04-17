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

  Future<void> fetchWeatherWithCity(String? city,
      {double? latitude, double? longitude}) async {
    if (city == null || city.isEmpty) return;

    (double, double)? position;
    if (latitude != null && longitude != null) {
      position = (latitude, longitude);
    } else {
      position = state.position;
    }
    emit(state.copyWith(
        status: WeatherStatus.loading,
        position: position,
        weather: (Weather.empty.copyWith(location: city))));

    try {
      final units = state.temperatureUnits;
      Weather currentWeather = await getCurrentWeather();
      List<Weather> hourlyForecast = await getHourlyWeather();
      List<Weather> dailyForecast = await getDailyWeather();

      emit(state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: currentWeather,
          dailyForecast: dailyForecast,
          hourlyForecast: hourlyForecast,
          forecastStatus: {
            "current": WeatherStatus.success,
            "hourly": WeatherStatus.success,
            "daily": WeatherStatus.success,
          }));
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<Weather> getCurrentWeather() async {
    try {
      final weather = Weather.fromRepository(
        await _weatherRepository.getWeather(state.weather.location,
            latitude: state.position?.$1, longitude: state.position?.$2),
      );

      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value
          : weather.temperature.value.toCelsius();
      return weather.copyWith(temperature: Temperature(value: value));
    } on Exception {
      return state.weather;
    }
  }

  Map<String, DateTime> getNextSunriseAndSunset() {
    DateTime now = DateTime.now();
    DateTime currentHour = DateTime.now().subtract(Duration(
        hours: 1,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond));
    List<Weather> nextSunrise = state.dailyForecast
        .where((daily) => daily.sunrise.isAfter(currentHour))
        .take(1)
        .toList();
    List<Weather> nextSunset = state.dailyForecast
        .where((daily) => daily.sunset.isAfter(currentHour))
        .take(1)
        .toList();
    return {"sunrise": nextSunrise[0].sunrise, "sunset": nextSunset[0].sunset};
  }

  Future<List<Weather>> getHourlyWeather() async {
    try {
      final fetchedHourlyForecasts = await _weatherRepository
          .getHourlyWeatherForecast(state.weather.location,
              latitude: state.position?.$1, longitude: state.position?.$2);

      // Convert temperatures from F to C if needed.
      final units = state.temperatureUnits;
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
      return hourlyForecast;
    } on Exception {
      return state.hourlyForecast;
    }
  }

  Future<List<Weather>> getDailyWeather() async {
    try {
      final fetchedDailyForecasts = await _weatherRepository
          .getDailyWeatherForecast(state.weather.location,
              latitude: state.position?.$1, longitude: state.position?.$2);

      final units = state.temperatureUnits;

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
      return dailyForecast;
    } on Exception {
      return state.dailyForecast;
    }
  }

  Future<void> refreshWeather(
      {bool all = false,
      bool current = false,
      bool hourly = false,
      bool daily = false}) async {
    if (!state.status.isSuccess) return;
    if (state.weather == Weather.empty) return;
    try {
      final units = state.temperatureUnits;

      var forecastStatus = {
        "current": (current || all)
            ? WeatherStatus.loading
            : state.forecastStatus["current"] ?? WeatherStatus.failure,
        "hourly": (hourly || all)
            ? WeatherStatus.loading
            : state.forecastStatus["hourly"] ?? WeatherStatus.failure,
        "daily": (daily || all)
            ? WeatherStatus.loading
            : state.forecastStatus["daily"] ?? WeatherStatus.failure,
      };
      emit(state.copyWith(forecastStatus: forecastStatus));
      Weather currentWeather =
          current || all ? await getCurrentWeather() : state.weather;
      List<Weather> hourlyForecast =
          hourly || all ? await getHourlyWeather() : state.hourlyForecast;
      List<Weather> dailyForecast =
          daily || all ? await getDailyWeather() : state.dailyForecast;
      forecastStatus = {
        "current": WeatherStatus.success,
        "hourly": WeatherStatus.success,
        "daily": WeatherStatus.success,
      };
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          forecastStatus: forecastStatus,
          temperatureUnits: units,
          weather: currentWeather,
          dailyForecast: dailyForecast,
          hourlyForecast: hourlyForecast,
        ),
      );
    } on Exception {
      emit(state);
    }
  }

  void handlePeriodicRefresh() {
    DateTime current = DateTime.now();
    bool shouldRefreshCurrent = false;
    bool shouldRefreshHourly = false;
    bool shouldRefreshDaily = false;

    if (!state.autoRefresh) {
      return; // Break if autoRefresh is disabled.
    }

    if ((current.hour == 0) && (current.minute == 1)) {
      refreshWeather(all: true); // At 12:01 AM, fetch all
      return;
    }

    if ((current.hour == 0) && (current.minute < 15)) {
      return; // Don't fetch until after 15 minutes past midnight
    }

    // check how long last updated has been to update data.
    if (current.difference(state.dailyForecast[0].lastUpdated).inSeconds >
        7199) {
      shouldRefreshDaily = true;
    }
    if (current.difference(state.hourlyForecast[0].lastUpdated).inSeconds >
        1799) {
      shouldRefreshHourly = true;
    }
    if (current.difference(state.weather.lastUpdated).inSeconds > 299) {
      shouldRefreshCurrent = true;
    }

    if (shouldRefreshCurrent || shouldRefreshHourly || shouldRefreshDaily) {
      refreshWeather(
        current: shouldRefreshCurrent,
        hourly: shouldRefreshHourly,
        daily: shouldRefreshDaily,
      );
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

import 'dart:async';

import 'package:open_meteo_api/open_meteo_api.dart' hide Weather;
import 'package:weather_repository/weather_repository.dart';

class WeatherRepository {
  WeatherRepository({OpenMeteoApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenMeteoApiClient();

  final OpenMeteoApiClient _weatherApiClient;

  Future<Weather> getWeather(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final weather = await _weatherApiClient.getCurrentWeather(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    DateTime now = DateTime.now();
    return Weather(
      date: DateTime.parse(
          '${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}'),
      temperature: weather.temperature,
      temperatureHigh: weather.temperature,
      temperatureLow: weather.temperature,
      location: location.name,
      condition: weather.weatherCode.toInt().toCondition,
    );
  }

  Future<List<Weather>> getWeatherForecast(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final forecast = await _weatherApiClient.getWeatherForecast(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    List<Weather> weather_forecast = [];
    for (var weather in forecast) {
      weather_forecast.add(Weather(
        temperature: weather.temperature_2m_max,
        date: weather.time,
        temperatureHigh: weather.temperature_2m_max,
        temperatureLow: weather.temperature_2m_min,
        location: location.name,
        condition: weather.weather_code.toInt().toCondition,
      ));
    }
    return weather_forecast;
  }
}

extension on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      case 2:
      case 3:
      case 45:
      case 48:
        return WeatherCondition.cloudy;
      case 51:
      case 53:
      case 55:
      case 56:
      case 57:
      case 61:
      case 63:
      case 65:
      case 66:
      case 67:
      case 80:
      case 81:
      case 82:
      case 95:
      case 96:
      case 99:
        return WeatherCondition.rainy;
      case 71:
      case 73:
      case 75:
      case 77:
      case 85:
      case 86:
        return WeatherCondition.snowy;
      default:
        return WeatherCondition.unknown;
    }
  }
}

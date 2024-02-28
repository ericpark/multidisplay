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

  Future<List<Weather>> getDailyWeatherForecast(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final forecast = await _weatherApiClient.getDailyWeatherForecast(
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

  Future<List<Weather>> getHourlyWeatherForecast(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final forecast = await _weatherApiClient.getHourlyWeatherForecast(
      latitude: location.latitude,
      longitude: location.longitude,
    );

    List<Weather> weather_forecast = [];
    for (var weather in forecast) {
      weather_forecast.add(Weather(
        temperature: weather.temperature_2m,
        date: weather.time,
        location: location.name,
        condition: weather.weather_code.toInt().toCondition,
        soilMoisture: weather.soil_moisture_0_to_1cm,
      ));
    }
    return weather_forecast;
  }
}

// This is kind of specific to open meteo and should be moved to open_meteo_api
// and this should be saved for converting into repository level fields later.
extension on int {
  WeatherCondition get toCondition {
    switch (this) {
      case 0:
        return WeatherCondition.clear;
      case 1:
      //return WeatherCondition.mainlyClear;
      case 2:
      //return WeatherCondition.partlyCloudy;
      case 3:
      //return WeatherCondition.overcast;
      case 45:
      // return WeatherCondition.fog;
      case 48:
        return WeatherCondition.cloudy;
      //return WeatherCondition.depositingRimeFog;
      case 51:
      //return WeatherCondition.drizzleLight;
      case 53:
      //return WeatherCondition.drizzleModerate;
      case 55:
      //return WeatherCondition.drizzleDense;
      case 56:
      //return WeatherCondition.freezingRainLight;
      case 57:
      //return WeatherCondition.freezingDrizzleHeavy;
      case 61:
      //return WeatherCondition.rainySlight;
      case 63:
      //return WeatherCondition.rainyModerate;
      case 65:
      //return WeatherCondition.rainyHeavy;
      case 66:
      //return WeatherCondition.freezingRainLight;
      case 67:
      //return WeatherCondition.freezingRainHeavy;
      case 80:
      //return WeatherCondition.rainShowersSlight;
      case 81:
      //return WeatherCondition.rainShowersModerate;
      case 82:
      //return WeatherCondition.rainShowersViolent;
      case 95:
      //return WeatherCondition.thunderSlight;
      case 96:
      //return WeatherCondition.thunderModerate;
      case 99:
        return WeatherCondition.rainy;
      //return WeatherCondition.thunderWithHeavyHail;
      case 71:
      //return WeatherCondition.snowySlight;
      case 73:
      //return WeatherCondition.snowyModerate;
      case 75:
      //return WeatherCondition.snowyHeavy;
      case 77:
      //return WeatherCondition.snowGrains;
      case 85:
      //return WeatherCondition.snowShowersSlight;
      case 86:
        return WeatherCondition.snowy;

      //return WeatherCondition.snowShowersHeavy;
      default:
        return WeatherCondition.unknown;
    }
  }
}

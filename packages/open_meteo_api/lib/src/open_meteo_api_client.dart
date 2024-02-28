import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_meteo_api/open_meteo_api.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

/// Dart API Client which wraps the [Open Meteo API](https://open-meteo.com).
class OpenMeteoApiClient {
  /// {@macro open_meteo_api_client}
  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlWeather = 'api.open-meteo.com';
  static const _baseUrlGeocoding = 'geocoding-api.open-meteo.com';

  final http.Client _httpClient;

  /// Finds a [Location] `/v1/search/?name=(query)`.
  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '1'},
    );

    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final locationJson = jsonDecode(locationResponse.body) as Map;

    if (!locationJson.containsKey('results')) throw LocationNotFoundFailure();

    final results = locationJson['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();

    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  /// Fetches [Weather] for a given [latitude] and [longitude].
  Future<Weather> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final weatherRequest = Uri.https(_baseUrlWeather, 'v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true',
      'temperature_unit': 'fahrenheit',
      'timezone': 'America/New_York',
      'precipitation_unit': 'inch',
    });

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['current_weather'] as Map<String, dynamic>;

    return Weather.fromJson(weatherJson);
  }

  /// Fetches List[Weather] for a given [latitude] and [longitude].
  Future<List<DailyWeather>> getDailyWeatherForecast(
      {required double latitude,
      required double longitude,
      int forecast_days = 7}) async {
    final weatherRequest = Uri.https(_baseUrlWeather, 'v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'temperature_unit': 'fahrenheit',
      'timezone': 'America/New_York',
      'forecast_days': '7',
      'precipitation_unit': 'inch',
      'daily':
          'weather_code,precipitation_sum,temperature_2m_max,temperature_2m_min'
    });
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('daily')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['daily'] as Map<String, dynamic>;
    return zipMaps(weatherJson).map<DailyWeather>((json) {
      return new DailyWeather.fromJson(json);
    }).toList();
  }

  /// Fetches List[Weather] for a given [latitude] and [longitude].
  Future<List<HourlyWeather>> getHourlyWeatherForecast(
      {required double latitude,
      required double longitude,
      int forecast_days = 7}) async {
    final weatherRequest = Uri.https(_baseUrlWeather, 'v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'temperature_unit': 'fahrenheit',
      'timezone': 'America/New_York',
      'forecast_days': '7',
      'precipitation_unit': 'inch',
      'hourly':
          'weather_code,precipitation,temperature_2m,soil_moisture_0_to_1cm'
    });
    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final bodyJson = jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (!bodyJson.containsKey('hourly')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson = bodyJson['hourly'] as Map<String, dynamic>;
    return zipMaps(weatherJson).map<HourlyWeather>((json) {
      return new HourlyWeather.fromJson(json);
    }).toList();
  }

  /// Fetches List[dynamic] json objects for a given [bodyjson]

  List<dynamic> zipMaps(Map<String, dynamic> bodyJson) {
    List<dynamic> zippedList = [];

    if (bodyJson.isNotEmpty) {
      // Assuming all lists have the same length
      int length = (bodyJson.values.toList()[0] as List<dynamic>).length;

      for (int i = 0; i < length; i++) {
        Map<String, dynamic> zippedMap = {};
        bodyJson.forEach((key, value) {
          zippedMap[key] = value[i];
        });

        zippedList.add(zippedMap);
      }
    }

    return zippedList;
  }
}

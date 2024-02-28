// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:open_meteo_api/open_meteo_api.dart';
import 'package:test/test.dart';
import 'dart:io';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenMeteoApiClient', () {
    late http.Client httpClient;
    late OpenMeteoApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = OpenMeteoApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenMeteoApiClient(), isNotNull);
      });
    });

    group('locationSearch', () {
      const query = 'mock-query';
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.locationSearch(query);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'geocoding-api.open-meteo.com',
              '/v1/search',
              {'name': query, 'count': '1'},
            ),
          ),
        ).called(1);
      });

      test('throws LocationRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.locationSearch(query),
          throwsA(isA<LocationRequestFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on error response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('throws LocationNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{"results": []}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        await expectLater(
          apiClient.locationSearch(query),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('returns Location on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
          {
            "results": [
              {
                "id": 4887398,
                "name": "Chicago",
                "latitude": 41.85003,
                "longitude": -87.65005
              }
            ]
          }''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.locationSearch(query);
        expect(
          actual,
          isA<Location>()
              .having((l) => l.name, 'name', 'Chicago')
              .having((l) => l.id, 'id', 4887398)
              .having((l) => l.latitude, 'latitude', 41.85003)
              .having((l) => l.longitude, 'longitude', -87.65005),
        );
      });
    });

    group('getWeather', () {
      const latitude = 41.85003;
      const longitude = -87.6500;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getCurrentWeather(
              latitude: latitude, longitude: longitude);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('api.open-meteo.com', 'v1/forecast', {
              'latitude': '$latitude',
              'longitude': '$longitude',
              'current_weather': 'true',
              'temperature_unit': 'fahrenheit',
              'timezone': 'America/New_York',
              'precipitation_unit': 'inch'
            }),
          ),
        ).called(1);
      });

      test('throws WeatherRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getCurrentWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getCurrentWeather(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });

      test('returns weather on valid response', () async {
        String sampleCurrentResult =
            File('test/json/current_forecast.json').readAsStringSync();
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(sampleCurrentResult);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getCurrentWeather(
          latitude: latitude,
          longitude: longitude,
        );
        expect(
          actual,
          isA<Weather>()
              .having((w) => w.temperature, 'temperature', 15.3)
              .having((w) => w.weatherCode, 'weatherCode', 63.0),
        );
      });
    });
    group('getDailyWeatherForecasts', () {
      const latitude = 41.85003;
      const longitude = -87.6500;
      test('returns daily forecast on valid response', () async {
        String sampleDailyForecastResult =
            File('test/json/daily_forecast.json').readAsStringSync();
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(sampleDailyForecastResult);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getDailyWeatherForecast(
          latitude: latitude,
          longitude: longitude,
        );
        expect(
          actual,
          isA<List<DailyWeather>>()
              .having((f) => f.length, 'length', 7)
              .having((f) => f[0].weather_code, 'weatherCode', 63.0),
        );
      });

      test('throws WeatherRequestFailure on non-200 daily response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getDailyWeatherForecast(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty  response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getDailyWeatherForecast(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });
    });

    group('getHourlyWeatherForecasts', () {
      const latitude = 41.85003;
      const longitude = -87.6500;
      test('returns hourly forecast on valid response', () async {
        String sampleHourlyForecastResult =
            File('test/json/hourly_forecast.json').readAsStringSync();
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(sampleHourlyForecastResult);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.getHourlyWeatherForecast(
          latitude: latitude,
          longitude: longitude,
        );
        expect(
          actual,
          isA<List<HourlyWeather>>()
              .having((f) => f.length, 'length', 7 * 24)
              .having((f) => f[0].weather_code, 'weatherCode', 51.0),
        );
      });

      test('throws WeatherRequestFailure on non-200 daily response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getHourlyWeatherForecast(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws WeatherNotFoundFailure on empty  response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.getHourlyWeatherForecast(
            latitude: latitude,
            longitude: longitude,
          ),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });
    });
  });
}


/*
flutter test --coverage                    
genhtml coverage/lcov.info -o coverage 
open coverage/index.html
*/
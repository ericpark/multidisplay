// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:open_meteo_api/open_meteo_api.dart' as open_meteo_api;
import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

class MockOpenMeteoApiClient extends Mock
    implements open_meteo_api.OpenMeteoApiClient {}

class MockLocation extends Mock implements open_meteo_api.Location {}

class MockWeather extends Mock implements open_meteo_api.Weather {}

class MockDailyWeather extends Mock implements open_meteo_api.DailyWeather {}

class MockHourlyWeather extends Mock implements open_meteo_api.HourlyWeather {}

void main() {
  group('WeatherRepository', () {
    late open_meteo_api.OpenMeteoApiClient weatherApiClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      weatherApiClient = MockOpenMeteoApiClient();
      weatherRepository = WeatherRepository(
        weatherApiClient: weatherApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal weather api client when not injected', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('getWeather', () {
      const city = 'chicago';
      const latitude = 41.85003;
      const longitude = -87.65005;

      test('calls locationSearch with correct city', () async {
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(() => weatherApiClient.locationSearch(city)).called(1);
      });

      test('throws when locationSearch fails', () async {
        final exception = Exception('oops');
        when(() => weatherApiClient.locationSearch(any())).thenThrow(exception);
        expect(
          () async => weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('calls getWeather with correct latitude/longitude', () async {
        final location = MockLocation();
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        try {
          await weatherRepository.getWeather(city);
        } catch (_) {}
        verify(
          () => weatherApiClient.getCurrentWeather(
            latitude: latitude,
            longitude: longitude,
          ),
        ).called(1);
      });

      test('throws when getWeather fails', () async {
        final exception = Exception('oops');
        final location = MockLocation();
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getCurrentWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenThrow(exception);
        expect(
          () async => weatherRepository.getWeather(city),
          throwsA(exception),
        );
      });

      test('returns correct weather on success (clear)', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final dailyWeather = MockDailyWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => dailyWeather.time).thenReturn(DateTime.parse("2024-01-01"));
        when(() => dailyWeather.temperature_2m_max).thenReturn(45);
        when(() => dailyWeather.temperature_2m_min).thenReturn(42);
        when(() => weather.weatherCode).thenReturn(0);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getCurrentWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        DateTime now = DateTime.now();
        expect(
          actual,
          Weather(
            date: DateTime.parse(
                '${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}'),
            temperature: 42.42,
            temperatureHigh: 42.42,
            temperatureLow: 42.42,
            location: city,
            condition: WeatherCondition.clear,
          ),
        );
      });

      test('returns correct weather on success (cloudy)', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final dailyWeather = MockDailyWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => dailyWeather.time).thenReturn(DateTime(2024));
        when(() => dailyWeather.temperature_2m_max).thenReturn(45);
        when(() => dailyWeather.temperature_2m_min).thenReturn(42);
        when(() => weather.weatherCode).thenReturn(1);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getCurrentWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        DateTime now = DateTime.now();
        expect(
          actual,
          Weather(
            date: DateTime.parse(
                '${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}'),
            temperature: 42.42,
            temperatureHigh: 42.42,
            temperatureLow: 42.42,
            location: city,
            condition: WeatherCondition.depositingRimeFog,
          ),
        );
      });

      test('returns correct weather on success (rainy)', () async {
        final location = MockLocation();
        final weather = MockWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => weather.weatherCode).thenReturn(51);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getCurrentWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        DateTime now = DateTime.now();
        expect(
          actual,
          Weather(
            date: DateTime.parse(
                '${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}'),
            temperature: 42.42,
            temperatureHigh: 42.42,
            temperatureLow: 42.42,
            location: city,
            condition: WeatherCondition.rainySlight,
          ),
        );
      });

      test('returns correct weather on success (snowy)', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final dailyWeather = MockDailyWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => dailyWeather.time).thenReturn(DateTime(2024));
        when(() => dailyWeather.temperature_2m_max).thenReturn(45);
        when(() => dailyWeather.temperature_2m_min).thenReturn(42);
        when(() => weather.weatherCode).thenReturn(71);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getCurrentWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        DateTime now = DateTime.now();
        expect(
          actual,
          Weather(
            date: DateTime.parse(
                '${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}'),
            temperature: 42.42,
            temperatureHigh: 42.42,
            temperatureLow: 42.42,
            location: city,
            condition: WeatherCondition.snowyModerate,
          ),
        );
      });

      test('returns correct weather on success (unknown)', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final dailyWeather = MockDailyWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => dailyWeather.time).thenReturn(DateTime(2024));
        when(() => dailyWeather.temperature_2m_max).thenReturn(45);
        when(() => dailyWeather.temperature_2m_min).thenReturn(42);
        when(() => weather.weatherCode).thenReturn(-1);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getCurrentWeather(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => weather);
        final actual = await weatherRepository.getWeather(city);
        DateTime now = DateTime.now();
        expect(
          actual,
          Weather(
            date: DateTime.parse(
                '${now.year}-${now.month.toString().padLeft(2, "0")}-${now.day.toString().padLeft(2, "0")}'),
            temperature: 42.42,
            temperatureHigh: 42.42,
            temperatureLow: 42.42,
            location: city,
            condition: WeatherCondition.unknown,
          ),
        );
      });

      test('returns daily forecast', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final dailyWeather = MockDailyWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => dailyWeather.time).thenReturn(DateTime.parse("2024-01-01"));
        when(() => dailyWeather.temperature_2m_max).thenReturn(45);
        when(() => dailyWeather.temperature_2m_min).thenReturn(42);
        when(() => dailyWeather.weather_code).thenReturn(-1);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getDailyWeatherForecast(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => [dailyWeather]);
        final actual = await weatherRepository.getDailyWeatherForecast(city);
        expect(
          actual,
          [
            Weather(
              date: DateTime.parse('2024-01-01'),
              temperature: 45,
              temperatureHigh: 45,
              temperatureLow: 42,
              location: city,
              condition: WeatherCondition.unknown,
            )
          ],
        );
      });

      test('returns hourly forecast', () async {
        final location = MockLocation();
        final weather = MockWeather();
        final hourlyWeather = MockHourlyWeather();
        when(() => location.name).thenReturn(city);
        when(() => location.latitude).thenReturn(latitude);
        when(() => location.longitude).thenReturn(longitude);
        when(() => weather.temperature).thenReturn(42.42);
        when(() => hourlyWeather.time).thenReturn(DateTime.parse("2024-01-01"));
        when(() => hourlyWeather.temperature_2m).thenReturn(45);
        when(() => hourlyWeather.soil_moisture_0_to_1cm).thenReturn(0.313);
        when(() => hourlyWeather.precipitation).thenReturn(0.015);
        when(() => hourlyWeather.weather_code).thenReturn(-1);
        when(() => weatherApiClient.locationSearch(any())).thenAnswer(
          (_) async => location,
        );
        when(
          () => weatherApiClient.getHourlyWeatherForecast(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          ),
        ).thenAnswer((_) async => [hourlyWeather]);
        final actual = await weatherRepository.getHourlyWeatherForecast(city);
        expect(
          actual,
          [
            Weather(
              date: DateTime.parse('2024-01-01'),
              temperature: 45,
              location: city,
              soilMoisture: 0.313,
              precipitation: 0.015,
              condition: WeatherCondition.unknown,
              soilCondition: SoilCondition.dry,
            )
          ],
        );
      });
    });
  });
}

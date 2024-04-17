// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multidisplay/weather/weather.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_repository/weather_repository.dart'
    as weather_repository;

import '../../helpers/hydrated_bloc.dart';

const weatherLocation = 'London';
const weatherCondition = weather_repository.WeatherCondition.rainySlight;
const weatherTemperature = 9.8;

class MockWeatherRepository extends Mock
    implements weather_repository.WeatherRepository {}

class MockWeather extends Mock implements weather_repository.Weather {}

void main() {
  initHydratedStorage();

  group('WeatherCubit', () {
    late weather_repository.Weather weather;
    late weather_repository.WeatherRepository weatherRepository;
    late WeatherCubit weatherCubit;

    setUp(() async {
      weather = MockWeather();
      weatherRepository = MockWeatherRepository();
      when(() => weather.condition).thenReturn(weatherCondition);
      when(() => weather.location).thenReturn(weatherLocation);
      when(() => weather.temperature).thenReturn(weatherTemperature);
      when(() => weather.date).thenReturn(DateTime(2024));
      when(() => weather.temperatureHigh).thenReturn(weatherTemperature);
      when(() => weather.temperatureLow).thenReturn(weatherTemperature);
      when(
        () => weatherRepository.getWeather(any()),
      ).thenAnswer((_) async => weather);
      when(
        () => weatherRepository.getDailyWeatherForecast(any()),
      ).thenAnswer((_) async => [weather]);
      weatherCubit = WeatherCubit(weatherRepository);
    });

    test('initial state is correct', () {
      final weatherCubit = WeatherCubit(weatherRepository);
      expect(weatherCubit.state, WeatherState());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final weatherCubit = WeatherCubit(weatherRepository);
        expect(
          weatherCubit.fromJson(weatherCubit.toJson(weatherCubit.state)),
          weatherCubit.state,
        );
      });
    });

    group('fetchWeather', () {
      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when city is null',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeatherWithCity(null),
        expect: () => <WeatherState>[],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when city is empty',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeatherWithCity(''),
        expect: () => <WeatherState>[],
      );

      blocTest<WeatherCubit, WeatherState>(
        'calls getWeather with correct city',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeatherWithCity(weatherLocation),
        verify: (_) {
          verify(() => weatherRepository.getWeather(weatherLocation)).called(1);
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, failure] when getWeather throws',
        setUp: () {
          when(
            () => weatherRepository.getWeather(any()),
          ).thenThrow(Exception('oops'));
        },
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeatherWithCity(weatherLocation),
        expect: () => <WeatherState>[
          WeatherState(status: WeatherStatus.loading),
          WeatherState(status: WeatherStatus.failure),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, success] when getWeather returns (celsius)',
        build: () => weatherCubit,
        act: (cubit) => cubit.fetchWeatherWithCity(weatherLocation),
        expect: () => <dynamic>[
          WeatherState(status: WeatherStatus.loading),
          isA<WeatherState>()
              .having((w) => w.status, 'status', WeatherStatus.success)
              .having(
                (w) => w.weather,
                'weather',
                isA<Weather>()
                    .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                    .having((w) => w.condition, 'condition', weatherCondition)
                    .having(
                      (w) => w.temperature,
                      'temperature',
                      Temperature(value: weatherTemperature),
                    )
                    .having((w) => w.location, 'location', weatherLocation),
              ),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, success] when getWeather returns (fahrenheit)',
        build: () => weatherCubit,
        seed: () => WeatherState(temperatureUnits: TemperatureUnits.fahrenheit),
        act: (cubit) => cubit.fetchWeatherWithCity(weatherLocation),
        expect: () => <dynamic>[
          WeatherState(
            status: WeatherStatus.loading,
            temperatureUnits: TemperatureUnits.fahrenheit,
          ),
          isA<WeatherState>()
              .having((w) => w.status, 'status', WeatherStatus.success)
              .having(
                (w) => w.weather,
                'weather',
                isA<Weather>()
                    .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                    .having((w) => w.condition, 'condition', weatherCondition)
                    .having(
                      (w) => w.temperature,
                      'temperature',
                      Temperature(value: weatherTemperature.toFahrenheit()),
                    )
                    .having((w) => w.location, 'location', weatherLocation),
              ),
        ],
      );
    });

    group('refreshWeather', () {
      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when status is not success',
        build: () => weatherCubit,
        act: (cubit) => cubit.refreshWeather(),
        expect: () => <WeatherState>[],
        verify: (_) {
          verifyNever(() => weatherRepository.getWeather(any()));
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when location is null',
        build: () => weatherCubit,
        seed: () => WeatherState(status: WeatherStatus.success),
        act: (cubit) => cubit.refreshWeather(),
        expect: () => <WeatherState>[],
        verify: (_) {
          verifyNever(() => weatherRepository.getWeather(any()));
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'invokes getWeather with correct location',
        build: () => weatherCubit,
        seed: () => WeatherState(
          status: WeatherStatus.success,
          weather: Weather(
            date: DateTime(2024),
            location: weatherLocation,
            temperature: Temperature(value: weatherTemperature),
            temperatureHigh: Temperature(value: weatherTemperature),
            temperatureLow: Temperature(value: weatherTemperature),
            lastUpdated: DateTime(2020),
            condition: weatherCondition,
          ),
        ),
        act: (cubit) => cubit.refreshWeather(),
        verify: (_) {
          verify(() => weatherRepository.getWeather(weatherLocation)).called(1);
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when exception is thrown',
        setUp: () {
          when(
            () => weatherRepository.getWeather(any()),
          ).thenThrow(Exception('oops'));
        },
        build: () => weatherCubit,
        seed: () => WeatherState(
          status: WeatherStatus.success,
          weather: Weather(
            date: DateTime(2024),
            location: weatherLocation,
            temperature: Temperature(value: weatherTemperature),
            temperatureHigh: Temperature(value: weatherTemperature),
            temperatureLow: Temperature(value: weatherTemperature),
            lastUpdated: DateTime(2020),
            condition: weatherCondition,
          ),
        ),
        act: (cubit) => cubit.refreshWeather(),
        expect: () => <WeatherState>[],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits updated weather (celsius)',
        build: () => weatherCubit,
        seed: () => WeatherState(
          status: WeatherStatus.success,
          weather: Weather(
            date: DateTime(2024),
            location: weatherLocation,
            temperature: Temperature(value: 0),
            temperatureHigh: Temperature(value: weatherTemperature),
            temperatureLow: Temperature(value: weatherTemperature),
            lastUpdated: DateTime(2020),
            condition: weatherCondition,
          ),
        ),
        act: (cubit) => cubit.refreshWeather(),
        expect: () => <Matcher>[
          isA<WeatherState>()
              .having((w) => w.status, 'status', WeatherStatus.success)
              .having(
                (w) => w.weather,
                'weather',
                isA<Weather>()
                    .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                    .having((w) => w.condition, 'condition', weatherCondition)
                    .having(
                      (w) => w.temperature,
                      'temperature',
                      Temperature(value: weatherTemperature),
                    )
                    .having((w) => w.location, 'location', weatherLocation),
              ),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits updated weather (fahrenheit)',
        build: () => weatherCubit,
        seed: () => WeatherState(
          temperatureUnits: TemperatureUnits.fahrenheit,
          status: WeatherStatus.success,
          weather: Weather(
            date: DateTime(2024),
            location: weatherLocation,
            temperature: Temperature(value: 0),
            temperatureHigh: Temperature(value: weatherTemperature),
            temperatureLow: Temperature(value: weatherTemperature),
            lastUpdated: DateTime(2020),
            condition: weatherCondition,
          ),
        ),
        act: (cubit) => cubit.refreshWeather(),
        expect: () => <Matcher>[
          isA<WeatherState>()
              .having((w) => w.status, 'status', WeatherStatus.success)
              .having(
                (w) => w.weather,
                'weather',
                isA<Weather>()
                    .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
                    .having((w) => w.condition, 'condition', weatherCondition)
                    .having(
                      (w) => w.temperature,
                      'temperature',
                      Temperature(value: weatherTemperature.toFahrenheit()),
                    )
                    .having((w) => w.location, 'location', weatherLocation),
              ),
        ],
      );
    });

    group('toggleUnits', () {
      blocTest<WeatherCubit, WeatherState>(
        'emits updated units when status is not success',
        build: () => weatherCubit,
        act: (cubit) => cubit.toggleUnits(),
        expect: () => <WeatherState>[
          WeatherState(temperatureUnits: TemperatureUnits.fahrenheit),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits updated units and temperature '
        'when status is success (celsius)',
        build: () => weatherCubit,
        seed: () => WeatherState(
          status: WeatherStatus.success,
          temperatureUnits: TemperatureUnits.fahrenheit,
          weather: Weather(
            date: DateTime(2024),
            location: weatherLocation,
            temperature: Temperature(value: weatherTemperature),
            temperatureHigh: Temperature(value: weatherTemperature),
            temperatureLow: Temperature(value: weatherTemperature),
            lastUpdated: DateTime(2020),
            condition: WeatherCondition.rainShowersSlight,
          ),
        ),
        act: (cubit) => cubit.toggleUnits(),
        expect: () => <WeatherState>[
          WeatherState(
            status: WeatherStatus.success,
            weather: Weather(
              temperature: Temperature(value: weatherTemperature.toCelsius()),
              date: DateTime(2024),
              location: weatherLocation,
              temperatureHigh: Temperature(value: weatherTemperature),
              temperatureLow: Temperature(value: weatherTemperature),
              lastUpdated: DateTime(2020),
              condition: WeatherCondition.rainShowersSlight,
            ),
          ),
        ],
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits updated units and temperature '
        'when status is success (fahrenheit)',
        build: () => weatherCubit,
        seed: () => WeatherState(
          status: WeatherStatus.success,
          weather: Weather(
            date: DateTime(2024),
            location: weatherLocation,
            temperature: Temperature(value: weatherTemperature),
            temperatureHigh: Temperature(value: weatherTemperature),
            temperatureLow: Temperature(value: weatherTemperature),
            lastUpdated: DateTime(2020),
            condition: WeatherCondition.rainShowersSlight,
          ),
        ),
        act: (cubit) => cubit.toggleUnits(),
        expect: () => <WeatherState>[
          WeatherState(
            status: WeatherStatus.success,
            temperatureUnits: TemperatureUnits.fahrenheit,
            weather: Weather(
              location: weatherLocation,
              temperature: Temperature(
                value: weatherTemperature.toFahrenheit(),
              ),
              date: DateTime(2024),
              temperatureHigh: Temperature(value: weatherTemperature),
              temperatureLow: Temperature(value: weatherTemperature),
              lastUpdated: DateTime(2020),
              condition: WeatherCondition.rainShowersSlight,
            ),
          ),
        ],
      );
    });
  });
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}

import 'package:weather_repository/weather_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      test('returns correct Weather object', () {
        expect(
            Weather.fromJson(
              <String, dynamic>{
                'date': '2024-01-01',
                'location': 'New York',
                'temperature': 45.1,
                'temperature_high': 60.1,
                'temperature_low': 40.1,
                'condition': 'cloudy',
              },
            ),
            isA<Weather>()
                .having((w) => w.date, 'date', DateTime(2024, 1, 1))
                .having((w) => w.location, 'location', 'New York')
                .having((w) => w.temperatureHigh, 'temperatureHigh', 60.1)
                .having((w) => w.temperatureLow, 'temperatureLow', 40.1)
                .having((w) => w.temperature, 'temperature', 45.1)
                .having((w) => w.condition, 'condition',
                    WeatherCondition.partlyCloudy));
      });
    });
    group('toJson', () {
      test('returns correct Weather JSON object', () {
        expect(
            Weather.fromJson(
              <String, dynamic>{
                'date': '2024-01-01',
                'location': 'New York',
                'temperature': 45.1,
                'temperature_high': 60.1,
                'temperature_low': 40.1,
                'condition': 'cloudy',
              },
            ).toJson(),
            isA<Map<String, dynamic>>()
                .having((w) => w['date'], 'date', '2024-01-01')
                .having((w) => w['location'], 'location', 'New York')
                .having((w) => w['temperature'], 'temperature', 45.1)
                .having((w) => w['condition'], 'condition', 'cloudy')
                .having((w) => w['temperature_high'], 'temperature_high', 60.1)
                .having((w) => w['temperature_low'], 'temperature_low', 40.1));
      });
    });
  });
}

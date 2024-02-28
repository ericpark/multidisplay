import 'package:multidisplay/weather/weather.dart';

extension WeatherExtensions on Weather {
  String formattedTemperature(TemperatureUnits units,
      {String temperatureType = ""}) {
    if (temperatureType == "low") {
      return '''${temperatureLow.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
    }
    if (temperatureType == "high") {
      return '''${temperatureHigh.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
    }
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}

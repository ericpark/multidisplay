import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multidisplay/weather/models/chart_data.dart';

void main() {
  group('ChartData', () {
    test('should create an instance of ChartData', () {
      final chartData = ChartData(DateTime.now(), 10, Colors.blue);
      expect(chartData, isA<ChartData>());
    });

    test('should have correct x value', () {
      final xValue = DateTime(2022);
      final chartData = ChartData(xValue, 10, Colors.blue);
      expect(chartData.x, equals(xValue));
    });

    test('should have correct y value', () {
      const yValue = 10.0;
      final chartData = ChartData(DateTime.now(), yValue, Colors.blue);
      expect(chartData.y, equals(yValue));
    });

    test('should have correct pointColorMapper value', () {
      const color = Colors.blue;
      final chartData = ChartData(DateTime.now(), 10, color);
      expect(chartData.pointColorMapper, equals(color));
    });

    test('should have null pointColorMapper if not provided', () {
      final chartData = ChartData(DateTime.now(), 10, null);
      expect(chartData.pointColorMapper, isNull);
    });
  });
}

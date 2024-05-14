import 'package:flutter_test/flutter_test.dart';
import 'package:multidisplay/app/helpers/date_helper.dart';

void main() {
  group('DateHelpers', () {
    test('isToday should return true for the current date', () {
      final now = DateTime.now();
      expect(now.isToday, isTrue);
    });

    test('isToday should return false for a different date', () {
      final date = DateTime(2022);
      expect(date.isToday, isFalse);
    });

    test('isYesterday should return true for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(yesterday.isYesterday, isTrue);
    });

    test('isYesterday should return false for a different date', () {
      final date = DateTime(2022);
      expect(date.isYesterday, isFalse);
    });

    test('midnight should return a DateTime object with time set to 00:00:00',
        () {
      final date = DateTime(2022, 1, 1, 12, 30, 45);
      final midnight = date.midnight;
      expect(midnight.hour, 0);
      expect(midnight.minute, 0);
      expect(midnight.second, 0);
    });

    test('midnight should return a DateTime object with the same date', () {
      final date = DateTime(2022, 1, 1, 12, 30, 45);
      final midnight = date.midnight;
      expect(midnight.year, date.year);
      expect(midnight.month, date.month);
      expect(midnight.day, date.day);
    });
  });
}

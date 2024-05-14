import 'package:flutter_test/flutter_test.dart';
import 'package:multidisplay/tracking/tracking.dart';

class _MockTrackingCubit extends BasicTrackingCubit<dynamic> {}

class _TestDaysSinceTrackingCubitMixin extends Object
    with DaysSinceTrackingCubit<dynamic> {
  _TestDaysSinceTrackingCubitMixin(this.trackingCubit);
  final BasicTrackingCubit<dynamic> trackingCubit;
}

void main() {
  group('DaysSinceTrackingCubit', () {
    final trackingCubit = _MockTrackingCubit();
    final mixin = _TestDaysSinceTrackingCubitMixin(trackingCubit);

    final lastDate = DateTime.now().subtract(const Duration(days: 6));

    test('incrementDaysSince should update days_since_last metric', () {
      final trackingSummary = TrackingSummary(
        metrics: {
          'days_since_last': {'display_name': 'Days Since Last', 'value': '5'},
          'last_date': {'display_name': 'Last Date', 'value': '2022-01-01'},
          'last_seven_days': {'display_name': 'Last Seven Days', 'value': '10'},
        },
        mainMetric: 'days_since_last',
        name: '',
        section: '',
        id: '',
        ownerId: '',
        records: [TrackingRecord(date: lastDate)],
      );

      final updatedSummary =
          mixin.incrementDaysSince(trackingSummary: trackingSummary);

      expect(updatedSummary.metrics['days_since_last']!['value'], '6');
    });

    test('incrementDaysSince should update last_date metric', () {
      final trackingSummary = TrackingSummary(
        metrics: {
          'days_since_last': {'display_name': 'Days Since Last', 'value': '5'},
          'last_date': {'display_name': 'Last Date', 'value': '2022-01-01'},
          'last_seven_days': {'display_name': 'Last Seven Days', 'value': '10'},
        },
        name: '',
        section: '',
        id: '',
        ownerId: '',
        records: [TrackingRecord(date: DateTime.parse('2022-01-02'))],
      );

      final updatedSummary =
          mixin.incrementDaysSince(trackingSummary: trackingSummary);

      expect(updatedSummary.metrics['last_date']!['value'], '01/02/2022');
    });

    test('incrementDaysSince should update last_seven_days metric', () {
      final trackingSummary = TrackingSummary(
        metrics: {
          'days_since_last': {'display_name': 'Days Since Last', 'value': '5'},
          'last_date': {'display_name': 'Last Date', 'value': '2022-01-01'},
          'last_seven_days': {'display_name': 'Last Seven Days', 'value': '10'},
        },
        name: '',
        section: '',
        id: '',
        ownerId: '',
        records: [TrackingRecord(date: DateTime.parse('2022-01-02'))],
      );

      final updatedSummary =
          mixin.incrementDaysSince(trackingSummary: trackingSummary);

      expect(updatedSummary.metrics['last_seven_days']!['value'], '0');
    });
  });
}

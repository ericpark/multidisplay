import 'package:multidisplay/tracking/tracking.dart';

mixin DaysSinceTrackingCubit<TrackingState> {
  TrackingSummary incrementDaysSince({
    required TrackingSummary trackingSummary,
  }) {
    final updatedMetrics = <String, Map<String, String>>{};
    final records = trackingSummary.records;
    //int currentStreak = getCurrentStreak(records: records);

    for (final key in trackingSummary.metrics.keys) {
      final currentMetric =
          trackingSummary.metrics[key] ?? {'display_name': '', 'value': ''};
      final updatedMetric = <String, String>{
        'display_name': currentMetric['display_name'] ?? '',
      };
      switch (key) {
        case 'days_since_last':
          updatedMetric['value'] =
              BasicTrackingCubit<dynamic>().getDaysSinceLast(records: records);
        case 'last_date':
          updatedMetric['value'] =
              BasicTrackingCubit<dynamic>().getLastDate(records: records);
        case 'last_seven_days':
          updatedMetric['value'] =
              '''${BasicTrackingCubit<dynamic>().getLastSevenDayCount(records: records)}''';
        default:
          updatedMetric['value'] = currentMetric['value'] ?? '-';
      }
      updatedMetrics[key] = updatedMetric;
    }

    final updatedTrackingSummary =
        trackingSummary.copyWith(metrics: updatedMetrics);

    return updatedTrackingSummary;
  }
}

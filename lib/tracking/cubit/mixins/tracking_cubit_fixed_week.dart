import 'package:multidisplay/tracking/tracking.dart';

mixin FixedWeekTrackingCubit<TrackingState> {
  TrackingSummary decrementFixedWeekTracker({
    required TrackingSummary trackingSummary,
  }) {
    final updatedMetrics = <String, Map<String, String>>{};
    final records = trackingSummary.records;

    for (final key in trackingSummary.metrics.keys) {
      final currentMetric =
          trackingSummary.metrics[key] ?? {'display_name': '', 'value': ''};
      final updatedMetric = <String, String>{
        'display_name': currentMetric['display_name'] ?? '',
      };
      switch (key) {
        case 'remaining_week':
          updatedMetric['value'] =
              BasicTrackingCubit<dynamic>().getRemainingWeek(records: records);
        case 'days_since_last':
          updatedMetric['value'] =
              BasicTrackingCubit<dynamic>().getDaysSinceLast(records: records);
        case 'last_thirty_days':
          updatedMetric['value'] = BasicTrackingCubit<dynamic>()
              .getLastThirtyDayCount(records: records);
        default:
          updatedMetric['value'] = currentMetric['value'] ?? '-';
      }
      updatedMetrics[key] = updatedMetric;
    }
    /*  int mainMetric = int.tryParse(
         trackingSummary.metrics[trackingSummary.mainMetric]?["value"] ??
              "") ??
      0;*/
    final updatedTrackingSummary =
        trackingSummary.copyWith(metrics: updatedMetrics);

    return updatedTrackingSummary;
  }
}

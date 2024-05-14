import 'package:multidisplay/tracking/tracking.dart';

mixin LastSevenTrackingCubit<TrackingState> {
  TrackingSummary incrementLastSevenTracker({
    required TrackingSummary trackingSummary,
  }) {
    final updatedMetrics = <String, Map<String, String>>{};
    final records = trackingSummary.records;
    final lastSevenDayTotal =
        BasicTrackingCubit<dynamic>().getLastSevenDayCount(records: records);

    for (final key in trackingSummary.metrics.keys) {
      final currentMetric =
          trackingSummary.metrics[key] ?? {'display_name': '', 'value': ''};
      final updatedMetric = <String, String>{
        'display_name': currentMetric['display_name'] ?? '',
      };
      switch (key) {
        case 'average':
          updatedMetric['value'] = BasicTrackingCubit<dynamic>()
              .getLastSevenDayAverage(total: lastSevenDayTotal);
        case 'days_since_last':
          updatedMetric['value'] =
              BasicTrackingCubit<dynamic>().getDaysSinceLast(records: records);
        case 'last_seven_days':
          updatedMetric['value'] = '$lastSevenDayTotal';
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

import 'package:intl/intl.dart';
import 'package:multidisplay/app/helpers/helpers.dart';
import 'package:multidisplay/tracking/tracking.dart';

mixin DaysUntilTrackingCubit<TrackingState> {
  TrackingSummary incrementConsecutiveTracker({
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
        case 'days_until':
          updatedMetric['value'] = '';

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

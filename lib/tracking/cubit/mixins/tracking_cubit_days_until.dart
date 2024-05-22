import 'package:intl/intl.dart';
import 'package:multidisplay/tracking/tracking.dart';

mixin DaysUntilTrackingCubit<TrackingState> {
  TrackingSummary incrementDaysUntilTracker({
    required TrackingSummary trackingSummary,
  }) {
    final updatedMetrics = <String, Map<String, String>>{};

    //final records = trackingSummary.records;

    for (final key in trackingSummary.metrics.keys) {
      final currentMetric =
          trackingSummary.metrics[key] ?? {'display_name': '', 'value': ''};
      final updatedMetric = <String, String>{
        'display_name': currentMetric['display_name'] ?? '',
      };

      final nextDateStr = trackingSummary.metrics['next_date']?['value'] ?? '';

      switch (key) {
        case 'days_until_next':
          try {
            final nextDate = DateFormat('MM/dd/yyyy').parse(nextDateStr);
            updatedMetric['value'] =
                (nextDate.difference(DateTime.now()).inDays + 1).toString();
          } catch (e) {
            updatedMetric['value'] = '-';
          }
        case 'next_date':
          try {
            final nextDate = DateFormat('MM/dd/yyyy').parse(nextDateStr);
            final now = DateTime.now();

            DateTime firstDayOfNextMonth;
            if (now.isAfter(nextDate)) {
              firstDayOfNextMonth = DateTime(now.year, now.month + 1);
            } else {
              firstDayOfNextMonth = nextDate;
            }

            updatedMetric['value'] =
                DateFormat('MM/dd/yyyy').format(firstDayOfNextMonth);
          } catch (e) {
            updatedMetric['value'] = '-';
          }

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

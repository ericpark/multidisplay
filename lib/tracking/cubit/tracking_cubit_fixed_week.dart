part of 'tracking_cubit.dart';

TrackingSummary decrementFixedWeekTracker(
    {required TrackingSummary trackingSummary}) {
  Map<String, Map<String, String>> updatedMetrics = {};
  final List<TrackingRecord> records = trackingSummary.records;

  for (var key in trackingSummary.metrics.keys) {
    final currentMetric =
        trackingSummary.metrics[key] ?? {"display_name": "", "value": ""};
    Map<String, String> updatedMetric = {
      "display_name": currentMetric["display_name"] ?? "",
    };
    switch (key) {
      case "remaining_week":
        updatedMetric["value"] = getRemainingWeek(records: records);
      case "days_since_last":
        updatedMetric["value"] = getDaysSinceLast(records: records);
      case "last_thirty_days":
        updatedMetric["value"] = getLastThirtyDayCount(records: records);
      default:
        updatedMetric["value"] = currentMetric["value"] ?? "-";
    }
    updatedMetrics[key] = updatedMetric;
  }
  int mainMetric = int.tryParse(
          trackingSummary.metrics[trackingSummary.mainMetric]?["value"] ??
              "") ??
      0;
  TrackingSummary updatedTrackingSummary =
      trackingSummary.copyWith(count: mainMetric, metrics: updatedMetrics);

  return updatedTrackingSummary;
}

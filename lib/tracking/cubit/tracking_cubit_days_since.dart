part of 'tracking_cubit.dart';

TrackingSummary incrementDaysSince({required TrackingSummary trackingSummary}) {
  Map<String, Map<String, String>> updatedMetrics = {};
  final List<TrackingRecord> records = trackingSummary.records;
  int currentStreak = getCurrentStreak(records: records);

  for (var key in trackingSummary.metrics.keys) {
    final currentMetric =
        trackingSummary.metrics[key] ?? {"display_name": "", "value": ""};
    Map<String, String> updatedMetric = {
      "display_name": currentMetric["display_name"] ?? "",
    };
    switch (key) {
      case "days_since_last":
        int prev = int.parse(currentMetric["value"] ?? "0");
        updatedMetric["value"] = getHighScore(curr: currentStreak, prev: prev);
      case "streak_start_date":
        updatedMetric["value"] =
            getStreakStartDate(curr: currentStreak, records: records);
      default:
        updatedMetric["value"] = currentMetric["value"] ?? "-";
    }
    updatedMetrics[key] = updatedMetric;
  }

  TrackingSummary updatedTrackingSummary =
      trackingSummary.copyWith(count: currentStreak, metrics: updatedMetrics);

  return updatedTrackingSummary;
}

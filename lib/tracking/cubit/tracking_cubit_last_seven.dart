part of 'tracking_cubit.dart';

TrackingSummary incrementLastSevenTracker(
    {required TrackingSummary trackingSummary}) {
  Map<String, Map<String, String>> updatedMetrics = {};
  final List<TrackingRecord> records = trackingSummary.records;
  int lastSevenDayTotal = getLastSevenDayCount(records: records);

  for (var key in trackingSummary.metrics.keys) {
    final currentMetric =
        trackingSummary.metrics[key] ?? {"display_name": "", "value": ""};
    Map<String, String> updatedMetric = {
      "display_name": currentMetric["display_name"] ?? "",
    };
    switch (key) {
      case "average":
        updatedMetric["value"] =
            getLastSevenDayAverage(total: lastSevenDayTotal);
      case "days_since_last":
        updatedMetric["value"] = getDaysSinceLast(records: records);
      case "last_7_days":
        updatedMetric["value"] = "$lastSevenDayTotal";
      default:
        updatedMetric["value"] = currentMetric["value"] ?? "-";
    }
    updatedMetrics[key] = updatedMetric;
  }

  TrackingSummary updatedTrackingSummary = trackingSummary.copyWith(
      count: lastSevenDayTotal, metrics: updatedMetrics);

  return updatedTrackingSummary;
}

int getLastSevenDayCount({required List<TrackingRecord> records}) {
  final now = DateTime.now();
  final compareDate =
      DateTime(now.year, now.month, now.day).subtract(const Duration(days: 7));
  return records
      .where((record) => record.date.isAfter(compareDate))
      .toList()
      .length;
}

String getDaysSinceLast({required List<TrackingRecord> records}) =>
    "${(DateTime.now().difference(records.last.date).inHours / 24).floor()}";

String getLastSevenDayAverage({required int total}) =>
    (total / 7).toStringAsFixed(2);

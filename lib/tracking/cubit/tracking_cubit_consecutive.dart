part of 'tracking_cubit.dart';

TrackingSummary incrementConsecutiveTracker({
  required TrackingSummary trackingSummary,
}) {
  // Updated Metrics to be returned
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
      case "consecutive_days":
        updatedMetric["value"] = "$currentStreak";

      case "high_score":
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

/// Return count of the current streak.
int getCurrentStreak({required List<TrackingRecord> records}) {
  // Start with 1 and return 0 if not.
  int currentStreak = 1;
  // No records
  if (records.isEmpty) {
    return 0;
  }

  DateTime today = DateTime.now().midnight;
  DateTime lastDate = records.last.date.midnight;

  //  Last day has been more than one day so streak has ended.
  if (today.difference(lastDate).inHours > 47) {
    return 0;
  }

  // Last day has not been more than one day but only 1 record.
  // This is checked here because we established there is a streak above.
  if (records.length == 1) {
    return 1;
  }

  final dates = {...records.map((record) => record.date.midnight)}.toList();

  // If there are more than one records and the last record was less than a day,
  // then count backwards until break;
  for (var i = dates.length - 1; i >= 1; i--) {
    // the current date compared to the previous date is more than 1 day,
    // so return the streak until now.

    if (dates[i].difference(dates[i - 1]).inHours > 24) {
      return currentStreak;
    }
    currentStreak = currentStreak + 1;
  }

  return currentStreak;
}

/// Return the updated high score if it has been updated
String getHighScore({required int prev, required int curr}) =>
    curr > prev ? "$curr" : "$prev";

/// REturn the streak start date
String getStreakStartDate(
        {required int curr, required List<TrackingRecord> records}) =>
    curr == 0
        ? "-"
        : DateFormat("MM/dd/yyyy").format(records[records.length - curr].date);

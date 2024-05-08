import 'package:multidisplay/tracking/tracking.dart';

mixin LastSevenTrackingCubit<TrackingState> {
  TrackingSummary incrementLastSevenTracker(
      {required TrackingSummary trackingSummary}) {
    Map<String, Map<String, String>> updatedMetrics = {};
    final List<TrackingRecord> records = trackingSummary.records;
    int lastSevenDayTotal =
        BasicTrackingCubit().getLastSevenDayCount(records: records);

    for (var key in trackingSummary.metrics.keys) {
      final currentMetric =
          trackingSummary.metrics[key] ?? {"display_name": "", "value": ""};
      Map<String, String> updatedMetric = {
        "display_name": currentMetric["display_name"] ?? "",
      };
      switch (key) {
        case "average":
          updatedMetric["value"] = BasicTrackingCubit()
              .getLastSevenDayAverage(total: lastSevenDayTotal);
        case "days_since_last":
          updatedMetric["value"] =
              BasicTrackingCubit().getDaysSinceLast(records: records);
        case "last_seven_days":
          updatedMetric["value"] = "$lastSevenDayTotal";
        default:
          updatedMetric["value"] = currentMetric["value"] ?? "-";
      }
      updatedMetrics[key] = updatedMetric;
    }

    TrackingSummary updatedTrackingSummary =
        trackingSummary.copyWith(metrics: updatedMetrics);

    return updatedTrackingSummary;
  }
}

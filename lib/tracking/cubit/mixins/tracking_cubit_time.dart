import 'package:multidisplay/tracking/tracking.dart';

mixin TimeTrackingCubit<TrackingState> {
  TrackingSummary calculateTimeBasedTracker({
    required TrackingSummary trackingSummary,
  }) {
    // Updated Metrics to be returned
    Map<String, Map<String, String>> updatedMetrics = {};
    // This may need to be sorted here because the firebase query is not indexed on
    // both createdAt and Date. Since Date is more important in every other case, this
    // is probably sorted by Date. If we created a new record and changed the date,
    // this would not be sorted correctly.
    final List<TrackingRecord> records = trackingSummary.records;

    for (var key in trackingSummary.metrics.keys) {
      final currentMetric =
          trackingSummary.metrics[key] ?? {"display_name": "", "value": ""};

      Map<String, String> updatedMetric = {
        "display_name": currentMetric["display_name"] ?? "",
      };

      switch (key) {
        case "days_since_last":
          updatedMetric["value"] =
              BasicTrackingCubit().getDaysSinceLast(records: records);

        case "last_date":
          updatedMetric["value"] =
              BasicTrackingCubit().getLastDate(records: records);

        case "hours_to_completion":
          updatedMetric["value"] = "";
          if (records.last.description != null) {
            DateTime finishedDate = DateTime.parse(
                records.last.description!.replaceAll("Finished at ", ""));
            updatedMetric["value"] =
                "${finishedDate.difference(records.last.createdAt ?? DateTime.now()).inHours}";
          }

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

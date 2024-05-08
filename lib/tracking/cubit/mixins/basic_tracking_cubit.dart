import 'package:intl/intl.dart';
import 'package:multidisplay/app/helpers/helpers.dart';
import 'package:multidisplay/tracking/tracking.dart';

/// BasicTrackingCubit.dart contains the [BasicTrackingCubit] class. This class
/// contains methods that are used by multiple tracking cubits to calculate basic
/// tracking metrics.
///
class BasicTrackingCubit<TrackingState> {
  String getLastThirtyDayCount({required List<TrackingRecord> records}) {
    final now = DateTime.now();
    final compareDate = now.midnight.subtract(const Duration(days: 30));
    return records
        .where((record) => record.date.midnight.isAfter(compareDate))
        .toList()
        .length
        .toString();
  }

  String getRemainingWeek({required List<TrackingRecord> records}) {
    final now = DateTime.now();
    // Subtract the number of days since Sunday (including today)
    int daysSinceSunday = now.weekday;
    // Calculate the date for the last Sunday
    final compareDate = DateTime(now.year, now.month, now.day)
        .midnight
        .subtract(Duration(days: daysSinceSunday));
    final recordsSinceSunday = records
        .where((record) => record.date.isAfter(compareDate))
        .toList()
        .length;
    return (1 - recordsSinceSunday).toString();
  }

  int getLastSevenDayCount({required List<TrackingRecord> records}) {
    final now = DateTime.now();
    final compareDate = DateTime(now.year, now.month, now.day)
        .midnight
        .subtract(const Duration(days: 7));
    return records
        .where((record) => record.date.midnight.isAfter(compareDate))
        .toList()
        .length;
  }

  String getDaysSinceLast({required List<TrackingRecord> records}) =>
      "${(DateTime.now().difference(records.last.date.midnight).inHours / 24).floor()}";

  String getLastSevenDayAverage({required int total}) =>
      (total / 7).toStringAsFixed(2);

  String getLastDate({required List<TrackingRecord> records}) =>
      records.isNotEmpty
          ? DateFormat("MM/dd/yyyy").format(records.last.date)
          : "-";
}

part of 'tracking_cubit.dart';

String getHighScore({required int prev, required int curr}) =>
    curr > prev ? "$curr" : "$prev";

String getStreakStartDate(
        {required int curr, required List<TrackingRecord> records}) =>
    curr == 0
        ? "-"
        : DateFormat("MM/dd/yyyy").format(records[records.length - curr].date);

String getLastThirtyDayCount({required List<TrackingRecord> records}) {
  final now = DateTime.now();
  final compareDate =
      DateTime(now.year, now.month, now.day).subtract(const Duration(days: 30));
  return records
      .where((record) => record.date.isAfter(compareDate))
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
      .subtract(Duration(days: daysSinceSunday));
  final recordsSinceSunday = records
      .where((record) => record.date.isAfter(compareDate))
      .toList()
      .length;
  return (1 - recordsSinceSunday).toString();
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

import 'package:flutter/material.dart';

Color defaultWidgetColor = Colors.black;
Color goodWidgetColor = Colors.green[700]!;
Color warnWidgetColor = Colors.amber[700]!;
Color poorWidgetColor = Colors.red[700]!;

mixin ThresholdColor {
  /// Get the color of the widget based on the thresholds and the compareMetric
  ///
  /// Threshold Assumptions:
  /// - If the start is less than the end, higher is positive
  /// - No gaps between thresholds and warn is between good and poor.
  /// - Thresholds do not overlap
  Color getThresholdColor({
    required Map<String, Map<String, double>> thresholds,
    required double compareMetric,
  }) {
    // Default/error color
    Color? widgetColor = defaultWidgetColor;

    // Check if all thresholds exist.
    try {
      if (thresholds.isEmpty) throw "No thresholds found";
      if (thresholds["good"] == null) throw "Good threshold not found";
      if (thresholds["warn"] == null) throw "Warn threshold not found";
      if (thresholds["poor"] == null) throw "Poor threshold not found";
      if (_gapsInThreshold(thresholds: thresholds)) throw "No Gaps allowed";
      if (_invalidThresholdOrder(thresholds: thresholds)) throw "Invalid Order";
    } catch (err) {
      debugPrint("Invalid Threshold: $err");
      return defaultWidgetColor;
    }

    bool higherIsPositive = _higherIsPositive(thresholds: thresholds);

    /// Determine if the compareMetric is within the threshold
    ///
    /// Given a threshold ("good", "warn", "poor") return true if the compareMetric
    /// is within the range. This works for both directions.
    bool isWithinThreshold(String threshold) =>
        (thresholds[threshold]!["start"]! <= compareMetric &&
            compareMetric <= thresholds[threshold]!["end"]!) ||
        (thresholds[threshold]!["start"]! >= compareMetric &&
            compareMetric >= thresholds[threshold]!["end"]!);

    try {
      // Check if in ranges first. Does not matter direction as long assumptions
      // above are true and thresholds are not overlapping.
      if (isWithinThreshold("good")) return goodWidgetColor;
      if (isWithinThreshold("warn")) return warnWidgetColor;
      if (isWithinThreshold("poor")) return poorWidgetColor;

      // Higher is positive for consecutive days or park visits
      if (higherIsPositive == true) {
        // EDGE CASE: Went above good end threshold assume good
        if (thresholds["good"]!["start"]! <= compareMetric &&
            thresholds["good"]!["end"]! <= compareMetric) {
          return goodWidgetColor;
        }
        // EDGE CASE: Went below poor end threshold assume poor
        if (thresholds["poor"]!["start"]! >= compareMetric &&
            thresholds["poor"]!["end"]! >= compareMetric) {
          return poorWidgetColor;
        }
      }
      // Lower is positive for consecutive days or park visits
      else {
        // EDGE CASE: Went below good start threshold assume good
        if (compareMetric <= thresholds["good"]!["start"]! &&
            compareMetric <= thresholds["good"]!["end"]!) {
          return goodWidgetColor;
        }
        // EDGE CASE: Went above poor end threshold assume poor
        if (thresholds["poor"]!["start"]! <= compareMetric &&
            thresholds["poor"]!["end"]! <= compareMetric) {
          return poorWidgetColor;
        }
      }
      // ERROR CASE: invalid thresholds
      debugPrint("Invalid thresholds: $thresholds");
      return widgetColor;
    } catch (err) {
      debugPrint("$err");
      return defaultWidgetColor;
    }
  }

  bool _higherIsPositive({
    required Map<String, Map<String, double>> thresholds,
  }) {
    if (thresholds["good"]!["start"]! <= thresholds["good"]!["end"]! &&
        thresholds["warn"]!["start"]! <= thresholds["warn"]!["end"]! &&
        thresholds["poor"]!["start"]! <= thresholds["poor"]!["end"]!) {
      return false;
    }
    return true;
  }

  bool _gapsInThreshold({
    required Map<String, Map<String, double>> thresholds,
  }) {
    final startWarnGap =
        (thresholds["good"]!["end"]! - thresholds["warn"]!["start"]!).abs();
    final warnPoorGap =
        (thresholds["warn"]!["end"]! - thresholds["poor"]!["start"]!).abs();

    if (startWarnGap > 1) return true;
    if (warnPoorGap > 1) return true;

    return false;
  }

  bool _invalidThresholdOrder({
    required Map<String, Map<String, double>> thresholds,
  }) {
    // Check order low to high
    if (thresholds["good"]!["start"]! <= thresholds["good"]!["end"]! &&
        thresholds["good"]!["end"]! <= thresholds["warn"]!["start"]! &&
        thresholds["warn"]!["start"]! <= thresholds["warn"]!["end"]! &&
        thresholds["warn"]!["end"]! <= thresholds["poor"]!["start"]! &&
        thresholds["poor"]!["start"]! <= thresholds["poor"]!["end"]!) {
      return false;
    }
    // Check order high to low
    if (thresholds["good"]!["start"]! >= thresholds["good"]!["end"]! &&
        thresholds["good"]!["end"]! >= thresholds["warn"]!["start"]! &&
        thresholds["warn"]!["start"]! >= thresholds["warn"]!["end"]! &&
        thresholds["warn"]!["end"]! >= thresholds["poor"]!["start"]! &&
        thresholds["poor"]!["start"]! >= thresholds["poor"]!["end"]!) {
      return false;
    }
    return true;
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multidisplay/app/helpers/helpers.dart';
import 'package:multidisplay/tracking/tracking.dart';

export 'package:confetti/confetti.dart';

enum ConfettiType { star, heart }

enum ConfettiMode { custom, always, never }

mixin Confetti {
  // This should be implemented on the widget itself.
  // Provided too difficult to happen consistently
  // late ConfettiController? controllerCenter;

  final confettiColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.purple,
  ];

  final heartColors = [
    Colors.pink,
    Colors.red,
  ];
  ConfettiController defaultConfettiController() =>
      ConfettiController(duration: const Duration(seconds: 15));

  /// Determine if the confetti should be shown.
  ///
  /// Default will only use random. Random will only affect the confetti after
  /// the celebration threshold is met if enabled. If multipleToday is enabled,
  /// it will always supersede the random and celebration threshold.
  bool showConfetti({
    ConfettiMode mode = ConfettiMode.custom,
    // Celebration Threshold
    bool useCelebrationThreshold = false,
    double celebrationThreshold = 30.0,
    double? celebrationMetric,
    // Used to calculate direction,
    // true = above the threshold is good, false = below the threshold is good
    bool positiveIsHigherThanThreshold = true,
    // Multiple Events in one day
    bool useMultipleToday = false,
    List<TrackingRecord> records = const [],
    // Random Number
    bool useRandom = true,
    double randomSuccessPercentage = 0.20,
    double randomMultiplier = 1, // Allows for random probability to be adjusted
    bool debug = false,
    void Function(String? widgetName, double? random)? onCompletion,
    String widgetId = '',
  }) {
    // randomMultiplier subtracts a percentage of the random number from itself.
    // randomMultiplier of 1 will not affect the random number
    // randomMultiplier of 0 will always return 0
    // Recommended range is 0.05 to 2.0 (~9% success to ~75% success)
    final randomThreshold = 1 - randomSuccessPercentage;
    final randomNumber = Random().nextDouble() * randomMultiplier;

    if (debug) {
      debugPrint('widgetId: $widgetId');
      debugPrint('Mode: $mode');
      debugPrint('useCelebrationThreshold: $useCelebrationThreshold');
      debugPrint('celebrationThreshold: $celebrationThreshold');
      debugPrint('celebrationMetric: $celebrationMetric');
      debugPrint('useMultipleToday: $useMultipleToday');
      debugPrint('records: $records');
      debugPrint('useRandom: $useRandom');
      debugPrint('randomOriginal: ${randomNumber / randomMultiplier}');
      debugPrint('randomMultiplier: $randomMultiplier');
      debugPrint('randomNumber: $randomNumber');
      debugPrint('randomThreshold: $randomThreshold');
    }

    if (mode == ConfettiMode.always) return true;
    if (mode == ConfettiMode.never) return false;

    // If everything is false, do not show confetti
    if (useCelebrationThreshold == false &&
        useRandom == false &&
        useMultipleToday == false) return false;

    /* Original implementation that was simplified below.
    final celebration = useCelebrationThreshold
        ? (thresholdHigherIsBetter
            ? ((celebrationMetric ?? 0) > celebrationThreshold)
            : ((celebrationMetric ?? 0) < celebrationThreshold))
        : true;
    */
    // If the following is true, it will not affect the confetti result.
    // If the following is false, it will rely on multipleInOneDay
    // !useCelebrationThreshold is used so if useCelebrationThreshold is false,
    // it will not affect the confetti result and purely depend on the random.
    final celebration = !useCelebrationThreshold ||
        (positiveIsHigherThanThreshold
            ? ((celebrationMetric ?? 0) > celebrationThreshold)
            : ((celebrationMetric ?? 0) < celebrationThreshold));
    /* Original implementation that was simplified below.
    final random = useRandom ? randomNumber >= randomThreshold : true;
    */
    // If useRandom is false, it will not affect the confetti result
    final random = !useRandom || (randomNumber >= randomThreshold);

    // If multipleToday is false/unset, it will not affect the confetti result
    // If multipleToday is true, it will rely on the records.
    final multipleInOneDay = useMultipleToday &&
        (records.where((record) => record.date.isToday).isNotEmpty);

    if (onCompletion != null) {
      onCompletion(widgetId, randomNumber);
    }
    return (random && celebration) || multipleInOneDay;
  }

  bool isConfettiEnabled({Map<String, Map<String, double>>? thresholds}) {
    if (thresholds == null) return false;
    if (thresholds.isEmpty) return false;
    if (thresholds.isEmpty) return false;
    if (thresholds['good'] == null) return false;
    if (thresholds['warn'] == null) return false;
    if (thresholds['poor'] == null) return false;

    return true;
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (var step = 0.0; step < fullAngle; step += degreesPerStep) {
      path
        ..lineTo(
          halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step),
        )
        ..lineTo(
          halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep),
        );
    }
    path.close();
    return path;
  }

  /// A custom Path to paint hearts.
  Path drawHeart(Size size) {
    final path = Path();

    final width = size.width;
    final height = size.height;

    // Modify the path to draw a heart shape
    path
      ..moveTo(0.5 * width, height * 0.35)
      ..cubicTo(
        0.2 * width,
        height * 0.1,
        -0.05 * width,
        height * 0.6,
        0.5 * width,
        height,
      )
      ..moveTo(0.5 * width, height * 0.35)
      ..cubicTo(
        0.8 * width,
        height * 0.1,
        1.05 * width,
        height * 0.6,
        0.5 * width,
        height,
      );

    return path;
  }
}

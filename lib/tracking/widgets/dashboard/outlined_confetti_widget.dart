import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multidisplay/app/widgets/dismissable_modal.dart';
import 'package:multidisplay/tracking/tracking.dart';

class OutlinedConfettiTrackingWidget extends StatefulWidget
    with TrackingDialog, Confetti, ThresholdColor {
  //constructor
  OutlinedConfettiTrackingWidget({
    required this.onDoubleTap,
    required this.id,
    required this.section,
    required this.trackingSummary,
    // Color to use if threshold is not used. Defaults to black.
    this.defaultColor,
    this.displayDetailsPage,
    // Use a threshold for celebration based on compare metric.
    this.useCelebrationThreshold = false,
    this.celebrationType = 'stars',
    this.thresholdMetric,
    this.compareThresholdType, // good, warn, or poor. Defaults to good.
    this.getCompareMetric,
    this.randomSuccessPercentage = 0.5,
    this.randomMultiplier = 1,
    this.useMultipleToday = false,
    this.isRestricted, // toggle on/off based on password
    this.isPrivate, // user only vs public
    this.isFavorite,
    super.key,
  });

  final int id;
  final String section;
  final TrackingSummary trackingSummary;

  final void Function()? onDoubleTap;
  final Color? defaultColor;
  final Future<void> Function()? displayDetailsPage;
  final bool useCelebrationThreshold;
  final String? thresholdMetric;
  final String? compareThresholdType;
  final String celebrationType;
  final double Function()? getCompareMetric;
  final double randomSuccessPercentage;
  final double randomMultiplier;
  final bool useMultipleToday;
  final bool? isRestricted;
  final bool? isPrivate;
  final bool? isFavorite;

  static const emptyMetric = {'display_name': '', 'value': ''};

  @override
  State<OutlinedConfettiTrackingWidget> createState() =>
      OutlinedConfettiTrackingWidgetState();
}

class OutlinedConfettiTrackingWidgetState
    extends State<OutlinedConfettiTrackingWidget> {
  late ConfettiController controllerCenter;

  @override
  void initState() {
    controllerCenter = widget.defaultConfettiController();

    super.initState();
  }

  @override
  void dispose() {
    controllerCenter.dispose();

    super.dispose();
  }

  Future<void> _onDoubleTap({
    required BuildContext context,
    double? compareMetric,
    double? compareThreshold,
  }) async {
    // Do nothing if no double tap function is provided
    if (widget.onDoubleTap == null) return;

    // Check confirmation and stop if not confirmed
    final confirmTracking = await widget.showDefaultDialog(
      context,
      onDoubleTap: widget.onDoubleTap,
    );
    if (confirmTracking != true) return;

    // Check confirmation and stop if not confirmed
    final celebrationMetric = compareMetric ?? 0;
    final celebrationThreshold = compareThreshold ?? 0;

    final showConfetti = widget.showConfetti(
      useCelebrationThreshold: widget.useCelebrationThreshold,
      celebrationMetric: celebrationMetric,
      celebrationThreshold: celebrationThreshold,
      useMultipleToday: widget.useMultipleToday,
      positiveIsHigherThanThreshold: _higherIsPositive(),
      records: widget.trackingSummary.records,
      randomSuccessPercentage: widget.randomSuccessPercentage,
      randomMultiplier: widget.randomMultiplier,
    );

    if ((confirmTracking ?? false) && showConfetti) {
      controllerCenter.play();
    }
  }

  Future<void> _displayDetailsPage() async {
    if (widget.displayDetailsPage != null) {
      await widget.displayDetailsPage!();
    } else {
      await showDismissableModal(
        context,
        TrackingDetailsView(id: widget.id, section: widget.section),
      );
    }
  }

  double? _calculateCompareMetric() {
    if (widget.getCompareMetric == null) return null;

    return widget.getCompareMetric!();
  }

  double? _calculateCompareThreshold() {
    if (widget.thresholdMetric == null) return null;
    if (widget.thresholdMetric == '') return null;
    if (widget.trackingSummary.thresholds.isEmpty ||
        widget.trackingSummary.records.isEmpty) return null;

    return widget.trackingSummary.thresholds[widget.thresholdMetric]![
        widget.compareThresholdType ?? 'good']!['end'];
  }

  bool _higherIsPositive() {
    if (widget.thresholdMetric == null) return false;
    if (widget.thresholdMetric == '') return false;
    if (widget.trackingSummary.thresholds.isEmpty) return false;

    final thresholds =
        widget.trackingSummary.thresholds[widget.thresholdMetric] ?? {};

    if (thresholds['good']!['start']! >= thresholds['good']!['end']! &&
        thresholds['warn']!['start']! >= thresholds['warn']!['end']! &&
        thresholds['poor']!['start']! >= thresholds['poor']!['end']!) {
      return true;
    }
    return false;
  }

  /// Sets the widget color based on the threshold metric.
  ///
  /// If the threshold metric is not set, the default color is used.
  /// If all else fails, it will show up as black.
  Color _calculateWidgetColor({double? compareMetric}) {
    var color = Colors.black;
    if (widget.defaultColor != null) color = widget.defaultColor!;

    if (compareMetric == null) return color;

    if (widget.thresholdMetric == null) return color;
    if (widget.thresholdMetric == '') return color;
    if (widget.trackingSummary.thresholds.isEmpty ||
        widget.trackingSummary.records.isEmpty) return color;

    final thresholds =
        widget.trackingSummary.thresholds[widget.thresholdMetric] ?? {};

    return widget.getThresholdColor(
      compareMetric: compareMetric,
      thresholds: thresholds,
    );
  }

  @override
  Widget build(BuildContext context) {
    final trackingName = widget.trackingSummary.name;
    final mainMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.mainMetric] ??
            OutlinedConfettiTrackingWidget.emptyMetric;
    final leftMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.leftMetric] ??
            OutlinedConfettiTrackingWidget.emptyMetric;
    final rightMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.rightMetric] ??
            OutlinedConfettiTrackingWidget.emptyMetric;

    final isRestricted =
        widget.isRestricted ?? widget.trackingSummary.restricted;
    final isPrivate = widget.isPrivate ?? widget.trackingSummary.private;
    final isFavorite = widget.isFavorite ?? false;

    final compareMetric = _calculateCompareMetric();
    final compareThreshold = _calculateCompareThreshold();
    Color? color = Colors.black;

    // Set Threshold based color
    color = _calculateWidgetColor(compareMetric: compareMetric);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onDoubleTap: () async => _onDoubleTap(
            context: context,
            compareMetric: compareMetric,
            compareThreshold: compareThreshold,
          ),
          onLongPress: () async => _displayDetailsPage(),
          onTap: () async => _displayDetailsPage(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: constraints.maxHeight,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  OutlinedTrackingWidgetAuto(
                    id: widget.id,
                    section: widget.section,
                    trackingName: trackingName,
                    mainMetric: mainMetric,
                    leftMetric: leftMetric,
                    rightMetric: rightMetric,
                    color: color,
                    isPrivate: isPrivate,
                    isRestricted: isRestricted,
                    isFavorite: isFavorite,
                  ),
                  // CONFETTI
                  Center(
                    child: ConfettiWidget(
                      confettiController: controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      minBlastForce: 20,
                      maxBlastForce: 50,
                      gravity: 0.01,
                      particleDrag: 0.15,
                      colors: widget.celebrationType == 'stars'
                          ? widget.confettiColors
                          : widget.heartColors,
                      createParticlePath: widget.celebrationType == 'stars'
                          ? widget.drawStar
                          : widget.drawHeart,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

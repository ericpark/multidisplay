import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Packages
import 'package:multidisplay/calendar/helpers/dismissable_modal.dart';

// Project
import 'package:multidisplay/tracking/tracking.dart';

class NthAgoTrackingWidget extends StatefulWidget
    with TrackingWidget, TrackingDialog, Confetti, ThresholdColor {
  NthAgoTrackingWidget({
    super.key,
    id,
    section,
    trackingSummary,
    required this.onDoubleTap,
    this.color,
  }) {
    // Confetti Mixin
    this.id = id;
    this.section = section;
    this.trackingSummary = trackingSummary;
  }

  final void Function()? onDoubleTap;
  final Color? color;

  @override
  State<NthAgoTrackingWidget> createState() => _NthAgoTrackingWidgetState();
}

class _NthAgoTrackingWidgetState extends State<NthAgoTrackingWidget> {
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

  void onDoubleTap({double? compareMetric, double? compareThreshold}) async {
    // Do nothing if no double tap function is provided
    if (widget.onDoubleTap == null) return;

    // Check confirmation and stop if not confirmed
    bool? confirmTracking = await widget.showDefaultDialog(
      context,
      onDoubleTap: widget.onDoubleTap,
    );
    if (confirmTracking != true) return;

    // Do not use compareMetric
    const useCelebration = true;
    final celebrationMetric = compareMetric ?? 0;
    final celebrationThreshold = compareThreshold ?? 0;

    // Check if confetti should be displayed
    bool showConfetti = widget.showConfetti(
      useCelebrationThreshold: useCelebration,
      celebrationMetric: celebrationMetric,
      celebrationThreshold: celebrationThreshold,
      useMultipleToday: false,
      records: widget.trackingSummary.records,
      useRandom: true,
    );

    if (confirmTracking == true && showConfetti) {
      controllerCenter.play();
    }
  }

  void displayDetailsPage() async {
    await showDismissableModal(
        context, TrackingDetailsView(id: widget.id, section: widget.section));
  }

  @override
  Widget build(BuildContext context) {
    final trackingName = widget.trackingSummary.name;
    final mainMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.mainMetric] ??
            widget.emptyMetric;
    final leftMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.leftMetric] ??
            widget.emptyMetric;
    final rightMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.rightMetric] ??
            widget.emptyMetric;
    final thresholdMetric = widget.trackingSummary.mainMetric;

    Color? color = widget.color;

    double? compareMetric;
    double? compareThreshold;

    // Set Threshold based color
    if (thresholdMetric != "" &&
        widget.trackingSummary.thresholds.isNotEmpty &&
        widget.trackingSummary.records.isNotEmpty) {
      Map<String, Map<String, double>> thresholds =
          widget.trackingSummary.thresholds[thresholdMetric] ?? {};
      compareThreshold ??=
          widget.trackingSummary.thresholds[thresholdMetric]?["good"]?["start"];

      compareMetric = double.tryParse(
              widget.trackingSummary.metrics[thresholdMetric]?["value"] ??
                  "0.0") ??
          0.0;

      color = widget.getThresholdColor(
        compareMetric: compareMetric,
        thresholds: thresholds,
      );
    }
    return GestureDetector(
      onDoubleTap: () => onDoubleTap(
          compareMetric: compareMetric, compareThreshold: compareThreshold),
      onLongPress: () async => displayDetailsPage(),
      onTap: () async => displayDetailsPage(),
      child: Stack(
        children: [
          OutlinedTrackingWidget(
            id: widget.id,
            section: widget.section,
            trackingName: trackingName,
            mainMetric: mainMetric,
            leftMetric: leftMetric,
            rightMetric: rightMetric,
            color: color,
          ),
          // CONFETTI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: ConfettiWidget(
                  confettiController: controllerCenter,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  minBlastForce: 20,
                  maxBlastForce: 50,
                  gravity: 0.01,
                  particleDrag: 0.15,
                  colors: widget.confettiColors,
                  createParticlePath: widget.drawStar,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

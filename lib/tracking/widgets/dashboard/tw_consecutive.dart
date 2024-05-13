import 'package:flutter/material.dart';

// Packages
import 'package:multidisplay/app/helpers/helpers.dart';
import 'package:multidisplay/app/widgets/dismissable_modal.dart';

// Project
import 'package:multidisplay/tracking/tracking.dart';

class ConsecutiveTrackingWidget extends StatefulWidget
    with TrackingWidget, TrackingDialog, Confetti, ThresholdColor {
  ConsecutiveTrackingWidget({
    super.key,
    id,
    section,
    trackingSummary,
    required this.onDoubleTap,
  }) {
    // Confetti Mixin
    this.id = id;
    this.section = section;
    this.trackingSummary = trackingSummary;
  }

  final void Function()? onDoubleTap;

  @override
  State<ConsecutiveTrackingWidget> createState() =>
      _ConsecutiveTrackingWidgetState();
}

class _ConsecutiveTrackingWidgetState extends State<ConsecutiveTrackingWidget> {
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

    // Check confirmation and stop if not confirmed
    final celebrationMetric = compareMetric ?? 0;
    final celebrationThreshold = compareThreshold ?? 0;

    bool showConfetti = widget.showConfetti(
      useCelebrationThreshold: true,
      celebrationMetric: celebrationMetric,
      celebrationThreshold: celebrationThreshold,
      useMultipleToday: true,
      records: widget.trackingSummary.records,
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
    const thresholdMetric = "hours_until_reset";

    Color? color = Colors.black;
    double? compareMetric;
    double? compareThreshold;

    // Set Threshold based color
    if (thresholdMetric != "" &&
        widget.trackingSummary.thresholds.isNotEmpty &&
        widget.trackingSummary.records.isNotEmpty) {
      final lastDate = widget.trackingSummary.records.last.date;
      Map<String, Map<String, double>> thresholds =
          widget.trackingSummary.thresholds[thresholdMetric] ?? {};
      compareThreshold ??=
          widget.trackingSummary.thresholds[thresholdMetric]?["good"]?["start"];

      int minutesUntilNextDay = (lastDate.midnight
          .add(const Duration(days: 2))
          .difference(DateTime.now())
          .inMinutes);
      compareMetric = minutesUntilNextDay / 60;

      color = widget.getThresholdColor(
        compareMetric: compareMetric,
        thresholds: thresholds,
      );
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onDoubleTap: () async => onDoubleTap(
            compareMetric: compareMetric,
            compareThreshold: compareThreshold,
          ),
          onLongPress: () async => displayDetailsPage(),
          onTap: () async => displayDetailsPage(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                  ),
                  // CONFETTI
                  Center(
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

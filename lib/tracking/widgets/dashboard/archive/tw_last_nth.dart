import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Packages
import 'package:multidisplay/app/widgets/dismissable_modal.dart';
// Project
import 'package:multidisplay/tracking/tracking.dart';

class LastNthTrackingWidget extends DefaultTrackingWidget
    with TrackingWidget, TrackingDialog, Confetti, ThresholdColor {
  LastNthTrackingWidget({
    required super.onDoubleTap,
    required super.id,
    required super.section,
    required super.trackingSummary,
    super.key,
    super.color,
  }) {
    // Confetti Mixin
    //this.id = id;
    //this.section = section;
    //this.trackingSummary = trackingSummary;
  }

  //final void Function()? onDoubleTap;
  //final Color? color;

  @override
  State<LastNthTrackingWidget> createState() => _LastNthTrackingWidgetState();
}

class _LastNthTrackingWidgetState extends State<LastNthTrackingWidget> {
  late ConfettiController controllerCenter;

  // Default values to set for confetti if needed.
  // static const useCelebration = false;
  // static const useMultipleToday = false;
  // static const useRandom = true;
  static const randomThreshold = 0.90;

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

  Future<void> onDoubleTap({
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

    // Calculate celebration metric and threshold if confirmed
    final celebrationMetric = compareMetric ?? 0;
    final celebrationThreshold = compareThreshold ?? 0;

    // Check if confetti should be displayed
    final showConfetti = widget.showConfetti(
      celebrationMetric: celebrationMetric,
      celebrationThreshold: celebrationThreshold,
      records: widget.trackingSummary.records,
      randomSuccessPercentage: randomThreshold,
    );

    if ((confirmTracking ?? false) && showConfetti) {
      controllerCenter.play();
    }
  }

  Future<void> displayDetailsPage() async {
    await showDismissableModal(
      context,
      TrackingDetailsView(id: widget.id, section: widget.section),
    );
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
    const thresholdMetric = 'average';

    final isRestricted = widget.trackingSummary.restricted;
    final isPrivate = widget.trackingSummary.private;

    var color = widget.color;
    double? compareMetric;
    double? compareThreshold;

    // Set Threshold based color
    if (thresholdMetric != '' &&
        widget.trackingSummary.thresholds.isNotEmpty &&
        widget.trackingSummary.records.isNotEmpty) {
      final thresholds =
          widget.trackingSummary.thresholds[thresholdMetric] ?? {};
      compareThreshold ??=
          widget.trackingSummary.thresholds[thresholdMetric]?['good']?['start'];

      compareMetric = double.tryParse(
            widget.trackingSummary.metrics[thresholdMetric]?['value'] ?? '0.0',
          ) ??
          0.0;

      color = widget.getThresholdColor(
        compareMetric: compareMetric,
        thresholds: thresholds,
      );
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onDoubleTap: () => onDoubleTap(
            compareMetric: compareMetric,
            compareThreshold: compareThreshold,
          ),
          onLongPress: () async => displayDetailsPage(),
          onTap: () async => displayDetailsPage(),
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
                    isRestricted: isRestricted,
                    isPrivate: isPrivate,
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

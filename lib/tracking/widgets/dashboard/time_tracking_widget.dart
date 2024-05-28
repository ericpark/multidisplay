import 'dart:async';

import 'package:flutter/material.dart';

// Packages
import 'package:multidisplay/app/widgets/dismissable_modal.dart';
import 'package:multidisplay/constants.dart';

// Project
import 'package:multidisplay/tracking/tracking.dart';

class TimeTrackingWidget extends StatefulWidget
    with TrackingWidget, TrackingDialog, Confetti, ThresholdColor {
  TimeTrackingWidget({
    required this.onDoubleTap,
    required this.onFinished,
    required int id,
    required String section,
    required TrackingSummary trackingSummary,
    super.key,
    this.color,
  }) {
    // Confetti Mixin
    this.id = id;
    this.section = section;
    this.trackingSummary = trackingSummary;
  }

  final Color? color;
  final void Function()? onDoubleTap;
  final void Function()? onFinished;

  @override
  State<TimeTrackingWidget> createState() => _TimeTrackingWidgetState();
}

class _TimeTrackingWidgetState extends State<TimeTrackingWidget> {
  Timer? timer;
  DateTime now = DateTime.now();
  late DateTime started;
  late int hours = now.difference(started).inHours;
  late int minutes = now.difference(started).inMinutes - (hours * 60);
  late ConfettiController controllerCenter;

  @override
  void initState() {
    controllerCenter = widget.defaultConfettiController();

    now = DateTime.now();
    started = widget.trackingSummary.records.last.createdAt ?? DateTime.now();
    hours = now.difference(started).inHours;
    minutes = now.difference(started).inMinutes - (hours * 60);

    final timeMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.rightMetric] ??
            widget.emptyMetric;
    if (timeMetric['value'] == '') {
      timer = Timer.periodic(
          const Duration(seconds: LONG_TICKER_DURATION_IN_SECONDS), (timer) {
        if (mounted) {
          setState(() {
            now = DateTime.now();
            hours = now.difference(started).inHours;
            minutes = now.difference(started).inMinutes - (hours * 60);
          });
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    final timeMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.rightMetric] ??
            widget.emptyMetric;
    if (timeMetric['value'] == '') {
      timer?.cancel();
    }
    controllerCenter.dispose();

    super.dispose();
  }

  Future<void> onFinish({
    double? compareMetric,
    double? compareThreshold,
  }) async {
    widget.onFinished!();

    // Check confirmation and stop if not confirmed
    final celebrationMetric = compareMetric ?? 0;
    final celebrationThreshold = compareThreshold ?? 0;

    final showConfetti = widget.showConfetti(
      useCelebrationThreshold: true,
      celebrationMetric: celebrationMetric,
      celebrationThreshold: celebrationThreshold,
      positiveIsHigherThanThreshold: false,
      records: widget.trackingSummary.records,
      useRandom: false,
    );

    if (showConfetti) {
      controllerCenter.play();
    }
  }

  Future<void> onDoubleTap() async {
    // Do nothing if no double tap function is provided
    if (widget.onDoubleTap == null) return;
    await widget.showDefaultDialog(
      context,
      onDoubleTap: widget.onDoubleTap,
    );
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
    var mainMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.mainMetric] ??
            widget.emptyMetric;
    final leftMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.leftMetric] ??
            widget.emptyMetric;
    final rightMetric =
        widget.trackingSummary.metrics[widget.trackingSummary.rightMetric] ??
            widget.emptyMetric;
    var thresholdMetric = widget.trackingSummary.mainMetric;

    Color? color = Theme.of(context).colorScheme.secondary;
    double? compareMetric;
    double? compareThreshold;

    // Calculate the hours and minutes since started
    started = widget.trackingSummary.records.last.createdAt ?? DateTime.now();
    hours = now.difference(started).inHours;
    minutes = now.difference(started).inMinutes - (hours * 60);

    final isActive =
        rightMetric['display_name'] != '' && rightMetric['value'] == '';
    // If the right metric is empty, we are still tracking.
    if (isActive) {
      mainMetric = {
        'display_name': 'Hours (in progress)',
        'value': '${hours + ((minutes ~/ 15) * 0.25)}',
      };
      thresholdMetric = widget.trackingSummary.rightMetric;
    }

    try {
      if (widget.trackingSummary.thresholds[thresholdMetric] != null) {
        final thresholds = widget.trackingSummary.thresholds[thresholdMetric]!;
        compareThreshold ??=
            widget.trackingSummary.thresholds[thresholdMetric]?['good']?['end'];

        compareMetric = double.parse(mainMetric['value']!);

        color = widget.getThresholdColor(
          compareMetric: compareMetric,
          thresholds: thresholds,
        );
      }
    } catch (err) {
      debugPrint('ERROR: TIME TRACKING WIDGET - $err');
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onDoubleTap: () async => isActive ? null : onDoubleTap(),
          onLongPress: () async => displayDetailsPage(),
          onTap: () async => isActive ? null : displayDetailsPage(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: constraints.maxHeight,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  OutlinedTrackingWithButtonWidget(
                    id: widget.id,
                    section: widget.section,
                    trackingName: trackingName,
                    mainMetric: mainMetric,
                    leftMetric: leftMetric,
                    rightMetric: rightMetric,
                    color: widget.color ?? color,
                    isActive: isActive,
                    onPress: () async => onFinish(
                      compareMetric: compareMetric,
                      compareThreshold: compareThreshold,
                    ),
                  ),
                  Center(
                    child: ConfettiWidget(
                      confettiController: controllerCenter,
                      blastDirectionality: BlastDirectionality.explosive,
                      minBlastForce: 20,
                      maxBlastForce: 50,
                      gravity: 0.01,
                      particleDrag: 0.15,
                      colors: widget.heartColors,
                      createParticlePath: widget.drawHeart,
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
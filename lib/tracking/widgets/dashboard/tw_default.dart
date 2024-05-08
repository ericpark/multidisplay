import 'package:flutter/material.dart';

// Packages
import 'package:multidisplay/calendar/helpers/dismissable_modal.dart';

// Project
import 'package:multidisplay/tracking/tracking.dart';

class DefaultTrackingWidget extends StatefulWidget
    with TrackingWidget, TrackingDialog {
  DefaultTrackingWidget({
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
  State<DefaultTrackingWidget> createState() => _DefaultTrackingWidgetState();
}

class _DefaultTrackingWidgetState extends State<DefaultTrackingWidget> {
  late ConfettiController controllerCenter;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onDoubleTap() async {
    // Do nothing if no double tap function is provided
    if (widget.onDoubleTap == null) return;

    // Check confirmation and stop if not confirmed
    bool? confirmTracking = await widget.showDefaultDialog(
      context,
      onDoubleTap: widget.onDoubleTap,
    );
    if (confirmTracking != true) return;
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

    Color? color = widget.color;

    return GestureDetector(
      onDoubleTap: () async => onDoubleTap(),
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
        ],
      ),
    );
  }
}

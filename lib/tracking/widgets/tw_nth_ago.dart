import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Packages
import 'package:adaptive_dialog/adaptive_dialog.dart';

// Project
import 'package:multidisplay/tracking/tracking.dart';

class NthAgoTrackingWidget extends StatelessWidget {
  const NthAgoTrackingWidget({
    super.key,
    required this.id,
    required this.section,
    required this.trackingSummary,
    required this.onDoubleTap,
    this.dialogChoices,
    this.color,
  });

  final int id;
  final String section;
  final TrackingSummary trackingSummary;

  final List<String>? dialogChoices;
  final Color? color;
  final void Function()? onDoubleTap;

  Future<bool?> _showChoiceDialog(BuildContext context) async {
    final actions = dialogChoices!
        .map((choice) => AlertDialogAction(
            key: choice.toLowerCase().replaceAll(" ", "-"), label: choice))
        .toList();

    final result = await showConfirmationDialog(
      context: context,
      title: 'Choices',
      message: 'Please Select',
      actions: actions,
    );
    if (result == OkCancelResult.ok.toString()) {
      onDoubleTap!();
      return true;
    }
    return null;
  }

  Future<bool?> _showDefaultDialog(BuildContext context) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Track Event',
      message: 'Do you want to add this event?',
      okLabel: 'Yes',
      cancelLabel: 'No',

      isDestructiveAction: false,
      //style: AdaptiveStyle.iOS,
      builder: (context, child) => Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
          ),

          // If this is commented out, the color for cupertino will be default blue/red.
          cupertinoOverrideTheme: const CupertinoThemeData(
            primaryColor: CupertinoColors.systemBlue,
          ),
        ),
        child: child,
      ),
    );
    if (result == OkCancelResult.ok) {
      onDoubleTap!();
      return true;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Color? widgetColor = Theme.of(context).colorScheme.secondary;

    final trackingName = trackingSummary.name;
    final mainMetric = trackingSummary.metrics[trackingSummary.mainMetric] ??
        {"display_name": "", "value": ""};
    final leftMetric = trackingSummary.metrics[trackingSummary.leftMetric] ??
        const {"display_name": "", "value": ""};
    final rightMetric = trackingSummary.metrics[trackingSummary.rightMetric] ??
        const {"display_name": "", "value": ""};

    try {
      if (trackingSummary.thresholds[trackingSummary.mainMetric] != null) {
        final thresholds =
            trackingSummary.thresholds[trackingSummary.mainMetric]!;
        final compareMetric = double.parse(mainMetric["value"]!);

        if (thresholds["good"]!["start"]! <= compareMetric &&
            compareMetric <= thresholds["good"]!["end"]!) {
          widgetColor = Colors.green[700];
        } else if (thresholds["warn"]!["start"]! <= compareMetric &&
            compareMetric <= thresholds["warn"]!["end"]!) {
          widgetColor = Colors.amber[700];
        } else if (thresholds["poor"]!["start"]! <= compareMetric &&
            compareMetric <= thresholds["poor"]!["end"]!) {
          widgetColor = Colors.red[700];
        } else {
          widgetColor = Colors.black;
        }
      }
    } catch (err) {
      //print(err);
    }

    return OutlinedTrackingWidget(
      id: id,
      section: section,
      trackingName: trackingName,
      mainMetric: mainMetric,
      leftMetric: leftMetric,
      rightMetric: rightMetric,
      color: color ?? widgetColor,
      onDoubleTap: () => dialogChoices != null
          ? _showChoiceDialog(context)
          : _showDefaultDialog(context),
    );
  }
}

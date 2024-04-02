import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Packages
import 'package:adaptive_dialog/adaptive_dialog.dart';

// Project
import 'package:multidisplay/tracking/tracking.dart';

class ConsecutiveTrackingWidget extends StatelessWidget {
  const ConsecutiveTrackingWidget({
    super.key,
    required this.id,
    required this.section,
    required this.trackingSummary,
    required this.onDoubleTap,
    this.dialogChoices,
  });

  final int id;
  final String section;
  final TrackingSummary trackingSummary;

  final List<String>? dialogChoices;
  final void Function()? onDoubleTap;

  void _showChoiceDialog(BuildContext context) async {
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
    }
  }

  void _showDefaultDialog(BuildContext context) async {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? color;
    final lastDate = trackingSummary.records.last.date;
    int hoursSinceLastRecord = DateTime.now().difference(lastDate).inHours;
    int hoursRemainingToday = 24 - DateTime.now().hour;

    if (hoursSinceLastRecord < 24) {
      color = Colors.green[700];
    } else if (hoursSinceLastRecord < 48 && hoursRemainingToday > 0) {
      color = Colors.amber[700];
    } else {
      color = Colors.red[700];
    }

    final trackingName = trackingSummary.name;
    final mainMetric = trackingSummary.metrics[trackingSummary.mainMetric] ??
        {"display_name": "", "value": ""};
    final leftMetric = trackingSummary.metrics[trackingSummary.leftMetric] ??
        const {"display_name": "", "value": ""};
    final rightMetric = trackingSummary.metrics[trackingSummary.rightMetric] ??
        const {"display_name": "", "value": ""};

    return OutlinedTrackingWidget(
      id: id,
      section: section,
      trackingName: trackingName,
      mainMetric: mainMetric,
      leftMetric: leftMetric,
      rightMetric: rightMetric,
      color: color,
      onDoubleTap: () => dialogChoices != null
          ? _showChoiceDialog(context)
          : _showDefaultDialog(context),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Packages
import 'package:adaptive_dialog/adaptive_dialog.dart';

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
*/

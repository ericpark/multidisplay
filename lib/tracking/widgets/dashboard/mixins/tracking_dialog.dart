import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin TrackingDialog {
  Future<bool?> showDefaultDialog(BuildContext context,
      {VoidCallback? onDoubleTap,}) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Track Event',
      message: 'Do you want to add this event?',
      okLabel: 'Yes',
      cancelLabel: 'No',
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
}

Future<bool?> showChoiceDialog(BuildContext context,
    {VoidCallback? onDoubleTap, List<String>? dialogChoices,}) async {
  final actions = dialogChoices!
      .map((choice) => AlertDialogAction(
          key: choice.toLowerCase().replaceAll(' ', '-'), label: choice,),)
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

Future<bool?> showFinishTrackingDialog(BuildContext context) async {
  final result = await showOkCancelAlertDialog(
    context: context,
    title: 'Finish Tracking',
    message: 'Do you want to mark this as finished?',
    okLabel: 'Yes',
    cancelLabel: 'No',
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
    return true;
  }
  return null;
}

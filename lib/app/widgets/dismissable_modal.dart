import 'package:flutter/cupertino.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:multidisplay/calendar/calendar.dart';

Future<dynamic> showDismissableModal(
    BuildContext buildContext, Widget widget) async {
  //CalendarCubit cubit = buildContext.read<CalendarCubit>();

  // cubit.startLoading();
  await showCupertinoModalPopup(
    useRootNavigator: true,
    barrierDismissible: true,
    context: buildContext,
    builder: (BuildContext context) {
      //cubit = context.read<CalendarCubit>();
      return Dismissible(
          direction: DismissDirection.down,
          key: UniqueKey(),
          onDismissed: (dismissDirection) async {
            bool isKeyboardShowing =
                MediaQuery.of(context).viewInsets.vertical > 0;
            //cubit = context.read<CalendarCubit>();
            Navigator.pop(context, "swipe_pop_$isKeyboardShowing");
          },
          child: CupertinoPopupSurface(
            child: Container(
              color: CupertinoColors.lightBackgroundGray,
              alignment: Alignment.topCenter,
              width: double.infinity, //double.infinity,
              height: 700,
              child: widget,
            ),
          ));
    },
  ).then((popType) async {
    if (popType == "keyboard_showing_true" || popType == "swipe_pop_true") {
      //await cubit.startLoading();

      await Future.delayed(const Duration(milliseconds: 800));
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    //await cubit.refreshCalendarUI();
  });
}

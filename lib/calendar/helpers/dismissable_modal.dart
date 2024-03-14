import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

Future<dynamic> showDismissableModal(
    BuildContext buildContext, Widget widget) async {
  buildContext.read<CalendarCubit>().startLoading();

  await showCupertinoModalPopup(
    barrierDismissible: true,
    context: buildContext,
    builder: (BuildContext context) {
      return Dismissible(
          direction: DismissDirection.down,
          key: const Key('dismissableModal'),
          onDismissed: (dismissDirection) async {
            Navigator.of(context).pop();
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
  );
  //.then((_) => buildContext.read<CalendarCubit>().refreshCalendarUI());
}

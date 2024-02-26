import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:multidisplay/calendar/widgets/cal_filter_widget.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.filter_list, semanticLabel: 'Filter'),
              onPressed: () async {
                showPopupModal(context, const CalendarFilterWidget());
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, semanticLabel: 'Search Event'),
                onPressed: () async {
                  showPopupModal(context, Container());
                },
              ),
              IconButton(
                icon: const Icon(Icons.add, semanticLabel: 'New Event'),
                onPressed: () async {
                  showPopupModal(context, const CalendarNewEvent());
                },
              ),
            ],
          ),
          body: const Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(flex: 60, child: CalendarMonthWidget()),
              Expanded(flex: 40, child: CalendarScheduleWidget()),
            ],
          ),
        );
      },
    );
  }

  void showPopupModal(BuildContext buildContext, Widget widget) {
    showCupertinoModalPopup(
      context: buildContext,
      builder: (BuildContext context) {
        return CupertinoPopupSurface(
          child: Container(
            color: CupertinoColors.white,
            alignment: Alignment.topCenter,
            width: double.infinity,
            height: 700,
            child: BlocBuilder<CalendarCubit, CalendarState>(
              builder: (context, state) {
                return widget;
              },
            ),
          ),
        );
      },
    );
  }
}

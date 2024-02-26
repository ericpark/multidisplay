import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.filter_list, semanticLabel: 'Filters'),
          onPressed: () async {
            showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoPopupSurface(
                      child: Container(
                          color: CupertinoColors.white,
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          height: 800,
                          child: CalendarNewEvent()));
                });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, semanticLabel: 'Search Event'),
            onPressed: () async {},
          ),
          IconButton(
            icon: const Icon(Icons.add, semanticLabel: 'New Event'),
            onPressed: () async {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoPopupSurface(
                        child: Container(
                            color: CupertinoColors.white,
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 400,
                            child: Center()));
                  });
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
  }
}

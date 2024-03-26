// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TrackingDetailsView extends StatelessWidget {
  const TrackingDetailsView(
      {super.key, required this.id, required this.section});

  final int id;
  final String section;

  @override
  Widget build(BuildContext context) {
    TrackingCubit trackingCubit = context.read<TrackingCubit>();

    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    final records =
        trackingCubit.state.trackingGroups[section]!.data[id].records;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
            key: const Key('editWidget_close_iconButton'),
            icon: const Icon(Icons.close_outlined, semanticLabel: 'Close'),
            onPressed: () async {
              Navigator.pop(context, "keyboard_showing_$isKeyboardShowing");
            }),
        title: Text(
            "${trackingCubit.state.trackingGroups[section]!.data[id].name}"),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 30,
            child: SfCalendar(
              blackoutDates: records.map((e) => e.date).toList(),
              blackoutDatesTextStyle: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold),
              view: CalendarView.month,
              todayHighlightColor: Colors.grey.shade300,
              viewNavigationMode: ViewNavigationMode.snap,
              monthViewSettings: MonthViewSettings(
                navigationDirection: MonthNavigationDirection.vertical,
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                dayFormat: 'EEEE',
                monthCellStyle: MonthCellStyle(
                  textStyle: TextStyle(color: Colors.grey.shade400),
                  trailingDatesTextStyle:
                      TextStyle(color: Colors.grey.shade400),
                  leadingDatesTextStyle: TextStyle(color: Colors.grey.shade400),
                ),
              ),
              headerHeight: 0,
              dataSource: null,
              onTap: (_) {},
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.transparent, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Expanded(
            flex: 70,
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final item = records[index];
                return Dismissible(
                  key: Key(item.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    /*ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item.name} dismissed")),
                    );*/
                  },
                  child: ListTile(
                    title: Text(item.toString()),
                    subtitle: Text("Date: ${item.date.toString()}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

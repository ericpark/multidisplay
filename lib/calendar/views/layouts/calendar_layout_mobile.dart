import 'package:flutter/material.dart';

// Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:custom_components/custom_components.dart';

// Project
import 'package:multidisplay/calendar/calendar.dart';

class CalendarLayoutMobile extends StatelessWidget {
  const CalendarLayoutMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        CalendarCubit calendarCubit = context.read<CalendarCubit>();
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              shadowColor: Colors.black,
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              clipBehavior: Clip.antiAlias,
              leading: IconButton(
                icon: const Icon(Icons.filter_list, semanticLabel: 'Filter'),
                onPressed: () async {
                  await calendarCubit.fetchEvents();

                  if (!context.mounted) {
                    return;
                  }

                  await showDismissableModal(
                      context, const CalendarFilterView());
                },
              ),
              title: CalendarSegmentButton(
                  selected: state.view,
                  onChange: (CalendarView view) =>
                      {calendarCubit.toggleCalendarView(view: view)}),
              actions: [
                /*IconButton(
                  icon: const Icon(Icons.search, semanticLabel: 'Search Event'),
                  onPressed: () async {
                    await showDismissableModal(context, Container());
                  },
                ),*/
                IconButton(
                  icon: const Icon(Icons.refresh,
                      semanticLabel: 'Refresh events'),
                  onPressed: () async {
                    //await calendarCubit.refreshCalendar();
                    //await calendarCubit.refreshCalendarUI();
                  },
                ),
              ],
            ),
            floatingActionButton: const AddEventFAB(),
            body: CalendarLayoutMobileView(view: state.view));
      },
    );
  }
}

class CalendarLayoutMobileView extends StatelessWidget {
  const CalendarLayoutMobileView({super.key, this.view = CalendarView.month});

  final CalendarView view;

  @override
  Widget build(BuildContext context) {
    const calendarMonthWidget = CalendarMonthWidget();
    const calendarScheduleWidget = CalendarSchedule();

    /// Layout :
    /// |---------------------|
    /// |                     |
    /// |                     |
    /// |         100%        |
    /// |                     |
    /// |                     |
    /// |---------------------|

    final child = (view == CalendarView.month)
        ? calendarMonthWidget
        : calendarScheduleWidget;

    return SafeArea(
      child: Center(
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 100,
                child: Padding(
                    padding: EdgeInsets.zero,
                    child: Container(color: Colors.white, child: child))),
          ],
        ),
      ),
    );
  }
}

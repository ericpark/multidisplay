import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';
// Packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:multidisplay/app/widgets/dismissable_modal.dart';
// Project
import 'package:multidisplay/calendar/calendar.dart';

class CalendarLayoutTablet extends StatelessWidget {
  const CalendarLayoutTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarCubit = context.read<CalendarCubit>();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 10,
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

              await showDismissableModal(context, const CalendarFilterView());
            },
          ),
          actions: [
            /*IconButton(
              icon: const Icon(Icons.search, semanticLabel: 'Search Event'),
              onPressed: () async {
                await showDismissableModal(context, Container());
              },
            ),*/
            IconButton(
              icon: const Icon(Icons.refresh, semanticLabel: 'Refresh events'),
              onPressed: () async {
                //await calendarCubit.refreshCalendar();
                //await calendarCubit.refreshCalendarUI();
              },
            ),
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const AddEventFAB(),
        body: const CalendarLayoutTabletView(),);
  }
}

class CalendarLayoutTabletView extends StatelessWidget {
  const CalendarLayoutTabletView({super.key});

  @override
  Widget build(BuildContext context) {
    const cardPadding = EdgeInsets.all(8);

    const calendarMonthWidget = SimpleCard(
        gradientPreset: GradientPreset.lighten, child: CalendarMonthWidget(),);
    const calendarScheduleWidget = SimpleCard(
        gradientPreset: GradientPreset.lighten, child: CalendarSchedule(),);

    /// Layout :
    /// |---------------------|
    /// |           |         |
    /// |           |         |
    /// |    60%    |   40%   |
    /// |           |         |
    /// |           |         |
    /// |---------------------|
    return const SafeArea(
      child: Center(
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 60,
                child:
                    Padding(padding: cardPadding, child: calendarMonthWidget),),
            Expanded(
                flex: 40,
                child: Padding(
                    padding: cardPadding, child: calendarScheduleWidget,),),
          ],
        ),
      ),
    );
  }
}

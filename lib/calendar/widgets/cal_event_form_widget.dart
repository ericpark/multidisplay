import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarEventForm extends StatelessWidget {
  const CalendarEventForm({
    super.key,
    this.event,
  });

  final CalendarEvent? event;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final formBloc = context.read<CalendarFormBloc>();
        final calendarCubit = context.read<CalendarCubit>();

        if (event != null) {
          CalendarEvent eventData = event!;

          formBloc.eventName.updateInitialValue(eventData.eventName);
          formBloc.description.updateInitialValue(eventData.description);
          formBloc.calendar.updateInitialValue(eventData.calendarId);
          formBloc.startDate.updateInitialValue(eventData.start);
          formBloc.endDate.updateInitialValue(eventData.end);
        }

        return FormBlocListener<CalendarFormBloc, String, String>(
          onSuccess: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.successResponse!),
              duration: const Duration(seconds: 2),
            ));
          },
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: <Widget>[
                TextFieldBlocBuilder(
                  textFieldBloc: formBloc.eventName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Event Name',
                    prefixIcon: Icon(Icons.people),
                    suffixIcon: Icon(
                      Icons.emergency,
                      size: 10,
                    ),
                  ),
                ),
                DropdownFieldBlocBuilder<String>(
                  selectFieldBloc: formBloc.calendar,
                  decoration: const InputDecoration(
                    labelText: 'Calendar',
                    prefixIcon: Icon(Icons.edit_calendar),
                    suffixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 20, 0),
                      child: Icon(
                        Icons.emergency,
                        size: 10,
                      ),
                    ),
                  ),
                  itemBuilder: (context, value) => FieldItem(
                    child: Flex(direction: Axis.horizontal, children: [
                      Expanded(
                        flex: 9,
                        child: Text(
                            calendarCubit.state.calendarDetails[value]!.name),
                      ),
                      Expanded(flex: 5, child: Container()),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 30, 0),
                        child: SizedBox(
                          width: 10,
                          height: 10,
                          child: Container(
                              color: calendarCubit
                                  .state.calendarDetails[value]?.color),
                        ),
                      ),
                    ]),
                  ),
                ),
                DateTimeFieldBlocBuilder(
                  dateTimeFieldBloc: formBloc.startDate,
                  format: DateFormat('MM-dd-yyyy'),
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  decoration: const InputDecoration(
                    labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    suffixIcon: Icon(
                      Icons.emergency,
                      size: 10,
                    ),
                  ),
                ),
                DateTimeFieldBlocBuilder(
                  dateTimeFieldBloc: formBloc.endDate,
                  format: DateFormat('MM-dd-yyyy'),
                  initialDate: formBloc.startDate.value ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  decoration: const InputDecoration(
                    labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                  ),
                ),
                TextFieldBlocBuilder(
                  textFieldBloc: formBloc.description,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description),
                  ),
                  maxLines: 3,
                  minLines: 3,
                ),
                FilterChipFieldBlocBuilder(
                  multiSelectFieldBloc: formBloc.tags,
                  decoration: const InputDecoration(
                    labelText: 'Tags',
                    prefixIcon: Icon(Icons.tag_sharp),
                  ),
                  itemBuilder: (context, value) =>
                      ChipFieldItem(label: Text(value)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

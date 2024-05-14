import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarFilterView extends StatelessWidget {
  const CalendarFilterView({super.key});

  Widget sectionHeader({
    required String sectionHeader,
    required TextStyle? textStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(sectionHeader, style: textStyle),
    );
  }

  Widget calendarSection() {
    final newCalendarButton = Center(
      child: ElevatedButton(
          onPressed: () => {}, child: const Text('New Calendar'),),
    );

    final calendarFilters = <Widget>[
      const CalendarFilterListTile(),
      const CalendarFilterListTile(),
      const CalendarFilterListTile(),
      const SizedBox(height: 10),
      newCalendarButton,
    ];
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return calendarFilters[index];
      },
    );
  }

  Widget tagsSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return ['dog', 'guest', 'overnight'].where((String option) {
            return option.contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          debugPrint('You just selected $selection');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sectionHeaderStyle = Theme.of(context).textTheme.titleLarge;
    return Center(
      child: BlocConsumer<CalendarCubit, CalendarState>(
        listener: (context, state) {
          if (state.status.isSuccess) {}
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                  key: const Key('filterWidget_close_iconButton'),
                  icon:
                      const Icon(Icons.close_outlined, semanticLabel: 'Close'),
                  onPressed: () {
                    //calendarCubit.refreshCalendarUI();
                    Navigator.of(context).pop();
                  },),
              title: const Text('Filter Events'),
              actions: [
                IconButton(
                  key: const Key('filterWidget_save_iconButton'),
                  icon: const Icon(Icons.check, semanticLabel: 'Save'),
                  onPressed: () {
                    //calendarCubit.refreshCalendarUI();

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionHeader(
                    sectionHeader: 'Calendars',
                    textStyle: sectionHeaderStyle,
                  ),
                  calendarSection(),
                  sectionHeader(
                    sectionHeader: 'Tags',
                    textStyle: sectionHeaderStyle,
                  ),
                  tagsSection(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

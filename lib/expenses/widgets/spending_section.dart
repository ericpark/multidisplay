import 'package:flutter/material.dart';

// Packages
import 'package:flutter_bloc/flutter_bloc.dart';

// Project
import 'package:multidisplay/expenses/expenses.dart';
import 'package:multidisplay/tracking/tracking.dart';

class SpendingSection extends StatelessWidget {
  const SpendingSection({super.key, required this.sectionName});

  final String sectionName;

  Widget sectionHeader({
    required String sectionHeader,
    required TextStyle? textStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sectionHeader, style: textStyle),
        ],
      ),
    );
  }

  Widget sectionWidgets({
    //required List<TrackingSummary> data,
    required ColorScheme colorScheme,
    //required TrackingCubit trackingCubit
  }) {
    //List<Widget> trackingWidgets = [];

    /* for (int i = 0; i < data.length; i++) {
      trackingWidgets.add(getTrackingWidget(
          index: i,
          data: data[i],
          colorScheme: colorScheme,
          trackingCubit: trackingCubit));
    }*/
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 1,
        itemBuilder: (context, index) {
          return HorizontalTrackingWidget(
            id: 0,
            section: "section",
            trackingName: "trackingName",
            mainMetric: const {"display_name": "Test", "value": "1"},
            onDoubleTap: () {},
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String sectionHeaderString = sectionName;
    final sectionHeaderStyle = Theme.of(context).textTheme.titleLarge;
    return BlocBuilder<ExpensesCubit, ExpensesState>(
      builder: (context, state) {
        //ExpensesCubit expensesCubit = context.read<ExpensesCubit>();
        switch (state.status) {
          //case ExpensesStatus.initial:
          //return const TrackingEmpty();
          case ExpensesStatus.loading:
            return const Text("TODO");
          //return const TrackingLoading();
          case ExpensesStatus.initial ||
                ExpensesStatus.success ||
                ExpensesStatus.transitioning:
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionHeader(
                  sectionHeader: sectionHeaderString,
                  textStyle: sectionHeaderStyle,
                ),
                const Divider(),
                sectionWidgets(
                  colorScheme: Theme.of(context).colorScheme,
                ),
              ],
            );
          case ExpensesStatus.failure:
            return const Text("TODO");
          //return const TrackingError();
          default:
            return const Text("Unhandled Exception");
        }
      },
    );
  }
}

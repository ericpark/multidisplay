import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingLayout extends StatelessWidget {
  const TrackingLayout({super.key});

  List<Widget> getSections(List<String> sectionOrder) {
    List<Widget> sections = [];
    for (int section = 0; section < sectionOrder.length; section++) {
      sections.add(TrackingSectionWidget(
        sectionName: sectionOrder[section],
      ));
    }
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingCubit, TrackingState>(
      builder: (context, state) {
        TrackingCubit trackingCubit = context.read<TrackingCubit>();
        List<Widget> sections = getSections(state.trackingSections);
        return ReorderableListView(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          onReorder: (int oldIndex, int newIndex) async {
            await trackingCubit.reorderSections(
                oldIndex: oldIndex, newIndex: newIndex);
          },
          buildDefaultDragHandles: trackingCubit.state.reorderable,
          children: <Widget>[
            for (int index = 0; index < sections.length; index += 1)
              Padding(
                key: Key('$index'),
                padding: const EdgeInsets.all(8.0),
                child: PhysicalModel(
                    color: Theme.of(context).dialogBackgroundColor,
                    elevation: 10,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    child: ListTile(title: sections[index])),
              ),
          ],
        );
      },
    );
  }
}

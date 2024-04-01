import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingLayoutTablet extends StatelessWidget {
  const TrackingLayoutTablet({super.key});

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
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 1,
          scrolledUnderElevation: 5.0,
          shadowColor: Colors.black,
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          clipBehavior: Clip.antiAlias,
          /*leading: IconButton(
            icon: const Icon(Icons.filter_list, semanticLabel: 'Filter'),
            onPressed: () async {},
          ),*/
          actions: [
            /*IconButton(
              icon: const Icon(Icons.search, semanticLabel: 'Search Event'),
              onPressed: () async {},
            ),*/
            IconButton(
              icon: const Icon(Icons.refresh, semanticLabel: 'Refresh events'),
              onPressed: () async {
                await context.read<TrackingCubit>().fetchTrackingGroups();
              },
            ),
            IconButton(
              icon: const Icon(Icons.add, semanticLabel: 'New Event'),
              onPressed: () async {},
            ),
          ],
        ),
        body: BlocBuilder<TrackingCubit, TrackingState>(
          builder: (context, state) {
            TrackingCubit trackingCubit = context.read<TrackingCubit>();

            List<Widget> sections = getSections(state.trackingSections);
            return ReorderableListView(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              onReorder: (int oldIndex, int newIndex) async {
                await trackingCubit.reorderSections(
                    oldIndex: oldIndex, newIndex: newIndex);
              },
              buildDefaultDragHandles: state.reorderable,
              children: <Widget>[
                for (int index = 0; index < sections.length; index += 1)
                  Padding(
                      key: Key('$index'),
                      padding: const EdgeInsets.all(8.0),
                      child: SimpleCard(
                        gradientPreset: GradientPreset.lighten,
                        child: ListTile(title: sections[index]),
                      )),
              ],
            );
          },
        ));
  }
}

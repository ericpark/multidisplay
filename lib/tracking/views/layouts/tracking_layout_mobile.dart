import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:multidisplay/auth/auth.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingLayoutMobile extends StatelessWidget {
  const TrackingLayoutMobile({super.key});

  List<Widget> getSections(List<String> sectionOrder) {
    final sections = <Widget>[];
    for (var section = 0; section < sectionOrder.length; section++) {
      sections.add(
        TrackingSectionWidget(
          sectionName: sectionOrder[section],
        ),
      );
    }
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 1,
        scrolledUnderElevation: 5,
        shadowColor: Colors.black,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        clipBehavior: Clip.antiAlias,
        /*leading: IconButton(
            icon: const Icon(Icons.filter_list, semanticLabel: 'Filter'),
            onPressed: () async {},
          ),*/
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, semanticLabel: 'Refresh events'),
            onPressed: () async {
              await context.read<TrackingCubit>().refreshTrackingGroups(
                    userId: context.read<AuthCubit>().state.user?.id,
                  );
            },
          ),
        ],
      ),
      body: BlocBuilder<TrackingCubit, TrackingState>(
        builder: (context, state) {
          final trackingCubit = context.read<TrackingCubit>();

          final sections = getSections(state.trackingSections);

          final sectionWidgets = <Widget>[];

          sectionWidgets.addAll([
            for (int index = 0; index < sections.length; index += 1)
              Padding(
                key: Key('$index'),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: sections[index],
                  contentPadding: EdgeInsets.zero,
                ),
              ),
          ]);
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<TrackingCubit>().refreshTrackingGroups(
                      userId: context.read<AuthCubit>().state.user?.id,
                    ),
            child: ReorderableListView(
              padding: EdgeInsets.zero,
              onReorder: (int oldIndex, int newIndex) async {
                await trackingCubit.reorderSections(
                  oldIndex: oldIndex,
                  newIndex: newIndex,
                );
              },
              buildDefaultDragHandles: state.reorderable,
              children: sectionWidgets,
            ),
          );
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const AddTrackingFAB(),
    );
  }
}

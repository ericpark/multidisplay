import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:multidisplay/auth/auth.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/tracking/widgets/fade_in_out.dart';

// ignore: must_be_immutable
class TrackingLayoutTablet extends StatelessWidget {
  TrackingLayoutTablet({super.key});
  late void Function(String?) fadeInOut;

  void fadeInOutCallback(String? message) {
    fadeInOut.call(message);
  }

  List<Widget> getSections(List<String> sectionOrder) {
    List<Widget> sections = [];
    for (int section = 0; section < sectionOrder.length; section++) {
      sections.add(TrackingSectionWidget(
        sectionName: sectionOrder[section],
        fadeInCallback: (message) {
          fadeInOutCallback(message);
        },
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
          IconButton(
            icon: const Icon(Icons.refresh, semanticLabel: 'Refresh events'),
            onPressed: () async {
              await context.read<TrackingCubit>().refreshTrackingGroups(
                  userId: context.read<AuthCubit>().state.user?.id);
            },
          ),
        ],
      ),
      body: BlocBuilder<TrackingCubit, TrackingState>(
        builder: (context, state) {
          TrackingCubit trackingCubit = context.read<TrackingCubit>();

          List<Widget> sections = getSections(state.trackingSections);

          List<Widget> sectionWidgets = [];

          sectionWidgets.addAll([
            for (int index = 0; index < sections.length; index += 1)
              Padding(
                key: Key('$index'),
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: sections[index],
                  contentPadding: EdgeInsets.zero,
                ),
              ),
          ]);
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async => await context
                    .read<TrackingCubit>()
                    .refreshTrackingGroups(
                        userId: context.read<AuthCubit>().state.user?.id),
                child: ReorderableListView(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  onReorder: (int oldIndex, int newIndex) async {
                    await trackingCubit.reorderSections(
                        oldIndex: oldIndex, newIndex: newIndex);
                  },
                  buildDefaultDragHandles: state.reorderable,
                  children: sectionWidgets,
                ),
              ),
              FadeInOutMessage(
                show: true,
                builder: (BuildContext context,
                    void Function(String?) runAnimation) {
                  fadeInOut = runAnimation;
                },
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: const AddTrackingFAB(),
    );
  }
}

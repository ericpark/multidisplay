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
    final sections = <Widget>[];
    for (var section = 0; section < sectionOrder.length; section++) {
      sections.add(
        TrackingSectionWidget(
          sectionName: sectionOrder[section],
          fadeInCallback: fadeInOutCallback,
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
        leading: BlocBuilder<TrackingCubit, TrackingState>(
          builder: (context, state) {
            return IconButton(
              icon: state.showAll
                  ? const Icon(Icons.visibility_sharp, semanticLabel: 'Visible')
                  : const Icon(
                      Icons.visibility_off_sharp,
                      semanticLabel: 'Not Visible',
                    ),
              onPressed: state.showAll
                  ? () async {
                      await context.read<TrackingCubit>().toggleShowAll();
                    }
                  : () async {
                      final valid = await Navigator.push(
                        context,
                        MaterialPageRoute<bool>(
                          builder: (context) => const TrackingPinPage(),
                        ),
                      );
                      if (valid != true) return;
                      if (!context.mounted) return;
                      await context.read<TrackingCubit>().toggleShowAll();
                    },
            );
          },
        ),
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
          final sectionWidgets = <Widget>[
            for (int index = 0; index < sections.length; index += 1)
              Padding(
                key: Key('$index'),
                padding: const EdgeInsets.all(8),
                child: ListTile(
                  title: sections[index],
                  contentPadding: EdgeInsets.zero,
                ),
              ),
          ];
          return Stack(
            children: [
              RefreshIndicator(
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
              ),
              FadeInOutMessage(
                show: true,
                builder: (
                  BuildContext context,
                  void Function(String?) runAnimation,
                ) {
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

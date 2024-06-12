// ignore_for_file: unnecessary_string_interpolations

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_heatmap/flutter_calendar_heatmap.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:multidisplay/auth/cubit/auth_cubit.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingDetailsView extends StatelessWidget {
  const TrackingDetailsView({
    required this.id,
    required this.section,
    super.key,
  });

  final int id;
  final String section;
  Future<bool> _showDefaultDialog(BuildContext context) async {
    final result = await showOkCancelAlertDialog(
      context: context,
      title: 'Delete Tracking',
      message: 'Do you want to delete this record?',
      okLabel: 'Yes',
      cancelLabel: 'No',

      isDestructiveAction: true,
      //style: AdaptiveStyle.iOS,
      builder: (context, child) => Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
          ),

          // If this is commented out, the color for cupertino will be default blue/red.
          cupertinoOverrideTheme: const CupertinoThemeData(
            primaryColor: CupertinoColors.systemBlue,
          ),
        ),
        child: child,
      ),
    );
    if (result == OkCancelResult.ok) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> _showTextInputDialog(
    BuildContext context, {
    String? description,
  }) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Update Description',
      message: 'Update the description for this event',
      okLabel: 'Ok',
      cancelLabel: 'Cancel',
      textFields: [
        DialogTextField(initialText: description ?? ''),
      ],
      builder: (context, child) => Theme(
        data: ThemeData(
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
          ),

          // If this is commented out, the color for cupertino will be default blue/red.
          cupertinoOverrideTheme: const CupertinoThemeData(
            primaryColor: CupertinoColors.systemBlue,
          ),
        ),
        child: child,
      ),
    );
    return result?[0];
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    //var trackingCubit = context.read<TrackingCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      primary: false,
      appBar: AppBar(
        centerTitle: true,
        primary: false,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: SizedBox.shrink(),
        ),
        leading: IconButton(
          key: const Key('editWidget_close_iconButton'),
          icon: const Icon(Icons.close_outlined, semanticLabel: 'Close'),
          onPressed: () async {
            Navigator.pop(context, 'keyboard_showing_$isKeyboardShowing');
          },
        ),
        title: Text(
          '''${context.read<TrackingCubit>().state.trackingGroups[section]!.data[id].name}''',
        ),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 100,
            child: BlocBuilder<TrackingCubit, TrackingState>(
              buildWhen: (previous, current) =>
                  previous.status == TrackingStatus.transitioning &&
                      current.status == TrackingStatus.success ||
                  previous.trackingGroups != current.trackingGroups,
              builder: (context, state) {
                final trackingSummary = state.trackingGroups[section]!.data[id];
                final records = state
                    .trackingGroups[section]!.data[id].records.reversed
                    .toList();
                final trackingCubit = context.read<TrackingCubit>();
                final heatmap = <DateTime, int>{};
                for (final record in records) {
                  final cleanDate = DateUtils.dateOnly(record.date);
                  if (heatmap.containsKey(cleanDate)) {
                    heatmap[cleanDate] = heatmap[cleanDate]! + 1;
                  } else {
                    heatmap[cleanDate] = 1;
                  }
                }
                switch (state.status) {
                  case TrackingStatus.initial:
                    return const TrackingEmpty();
                  case TrackingStatus.loading:
                    return const TrackingLoading();
                  case TrackingStatus.transitioning:
                    return const TrackingLoading();
                  case TrackingStatus.success:
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverAppBar(
                          stretch: true,
                          leading: Container(),
                          bottom: PreferredSize(
                            preferredSize: Size.zero,
                            child: Container(),
                          ),
                          title: Text(
                            '''(${trackingCubit.state.trackingGroups[section]!.data[id].trackingType}) ${trackingCubit.state.trackingGroups[section]!.data[id].description}''',
                            textScaler: const TextScaler.linear(0.5),
                            maxLines: 1,
                          ),
                          onStretchTrigger: () async {
                            // Triggers when stretching
                          },
                          // [stretchTriggerOffset] describes the amount of
                          // overscroll that must occur to trigger
                          // [onStretchTrigger]
                          //
                          // Setting [stretchTriggerOffset] to a value of 300.0
                          // will trigger [onStretchTrigger] when the user has
                          // over scrolled by 300.0 pixels.
                          floating: true,
                          primary: false,
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (index == 0) {
                                return Align(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: HeatMap(
                                      aspectRatio: 4.4,
                                      data: heatmap,
                                      colors: [
                                        Colors.white,
                                        Colors.green.shade400,
                                        Colors.green.shade800,
                                      ],
                                      strokeColor: Colors.blue,
                                      itemSize: 30,
                                      itemPadding: 5,
                                    ),
                                  ),
                                );
                              }

                              final item = heatmap.keys.toList()[index - 1];
                              final expanded = records
                                  .where(
                                    (record) =>
                                        DateUtils.dateOnly(record.date) ==
                                        DateUtils.dateOnly(item),
                                  )
                                  .map(
                                    (record) => Slidable(
                                      key: ValueKey(record.id),
                                      startActionPane: ActionPane(
                                        extentRatio: 0.1,
                                        motion: const ScrollMotion(),
                                        /*dismissible:
                                            DismissiblePane(
                                            onDismissed: (){}),*/
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) async {
                                              final description =
                                                  await _showTextInputDialog(
                                                context,
                                                description: record.description,
                                              );
                                              if (description != null) {
                                                await trackingCubit
                                                    .updateTrackingRecord(
                                                  trackingSummary:
                                                      trackingSummary,
                                                  trackingRecord: record,
                                                  data: {
                                                    'description': description,
                                                  },
                                                );
                                              }
                                            },
                                            backgroundColor:
                                                const Color(0xFF0392CF),
                                            foregroundColor: Colors.white,
                                            icon: Icons.save,
                                            label: 'Edit',
                                          ),
                                        ],
                                      ),
                                      endActionPane: ActionPane(
                                        extentRatio: 0.1,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) async {
                                              final userId = context
                                                  .read<AuthCubit>()
                                                  .state
                                                  .user
                                                  ?.id;
                                              final confirm =
                                                  await _showDefaultDialog(
                                                context,
                                              );
                                              if (!confirm) return;

                                              await trackingCubit
                                                  .deleteTrackingRecord(
                                                trackingSummaryId:
                                                    trackingSummary.id,
                                                trackingRecordId: record.id,
                                                section:
                                                    trackingSummary.section,
                                                userId: userId,
                                              );
                                            },
                                            backgroundColor:
                                                const Color(0xFFFE4A49),
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        onTap: () async {
                                          final description =
                                              await _showTextInputDialog(
                                            context,
                                            description: record.description,
                                          );
                                          if (description != null) {
                                            await trackingCubit
                                                .updateTrackingRecord(
                                              trackingSummary: trackingSummary,
                                              trackingRecord: record,
                                              data: {
                                                'description': description,
                                              },
                                            );
                                          }
                                        },
                                        title: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            '''${record.description != "" && record.description != null ? record.description : "${trackingSummary.name} at ${DateFormat("jms").format(item)}"}''',
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList();
                              return Expandable(
                                initiallyExpanded:
                                    state.status == TrackingStatus.success,
                                animationDuration: Duration.zero,
                                firstChild: Expanded(
                                  child: ListTile(
                                    title: Text(
                                      '''${DateFormat("EEE - MMM dd").format(item)}''',
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                      style: const TextStyle(
                                        fontFeatures: [
                                          FontFeature.tabularFigures(),
                                        ],
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        '''${trackingSummary.name}: ${heatmap[DateTime(item.year, item.month, item.day)]}''',
                                      ),
                                    ),
                                  ),
                                ),
                                secondChild: Column(
                                  children: expanded,
                                ),
                                showArrowWidget: true,
                                //onPressed: () => debugPrint('done!'),
                                clickable: Clickable.everywhere,
                              );
                            },
                            childCount: heatmap.keys.length + 1,
                          ),
                        ),
                      ],
                    );
                  case TrackingStatus.failure:
                    return const TrackingError();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

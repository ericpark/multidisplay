import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class NewTrackerPage extends StatelessWidget {
  const NewTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    TrackingCubit trackingCubit =
        BlocProvider.of<TrackingCubit>(context, listen: true);
    List<String> sections = trackingCubit.state.trackingSections;
    List<String> trackingTypes = ["days_ago", "last_seven"];
    Map<String, List<String>> metricsMap = {
      "days_ago": ["days_since_last", "last_date"],
      "last_seven": ["last_seven_days", "days_since_last"]
    };

    return BlocProvider(
      create: (formContext) => TrackerFormBloc(
          sectionList: sections,
          trackingTypeList: trackingTypes,
          metricsMap: metricsMap),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<TrackerFormBloc>(context);
          bool isKeyboardShowing =
              MediaQuery.of(context).viewInsets.vertical > 0;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                  key: const Key('newTracker_close_iconButton'),
                  icon:
                      const Icon(Icons.close_outlined, semanticLabel: 'Close'),
                  onPressed: () async {
                    if (!context.mounted) return;
                    Navigator.pop(
                        context, "keyboard_showing_$isKeyboardShowing");
                  }),
              title: const Text("Create New Tracker"),
              actions: [
                IconButton(
                  key: const Key('newTracker_save_iconButton'),
                  icon: const Icon(Icons.check, semanticLabel: 'Save'),
                  onPressed: () async {
                    // Perform validation
                    await formBloc.onSubmitting();
                    if (!formBloc.state.isValid()) {
                      return;
                    }
                    // If successful, add event
                    TrackingSummary newTrackingSummary =
                        formBloc.toTrackingSummary();

                    await trackingCubit.addNewTrackingSummary(
                        trackingSummaryData: newTrackingSummary);

                    // Dismiss popover
                    if (!context.mounted) return;
                    Navigator.pop(
                        context, "keyboard_showing_$isKeyboardShowing");
                  },
                ),
              ],
            ),
            body: const SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [TrackingForm()],
              ),
            ),
          );
        },
      ),
    );
  }
}

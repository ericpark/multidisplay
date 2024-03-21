import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    TrackingCubit trackingCubit = context.read<TrackingCubit>();
    // Do stuff here that will run when tab changes
    //if (trackingCubit.state.status.isInitial) {}
    //if (trackingCubit.state.status.isLoading) {}
    //if (trackingCubit.state.status.isSuccess) {}
    return BlocBuilder<TrackingCubit, TrackingState>(
        //buildWhen: (previous, current) => previous.events != current.events,
        builder: (context, state) {
      return BlocProvider.value(
        value: trackingCubit,
        child: const TrackingViewContainer(),
      );
    });
  }
}

class TrackingViewContainer extends StatelessWidget {
  const TrackingViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    TrackingCubit trackingCubit = context.read<TrackingCubit>();

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
                await trackingCubit.fetchTrackingGroups();
              },
            ),
            IconButton(
              icon: const Icon(Icons.add, semanticLabel: 'New Event'),
              onPressed: () async {},
            ),
          ],
        ),
        body: const TrackingLayout());
  }
}

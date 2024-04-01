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
    trackingCubit.refreshTrackingSummariesOnNewDay();
    return BlocBuilder<TrackingCubit, TrackingState>(
        //buildWhen: (previous, current) => previous.events != current.events,
        builder: (context, state) {
      return BlocProvider.value(
          value: trackingCubit,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 400) {}
              return const TrackingLayoutTablet();
            },
          ));
    });
  }
}

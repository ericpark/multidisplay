import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:multidisplay/auth/auth.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // When the [AuthCubit] is first initialized, an id will be passed
        // to the the tracking cubit init if available. This is only done once
        // and any other refetching is done on login or log out.
        if (state.status.isAuthenticated) {
          context.read<TrackingCubit>().init(userId: state.user?.id);
        }
        if (state.status.isUnauthenticated) {
          context.read<TrackingCubit>().init();
        }
      },
      builder: (authContext, authState) {
        // Do stuff here that will run when tab changes
        // if (trackingCubit.state.status.isInitial) {}
        //if (trackingCubit.state.status.isLoading) {}
        //if (trackingCubit.state.status.isSuccess) {}

        // This is before the builder so that it checks if it needs to refresh
        // when the tab is changed.
        context
            .read<TrackingCubit>()
            .refreshTrackingSummariesOnNewDay(userId: authState.user?.id);
        return BlocBuilder<TrackingCubit, TrackingState>(
          builder: (context, state) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth < 400) {
                  return const TrackingLayoutMobile();
                }
                return const TrackingLayoutTablet();
              },
            );
          },
        );
      },
    );
  }
}

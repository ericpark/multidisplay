import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multidisplay/auth/auth.dart';
import 'package:multidisplay/constants.dart';
import 'package:multidisplay/tracking/tracking.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  late Timer timer;
  late DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: LONG_TICKER_DURATION_IN_SECONDS * 2), (timer) {
      if (mounted) {
        setState(() {
          now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

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
                return TrackingLayoutTablet();
              },
            );
          },
        );
      },
    );
  }
}

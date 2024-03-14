import 'package:flutter/foundation.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';
import 'package:multidisplay/timer/timer.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (bloc is TimerBloc) {
      return;
    }
    if (kDebugMode) {
      print('EVENT: $event');
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('ERROR: $error');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (change.currentState is TimerRunInProgress &&
        change.nextState is TimerRunInProgress) {
      return;
    }
    if (change.currentState is TextFieldBlocState &&
        change.nextState is TextFieldBlocState) {
      return;
    }
    if (change.currentState is CalendarState &&
        change.nextState is CalendarState) {
      return;
    }

    if (kDebugMode) {
      //print('CHANGE: $change');
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (!(transition.currentState is TimerRunInProgress &&
        transition.nextState is TimerRunInProgress)) {
      if (kDebugMode) {
        print('TRANSITION: $transition');
      }
    }
  }
}

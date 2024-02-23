// ignore_for_file: avoid_print
import 'package:bloc/bloc.dart';
import 'package:multidisplay/timer/timer.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    print('EVENT: $event');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print('ERROR: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (!(change.currentState is TimerRunInProgress &&
        change.nextState is TimerRunInProgress)) {
      print('CHANGE: $change');
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
      print('TRANSITION: $transition');
    }
  }
}

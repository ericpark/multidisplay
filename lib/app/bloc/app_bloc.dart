import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.started()) {
    on<AppStarted>(onAppStarted);
    on<AppLoaded>(onAppLoaded);
  }

  void onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    emit(const AppState.started());
  }

  void onAppLoaded(AppLoaded event, Emitter<AppState> emit) async {
    emit(state);
  }

  void onAppPageChanged() {}
}

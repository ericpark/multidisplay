import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multidisplay/app/helpers/device_helper.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required FormFactor deviceType, String appVersion = '0.0.0'})
      : super(AppState.started(
          deviceType: deviceType,
          appVersion: appVersion,
        )) {
    on<AppStarted>(onAppStarted);
    on<AppLoaded>(onAppLoaded);
    on<AppPageChanged>(onAppPageChanged);
  }

  Future<void> onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    emit(AppState.started(deviceType: state.deviceType));
  }

  Future<void> onAppLoaded(AppLoaded event, Emitter<AppState> emit) async {
    emit(state);
  }

  void onAppPageChanged(AppPageChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(page: event.page));
  }
}

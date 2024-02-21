import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void toggleClockType() {
    final clock = state.clockType == ClockType.military
        ? ClockType.standard
        : ClockType.military;

    emit(
      state.copyWith(
        clockType: clock,
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());

  Future<void> refreshCalendar() async {
    return;
  }

  Future<void> addCalendarEvent() async {
    return;
  }

  Future<void> updateCalendarEvent() async {
    return;
  }
}

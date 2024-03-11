import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:multidisplay/calendar/calendar.dart';

import 'package:calendar_repository/calendar_repository.dart'
    show CalendarRepository;

part 'calendar_state.dart';
part 'calendar_cubit.g.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(this._calendarRepository) : super(CalendarInitial());
  final CalendarRepository _calendarRepository;

  Future<void> init() async {
    emit(state.copyWith(status: CalendarStatus.loading));

    await getCalendarsList();
    fetchEvents(state.calendars);
  }

  Future<void> getCalendarsList() async {
    // Commented out this emit so it doesn't change from loading to success to loading
    // emit(state.copyWith(status: CalendarStatus.loading));
    List<String> calendars =
        await _calendarRepository.getAllCalendars(userId: "default");

    emit(state.copyWith(calendars: calendars));
  }

  Future<void> refreshCalendar() async {
    return;
  }

  Future<void> addCalendarEvent(CalendarEvent event) async {
    final eventData = event.toRepository();
    //emit(state.copyWith(status: CalendarStatus.loading));
    final newEvent =
        await _calendarRepository.addNewEvent(eventData: eventData);

    List<CalendarEvent> updatedListOfEvents = state.events;
    updatedListOfEvents.add(CalendarEvent.fromRepository(newEvent));

    /*emit(state.copyWith(
        status: CalendarStatus.success, events: updatedListOfEvents));*/
  }

  Future<void> updateCalendarEvent() async {
    return;
  }

  Future<void> fetchEvents(List<String> calendarIDs) async {
    if (calendarIDs.isEmpty) return;
    emit(state.copyWith(status: CalendarStatus.loading));
    try {
      List<CalendarEvent> calendarEvents = [];
      final firebaseEvents = await _calendarRepository
          .getAllEventsFromCalendars(calendarIDs: calendarIDs);
      calendarEvents = firebaseEvents
          .map((fEvent) => CalendarEvent.fromRepository(fEvent))
          .toList();
      emit(state.copyWith(
          status: CalendarStatus.success, events: calendarEvents));
    } on Exception {
      emit(state.copyWith(status: CalendarStatus.failure));
    }
  }
}

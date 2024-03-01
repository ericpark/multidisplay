import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
    // Get calendars list
    emit(state.copyWith(status: CalendarStatus.loading));

    // Stub
    List<String> calendars =
        await Future.delayed(const Duration(seconds: 1)).then((val) {
      return ["guestcal"];
    });

    emit(state.copyWith(calendars: calendars));
    fetchEvents(calendars);
  }

  Future<void> refreshCalendar() async {
    return;
  }

  Future<void> addCalendarEvent(CalendarEvent event) async {
    final eventData = event.toRepository();
    emit(state.copyWith(status: CalendarStatus.loading));
    final newEvent =
        await _calendarRepository.addNewEvent(eventData: eventData);

    List<CalendarEvent> updatedListOfEvents = state.events;
    updatedListOfEvents.add(CalendarEvent.fromRepository(newEvent));
    emit(state.copyWith(
        status: CalendarStatus.success, events: updatedListOfEvents));
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

  List<CalendarEvent> getEvents() {
    final List<CalendarEvent> events = <CalendarEvent>[];
    //final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(2023, 11, 3, 13, 0, 0);
    final DateTime endTime = startTime.add(const Duration(days: 2));
    events.add(CalendarEvent(
        eventName: 'Ke Mary Otis',
        start: startTime,
        end: endTime,
        background: const Color(0xFF0F8644),
        isAllDay: false));
    final DateTime startTime2 = DateTime(2024, 2, 13, 13, 0, 0);
    final DateTime endTime2 = startTime2.add(const Duration(days: 10));
    events.add(CalendarEvent(
        eventName: 'Milo',
        start: startTime2,
        end: endTime2,
        background: const Color(0xFF0F8644),
        isAllDay: false));
    return events;
  }
}

part of 'calendar_cubit.dart';

enum CalendarStatus { initial, loading, transitioning, success, failure }

enum CalendarView { all, month, schedule }

extension CalendarStatusX on CalendarStatus {
  bool get isInitial => this == CalendarStatus.initial;
  bool get isLoading => this == CalendarStatus.loading;
  bool get isTransitioning => this == CalendarStatus.transitioning;
  bool get isSuccess => this == CalendarStatus.success;
  bool get isFailure => this == CalendarStatus.failure;
}

@JsonSerializable()
class CalendarState extends Equatable {
  CalendarState({
    this.status = CalendarStatus.initial,
    this.calendars = const [],
    this.calendarDetails = const {},
    this.view = CalendarView.all,
    List<CalendarEvent>? events,
    DateTime? selectedDate,
  })  : events = events ?? [],
        selectedDate = selectedDate ?? DateTime.now();

  factory CalendarState.fromJson(Map<String, dynamic> json) =>
      _$CalendarStateFromJson(json);

  final CalendarStatus status;
  final List<String> calendars;
  final Map<String, CalendarDetails> calendarDetails;
  final List<CalendarEvent> events;
  final DateTime selectedDate;
  final CalendarView view;

  CalendarState copyWith({
    CalendarStatus? status,
    List<String>? calendars,
    Map<String, CalendarDetails>? calendarDetails,
    List<CalendarEvent>? events,
    DateTime? selectedDate,
    CalendarView? view,
  }) {
    return CalendarState(
      status: status ?? this.status,
      calendars: calendars ?? this.calendars,
      calendarDetails: calendarDetails ?? this.calendarDetails,
      events: events ?? this.events,
      selectedDate: selectedDate ?? this.selectedDate,
      view: view ?? this.view,
    );
  }

  Map<String, dynamic> toJson() => _$CalendarStateToJson(this);

  @override
  List<Object> get props =>
      [status, events, calendars, calendarDetails, selectedDate, view];
}

final class CalendarInitial extends CalendarState {}

part of 'calendar_cubit.dart';

enum CalendarStatus { initial, loading, success, failure }

extension CalendarStatusX on CalendarStatus {
  bool get isInitial => this == CalendarStatus.initial;
  bool get isLoading => this == CalendarStatus.loading;
  bool get isSuccess => this == CalendarStatus.success;
  bool get isFailure => this == CalendarStatus.failure;
}

@JsonSerializable()
class CalendarState extends Equatable {
  CalendarState({
    this.status = CalendarStatus.initial,
    this.calendars = const [],
    List<CalendarEvent>? events,
    CalendarEvent? newEvent,
  }) : events = events ?? [];

  factory CalendarState.fromJson(Map<String, dynamic> json) =>
      _$CalendarStateFromJson(json);

  final CalendarStatus status;
  final List<String> calendars;
  final List<CalendarEvent> events;

  CalendarEvent? newEvent;

  CalendarState copyWith({
    CalendarStatus? status,
    List<String>? calendars,
    List<CalendarEvent>? events,
    CalendarEvent? newEvent,
  }) {
    return CalendarState(
      status: status ?? this.status,
      calendars: calendars ?? this.calendars,
      events: events ?? this.events,
      newEvent: newEvent ?? this.newEvent,
    );
  }

  Map<String, dynamic> toJson() => _$CalendarStateToJson(this);

  @override
  List<Object> get props => [status, events, calendars];
}

final class CalendarInitial extends CalendarState {}

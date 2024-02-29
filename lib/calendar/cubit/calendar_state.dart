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
  CalendarState({this.status = CalendarStatus.initial, List<Meeting>? events})
      : events = events ?? [];

  factory CalendarState.fromJson(Map<String, dynamic> json) =>
      _$CalendarStateFromJson(json);

  final CalendarStatus status;
  final List<Meeting> events;

  CalendarState copyWith({
    CalendarStatus? status,
    List<Meeting>? events,
  }) {
    return CalendarState(
      status: status ?? this.status,
      events: events ?? this.events,
    );
  }

  //Map<String, dynamic> toJson() => _$CalendarStateFromJson(this);

  @override
  List<Object> get props => [status, events];
}

final class CalendarInitial extends CalendarState {}

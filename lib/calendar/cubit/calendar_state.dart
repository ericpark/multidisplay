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
  const CalendarState({this.status = CalendarStatus.initial});

  factory CalendarState.fromJson(Map<String, dynamic> json) =>
      _$CalendarStateFromJson(json);

  final CalendarStatus status;

  CalendarState copyWith({
    CalendarStatus? status,
  }) {
    return CalendarState(
      status: status ?? this.status,
    );
  }

  //Map<String, dynamic> toJson() => _$CalendarStateFromJson(this);

  @override
  List<Object> get props => [status];
}

final class CalendarInitial extends CalendarState {}

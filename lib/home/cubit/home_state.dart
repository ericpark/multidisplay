part of 'home_cubit.dart';

enum ClockType { standard, military }

extension ClockTypeX on ClockType {
  bool get isStandard => this == ClockType.standard;
  bool get isMilitary => this == ClockType.military;
}

class HomeState extends Equatable {
  const HomeState({this.clockType = ClockType.standard});

  final ClockType clockType;

  HomeState copyWith({
    ClockType? clockType,
  }) {
    return HomeState(
      clockType: clockType ?? this.clockType,
    );
  }

  @override
  List<Object> get props => [clockType];
}

final class HomeInitial extends HomeState {}

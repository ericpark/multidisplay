part of 'home_cubit.dart';

enum ClockType { standard, military }

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

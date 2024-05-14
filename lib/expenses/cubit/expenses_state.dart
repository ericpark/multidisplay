part of 'expenses_cubit.dart';

enum ExpensesStatus { initial, loading, transitioning, success, failure }

extension ExpensesStatusX on ExpensesStatus {
  bool get isInitial => this == ExpensesStatus.initial;
  bool get isLoading => this == ExpensesStatus.loading;
  bool get isTransitioning => this == ExpensesStatus.transitioning;
  bool get isSuccess => this == ExpensesStatus.success;
  bool get isFailure => this == ExpensesStatus.failure;
}

@freezed
abstract class ExpensesState with _$ExpensesState {
  const factory ExpensesState({
    @Default(ExpensesStatus.initial) ExpensesStatus status,
  }) = _ExpensesState;

  factory ExpensesState.initial() => const ExpensesState();

  factory ExpensesState.fromJson(Map<String, dynamic> json) =>
      _$ExpensesStateFromJson(json);
}

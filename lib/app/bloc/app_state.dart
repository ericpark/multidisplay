part of 'app_bloc.dart';

enum AppStatus {
  started,
}

final class AppState extends Equatable {
  const AppState({
    required this.status,
    required this.page,
  });

  const AppState._({
    required this.status,
    required this.page,
  });

  const AppState.started() : this._(status: AppStatus.started, page: 0);

  final AppStatus status;
  final int page;

  @override
  List<Object> get props => [status, page];

  AppState copyWith({
    AppStatus? status,
    int? page,
  }) {
    return AppState(
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }
}

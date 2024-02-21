part of 'app_bloc.dart';

enum AppStatus {
  started,
}

final class AppState extends Equatable {
  const AppState._({
    required this.status,
    required this.page,
  });

  const AppState.started() : this._(status: AppStatus.started, page: "home");

  final AppStatus status;
  final String page;

  @override
  List<Object> get props => [status];
}

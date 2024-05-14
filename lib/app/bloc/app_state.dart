part of 'app_bloc.dart';

enum AppStatus {
  started,
}

final class AppState extends Equatable {
  const AppState({
    required this.status,
    required this.page,
    required this.deviceType,
  });

  const AppState._({
    required this.status,
    required this.page,
    required this.deviceType,
  });

  const AppState.started({required FormFactor deviceType})
      : this._(status: AppStatus.started, page: 0, deviceType: deviceType);

  final AppStatus status;
  final int page;
  final FormFactor deviceType; // NOTE: On web, this will not be consistent

  AppState copyWith({
    AppStatus? status,
    int? page,
    FormFactor? deviceType,
  }) {
    return AppState(
      status: status ?? this.status,
      page: page ?? this.page,
      deviceType: deviceType ?? this.deviceType,
    );
  }

  @override
  List<Object> get props => [status, page, deviceType];

  @override
  String toString({bool? detailed = false}) {
    if (detailed ?? false) {
      return super.toString();
    } else {
      return 'AppState($page)';
    }
  }
}

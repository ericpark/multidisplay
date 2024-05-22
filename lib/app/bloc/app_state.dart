part of 'app_bloc.dart';

enum AppStatus {
  started,
}

final class AppState extends Equatable {
  const AppState({
    required this.status,
    required this.page,
    required this.deviceType,
    required this.appVersion,
  });

  const AppState._({
    required this.status,
    required this.page,
    required this.deviceType,
    required this.appVersion,
  });

  const AppState.started({
    required FormFactor deviceType,
    String appVersion = '0.0.0',
  }) : this._(
          status: AppStatus.started,
          page: 0,
          deviceType: deviceType,
          appVersion: appVersion,
        );

  final AppStatus status;
  final int page;
  final FormFactor deviceType; // NOTE: On web, this will not be consistent
  final String appVersion;

  AppState copyWith({
    AppStatus? status,
    int? page,
    FormFactor? deviceType,
    String? appVersion,
  }) {
    return AppState(
      status: status ?? this.status,
      page: page ?? this.page,
      deviceType: deviceType ?? this.deviceType,
      appVersion: appVersion ?? this.appVersion,
    );
  }

  @override
  List<Object> get props => [status, page, deviceType, appVersion];

  @override
  String toString({bool? detailed = false}) {
    if (detailed ?? false) {
      return super.toString();
    } else {
      return 'AppState($page)';
    }
  }
}

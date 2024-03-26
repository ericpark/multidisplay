part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppStarted extends AppEvent {
  const AppStarted();
}

final class AppLoaded extends AppEvent {
  const AppLoaded();
}

final class AppPageChanged extends AppEvent {
  const AppPageChanged({required this.page});
  final int page;
}

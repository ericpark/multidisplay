part of 'tracking_cubit.dart';

enum TrackingStatus { initial, loading, transitioning, success, failure }

extension TrackingStatusX on TrackingStatus {
  bool get isInitial => this == TrackingStatus.initial;
  bool get isLoading => this == TrackingStatus.loading;
  bool get isTransitioning => this == TrackingStatus.transitioning;
  bool get isSuccess => this == TrackingStatus.success;
  bool get isFailure => this == TrackingStatus.failure;
}

@freezed
abstract class TrackingState with _$TrackingState {
  const factory TrackingState({
    @Default(TrackingStatus.initial) TrackingStatus status,
    @Default({}) Map<String, TrackingGroup> trackingGroups,
    @Default([]) List<String> trackingSections,
  }) = _TrackingState;

  factory TrackingState.fromJson(Map<String, dynamic> json) =>
      _$TrackingStateFromJson(json);
}

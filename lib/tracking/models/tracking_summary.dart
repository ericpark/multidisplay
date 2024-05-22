import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:tracking_repository/tracking_repository.dart'
    as tracking_repository;

part 'generated/tracking_summary.freezed.dart';
part 'generated/tracking_summary.g.dart';

@freezed
abstract class TrackingSummary with _$TrackingSummary {
  const factory TrackingSummary({
    required String name,
    required String section,
    // @JsonKey(name: 'total') @JsonKey(name: 'count') @Default(0) int count,
    //@Deprecated("") @JsonKey(name: 'tracking_subtitle') String? subtitle,
    required String id,
    required String ownerId,
    @Default('') String description,
    @Default('') String mainMetric,
    @Default('') String leftMetric,
    @Default('') String rightMetric,
    @Default({}) Map<String, Map<String, String>> metrics,
    @Default({}) Map<String, Map<String, Map<String, double>>> thresholds,
    @Default(false) bool autoUpdate,
    @Default([]) List<TrackingRecord> records,
    // 'days_ago', 'consecutive', 'last_seven', 'fixed_week', 'time'
    @Default('') String trackingType,
    @Default('') String mainThreshold,
    @DateTimeNullableConverter() DateTime? createdAt,
    @DateTimeNullableConverter() DateTime? fetchedAt,
    @Default({}) Map<String, dynamic> additionalConfigs,
  }) = _TrackingSummary;
  const TrackingSummary._();

  factory TrackingSummary.fromJson(Map<String, dynamic> json) =>
      _$TrackingSummaryFromJson(json);

  factory TrackingSummary.fromRepository(
    tracking_repository.TrackingSummary repositoryTrackingSummary,
  ) {
    final json = repositoryTrackingSummary.toJson();
    return TrackingSummary.fromJson(json);
  }

  tracking_repository.TrackingSummary toRepository() {
    final json = toJson();
    return tracking_repository.TrackingSummary.fromJson(json);
  }
}

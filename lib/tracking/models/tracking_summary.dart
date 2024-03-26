import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:tracking_repository/tracking_repository.dart'
    as tracking_repository;

part 'tracking_summary.freezed.dart';
part 'tracking_summary.g.dart';

@freezed
abstract class TrackingSummary with _$TrackingSummary {
  const TrackingSummary._();

  const factory TrackingSummary({
    required String name,
    required String section,
    @JsonKey(name: 'total') @JsonKey(name: 'count') @Default(0) int count,
    @JsonKey(name: 'tracking_subtitle') String? subtitle,
    required String id,
    required String ownerId,
    @Default('') String mainMetric,
    @Default('') String leftMetric,
    @Default('') String rightMetric,
    @Default({}) Map<String, Map<String, String>> metrics,
    @Default(false) bool autoUpdate,
    @Default([]) List<TrackingRecord> records,
    @Default('') String trackingType,
    @DateTimeNullableConverter() DateTime? createdAt,
    @DateTimeNullableConverter() DateTime? fetchedAt,
  }) = _TrackingSummary;

  factory TrackingSummary.fromJson(Map<String, dynamic> json) =>
      _$TrackingSummaryFromJson(json);

  factory TrackingSummary.fromRepository(
      tracking_repository.TrackingSummary repositoryTrackingSummary) {
    var json = repositoryTrackingSummary.toJson();
    return TrackingSummary.fromJson(json);
  }

  tracking_repository.TrackingSummary toRepository() {
    var json = toJson();
    return tracking_repository.TrackingSummary.fromJson(json);
  }
}

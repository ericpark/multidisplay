import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/tracking/tracking.dart';

part 'tracking_summary.freezed.dart';
part 'tracking_summary.g.dart';

@freezed
abstract class TrackingSummary with _$TrackingSummary {
  const factory TrackingSummary({
    required String name,
    required String section,
    @Default(0) int count,
    String? subtitle,
    @Default('') String left,
    @Default('') String right,
    @DateTimeNullableConverter() DateTime? createdAt,
  }) = _TrackingSummary;

  factory TrackingSummary.fromJson(Map<String, dynamic> json) =>
      _$TrackingSummaryFromJson(json);
}

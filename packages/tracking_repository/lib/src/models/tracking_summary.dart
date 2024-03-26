import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_converter/firestore_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:tracking_repository/tracking_repository.dart';

part 'tracking_summary.g.dart';
part 'tracking_summary.firestore_converter.dart';
part 'tracking_summary.freezed.dart';

@freezed
//@JsonSerializable(explicitToJson: true)
@FirestoreConverter(defaultPath: 'tracking')
class TrackingSummary with _$TrackingSummary {
  factory TrackingSummary({
    String? id,
    required String ownerId,
    required String name,
    required String section,
    @Default(0) int total,
    @Default('') String description,
    @Default('') String trackingType,
    @Default('') String trackingSubtitle,
    @Default('') String mainMetric,
    @Default('') String leftMetric,
    @Default('') String rightMetric,
    @Default(false) bool autoUpdate,
    @Default({}) Map<String, Map<String, String>> metrics,
    @Default(true) bool? active,
    @DateTimeNullableConverter() DateTime? createdAt,
    @Default([]) List<String>? tags,
  }) = _TrackingSummary;

  factory TrackingSummary.fromJson(Map<String, dynamic> json) =>
      _$TrackingSummaryFromJson(json);
}

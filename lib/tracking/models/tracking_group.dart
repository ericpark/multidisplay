import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/tracking/tracking.dart';

part 'tracking_group.g.dart';
part 'tracking_group.freezed.dart';

@freezed
class TrackingGroup with _$TrackingGroup {
  factory TrackingGroup({
    //@DateTimeConverter() required DateTime date,
    required String name,
    @Default('') String notes,
    @DateTimeNullableConverter() DateTime? createdAt,
    @Default([]) List<TrackingSummary> data,
  }) = _TrackingGroup;

  factory TrackingGroup.fromJson(Map<String, dynamic> json) =>
      _$TrackingGroupFromJson(json);
}

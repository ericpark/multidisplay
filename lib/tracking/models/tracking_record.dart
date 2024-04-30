import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multidisplay/tracking/tracking.dart';
import 'package:tracking_repository/tracking_repository.dart'
    as tracking_repository;

part 'generated/tracking_record.g.dart';
part 'generated/tracking_record.freezed.dart';

@freezed
class TrackingRecord with _$TrackingRecord {
  const TrackingRecord._();

  factory TrackingRecord({
    @DateTimeConverter() required DateTime date,
    @Default('') String id,
    @TimestampNullableConverter() DateTime? createdAt,
    String? description,
  }) = _TrackingRecord;

  factory TrackingRecord.fromJson(Map<String, dynamic> json) =>
      _$TrackingRecordFromJson(json);

  tracking_repository.TrackingRecord toRepository() {
    var json = toJson();
    return tracking_repository.TrackingRecord.fromJson(json);
  }
}

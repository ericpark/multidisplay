import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_converter/firestore_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:tracking_repository/tracking_repository.dart';

part 'tracking_group.g.dart';
part 'tracking_group.firestore_converter.dart';
part 'tracking_group.freezed.dart';

@freezed
//@JsonSerializable(explicitToJson: true)
@FirestoreConverter(defaultPath: 'tracking_groups')
class TrackingGroup with _$TrackingGroup {
  factory TrackingGroup({
    String? id,
    required String name,
    @Default('') String description,
    @Default(true) bool? active,
    @DateTimeNullableConverter() DateTime? createdAt,
    @Default([]) List<String>? tags,
  }) = _TrackingGroup;

  factory TrackingGroup.fromJson(Map<String, dynamic> json) =>
      _$TrackingGroupFromJson(json);
}

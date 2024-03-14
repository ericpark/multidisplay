// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tracking_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingGroupImpl _$$TrackingGroupImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TrackingGroupImpl',
      json,
      ($checkedConvert) {
        final val = _$TrackingGroupImpl(
          name: $checkedConvert('name', (v) => v as String),
          notes: $checkedConvert('notes', (v) => v as String? ?? ''),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeNullableConverter().fromJson(v)),
          data: $checkedConvert(
              'data',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          TrackingSummary.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at'},
    );

Map<String, dynamic> _$$TrackingGroupImplToJson(_$TrackingGroupImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'notes': instance.notes,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
      'data': instance.data.map((e) => e.toJson()).toList(),
    };

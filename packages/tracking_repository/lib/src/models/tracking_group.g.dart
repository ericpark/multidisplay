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
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          active: $checkedConvert('active', (v) => v as bool? ?? true),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeNullableConverter().fromJson(v)),
          tags: $checkedConvert(
              'tags',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
        );
        return val;
      },
      fieldKeyMap: const {'createdAt': 'created_at'},
    );

Map<String, dynamic> _$$TrackingGroupImplToJson(_$TrackingGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'active': instance.active,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
      'tags': instance.tags,
    };

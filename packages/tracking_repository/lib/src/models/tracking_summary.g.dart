// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'tracking_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackingSummaryImpl _$$TrackingSummaryImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TrackingSummaryImpl',
      json,
      ($checkedConvert) {
        final val = _$TrackingSummaryImpl(
          id: $checkedConvert('id', (v) => v as String?),
          ownerId: $checkedConvert('owner_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          section: $checkedConvert('section', (v) => v as String),
          total: $checkedConvert('total', (v) => v as int? ?? 0),
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
      fieldKeyMap: const {'ownerId': 'owner_id', 'createdAt': 'created_at'},
    );

Map<String, dynamic> _$$TrackingSummaryImplToJson(
        _$TrackingSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'name': instance.name,
      'section': instance.section,
      'total': instance.total,
      'description': instance.description,
      'active': instance.active,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
      'tags': instance.tags,
    };

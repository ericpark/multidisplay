// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'calendar_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalendarDetailsImpl _$$CalendarDetailsImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CalendarDetailsImpl',
      json,
      ($checkedConvert) {
        final val = _$CalendarDetailsImpl(
          id: $checkedConvert('id', (v) => v as String?),
          ownerId: $checkedConvert('owner_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          users: $checkedConvert(
              'users',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          color: $checkedConvert(
              'color',
              (v) => v == null
                  ? Colors.transparent
                  : const ColorConverter().fromJson(v as String)),
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

Map<String, dynamic> _$$CalendarDetailsImplToJson(
        _$CalendarDetailsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'users': instance.users,
      'color': const ColorConverter().toJson(instance.color),
      'active': instance.active,
      'created_at':
          const DateTimeNullableConverter().toJson(instance.createdAt),
      'tags': instance.tags,
    };

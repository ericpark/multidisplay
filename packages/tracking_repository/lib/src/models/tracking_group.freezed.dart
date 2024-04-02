// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackingGroup _$TrackingGroupFromJson(Map<String, dynamic> json) {
  return _TrackingGroup.fromJson(json);
}

/// @nodoc
mixin _$TrackingGroup {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingGroupCopyWith<TrackingGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingGroupCopyWith<$Res> {
  factory $TrackingGroupCopyWith(
          TrackingGroup value, $Res Function(TrackingGroup) then) =
      _$TrackingGroupCopyWithImpl<$Res, TrackingGroup>;
  @useResult
  $Res call(
      {String? id,
      String name,
      String description,
      bool? active,
      @DateTimeNullableConverter() DateTime? createdAt,
      List<String>? tags});
}

/// @nodoc
class _$TrackingGroupCopyWithImpl<$Res, $Val extends TrackingGroup>
    implements $TrackingGroupCopyWith<$Res> {
  _$TrackingGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? active = freezed,
    Object? createdAt = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingGroupImplCopyWith<$Res>
    implements $TrackingGroupCopyWith<$Res> {
  factory _$$TrackingGroupImplCopyWith(
          _$TrackingGroupImpl value, $Res Function(_$TrackingGroupImpl) then) =
      __$$TrackingGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
      String description,
      bool? active,
      @DateTimeNullableConverter() DateTime? createdAt,
      List<String>? tags});
}

/// @nodoc
class __$$TrackingGroupImplCopyWithImpl<$Res>
    extends _$TrackingGroupCopyWithImpl<$Res, _$TrackingGroupImpl>
    implements _$$TrackingGroupImplCopyWith<$Res> {
  __$$TrackingGroupImplCopyWithImpl(
      _$TrackingGroupImpl _value, $Res Function(_$TrackingGroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? active = freezed,
    Object? createdAt = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$TrackingGroupImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingGroupImpl implements _TrackingGroup {
  _$TrackingGroupImpl(
      {this.id,
      required this.name,
      this.description = '',
      this.active = true,
      @DateTimeNullableConverter() this.createdAt,
      final List<String>? tags = const []})
      : _tags = tags;

  factory _$TrackingGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingGroupImplFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final bool? active;
  @override
  @DateTimeNullableConverter()
  final DateTime? createdAt;
  final List<String>? _tags;
  @override
  @JsonKey()
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TrackingGroup(id: $id, name: $name, description: $description, active: $active, createdAt: $createdAt, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, active,
      createdAt, const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingGroupImplCopyWith<_$TrackingGroupImpl> get copyWith =>
      __$$TrackingGroupImplCopyWithImpl<_$TrackingGroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingGroupImplToJson(
      this,
    );
  }
}

abstract class _TrackingGroup implements TrackingGroup {
  factory _TrackingGroup(
      {final String? id,
      required final String name,
      final String description,
      final bool? active,
      @DateTimeNullableConverter() final DateTime? createdAt,
      final List<String>? tags}) = _$TrackingGroupImpl;

  factory _TrackingGroup.fromJson(Map<String, dynamic> json) =
      _$TrackingGroupImpl.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get description;
  @override
  bool? get active;
  @override
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  List<String>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$TrackingGroupImplCopyWith<_$TrackingGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

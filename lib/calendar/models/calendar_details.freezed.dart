// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalendarDetails _$CalendarDetailsFromJson(Map<String, dynamic> json) {
  return _CalendarDetails.fromJson(json);
}

/// @nodoc
mixin _$CalendarDetails {
  String? get id => throw _privateConstructorUsedError;
  String get ownerId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String>? get users => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get color => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarDetailsCopyWith<CalendarDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarDetailsCopyWith<$Res> {
  factory $CalendarDetailsCopyWith(
          CalendarDetails value, $Res Function(CalendarDetails) then) =
      _$CalendarDetailsCopyWithImpl<$Res, CalendarDetails>;
  @useResult
  $Res call(
      {String? id,
      String ownerId,
      String name,
      String description,
      List<String>? users,
      @ColorConverter() Color color,
      bool? active,
      @DateTimeNullableConverter() DateTime? createdAt,
      List<String>? tags});
}

/// @nodoc
class _$CalendarDetailsCopyWithImpl<$Res, $Val extends CalendarDetails>
    implements $CalendarDetailsCopyWith<$Res> {
  _$CalendarDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ownerId = null,
    Object? name = null,
    Object? description = null,
    Object? users = freezed,
    Object? color = null,
    Object? active = freezed,
    Object? createdAt = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
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
abstract class _$$CalendarDetailsImplCopyWith<$Res>
    implements $CalendarDetailsCopyWith<$Res> {
  factory _$$CalendarDetailsImplCopyWith(_$CalendarDetailsImpl value,
          $Res Function(_$CalendarDetailsImpl) then) =
      __$$CalendarDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String ownerId,
      String name,
      String description,
      List<String>? users,
      @ColorConverter() Color color,
      bool? active,
      @DateTimeNullableConverter() DateTime? createdAt,
      List<String>? tags});
}

/// @nodoc
class __$$CalendarDetailsImplCopyWithImpl<$Res>
    extends _$CalendarDetailsCopyWithImpl<$Res, _$CalendarDetailsImpl>
    implements _$$CalendarDetailsImplCopyWith<$Res> {
  __$$CalendarDetailsImplCopyWithImpl(
      _$CalendarDetailsImpl _value, $Res Function(_$CalendarDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? ownerId = null,
    Object? name = null,
    Object? description = null,
    Object? users = freezed,
    Object? color = null,
    Object? active = freezed,
    Object? createdAt = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$CalendarDetailsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      users: freezed == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
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
class _$CalendarDetailsImpl implements _CalendarDetails {
  _$CalendarDetailsImpl(
      {this.id,
      required this.ownerId,
      required this.name,
      this.description = '',
      final List<String>? users = const [],
      @ColorConverter() this.color = Colors.transparent,
      this.active = true,
      @DateTimeNullableConverter() this.createdAt,
      final List<String>? tags = const []})
      : _users = users,
        _tags = tags;

  factory _$CalendarDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarDetailsImplFromJson(json);

  @override
  final String? id;
  @override
  final String ownerId;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  final List<String>? _users;
  @override
  @JsonKey()
  List<String>? get users {
    final value = _users;
    if (value == null) return null;
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  @ColorConverter()
  final Color color;
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
    return 'CalendarDetails(id: $id, ownerId: $ownerId, name: $name, description: $description, users: $users, color: $color, active: $active, createdAt: $createdAt, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarDetailsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      ownerId,
      name,
      description,
      const DeepCollectionEquality().hash(_users),
      color,
      active,
      createdAt,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarDetailsImplCopyWith<_$CalendarDetailsImpl> get copyWith =>
      __$$CalendarDetailsImplCopyWithImpl<_$CalendarDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarDetailsImplToJson(
      this,
    );
  }
}

abstract class _CalendarDetails implements CalendarDetails {
  factory _CalendarDetails(
      {final String? id,
      required final String ownerId,
      required final String name,
      final String description,
      final List<String>? users,
      @ColorConverter() final Color color,
      final bool? active,
      @DateTimeNullableConverter() final DateTime? createdAt,
      final List<String>? tags}) = _$CalendarDetailsImpl;

  factory _CalendarDetails.fromJson(Map<String, dynamic> json) =
      _$CalendarDetailsImpl.fromJson;

  @override
  String? get id;
  @override
  String get ownerId;
  @override
  String get name;
  @override
  String get description;
  @override
  List<String>? get users;
  @override
  @ColorConverter()
  Color get color;
  @override
  bool? get active;
  @override
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  List<String>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$CalendarDetailsImplCopyWith<_$CalendarDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

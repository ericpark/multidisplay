// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackingEvent _$TrackingEventFromJson(Map<String, dynamic> json) {
  return _TrackingEvent.fromJson(json);
}

/// @nodoc
mixin _$TrackingEvent {
  @DateTimeConverter()
  DateTime get date => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get trackingId => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  bool? get active => throw _privateConstructorUsedError;
  @DateTimeNullableConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingEventCopyWith<TrackingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingEventCopyWith<$Res> {
  factory $TrackingEventCopyWith(
          TrackingEvent value, $Res Function(TrackingEvent) then) =
      _$TrackingEventCopyWithImpl<$Res, TrackingEvent>;
  @useResult
  $Res call(
      {@DateTimeConverter() DateTime date,
      String name,
      String trackingId,
      String location,
      String description,
      int count,
      bool? active,
      @DateTimeNullableConverter() DateTime? createdAt,
      String? id,
      List<String>? tags});
}

/// @nodoc
class _$TrackingEventCopyWithImpl<$Res, $Val extends TrackingEvent>
    implements $TrackingEventCopyWith<$Res> {
  _$TrackingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? name = null,
    Object? trackingId = null,
    Object? location = null,
    Object? description = null,
    Object? count = null,
    Object? active = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      trackingId: null == trackingId
          ? _value.trackingId
          : trackingId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingEventImplCopyWith<$Res>
    implements $TrackingEventCopyWith<$Res> {
  factory _$$TrackingEventImplCopyWith(
          _$TrackingEventImpl value, $Res Function(_$TrackingEventImpl) then) =
      __$$TrackingEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DateTimeConverter() DateTime date,
      String name,
      String trackingId,
      String location,
      String description,
      int count,
      bool? active,
      @DateTimeNullableConverter() DateTime? createdAt,
      String? id,
      List<String>? tags});
}

/// @nodoc
class __$$TrackingEventImplCopyWithImpl<$Res>
    extends _$TrackingEventCopyWithImpl<$Res, _$TrackingEventImpl>
    implements _$$TrackingEventImplCopyWith<$Res> {
  __$$TrackingEventImplCopyWithImpl(
      _$TrackingEventImpl _value, $Res Function(_$TrackingEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? name = null,
    Object? trackingId = null,
    Object? location = null,
    Object? description = null,
    Object? count = null,
    Object? active = freezed,
    Object? createdAt = freezed,
    Object? id = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$TrackingEventImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      trackingId: null == trackingId
          ? _value.trackingId
          : trackingId // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      active: freezed == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingEventImpl implements _TrackingEvent {
  _$TrackingEventImpl(
      {@DateTimeConverter() required this.date,
      required this.name,
      required this.trackingId,
      this.location = '',
      this.description = '',
      this.count = 0,
      this.active = true,
      @DateTimeNullableConverter() this.createdAt,
      this.id,
      final List<String>? tags = const []})
      : _tags = tags;

  factory _$TrackingEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingEventImplFromJson(json);

  @override
  @DateTimeConverter()
  final DateTime date;
  @override
  final String name;
  @override
  final String trackingId;
  @override
  @JsonKey()
  final String location;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int count;
  @override
  @JsonKey()
  final bool? active;
  @override
  @DateTimeNullableConverter()
  final DateTime? createdAt;
  @override
  final String? id;
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
    return 'TrackingEvent(date: $date, name: $name, trackingId: $trackingId, location: $location, description: $description, count: $count, active: $active, createdAt: $createdAt, id: $id, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingEventImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.trackingId, trackingId) ||
                other.trackingId == trackingId) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      name,
      trackingId,
      location,
      description,
      count,
      active,
      createdAt,
      id,
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingEventImplCopyWith<_$TrackingEventImpl> get copyWith =>
      __$$TrackingEventImplCopyWithImpl<_$TrackingEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingEventImplToJson(
      this,
    );
  }
}

abstract class _TrackingEvent implements TrackingEvent {
  factory _TrackingEvent(
      {@DateTimeConverter() required final DateTime date,
      required final String name,
      required final String trackingId,
      final String location,
      final String description,
      final int count,
      final bool? active,
      @DateTimeNullableConverter() final DateTime? createdAt,
      final String? id,
      final List<String>? tags}) = _$TrackingEventImpl;

  factory _TrackingEvent.fromJson(Map<String, dynamic> json) =
      _$TrackingEventImpl.fromJson;

  @override
  @DateTimeConverter()
  DateTime get date;
  @override
  String get name;
  @override
  String get trackingId;
  @override
  String get location;
  @override
  String get description;
  @override
  int get count;
  @override
  bool? get active;
  @override
  @DateTimeNullableConverter()
  DateTime? get createdAt;
  @override
  String? get id;
  @override
  List<String>? get tags;
  @override
  @JsonKey(ignore: true)
  _$$TrackingEventImplCopyWith<_$TrackingEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrackingState _$TrackingStateFromJson(Map<String, dynamic> json) {
  return _TrackingState.fromJson(json);
}

/// @nodoc
mixin _$TrackingState {
  TrackingStatus get status => throw _privateConstructorUsedError;
  Map<String, TrackingGroup> get trackingGroups =>
      throw _privateConstructorUsedError;
  List<String> get trackingSections => throw _privateConstructorUsedError;
  bool get reorderable => throw _privateConstructorUsedError;
  bool get showOnlyPublic => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackingStateCopyWith<TrackingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackingStateCopyWith<$Res> {
  factory $TrackingStateCopyWith(
          TrackingState value, $Res Function(TrackingState) then) =
      _$TrackingStateCopyWithImpl<$Res, TrackingState>;
  @useResult
  $Res call(
      {TrackingStatus status,
      Map<String, TrackingGroup> trackingGroups,
      List<String> trackingSections,
      bool reorderable,
      bool showOnlyPublic});
}

/// @nodoc
class _$TrackingStateCopyWithImpl<$Res, $Val extends TrackingState>
    implements $TrackingStateCopyWith<$Res> {
  _$TrackingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? trackingGroups = null,
    Object? trackingSections = null,
    Object? reorderable = null,
    Object? showOnlyPublic = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TrackingStatus,
      trackingGroups: null == trackingGroups
          ? _value.trackingGroups
          : trackingGroups // ignore: cast_nullable_to_non_nullable
              as Map<String, TrackingGroup>,
      trackingSections: null == trackingSections
          ? _value.trackingSections
          : trackingSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reorderable: null == reorderable
          ? _value.reorderable
          : reorderable // ignore: cast_nullable_to_non_nullable
              as bool,
      showOnlyPublic: null == showOnlyPublic
          ? _value.showOnlyPublic
          : showOnlyPublic // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrackingStateImplCopyWith<$Res>
    implements $TrackingStateCopyWith<$Res> {
  factory _$$TrackingStateImplCopyWith(
          _$TrackingStateImpl value, $Res Function(_$TrackingStateImpl) then) =
      __$$TrackingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TrackingStatus status,
      Map<String, TrackingGroup> trackingGroups,
      List<String> trackingSections,
      bool reorderable,
      bool showOnlyPublic});
}

/// @nodoc
class __$$TrackingStateImplCopyWithImpl<$Res>
    extends _$TrackingStateCopyWithImpl<$Res, _$TrackingStateImpl>
    implements _$$TrackingStateImplCopyWith<$Res> {
  __$$TrackingStateImplCopyWithImpl(
      _$TrackingStateImpl _value, $Res Function(_$TrackingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? trackingGroups = null,
    Object? trackingSections = null,
    Object? reorderable = null,
    Object? showOnlyPublic = null,
  }) {
    return _then(_$TrackingStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TrackingStatus,
      trackingGroups: null == trackingGroups
          ? _value._trackingGroups
          : trackingGroups // ignore: cast_nullable_to_non_nullable
              as Map<String, TrackingGroup>,
      trackingSections: null == trackingSections
          ? _value._trackingSections
          : trackingSections // ignore: cast_nullable_to_non_nullable
              as List<String>,
      reorderable: null == reorderable
          ? _value.reorderable
          : reorderable // ignore: cast_nullable_to_non_nullable
              as bool,
      showOnlyPublic: null == showOnlyPublic
          ? _value.showOnlyPublic
          : showOnlyPublic // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrackingStateImpl implements _TrackingState {
  const _$TrackingStateImpl(
      {this.status = TrackingStatus.initial,
      final Map<String, TrackingGroup> trackingGroups = const {},
      final List<String> trackingSections = const [],
      this.reorderable = false,
      this.showOnlyPublic = true})
      : _trackingGroups = trackingGroups,
        _trackingSections = trackingSections;

  factory _$TrackingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrackingStateImplFromJson(json);

  @override
  @JsonKey()
  final TrackingStatus status;
  final Map<String, TrackingGroup> _trackingGroups;
  @override
  @JsonKey()
  Map<String, TrackingGroup> get trackingGroups {
    if (_trackingGroups is EqualUnmodifiableMapView) return _trackingGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_trackingGroups);
  }

  final List<String> _trackingSections;
  @override
  @JsonKey()
  List<String> get trackingSections {
    if (_trackingSections is EqualUnmodifiableListView)
      return _trackingSections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackingSections);
  }

  @override
  @JsonKey()
  final bool reorderable;
  @override
  @JsonKey()
  final bool showOnlyPublic;

  @override
  String toString() {
    return 'TrackingState(status: $status, trackingGroups: $trackingGroups, trackingSections: $trackingSections, reorderable: $reorderable, showOnlyPublic: $showOnlyPublic)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackingStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._trackingGroups, _trackingGroups) &&
            const DeepCollectionEquality()
                .equals(other._trackingSections, _trackingSections) &&
            (identical(other.reorderable, reorderable) ||
                other.reorderable == reorderable) &&
            (identical(other.showOnlyPublic, showOnlyPublic) ||
                other.showOnlyPublic == showOnlyPublic));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_trackingGroups),
      const DeepCollectionEquality().hash(_trackingSections),
      reorderable,
      showOnlyPublic);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackingStateImplCopyWith<_$TrackingStateImpl> get copyWith =>
      __$$TrackingStateImplCopyWithImpl<_$TrackingStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrackingStateImplToJson(
      this,
    );
  }
}

abstract class _TrackingState implements TrackingState {
  const factory _TrackingState(
      {final TrackingStatus status,
      final Map<String, TrackingGroup> trackingGroups,
      final List<String> trackingSections,
      final bool reorderable,
      final bool showOnlyPublic}) = _$TrackingStateImpl;

  factory _TrackingState.fromJson(Map<String, dynamic> json) =
      _$TrackingStateImpl.fromJson;

  @override
  TrackingStatus get status;
  @override
  Map<String, TrackingGroup> get trackingGroups;
  @override
  List<String> get trackingSections;
  @override
  bool get reorderable;
  @override
  bool get showOnlyPublic;
  @override
  @JsonKey(ignore: true)
  _$$TrackingStateImplCopyWith<_$TrackingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

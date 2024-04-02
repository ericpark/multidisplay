// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expenses_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExpensesState _$ExpensesStateFromJson(Map<String, dynamic> json) {
  return _ExpensesState.fromJson(json);
}

/// @nodoc
mixin _$ExpensesState {
  ExpensesStatus get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpensesStateCopyWith<ExpensesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpensesStateCopyWith<$Res> {
  factory $ExpensesStateCopyWith(
          ExpensesState value, $Res Function(ExpensesState) then) =
      _$ExpensesStateCopyWithImpl<$Res, ExpensesState>;
  @useResult
  $Res call({ExpensesStatus status});
}

/// @nodoc
class _$ExpensesStateCopyWithImpl<$Res, $Val extends ExpensesState>
    implements $ExpensesStateCopyWith<$Res> {
  _$ExpensesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExpensesStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpensesStateImplCopyWith<$Res>
    implements $ExpensesStateCopyWith<$Res> {
  factory _$$ExpensesStateImplCopyWith(
          _$ExpensesStateImpl value, $Res Function(_$ExpensesStateImpl) then) =
      __$$ExpensesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ExpensesStatus status});
}

/// @nodoc
class __$$ExpensesStateImplCopyWithImpl<$Res>
    extends _$ExpensesStateCopyWithImpl<$Res, _$ExpensesStateImpl>
    implements _$$ExpensesStateImplCopyWith<$Res> {
  __$$ExpensesStateImplCopyWithImpl(
      _$ExpensesStateImpl _value, $Res Function(_$ExpensesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$ExpensesStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ExpensesStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExpensesStateImpl implements _ExpensesState {
  const _$ExpensesStateImpl({this.status = ExpensesStatus.initial});

  factory _$ExpensesStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpensesStateImplFromJson(json);

  @override
  @JsonKey()
  final ExpensesStatus status;

  @override
  String toString() {
    return 'ExpensesState(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpensesStateImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpensesStateImplCopyWith<_$ExpensesStateImpl> get copyWith =>
      __$$ExpensesStateImplCopyWithImpl<_$ExpensesStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpensesStateImplToJson(
      this,
    );
  }
}

abstract class _ExpensesState implements ExpensesState {
  const factory _ExpensesState({final ExpensesStatus status}) =
      _$ExpensesStateImpl;

  factory _ExpensesState.fromJson(Map<String, dynamic> json) =
      _$ExpensesStateImpl.fromJson;

  @override
  ExpensesStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$ExpensesStateImplCopyWith<_$ExpensesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

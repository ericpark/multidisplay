// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'auth_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$AuthStateImpl',
      json,
      ($checkedConvert) {
        final val = _$AuthStateImpl(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$AuthStatusEnumMap, v) ??
                  AuthStatus.initial),
          user: $checkedConvert(
              'user',
              (v) =>
                  v == null ? null : User.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'status': _$AuthStatusEnumMap[instance.status]!,
      'user': instance.user?.toJson(),
    };

const _$AuthStatusEnumMap = {
  AuthStatus.initial: 'initial',
  AuthStatus.unauthenticated: 'unauthenticated',
  AuthStatus.authenticated: 'authenticated',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'expenses_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpensesStateImpl _$$ExpensesStateImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ExpensesStateImpl',
      json,
      ($checkedConvert) {
        final val = _$ExpensesStateImpl(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$ExpensesStatusEnumMap, v) ??
                  ExpensesStatus.initial),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ExpensesStateImplToJson(_$ExpensesStateImpl instance) =>
    <String, dynamic>{
      'status': _$ExpensesStatusEnumMap[instance.status]!,
    };

const _$ExpensesStatusEnumMap = {
  ExpensesStatus.initial: 'initial',
  ExpensesStatus.loading: 'loading',
  ExpensesStatus.transitioning: 'transitioning',
  ExpensesStatus.success: 'success',
  ExpensesStatus.failure: 'failure',
};

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class CalendarFormBloc extends FormBloc<String, String> {
  final name = TextFieldBloc(
    name: 'name',
  );

  final gender = SelectFieldBloc(
    name: 'gender',
    items: ['male', 'female'],
  );

  final birthDate = InputFieldBloc<DateTime?, Object>(
    name: 'birthDate',
    initialValue: null,
    toJson: (value) => value!.toUtc().toIso8601String(),
  );

  CalendarFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        name,
        gender,
        birthDate,
      ],
    );
  }

  @override
  Future<void> onSubmitting() async {
    emitSuccess(
      canSubmitAgain: true,
      successResponse: const JsonEncoder.withIndent('    ').convert(
        state.toJson(),
      ),
    );
  }
}

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarFormBloc extends FormBloc<String, String> {
  CalendarFormBloc({List<String>? calendarList})
      : calendarList = calendarList ?? [] {
    addFieldBlocs(
      fieldBlocs: [
        eventName,
        calendar,
        startDate,
        endDate,
        description,
        isAllDay,
        tags,
      ],
    );
    endDate.addValidators([_endDateMustBeAfterStartDate(startDate)]);
  }

  final List<String> calendarList;

  final eventName = TextFieldBloc<dynamic>(
    name: 'event_name',
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final startDate = InputFieldBloc<DateTime?, Object>(
    name: 'start',
    initialValue: null,
    toJson: (value) => (value ?? DateTime.now()).toUtc().toIso8601String(),
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final endDate = InputFieldBloc<DateTime?, Object>(
    name: 'end',
    initialValue: null,
    toJson: (value) => (value ?? DateTime.now()).toUtc().toIso8601String(),
  );

  late final calendar = SelectFieldBloc<String, dynamic>(
    name: 'calendar_id',
    items: calendarList,
    initialValue: calendarList.isNotEmpty ? calendarList[0] : null,
  );

  final description = TextFieldBloc<dynamic>(
    name: 'description',
  );

  final background = TextFieldBloc<dynamic>(
    name: 'background',
  );

  final isAllDay = BooleanFieldBloc<dynamic>(
    name: 'is_all_day',
    initialValue: true,
  );

  final tags = MultiSelectFieldBloc<String, dynamic>(
    name: 'tags',
    items: ['tag 1', 'tag 2', 'tag 3'],
  );

  CalendarEvent toCalendarEvent() {
    final json = state.toJson();
    if (json['end'] == null) {
      json['end'] = json['start'];
    }
    json['background'] = '000000';
    return CalendarEvent.fromJson(json);
  }

  @override
  Future<void> onSubmitting() async {
    if (!await eventName.validate()) {
      emitFailure(failureResponse: 'Invalid Event Name');
      return;
    }
    if (!await startDate.validate()) {
      emitFailure(failureResponse: 'Invalid Start Date');
      return;
    }

    emitSuccess(
      canSubmitAgain: true,
      /*(successResponse: const JsonEncoder.withIndent('    ').convert(
        state.toJson(),
      ),*/
    );
  }

  Validator<DateTime?> _endDateMustBeAfterStartDate(
    InputFieldBloc<DateTime?, Object> startDateFieldBloc,
  ) {
    return (DateTime? endDate) {
      if (startDateFieldBloc.value == null) return 'Invalid Start Date';
      if (endDate == null) {
        // End Date can be empty
        return null;
      }
      if (!endDate.isBefore(startDateFieldBloc.value!)) {
        return null;
      }
      return 'End Date must be after Start Date';
    };
  }
}

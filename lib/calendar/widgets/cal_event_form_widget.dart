import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:multidisplay/calendar/calendar.dart';

class CalendarEventForm extends StatelessWidget {
  const CalendarEventForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final formBloc = context.read<CalendarFormBloc>();

        return Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            /*appBar: AppBar(title: const Text('Serialized Form')),
              floatingActionButton: FloatingActionButton(
                onPressed: formBloc.submit,
                child: const Icon(Icons.send),
              ),*/
            body: FormBlocListener<CalendarFormBloc, String, String>(
              onSuccess: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.successResponse!),
                  duration: const Duration(seconds: 2),
                ));
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFieldBlocBuilder(
                        textFieldBloc: formBloc.name,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.people),
                        ),
                      ),
                      RadioButtonGroupFieldBlocBuilder<String>(
                        selectFieldBloc: formBloc.gender,
                        itemBuilder: (context, value) => FieldItem(
                            child: Text(
                                value[0].toUpperCase() + value.substring(1))),
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          prefixIcon: SizedBox(),
                        ),
                      ),
                      DateTimeFieldBlocBuilder(
                        dateTimeFieldBloc: formBloc.birthDate,
                        format: DateFormat('dd-MM-yyyy'),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

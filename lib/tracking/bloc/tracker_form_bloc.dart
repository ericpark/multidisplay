import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class TrackerFormBloc extends FormBloc<String, String> {
  TrackerFormBloc({List<String>? sectionList})
      : sectionList = sectionList ?? [] {
    addFieldBlocs(
      fieldBlocs: [
        name,
        section,
        //description,
        //tags,
      ],
    );
  }

  final List<String> sectionList;

  final metrics = ListFieldBloc<MetricsFieldBloc, dynamic>(name: 'members');

  final name = TextFieldBloc(
    name: 'name',
    validators: [
      FieldBlocValidators.required,
    ],
  );

  late final section = SelectFieldBloc(
      name: 'section',
      items: sectionList,
      initialValue: sectionList.isNotEmpty ? sectionList[0] : null);

  /*final description = TextFieldBloc(
    name: 'description',
  );

  final tags = MultiSelectFieldBloc(
    name: 'tags',
    items: ['tag 1', 'tag 2', 'tag 3'],
  );*/

  @override
  Future<void> onSubmitting() async {
    emitSuccess(
      canSubmitAgain: true,
      /*(successResponse: const JsonEncoder.withIndent('    ').convert(
        state.toJson(),
      ),*/
    );
  }
}

class MetricsFieldBloc extends GroupFieldBloc {
  final SelectFieldBloc firstName;
  final SelectFieldBloc lastName;
  final ListFieldBloc<TextFieldBloc, dynamic> hobbies;

  MetricsFieldBloc({
    required this.firstName,
    required this.lastName,
    required this.hobbies,
    super.name,
  }) : super(fieldBlocs: [firstName, lastName, hobbies]);
}

class Club {
  String? clubName;
  List<Member>? members;

  Club({this.clubName, this.members});

  Club.fromJson(Map<String, dynamic> json) {
    clubName = json['clubName'];
    if (json['members'] != null) {
      members = <Member>[];
      json['members'].forEach((v) {
        members!.add(Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clubName'] = clubName;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => '''Club {
  clubName: $clubName,
  members: $members
}''';
}

class Member {
  String? firstName;
  String? lastName;
  List<String?>? hobbies;

  Member({this.firstName, this.lastName, this.hobbies});

  Member.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    hobbies = json['hobbies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['hobbies'] = hobbies;
    return data;
  }

  @override
  String toString() => '''Member {
  firstName: $firstName,
  lastName: $lastName,
  hobbies: $hobbies
}''';
}

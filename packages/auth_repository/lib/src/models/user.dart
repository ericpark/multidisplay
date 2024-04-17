import 'package:firestore_converter/firestore_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FBAuth;

//import 'package:auth_repository/auth_repository.dart';

part 'user.firestore_converter.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
@FirestoreConverter(defaultPath: 'users')
class User with _$User {
  factory User({
    required String id,
    String? firstName,
    String? lastName,
    String? email,
    @Default([]) List<String> calendars,
    @Default(true) bool? active,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromFirebaseUser(FBAuth.User? user) {
    if (user == null) {
      return User(id: "default");
    }
    return User(id: user.uid, email: user.email ?? "");
  }
}

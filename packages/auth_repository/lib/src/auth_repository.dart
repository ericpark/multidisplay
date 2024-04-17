import 'dart:async';

import 'package:auth_repository/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FBAuth;
import 'package:flutter/foundation.dart';

class AuthRepository {
  AuthRepository({required FirebaseFirestore? firebaseDB})
      : _firebaseDB = firebaseDB ?? FirebaseFirestore.instance;

  // ignore: unused_field
  final FirebaseFirestore _firebaseDB;

  User get currentUser =>
      User.fromFirebaseUser(FBAuth.FirebaseAuth.instance.currentUser);

  bool get isLoggedIn => FBAuth.FirebaseAuth.instance.currentUser != null;

  //
  Future<User?> loginWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FBAuth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user != null) {
        final user = getUserById(
          id: credential.user!.uid,
          email: credential.user!.email ?? "",
        );

        return user;
      }
    } on FBAuth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<User?> getUserById({required String id, String? email}) async {
    final query = userCollection()
        .where("active", isEqualTo: true)
        .where("id", isEqualTo: id);
    final user = await query.get().then((querySnapshot) {
      List<User> users = [];

      for (var docSnapshot in querySnapshot.docs) {
        User data = docSnapshot.data();

        users.add(data);
      }
      return users;
    });
    if (user.length > 1) {
      debugPrint("Duplicate User Record. Should not be possible.");
    }
    final userDoesNotExist = user.isEmpty;

    if (userDoesNotExist) {
      final newUser = User(id: id, email: email);
      await userCollection().doc(id).set(newUser);
      return newUser;
    }
    return user[0];
  }

  Future<void> logout() async {
    if (isLoggedIn) {
      await FBAuth.FirebaseAuth.instance.signOut();
    }
  }
}

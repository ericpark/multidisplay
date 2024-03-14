import 'dart:async';

import 'package:tracking_repository/tracking_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrackingRepository {
  TrackingRepository({required FirebaseFirestore? firebaseDB})
      : _firebaseDB = firebaseDB ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseDB;
}

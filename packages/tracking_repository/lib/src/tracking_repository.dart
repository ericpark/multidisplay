import 'dart:async';

import 'package:tracking_repository/tracking_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'records_api.dart';
part 'summaries_api.dart';
part 'groups_api.dart';

class TrackingRepository with RecordsAPI, SummariesAPI, GroupsAPI {
  TrackingRepository({required FirebaseFirestore? firebaseDB})
      : _firebaseDB = firebaseDB ?? FirebaseFirestore.instance;

  // ignore: unused_field
  final FirebaseFirestore _firebaseDB;
}

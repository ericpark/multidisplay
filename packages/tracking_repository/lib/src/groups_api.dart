part of 'tracking_repository.dart';

mixin GroupsAPI {
  /**
  * Tracking Groups CRUD
  */

  /** CREATE */

  ///
  Future<TrackingGroup?> addTrackingGroup({
    required TrackingGroup trackingGroup,
  }) async {
    final trackingGroupRef = trackingGroupCollection();

    final trackingGroupId = await trackingGroupRef
        .add(trackingGroup)
        .then((documentSnapshot) => documentSnapshot.id);

    updateTrackingGroup(
        trackingGroupId: trackingGroupId, data: {"id": trackingGroupId});

    return trackingGroup.copyWith(id: trackingGroupId);
  }

  /** READ */

  ///
  Future<List<TrackingGroup>> getAllTrackingGroups() async {
    final trackingGroupRef = trackingGroupCollection();
    List<TrackingGroup> allTrackingGroups = [];

    try {
      allTrackingGroups = await trackingGroupRef.get().then(
        (querySnapshot) {
          List<TrackingGroup> trackingGroups = [];
          for (var docSnapshot in querySnapshot.docs) {
            TrackingGroup data = docSnapshot.data();
            if (data.id == null || data.id == "") {
              print("${data.id} => ${docSnapshot.id} ");
              data = data.copyWith(id: docSnapshot.id);
            }

            trackingGroups.add(data);
          }
          return trackingGroups;
        },
        onError: (e) => print("Error completing Tracking Groups Retrieval: $e"),
      );
      return allTrackingGroups;
    } catch (err) {
      print("Error while retrieving Tracking Groups: $err");
      return [];
    }
  }

  /**  UPDATE */

  ///
  Future<TrackingGroup?> updateTrackingGroup({
    required String trackingGroupId,
    required data,
  }) async {
    if (trackingGroupId == "") {
      return null;
    } else {
      final query = trackingGroupDoc(docId: trackingGroupId);
      try {
        return await query.update(data).then(
          (_) async {
            final trackingGroup = await query.get().then((doc) {
              return doc.data();
            });
            return trackingGroup;
          },
          onError: (e) => print("Error completing Tracking Group Update: $e"),
        );
      } catch (err) {
        print("Error while retrieving Tracking Group: $err");
        return null;
      }
    }
  }
}

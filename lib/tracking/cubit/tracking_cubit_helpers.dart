part of 'tracking_cubit.dart';

/// HELPERS --------------------------------------------------------------------

/// Get the new order of sections after a section has been moved.
List<String> getNewSectionOrder({
  required List<String> previousOrder,
  required int oldIndex,
  required int newIndex,
}) {
  var newOrder = <String>[];

  // Moved item down the list
  if (oldIndex < newIndex) {
    for (var before = 0; before < oldIndex; before++) {
      newOrder.add(previousOrder[before]);
    }
    if (newIndex == previousOrder.length) {
      newOrder = [
        ...newOrder,
        ...previousOrder.sublist(oldIndex + 1),
        previousOrder[oldIndex],
      ];
    } else {
      for (var after = oldIndex + 1; after < newIndex; after++) {
        newOrder.add(previousOrder[after]);
      }
      newOrder.add(previousOrder[oldIndex]);
      for (var after = newIndex; after < previousOrder.length; after++) {
        newOrder.add(previousOrder[after]);
      }
    }
  }
  // Moved item up the list
  else if (oldIndex > newIndex) {
    if (newIndex == 0) {
      newOrder = [
        previousOrder[oldIndex],
        ...previousOrder.sublist(0, oldIndex),
        ...previousOrder.sublist(oldIndex + 1),
      ];
    } else {
      for (var before = 0; before < newIndex; before++) {
        newOrder.add(previousOrder[before]);
      }
      newOrder.add(previousOrder[oldIndex]);
      for (var after = newIndex; after < oldIndex; after++) {
        newOrder.add(previousOrder[after]);
      }
      for (var after = oldIndex + 1; after < previousOrder.length; after++) {
        newOrder.add(previousOrder[after]);
      }
    }
  }
  return newOrder;
}

/// Get the tracking summary from the tracking groups based on section and index
TrackingSummary indexToTrackingSummary({
  required String section,
  required int index,
  required Map<String, TrackingGroup> trackingGroups,
}) {
  final trackingGroup = trackingGroups[section]!;
  return trackingGroup.data[index];
}

import 'package:flutter/material.dart';

// Packages
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:multidisplay/tracking/views/tracking_new_tracker_page.dart';

class AddTrackingFAB extends StatefulWidget {
  const AddTrackingFAB({super.key});

  @override
  State<AddTrackingFAB> createState() => _AddTrackingFABState();
}

class _AddTrackingFABState extends State<AddTrackingFAB> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      // duration: const Duration(milliseconds: 500),
      distance: 70,
      type: ExpandableFabType.up,
      // pos: ExpandableFabPos.left,
      // childrenOffset: const Offset(0, 20),
      // fanAngle: 40,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        foregroundColor: Colors.red[300],
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      overlayStyle: ExpandableFabOverlayStyle(
        // color: Colors.black.withOpacity(0.5),
        blur: 5,
      ),
      onOpen: () {
        //debugPrint('onOpen');
      },
      afterOpen: () {
        //debugPrint('afterOpen');
      },
      onClose: () {
        //debugPrint('onClose');
      },
      afterClose: () {
        //debugPrint('afterClose');
      },
      children: [
        FloatingActionButton.extended(
          //shape: const CircleBorder(),
          heroTag: null,
          icon: const Icon(Icons.add_to_photos),
          label: const Text('Add Section'),
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          onPressed: () {
            /* Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const NextPage())));*/
            final state = _key.currentState;
            if (state != null) {
              debugPrint('isOpen:${state.isOpen}');
              state.toggle();
            }
          },
        ),
        FloatingActionButton.extended(
          //shape: const CircleBorder(),
          heroTag: null,
          icon: const Icon(Icons.add_box_outlined),
          label: const Text('Add Tracking'),
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const NewTrackerPage(),
              ),
            );
            final state = _key.currentState;
            if (state != null) {
              debugPrint('isOpen:${state.isOpen}');
              state.toggle();
            }
          },
        ),
      ],
    );
  }
}

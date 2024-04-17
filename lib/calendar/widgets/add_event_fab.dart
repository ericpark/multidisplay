import 'package:flutter/material.dart';

// Packages
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:multidisplay/calendar/calendar.dart';

class AddEventFAB extends StatefulWidget {
  const AddEventFAB({super.key});

  @override
  State<AddEventFAB> createState() => _AddEventFABState();
}

class _AddEventFABState extends State<AddEventFAB> {
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      // duration: const Duration(milliseconds: 500),
      distance: 70.0,
      type: ExpandableFabType.up,
      // pos: ExpandableFabPos.left,
      // childrenOffset: const Offset(0, 20),
      // fanAngle: 40,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: Colors.red[300],
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      overlayStyle: ExpandableFabOverlayStyle(
        // color: Colors.black.withOpacity(0.5),
        blur: 5,
      ),
      onOpen: () {
        debugPrint('onOpen');
      },
      afterOpen: () {
        debugPrint('afterOpen');
      },
      onClose: () {
        debugPrint('onClose');
      },
      afterClose: () {
        debugPrint('afterClose');
      },
      children: [
        FloatingActionButton.extended(
          //shape: const CircleBorder(),
          heroTag: null,
          icon: const Icon(Icons.calendar_month),
          label: const Text('Add Group'),
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
          icon: const Icon(Icons.event),
          label: const Text('Add Event'),
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          onPressed: () async {
            await showDismissableModal(context, const CalendarNewEventView());
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

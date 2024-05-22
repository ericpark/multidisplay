import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multidisplay/local_constants.dart';
import 'package:pinput/pinput.dart';

class TrackingPinPage extends StatefulWidget {
  const TrackingPinPage({super.key});

  @override
  State<TrackingPinPage> createState() => _TrackingPinPageState();
}

class _TrackingPinPageState extends State<TrackingPinPage> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(30, 60, 87, 1);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: const BoxDecoration(),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Pin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, semanticLabel: 'Submit Password'),
            onPressed: controller.text == LocalConstants.defaultPassword
                ? () async {
                    if (controller.text.length == 4) {
                      Navigator.pop(context, true);
                    }
                  }
                : null,
          ),
        ],
      ),
      body: FractionallySizedBox(
        widthFactor: 1,
        child: Pinput(
          pinAnimationType: PinAnimationType.slide,
          controller: controller,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          cursor: cursor,
          preFilledWidget: preFilledWidget,
          onCompleted: (value) => {
            setState(() {}),
          },
          keyboardType: TextInputType.phone,
          hapticFeedbackType: HapticFeedbackType.vibrate,
        ),
      ),
    );
  }
}

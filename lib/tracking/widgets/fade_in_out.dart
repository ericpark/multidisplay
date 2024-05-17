import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:multidisplay/tracking/tracking.dart';

typedef MyBuilder = void Function(
  BuildContext context,
  void Function(String?) run,
);

class FadeInOutMessage extends StatefulWidget with Confetti {
  FadeInOutMessage({
    required this.show,
    required this.builder,
    super.key,
  });

  final bool show;
  final MyBuilder builder;

  @override
  State<StatefulWidget> createState() => _FadeInOutMessageState();
}

class _FadeInOutMessageState extends State<FadeInOutMessage>
    with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  late ConfettiController controllerCenter;
  late AudioPlayer player;
  late AudioPlayer secondaryPlayer;

  bool notCompleted = true;
  String message = 'Congrats!';

  @override
  void initState() {
    super.initState();
    // Initialize the audio players
    player = AudioPlayer();
    player.setAsset('assets/tracking/congrats_audio.mp3');
    secondaryPlayer = AudioPlayer();
    secondaryPlayer
      ..setAsset('assets/tracking/bbl.mp3')
      ..seek(const Duration(seconds: 29))
      ..setVolume(0.75);

    if (widget.show) {
      animation = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 15),
      );
      _fadeInFadeOut = Tween<double>(begin: 0, end: 1).animate(animation);
      controllerCenter = widget.defaultConfettiController();

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed && notCompleted) {
          controllerCenter.play();
          secondaryPlayer.play();
          player.play();

          animation.reverse();
          notCompleted = false;
        } else if (status == AnimationStatus.dismissed) {}
      });
    }
  }

  void runAnimation(String? message) {
    setState(() {
      this.message = message ?? this.message;
    });
    if (widget.show) {
      animation.forward();
    }
  }

  @override
  void dispose() {
    animation.dispose();
    controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, runAnimation);

    return Stack(
      children: [
        Center(
          child: ConfettiWidget(
            confettiController: controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            minBlastForce: 20,
            maxBlastForce: 50,
            gravity: 0.01,
            colors: widget.confettiColors,
            createParticlePath: widget.drawStar,
          ),
        ),
        Center(
          child: FadeTransition(
            opacity: _fadeInFadeOut,
            child: Text(message, style: const TextStyle(fontSize: 40)),
          ),
        ),
      ],
    );
  }
}

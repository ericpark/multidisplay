import 'package:flutter/material.dart';

enum GradientPreset {
  basic,
  lighten,
  darken,
  none,
}

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.backgroundGradient,
    this.gradientPreset = GradientPreset.basic,
  });

  final Widget child;

  final VoidCallback? onTap;

  /// Overrides [gradientPreset] when not null
  final LinearGradient? backgroundGradient;

  /// Defaults to the Theme Primary Color.
  final Color? backgroundColor;

  /// If [backgroundGradient] is not null, then [gradientPreset] will not be used.
  /// [GradientPreset.basic] (Default) will add a gradient using the [backgroundColor]
  /// This will make the card more saturated.
  /// [GradientPreset.none] will set no gradient
  /// [GradientPreset.darken] will darken the card slightly
  final GradientPreset? gradientPreset;

  LinearGradient getGradient({required Color color}) {
    if (backgroundGradient != null) {
      return backgroundGradient!;
    }
    switch (gradientPreset!) {
      case GradientPreset.darken:
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 1],
          colors: [Colors.white.withOpacity(0), Colors.black.withOpacity(0.09)],
        );
      case GradientPreset.lighten:
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 1],
          colors: [Colors.white.withOpacity(0), Colors.white.withOpacity(0.5)],
        );
      case GradientPreset.none:
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0],
          colors: [Colors.white.withOpacity(0), Colors.white.withOpacity(0)],
        );
      case GradientPreset.basic:
        return LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.25, 0.75, 0.90, 1.0],
          colors: [
            color,
            color.brighten(),
            color.brighten(33),
            color.brighten(50),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color =
        (backgroundColor ?? Theme.of(context).primaryColor).withOpacity(0.1);

    final gradient = getGradient(color: color);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Theme.of(context).primaryColor.withAlpha(30),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(gradient: gradient),
          color: backgroundColor,
          child: child,
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}

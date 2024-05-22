import 'package:flutter/material.dart';
import 'package:custom_components/custom_components.dart';

class PullToRefreshCard extends StatelessWidget {
  const PullToRefreshCard({
    super.key,
    required this.child,
    this.onTap,
    this.onRefresh,
    this.backgroundColor,
    this.backgroundGradient,
    this.gradientPreset = GradientPreset.basic,
  });

  final Widget child;

  final VoidCallback? onTap;

  final RefreshCallback? onRefresh;

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return RefreshIndicator(
          displacement: 30.0,
          onRefresh: onRefresh ?? () async => {},
          child: SingleChildScrollView(
              clipBehavior: Clip.none,
              physics: onRefresh != null
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: Container(
                height: viewportConstraints.maxHeight,
                child: SimpleCard(
                  onTap: onTap,
                  child: child,
                  backgroundGradient: backgroundGradient,
                  backgroundColor: backgroundColor,
                  gradientPreset: gradientPreset,
                ),
              )),
        );
      },
    );
  }
}

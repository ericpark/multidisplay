import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: double.infinity,
        height: 500.0,
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
      ),
    );
  }
}

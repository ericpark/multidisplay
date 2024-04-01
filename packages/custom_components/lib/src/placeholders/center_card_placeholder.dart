import 'package:flutter/material.dart';

class CenterCardPlaceholder extends StatelessWidget {
  const CenterCardPlaceholder({
    super.key,
    this.contentColor,
  });

  final Color? contentColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: constraints.maxWidth / 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: constraints.maxWidth / 2,
                  height: 10.0,
                  color: contentColor ?? Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                const SizedBox(height: 12.0),
                Container(
                  width: 96.0,
                  height: 72.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: contentColor ?? Colors.white,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  width: constraints.maxWidth / 3,
                  height: 10.0,
                  color: contentColor ?? Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                Container(
                  width: constraints.maxWidth / 3,
                  height: 10.0,
                  color: contentColor ?? Colors.white,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

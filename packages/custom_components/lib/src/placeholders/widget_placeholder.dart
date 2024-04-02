import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WidgetPlaceholder extends StatelessWidget {
  const WidgetPlaceholder({
    super.key,
    this.contentColor,
  });

  final Color? contentColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFFFFFFF)),
            left: BorderSide(color: Color(0xFFFFFFFF)),
            right: BorderSide(),
            bottom: BorderSide(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 10.0,
                color: contentColor ?? Colors.white,
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
              Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: contentColor ?? Colors.white,
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
                width: 50,
                height: 10.0,
                color: contentColor ?? Colors.white,
                margin: const EdgeInsets.only(bottom: 8.0),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50.0,
                    height: 10.0,
                    color: contentColor ?? Colors.white,
                  ),
                  Container(
                    width: 50.0,
                    height: 10.0,
                    color: contentColor ?? Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50.0,
                    height: 10.0,
                    color: contentColor ?? Colors.white,
                  ),
                  Container(
                    width: 50.0,
                    height: 10.0,
                    color: contentColor ?? Colors.white,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

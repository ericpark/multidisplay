import 'package:flutter/material.dart';
import 'package:custom_components/custom_components.dart';

class ExperimentalLayoutTablet extends StatelessWidget {
  const ExperimentalLayoutTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Demo'),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return SimpleTrackingWidget(
                title: "SimpleTrackingWidget",
                mainMetric: {"display_name": "Index", "value": "$index"},
                leftMetric: {
                  "display_name": "days since then",
                  "value": "$index"
                },
                rightMetric: {"display_name": "Index", "value": "$index"},
                //size: Size(200, 200),
              );
            },
            childCount: 20,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('List Item $index'),
              );
            },
          ),
        ),
      ],
    ));
  }
}

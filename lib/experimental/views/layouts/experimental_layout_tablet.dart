import 'package:custom_components/custom_components.dart';
import 'package:flutter/material.dart';
import 'package:multidisplay/tracking/tracking.dart';

class ExperimentalLayoutTablet extends StatelessWidget {
  const ExperimentalLayoutTablet({super.key});

  Widget sectionLayout({
    required String sectionTitle,
    required String description,
    required List<Widget> widgets,
  }) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(),
          SizedBox(
            height: 230,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int index = 0; index < widgets.length; index += 1)
                  Padding(
                    key: Key('$index'),
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(height: 200, child: widgets[index]),
                  ),
              ],
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(description),
      ),
    );
  }

  List<Widget> simpleWidgets() {
    final simpleWidget = SimpleTrackingWidget(
      id: 0,
      section: 'Meeko',
      trackingName: 'Simple',
      mainMetric: const {'display_name': 'Main Metric', 'value': '1'},
      leftMetric: const {'display_name': 'Left Metric', 'value': '1'},
      rightMetric: const {'display_name': 'Right Metric', 'value': '1'},
      onDoubleTap: () => {},
    );

    final outlineWidget = OutlinedTrackingWidgetNonModular(
      id: 0,
      section: 'Meeko',
      trackingName: 'Outlined',
      mainMetric: const {'display_name': 'Main Metric', 'value': '1'},
      leftMetric: const {'display_name': 'Left Metric', 'value': '1'},
      rightMetric: const {'display_name': 'Right Metric', 'value': '1'},
      onDoubleTap: () => {},
    );

    final outlineRoundedWidget = OutlinedTrackingWidgetNonModular(
      id: 0,
      section: 'Meeko',
      trackingName: 'Outlined Rounded',
      mainMetric: const {'display_name': 'Main Metric', 'value': '1'},
      leftMetric: const {'display_name': 'Left Metric', 'value': '1'},
      rightMetric: const {'display_name': 'Right Metric', 'value': '1'},
      onDoubleTap: () => {},
      clipBehavior: Clip.hardEdge,
    );

    final horizontalWidget = HorizontalTrackingWidget(
      id: 0,
      section: 'Meeko',
      trackingName: 'Horizontal',
      mainMetric: const {'display_name': 'Main Metric', 'value': '1'},
      leftMetric: const {'display_name': 'Left Metric', 'value': '1'},
      rightMetric: const {'display_name': 'Right Metric', 'value': '1'},
      onDoubleTap: () => {},
    );

    final horizontalRoundedWidget = HorizontalTrackingWidget(
      id: 0,
      section: 'Meeko',
      trackingName: 'Horizontal Rounded',
      mainMetric: const {'display_name': 'Main Metric', 'value': '1'},
      leftMetric: const {'display_name': 'Left Metric', 'value': '1'},
      rightMetric: const {'display_name': 'Right Metric', 'value': '1'},
      clipBehavior: Clip.hardEdge,
      onDoubleTap: () => {},
    );

    return [
      simpleWidget,
      outlineWidget,
      outlineRoundedWidget,
      horizontalWidget,
      horizontalRoundedWidget,
    ];
  }

  List<Widget> consecutiveWidgets() {
    final trackingSummary = TrackingSummary(
      id: 'test',
      name: 'Good',
      records: [TrackingRecord(date: DateTime.now())],
      mainMetric: 'main',
      leftMetric: 'left',
      rightMetric: 'right',
      metrics: {
        'main': {'display_name': 'Main Metric', 'value': '1'},
        'left': {'display_name': 'Left Metric', 'value': '1'},
        'right': {'display_name': 'Right Metric', 'value': '1'},
      },
      section: '',
      ownerId: '',
    );

    final trackingSummaryWarning = TrackingSummary(
      id: 'test',
      name: 'Warn',
      records: [
        TrackingRecord(date: DateTime.now().subtract(const Duration(days: 1))),
      ],
      mainMetric: 'main',
      leftMetric: 'left',
      rightMetric: 'right',
      metrics: {
        'main': {'display_name': 'Main Metric', 'value': '1'},
        'left': {'display_name': 'Left Metric', 'value': '1'},
        'right': {'display_name': 'Right Metric', 'value': '1'},
      },
      section: '',
      ownerId: '',
    );

    final trackingSummaryFailure = TrackingSummary(
      id: 'test',
      name: 'Miss',
      records: [
        TrackingRecord(date: DateTime.now().subtract(const Duration(days: 2))),
      ],
      mainMetric: 'main',
      leftMetric: 'left',
      rightMetric: 'right',
      metrics: {
        'main': {'display_name': 'Main Metric', 'value': '1'},
        'left': {'display_name': 'Left Metric', 'value': '1'},
        'right': {'display_name': 'Right Metric', 'value': '1'},
      },
      section: '',
      ownerId: '',
    );
    final consecutiveGood = ConsecutiveTrackingWidget(
      id: 0,
      section: 'Meeko',
      trackingSummary: trackingSummary,
      onDoubleTap: () => {},
    );
    final consecutiveWarning = ConsecutiveTrackingWidget(
      id: 0,
      section: 'Meeko',
      trackingSummary: trackingSummaryWarning,
      onDoubleTap: () => {},
    );
    final consecutiveFail = ConsecutiveTrackingWidget(
      id: 0,
      section: 'Meeko',
      trackingSummary: trackingSummaryFailure,
      onDoubleTap: () => {},
    );
    return [
      consecutiveGood,
      consecutiveWarning,
      consecutiveFail,
    ];
  }

  List<Widget> placeholderWidgets(BuildContext context) {
    const contentTwo = Column(
      children: [
        SizedBox(
          height: 190,
          width: 190,
          child: ContentPlaceholder(
            lineType: ContentLineType.twoLines,
          ),
        ),
        Text('Content Placeholder Two Lines'),
      ],
    );
    const contentThree = Column(
      children: [
        SizedBox(
          height: 190,
          width: 190,
          child: ContentPlaceholder(
            lineType: ContentLineType.threeLines,
          ),
        ),
        Text('Content Placeholder Three Lines'),
      ],
    );

    const widgetPlaceholder = Column(
      children: [
        SizedBox(height: 190, width: 190, child: WidgetPlaceholder()),
        Text('Widget Placeholder'),
      ],
    );
    const cardPlaceholder = Column(
      children: [
        Card(
          elevation: 5,
          shadowColor: Colors.black,
          clipBehavior: Clip.none,
          child: SizedBox(
            height: 180,
            width: 180,
            child: Center(child: CenterCardPlaceholder()),
          ),
        ),
        Text('Card Placeholder'),
      ],
    );

    return [contentTwo, contentThree, widgetPlaceholder, cardPlaceholder];
  }

  List<Widget> cardWidgets(BuildContext context) {
    const cardPlaceholder = Column(
      children: [
        Card(
          elevation: 5,
          shadowColor: Colors.black,
          clipBehavior: Clip.none,
          child: SizedBox(
            height: 180,
            width: 180,
            child: Center(child: CenterCardPlaceholder()),
          ),
        ),
        Text('Card Placeholder'),
      ],
    );

    const simpleCardPlaceholder = Column(
      children: [
        SimpleCard(
          child: SizedBox(
            height: 180,
            width: 180,
            child: Center(child: CenterCardPlaceholder()),
          ),
        ),
        Text('Basic Placeholder'),
      ],
    );
    final pullToRefreshCard = Column(
      children: [
        SizedBox(
          height: 180,
          width: 180,
          child: PullToRefreshCard(
            onRefresh: () async => {},
            child: const Center(child: CenterCardPlaceholder()),
          ),
        ),
        const Text('Pull To Refresh Card'),
      ],
    );

    return [
      cardPlaceholder,
      simpleCardPlaceholder,
      pullToRefreshCard,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      sectionLayout(
        sectionTitle: 'Simple Widgets',
        description: 'Simple widgets',
        widgets: simpleWidgets(),
      ),
      sectionLayout(
        sectionTitle: 'Consecutive Widgets',
        description: 'The different states that a consecutive widget may take',
        widgets: consecutiveWidgets(),
      ),
      sectionLayout(
        sectionTitle: 'Placeholder Widgets',
        description: 'Placeholders used while loading',
        widgets: placeholderWidgets(context),
      ),
      sectionLayout(
        sectionTitle: 'Card Widgets',
        description: 'Card Widgets',
        widgets: cardWidgets(context),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Library'),
      ),
      body: ListView(children: widgets),
    );
  }
}

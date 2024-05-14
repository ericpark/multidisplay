import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multidisplay/app/helpers/device_helper.dart';

class MockBuildContext extends Mock implements BuildContext {}

class MockMediaQueryData extends Mock implements MediaQueryData {
  MockMediaQueryData(this.mockSize);

  final Size mockSize;

  @override
  Size get size => mockSize;
}

void main() {
  group('DeviceType - Phone', () {
    testWidgets('getDeviceType should return "Phone" for small screens',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      const size = Size(320, 480);

      final Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: SizedBox.fromSize(size: size),
          navigatorKey: navigatorKey,
        ),
      );
      await tester.pumpWidget(testWidget);

      final deviceType = DeviceType.getDeviceType(navigatorKey.currentContext!);
      expect(deviceType, 'Phone');
    });
    testWidgets(
        'getDeviceFormFactor should return FormFactor.mobile for small screens',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      const size = Size(320, 480);

      final Widget testWidget = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: SizedBox.fromSize(size: size),
          navigatorKey: navigatorKey,
        ),
      );
      await tester.pumpWidget(testWidget);

      final formFactor =
          DeviceType.getDeviceFormFactor(navigatorKey.currentContext!);
      expect(formFactor, FormFactor.mobile);
    });
  });

  group('DeviceType - Phablet', () {
    testWidgets('getDeviceType should return "Phablet" for medium screens',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      tester.view.physicalSize = const Size(400, 600);
      tester.view.devicePixelRatio = 1.0;
      final Widget testWidget = MaterialApp(
        home: Container(),
        navigatorKey: navigatorKey,
      );
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      final deviceType = DeviceType.getDeviceType(navigatorKey.currentContext!);
      expect(deviceType, 'Phablet');
    });
    testWidgets(
        '''getDeviceFormFactor should return FormFactor.mobile for medium screens''',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      tester.view.physicalSize = const Size(400, 600);
      tester.view.devicePixelRatio = 1.0;
      final Widget testWidget = MaterialApp(
        home: Container(),
        navigatorKey: navigatorKey,
      );
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();
      final formFactor =
          DeviceType.getDeviceFormFactor(navigatorKey.currentContext!);
      expect(formFactor, FormFactor.mobile);
    });
  });

  group('DeviceType - Tablet', () {
    testWidgets(
        '''getDeviceFormFactor should return FormFactor.tablet for large screens''',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      tester.view.physicalSize = const Size(750, 1000);
      tester.view.devicePixelRatio = 1.0;
      final Widget testWidget = MaterialApp(
        home: Container(),
        navigatorKey: navigatorKey,
      );
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();
      final formFactor =
          DeviceType.getDeviceFormFactor(navigatorKey.currentContext!);
      expect(formFactor, FormFactor.tablet);
    });

    testWidgets('getDeviceType should return "Tablet" for large screens',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      tester.view.physicalSize = const Size(750, 1000);
      tester.view.devicePixelRatio = 1.0;
      final Widget testWidget = MaterialApp(
        home: Container(),
        navigatorKey: navigatorKey,
      );
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();
      final deviceType = DeviceType.getDeviceType(navigatorKey.currentContext!);
      expect(deviceType, 'Tablet');
    });
  });

  group('DeviceType - Large/Desktop', () {
    testWidgets(
        'getDeviceType should return "Larger Device" for extra large screens',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      tester.view.physicalSize = const Size(2000, 3000);
      tester.view.devicePixelRatio = 1.0;
      final Widget testWidget = MaterialApp(
        home: Container(),
        navigatorKey: navigatorKey,
      );
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();

      final deviceType = DeviceType.getDeviceType(navigatorKey.currentContext!);
      expect(deviceType, 'Larger Device');
    });

    testWidgets(
        '''getDeviceFormFactor should return FormFactor.desktop for extra large screens''',
        (WidgetTester tester) async {
      final navigatorKey = GlobalKey<NavigatorState>();
      tester.view.physicalSize = const Size(2000, 3000);
      tester.view.devicePixelRatio = 1.0;
      final Widget testWidget = MaterialApp(
        home: Container(),
        navigatorKey: navigatorKey,
      );
      await tester.pumpWidget(testWidget);
      await tester.pumpAndSettle();
      final formFactor =
          DeviceType.getDeviceFormFactor(navigatorKey.currentContext!);
      expect(formFactor, FormFactor.desktop);
    });
  });
}

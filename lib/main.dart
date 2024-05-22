import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:calendar_repository/calendar_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:multidisplay/app/app.dart';
import 'package:multidisplay/firebase_options.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tracking_repository/tracking_repository.dart';
import 'package:weather_repository/weather_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final db = FirebaseFirestore.instance;

  Bloc.observer = const AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final packageInfo = await PackageInfo.fromPlatform();
  final appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';

  runApp(
    App(
      weatherRepository: WeatherRepository(),
      calendarRepository: CalendarRepository(firebaseDB: db),
      trackingRepository: TrackingRepository(firebaseDB: db),
      authRepository: AuthRepository(firebaseDB: db),
      savedThemeMode: savedThemeMode,
      appVersion: appVersion,
    ),
  );
}

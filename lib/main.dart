// import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poochcare/app.dart';
import 'package:poochcare/core/config/app_config.dart';
import 'package:poochcare/core/di/service_locator.dart';
import 'package:poochcare/core/localization/multi_json_loader.dart';
import 'package:poochcare/core/services/notification_service.dart';

/// ✅ GLOBAL KEY (ADD THIS)
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e, stack) {
    debugPrint('Firebase init failed: $e');
    debugPrintStack(stackTrace: stack);
    // Optional: continue app without Firebase OR show fallback UI
  }
  await NotificationService().init();
  await AppConfig.init();
  await Hive.initFlutter();
  await EasyLocalization.ensureInitialized();
  Intl.defaultLocale = 'en';

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          ),
  );

  setupDI();
  // Run the app normally; loader overlay will be injected inside app.dart
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',

      fallbackLocale: const Locale('en'),

      assetLoader: const MultiJsonLoader(),
      // child: DevicePreview(
      //   builder: (context) => PoochCareApp(),
      // )
      child: PoochCareApp(),
    ),
  );
  // runApp(DevicePreview(enabled: true, builder: (context) => PoochCareApp()));
}

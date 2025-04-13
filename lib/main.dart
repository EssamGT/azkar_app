import 'package:azkar_app/core/NotiServices/Notification_Services.dart';
import 'package:azkar_app/core/cache/prefs_helper.dart';
import 'package:azkar_app/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:azkar_app/core/boxes/azkar_box.dart';
import 'package:azkar_app/core/boxes/azkar_gen.dart';
import 'package:azkar_app/core/resources/theme_manager.dart';
import 'package:azkar_app/core/routes/Routes.dart';
import 'package:azkar_app/core/routes/route_genrator.dart';
import 'package:azkar_app/features/AzkarDetails/model/Azkar_Model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await getLocation();
  await NotificationServices().initNotification();
  tz.initializeTimeZones();
  PrefsHelper.init();

  configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(AzkarTypeAdapter());
  Hive.registerAdapter(ZekrAdapter());
  azkarBox = await Hive.openBox<Zekr>('azkarBox');
  await preloadAzkar();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait mode
    DeviceOrientation.portraitDown, // Upside-down portrait mode
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => MaterialApp(
            home: child,
            locale: const Locale('ar'), // Set Arabic as default
            supportedLocales: const [
              Locale('en'), // English (optional)
              Locale('ar'), // Arabic
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashScreen,
            theme: getApplicationTheme(),
          ),
    );
  }
}

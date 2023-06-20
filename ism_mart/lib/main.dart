import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ism_mart/api_helper/api_constant.dart';
import 'package:ism_mart/app_binding/app_init_binding.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'exports/export_api_helper.dart';
import 'helper/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Stripe.publishableKey = ApiConstant.PUBLISHABLE_KEY;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.grey[300]!));

  ///firebase integration for crashlytics
  ///
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    //Get.put(AppInitBinding());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ISMMART",
      theme: ThemeHelper.lightTheme,
      darkTheme: ThemeHelper.darkTheme,
      themeMode: getThemeMode(themeController.theme.value),
      initialRoute: Routes.initRoute,
      getPages: Routes.pages,
      defaultTransition: Transition.fadeIn,
      initialBinding: AppInitBinding(),
      translations: AppTranslations(),
      locale: getLocale(languageController.languageKey.value),
      fallbackLocale: Locale('en', 'US'),
    );
  }

  ThemeMode getThemeMode(String theme) {
    ThemeMode themeMode = ThemeMode.system;
    switch (theme) {
      case "system":
        themeMode = ThemeMode.system;
        break;
      case "dark":
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.light;
        break;
    }

    return themeMode;
  }

  Locale getLocale(String languageKey) {
    // Locale? locale = Get.locale!;
    return Locale(
        languageController.optionsLocales[languageKey]['languageCode'],
        languageController.optionsLocales[languageKey]['countryCode']);
  }
}

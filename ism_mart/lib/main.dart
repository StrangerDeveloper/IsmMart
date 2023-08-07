import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ism_mart/app_binding/app_init_binding.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/screens/bottom_navigation_and_appbar/bottom_navigation_and_appbar_view.dart';
import 'package:ism_mart/screens/onBoard/onboard_view.dart';
import 'package:ism_mart/screens/onboard/onboard_viewModel.dart';
import 'helper/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }

  await GetStorage.init();

  //Stripe.publishableKey = ApiConstant.PUBLISHABLE_KEY;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.grey[300]!));

  ///firebase integration for crashlytics
  ///
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // FlutterError.onError = (errorDetails) {
  //   // If you wish to record a "non-fatal" exception, please use `FirebaseCrashlytics.instance.recordFlutterError` instead
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   // If you wish to record a "non-fatal" exception, please remove the "fatal" parameter
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

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

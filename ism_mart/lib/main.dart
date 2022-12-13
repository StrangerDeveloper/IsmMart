import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ism_mart/app_binding/app_init_binding.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/utils/exports_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  Stripe.publishableKey = AppConstant.PUBLISHABLE_KEY;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    //Get.put(AppInitBinding());
    final ThemesController themeController = Get.put(ThemesController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ism-Mart",
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: getThemeMode(themeController.theme.value),
      initialRoute: Routes.initRoute,
      getPages: Routes.pages,
      defaultTransition: Transition.fadeIn,
      initialBinding: AppInitBinding(),
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
}

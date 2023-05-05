import 'package:get/get.dart';

import 'export_controllers.dart';

AuthController authController = Get.find<AuthController>();
BaseController baseController = Get.find<BaseController>();

ThemesController themeController = Get.put(ThemesController());

LanguageController languageController = Get.put(LanguageController());

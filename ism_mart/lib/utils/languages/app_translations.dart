import 'package:get/get.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': English().translations,
        'ar_AE': Arabic().translations,
        'ur_PK': Urdu().translations,
        'ru_RU': Russian().translations,
        'zh_CN': Chinese().translations,
      };
}



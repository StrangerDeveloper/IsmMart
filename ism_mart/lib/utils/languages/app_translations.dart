import 'package:get/get.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/dutch_german.dart';
import 'package:ism_mart/utils/languages/french.dart';
import 'package:ism_mart/utils/languages/italian.dart';
import 'package:ism_mart/utils/languages/japanese.dart';
import 'package:ism_mart/utils/languages/korean.dart';
import 'package:ism_mart/utils/languages/spanish.dart';
import 'package:ism_mart/utils/languages/turkish.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': English().translations,
        'ar_AE': Arabic().translations,
        'ur_PK': Urdu().translations,
        'ru_RU': Russian().translations,
        'zh_CN': Chinese().translations,
        'tr_TR': Turkish().translations,
        'fr_CH': French().translations,
        'es_ES': Spanish().translations,
        'ja_JP': Japanese().translations,
        'de_DE': DutchGerman().translations,
        'it_IT': Italian().translations,
        'ko_KR': Korean().translations,
      };
}

import 'package:get/get.dart';
import 'arabic.dart';
import 'chinese.dart';
import 'dutch_german.dart';
import 'english.dart';
import 'french.dart';
import 'italian.dart';
import 'japanese.dart';
import 'korean.dart';
import 'russian.dart';
import 'spanish.dart';
import 'turkish.dart';
import 'urdu.dart';

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

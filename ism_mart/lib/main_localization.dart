// import 'dart:io';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:csv/csv.dart';

// void main() {
//   updateLocalizationFile();
// }

// Future updateLocalizationFile() async {
//   //the document id for your google sheet
//   String documentId = "1KOwB8NH_O3UvoIuWweapOL_gbxEfEkGSqD9wPjJSBpA";
//   //the sheetid of your google sheet

// // SheetID
// //      0-->General and All app widget Text
// //      15336104---> General Single Data (Sheet4)
// //      1423501492--> About US
// //      80287141-->TermsAndConditions
// //      1372575240 ---> Return And Exchange
// //      1207021985----> FAQS
// //      572245348----> MembershipAndPlans
// //      368543940 ---> PrivacyPolicy
// //      38595980-----> Contact Us
// //      1563929016 ---> hayat
// //      15336104 ----> Sheet4
// //      1522681252 ---> VendorTermsAndConditions
// //      979142310----->NewTerm&ConditionCustomer

//   String sheetId = "979142310";

//   String _phraseKey = '';
//   List<LocalizationModel> _localizations = [];
//   String _localizationFile = """import 'package:get/get.dart';
// class AppTranslations extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys => {
//     """;

//   try {
//     final url =
//         'https://docs.google.com/spreadsheets/d/$documentId/export?format=csv&id=$documentId&gid=$sheetId';

//     stdout.writeln('');
//     stdout.writeln('---------------------------------------');
//     stdout.writeln('Downloading Google sheet url "$url" ...');
//     stdout.writeln('---------------------------------------');
//     var response = await http
//         .get(Uri.parse(url), headers: {'accept': 'text/csv;charset=UTF-8'});

//     //print('Google sheet csv:\n ${response.body}');

//     final bytes = response.bodyBytes.toList();
//     final csv = Stream<List<int>>.fromIterable([bytes]);

//     final fields = await csv
//         .transform(utf8.decoder)
//         .transform(CsvToListConverter(
//           shouldParseNumbers: false,
//         ))
//         .toList();

//     final index = fields[0]
//         .cast<String>()
//         .map(_uniformizeKey)
//         .takeWhile((x) => x.isNotEmpty)
//         .toList();

//     for (var r = 1; r < fields.length; r++) {
//       final rowValues = fields[r];

//       /// Creating a map
//       final row = Map<String, String>.fromEntries(
//         rowValues
//             .asMap()
//             .entries
//             .where(
//               (e) => e.key < index.length,
//             )
//             .map(
//               (e) => MapEntry(index[e.key], e.value),
//             ),
//       );

//       row.forEach((key, value) {
//         if (key == 'key') {
//           _phraseKey = value;
//         } else {
//           bool _languageAdded = false;
//           _localizations.forEach((element) {
//             if (element.language == key) {
//               element.phrases.add(PhraseModel(key: _phraseKey, phrase: value));
//               _languageAdded = true;
//             }
//           });
//           if (_languageAdded == false) {
//             _localizations.add(LocalizationModel(
//                 language: key,
//                 phrases: [PhraseModel(key: _phraseKey, phrase: value)]));
//           }
//         }
//       });
//     }

//     _localizations.forEach((_localization) {
//       String _language = _localization.language;
//       String _currentLanguageTextCode = "'$_language': {\n";
//       _localizationFile = _localizationFile + _currentLanguageTextCode;
//       _localization.phrases.forEach((_phrase) {
//         String _phraseKey = _phrase.key;
//         String _phrasePhrase = _phrase.phrase.replaceAll(r"'", "\\\'");
//         String _currentPhraseTextCode = "'$_phraseKey': '$_phrasePhrase',\n";
//         _localizationFile = _localizationFile + _currentPhraseTextCode;
//       });
//       String _currentLanguageCodeEnding = "},\n";
//       _localizationFile = _localizationFile + _currentLanguageCodeEnding;
//     });
//     String _fileEnding = """
//         };
//       }
//       """;
//     _localizationFile = _localizationFile + _fileEnding;

//     stdout.writeln('');
//     stdout.writeln('---------------------------------------');
//     //stdout.writeln('Saving app_translation_new.g.dart');
//     //stdout.writeln('Saving app_translation_about_us.g.dart');
//     stdout.writeln('Saving app_translation_sheetId_$sheetId.g.dart');
//     stdout.writeln('---------------------------------------');
//     final file = File('app_translation_sheet_$sheetId.g.dart');
//     await file.writeAsString(_localizationFile);
//     stdout.writeln('Done...');
//   } catch (e) {
//     //output error
//     stderr.writeln('error: networking error');
//     stderr.writeln(e.toString());
//   }
// }

// String _uniformizeKey(String key) {
//   key = key.trim().replaceAll('\n', '').toLowerCase();
//   return key;
// }

// //Localization Model
// class LocalizationModel {
//   final String language;
//   final List<PhraseModel> phrases;

//   LocalizationModel({
//     required this.language,
//     required this.phrases,
//   });

//   factory LocalizationModel.fromMap(Map data) {
//     return LocalizationModel(
//       language: data['language'],
//       phrases:
//           (data['phrases'] as List).map((v) => PhraseModel.fromMap(v)).toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "language": language,
//         "phrases": List<dynamic>.from(phrases.map((x) => x.toJson())),
//       };
// }

// class PhraseModel {
//   String key;
//   String phrase;

//   PhraseModel({required this.key, required this.phrase});

//   factory PhraseModel.fromMap(Map data) {
//     return PhraseModel(
//       key: data['key'],
//       phrase: data['phrase'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "key": key,
//         "phrase": phrase,
//       };
// }

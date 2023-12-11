import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:get/get.dart';

class OnBoardModel {
  final String image;
  final String title;
  final String description;

  OnBoardModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnBoardModel> list = [
    OnBoardModel(
      image: 'assets/images/banner01.png',
      title: langKey.availAmazingDiscount.tr,
      description: langKey.descriptionOfDiscount.tr,
    ),
    OnBoardModel(
      image: 'assets/images/banner02.png',
      title: langKey.boostYourBusiness.tr,
      description: langKey.descriptionOfFreedomAndSavings.tr,
    ),
    OnBoardModel(
      image: 'assets/images/banner03.png',
      title: langKey.celebrateFreedomAndSavings.tr,
      description: langKey.descriptionOfBoostYourBusiness.tr,
    ),
  ];
}

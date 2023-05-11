import 'package:get/get.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class MembershipController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  List getPlansData() {
    return [
      {
        'title': langKey.memPlan1Title.tr,
        'price': langKey.memPlan1Price.tr,
        'isPopular': false,
        'description': [
          langKey.memPlan1Desc1.tr,
          langKey.memPlan1Desc2.tr,
          langKey.memPlan1Desc3.tr,
          langKey.memPlan1Desc4.tr,
        ],
      },
      {
        'title': langKey.memPlan2Title.tr,
        'price': '${AppConstant.getCurrencySymbol(currencyCode: 'usd')}9.5',
        'isPopular': true,
        'description': [
          langKey.memPlan2Desc1.tr,
          langKey.memPlan2Desc2.tr,
          langKey.memPlan2Desc3.tr,
          langKey.memPlan2Desc4.tr,
          langKey.memPlan2Desc5.tr,
          langKey.memPlan2Desc6.tr,
          langKey.memPlan2Desc7.tr,
        ],
      },
      {
        'title': langKey.memPlan3Title.tr,
        'price': '${AppConstant.getCurrencySymbol(currencyCode: 'usd')}12.5',
        'isPopular': false,
        'description': [
          langKey.memPlan3Desc1.tr,
          langKey.memPlan3Desc2.tr,
          langKey.memPlan3Desc3.tr,
          langKey.memPlan3Desc4.tr,
          langKey.memPlan3Desc5.tr,
          langKey.memPlan3Desc6.tr,
          langKey.memPlan3Desc7.tr,
          langKey.memPlan3Desc8.tr,
          langKey.memPlan3Desc9.tr,
        ],
      },
    ];
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class MembershipModel {
  String? title, price;
  bool? isPopular;
  List<String>? description;

  MembershipModel({this.title, this.price, this.isPopular, this.description});

  factory MembershipModel.fromJson(Map<String, dynamic> json) =>
      MembershipModel(
        title: json["title"],
        price: json["price"],
        isPopular: json["isPopular"],
        description: List<String>.from(json["description"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "isPopular": isPopular,
        "description": List<dynamic>.from(description!.map((x) => x)),
      };
}

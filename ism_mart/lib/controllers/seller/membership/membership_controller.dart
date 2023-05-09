import 'package:get/get.dart';
import 'package:ism_mart/utils/constants.dart';

class MembershipController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  List getPlansData() {
    return [
      {
        'title': 'START',
        'price': 'Free',
        'isPopular': false,
        'description': [
          'Anyone can be registered as free members.',
          'Can sell up to 3 Products on ISMMART platform.',
          'Will have only access to the products and stores to visit that are opened by default or kept opened by the Vendors & Businesses to visit.',
          'They can buy anything at their own as a direct customers with mutual understanding with the seller; ISMMART will not be responsible or back up in case of any issues in such deal.',
        ],
      },
      {
        'title': 'PRO',
        'price': '${AppConstant.getCurrencySymbol(currencyCode: 'usd')}9.5',
        'isPopular': true,
        'description': [
          'A free one month trial',
          'Can sell anything on ISMMART platform',
          'Will have access to all products and stores to visit.',
          'All deals by Premium Members on ISMMART will be backed up by ISMMART. We will be responsible for smooth transactions and delivery of products. ISMMART will guarantee to honor the mutual understanding that both Seller and Buyer have agreed upon.',
          'Unlimited deliveries on eligible items.',
          'Premium Members will have worry less access to all businesses worldwide, both as a Seller & Buyer as ISMMART will be directly guaranteeing and verifying such members and any deals they do.',
          'As all Premium Members are scrutinized and are verified through ISMMART verification process, so all such members can do worry less trade with each other, anywhere in the World.',
        ],
      },
      {
        'title': 'BUSINESS',
        'price': '${AppConstant.getCurrencySymbol(currencyCode: 'usd')}12.5',
        'isPopular': false,
        'description': [
          '2 month free trial',
          'B2B Opportunities',
          'Unlimited free deliveries',
          'Unlimited Promotional Tools',
          'Wholesale shipping',
          'Get a chance to place products in our physical stores.',
          'Unlimited deliveries on eligible items.',
          'Premium Members will have worry less access to all businesses worldwide, both as a Seller & Buyer as ISMMART will be directly guaranteeing and verifying such members and any deals they do.',
          'As all Premium Members are scrutinized and are verified through ISMMART verification process, so all such members can do worry less trade with each other, anywhere in the World.',
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

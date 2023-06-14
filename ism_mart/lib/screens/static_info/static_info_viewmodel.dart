import 'package:get/get.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class StaticInfoViewModel extends GetxController {
  String title = '';

  @override
  void onInit() {
    title = Get.arguments['title'];
    getData();
    super.onInit();
  }

  List getData() {
    if (title == langKey.termsAndConditions.tr) {
      return getTermConditionData();
    } else if (title == langKey.privacyPolicy.tr)
      return getPrivacyData();
    else if (title == langKey.returnAndExchange.tr)
      return getReturnExchangeData();
    return getAboutUsData();
  }

  List getAboutUsData() {
    return [
      {'header': langKey.aboutHeader1.tr, 'body': langKey.aboutBody1.tr},
      {'header': langKey.aboutHeader2.tr, 'body': langKey.aboutBody2.tr},
      {'header': langKey.aboutHeader3.tr, 'body': langKey.aboutBody3.tr},
      {'header': langKey.aboutHeader4.tr, 'body': langKey.aboutBody4.tr},
      {'header': langKey.aboutHeader5.tr, 'body': langKey.aboutBody5.tr},
      {'header': langKey.aboutHeader6.tr, 'body': langKey.aboutBody6.tr},
    ];
  }

  List getPrivacyData() {
    return [
      {'header': langKey.privacyHeader1.tr, 'body': langKey.privacyBody1.tr},
      {'header': langKey.privacyHeader2.tr, 'body': langKey.privacyBody2.tr},
      {'header': langKey.privacyHeader3.tr, 'body': langKey.privacyBody3.tr},
      {'header': langKey.privacyHeader4.tr, 'body': langKey.privacyBody4.tr},
      {'header': langKey.privacyHeader5.tr, 'body': langKey.privacyBody5.tr},
      {'header': langKey.privacyHeader6.tr, 'body': langKey.privacyBody6.tr},
      {'header': langKey.privacyHeader7.tr, 'body': langKey.privacyBody7.tr},
      {'header': langKey.privacyHeader8.tr, 'body': langKey.privacyBody8.tr},
      {'header': langKey.privacyHeader9.tr, 'body': langKey.privacyBody9.tr},
      {'header': langKey.privacyHeader10.tr, 'body': langKey.privacyBody10.tr},
      {'header': langKey.privacyHeader11.tr, 'body': langKey.privacyBody11.tr},
      {'header': langKey.privacyHeader12.tr, 'body': langKey.privacyBody12.tr},
      {'header': langKey.privacyHeader13.tr, 'body': langKey.privacyBody13.tr},
      {'header': langKey.privacyHeader14.tr, 'body': langKey.privacyBody14.tr},
      {'header': langKey.privacyHeader15.tr, 'body': langKey.privacyBody15.tr},
    ];
  }

  List getTermConditionData() {
    return [
      {'header': langKey.tCHeader1.tr, 'body': langKey.tCBody1.tr},
      {'header': langKey.tCHeader2.tr, 'body': langKey.tCBody2.tr},
      {'header': langKey.tCHeader3.tr, 'body': langKey.tCBody3.tr},
      {'header': langKey.tCHeader4.tr, 'body': langKey.tCBody4.tr},
      {'header': langKey.tCHeader5.tr, 'body': langKey.tCBody5.tr},
      {'header': langKey.tCHeader6.tr, 'body': langKey.tCBody6.tr},
      {'header': langKey.tCHeader7.tr, 'body': langKey.tCBody7.tr},
      {'header': langKey.tCHeader8.tr, 'body': langKey.tCBody8.tr},
      {'header': langKey.tCHeader9.tr, 'body': langKey.tCBody9.tr},
      {'header': langKey.tCHeader10.tr, 'body': langKey.tCBody10.tr},
      {'header': langKey.tCHeader11.tr, 'body': langKey.tCBody11.tr},
      {'header': langKey.tCHeader12.tr, 'body': langKey.tCBody12.tr},
      {'header': langKey.tCHeader13.tr, 'body': langKey.tCBody13.tr},
      {'header': langKey.tCHeader14.tr, 'body': langKey.tCBody14.tr},
      {'header': langKey.tCHeader15.tr, 'body': langKey.tCBody15.tr},
      {'header': langKey.tCHeader16.tr, 'body': langKey.tCBody16.tr},
      {'header': langKey.tCHeader17.tr, 'body': langKey.tCBody17.tr},
      {'header': langKey.tCHeader18.tr, 'body': langKey.tCBody18.tr},
      {'header': langKey.tCHeader19.tr, 'body': langKey.tCBody19.tr},
      {'header': langKey.tCHeader20.tr, 'body': langKey.tCBody20.tr},
      {'header': langKey.tCHeader21.tr, 'body': langKey.tCBody21.tr},
    ];
  }

  List getReturnExchangeData() {
    return [
      {
        'header': langKey.exchangeHeader1.tr,
        'body': langKey.exchangeBody1.tr,
      },
      {
        'header': langKey.exchangeHeader2.tr,
        'body': langKey.exchangeBody2.tr,
      },
    ];
  }
}

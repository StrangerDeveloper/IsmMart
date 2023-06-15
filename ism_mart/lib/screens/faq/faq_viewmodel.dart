import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/screens/faq/faq_model.dart';

class FaqViewModel extends GetxController {
  List<FaqModel> faqsList = <FaqModel>[].obs;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  getData() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(url: Urls.getFaq, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'] as List;
        faqsList.addAll(data.map((e) => FaqModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
}

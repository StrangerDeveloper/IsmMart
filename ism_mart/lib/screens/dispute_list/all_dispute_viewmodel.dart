import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/screens/dispute_list/all_dispute_model.dart';

class DisputeListViewModel extends GetxController {
  List<AllDisputeModel> allDisputeList = <AllDisputeModel>[].obs;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  getData() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper().getMethod(url: Urls.allTickets, withAuthorization: true).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'] as List;
        allDisputeList.addAll(data.map((e) => AllDisputeModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
}

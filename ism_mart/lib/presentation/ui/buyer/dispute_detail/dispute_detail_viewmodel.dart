import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/presentation/ui/buyer/dispute_detail/dispute_detail_model.dart';
import 'package:ism_mart/presentation/widgets/getx_helper.dart';

class DisputeDetailViewModel extends GetxController {
  Rx<DisputeDetailModel> disputeDetailModel = DisputeDetailModel().obs;
  String id = '';

  @override
  void onInit() {
    super.onInit();
    id = Get.arguments['id'];
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  getData() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper().getMethod(url: Urls.ticketDetail + id).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        disputeDetailModel.value =
            DisputeDetailModel.fromJson(parsedJson['data']);
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
}

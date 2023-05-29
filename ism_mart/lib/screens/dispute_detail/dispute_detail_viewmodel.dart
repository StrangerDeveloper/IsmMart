import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/screens/dispute_detail/dispute_detail_model.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class DisputeDetailViewModel extends GetxController {
  Rx<DisputeDetailModel> disputeDetailModel = DisputeDetailModel().obs;
  String id = '';
  RxInt indicatorIndex = 0.obs;

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

    ApiBaseHelper().getMethod(url: Urls.ticketDetail + id, withBearer: true).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        disputeDetailModel.value =
            DisputeDetailModel.fromJson(parsedJson['data']);
        print(disputeDetailModel.toJson());
      } else {
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          langKey.recordDoNotExist.tr,
        );
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
}

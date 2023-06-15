import 'package:get/get.dart';
import 'package:ism_mart/screens/top_vendors/top_vendors_model.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/global_variables.dart';
import '../../helper/urls.dart';

class TopVendorsViewModel extends GetxController {
  Rx<TopVendorsModel> topVendorsModel = TopVendorsModel().obs;
  @override
  void onReady() {
    //getData();
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    // getTopVendors();
    // getData();
  }

  // getTopVendors() async {
  //   final String token = authController.userToken!;
  //   var limit = '10';
  //   GlobalVariable.showLoader.value = true;
  //   final String _url = ApiConstant.baseUrl + "getTopVendors?limit=$limit";
  //   var headers = {'Authorization': 'Bearer $token'};
  //   var request = http.Request('GET', Uri.parse('$_url'));
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   var rawData = await http.Response.fromStream(response);
  //   var res = jsonDecode(rawData.body);

  //   if (res['success'] == true && res['data'] != null) {
  //     topVendorsModel.value = TopVendorsModel.fromJson(res);
  //     print("Top Vendors API Res =>>> ${res['data']}");
  //   } else {
  //     print(res['data']);
  //     AppConstant.displaySnackBar(
  //       langKey.errorTitle.tr,
  //       langKey.recordDoNotExist.tr,
  //     );
  //   }
  // }

  RxList<TopVendorsModel> topvendorList = <TopVendorsModel>[].obs;
  getData() {
    GlobalVariable.showLoader.value = true;
    var limit = '10';
    ApiBaseHelper()
        .getMethod(url: Urls.getTopVendors + limit)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'] as List;

        topvendorList.addAll(data.map((e) => TopVendorsModel.fromJson(e)));

        print(topvendorList.length);
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
}

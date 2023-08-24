import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class SellerDashBoardViewModel extends GetxController with GetTickerProviderStateMixin{
  ScrollController scrollController = ScrollController();
  int pageNo = 0;
  late AnimationController animationController1 = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late Animation<Offset> animation1 = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(animationController1);
  late AnimationController animationController2 = AnimationController(vsync: this, duration: Duration(seconds: 2));
  late Animation<double> animation2 = CurvedAnimation(parent: animationController2, curve: Curves.ease);
  RxBool announcementVisibility = true.obs;
  RxBool showLoader = false.obs;
  Rx<VendorStats> vendorStats = VendorStats().obs;
  List<VendorOrder> ordersList = <VendorOrder>[].obs;

  @override
  void onReady() {
    print('>>>Global Value: ${GlobalVariable.userModel?.infoCompleted}');
    getStats();
    getOrders();
    scrollController.addListener(() {
      getOrders();
    });
    if(GlobalVariable.userModel?.infoCompleted == 0) {
      animationController1.forward();
      animationController1.addListener(() {
        animation1.value;
        if (animationController1.isCompleted) {
          animationController2.forward();
          animationController2.addListener(() {
            animation2.value;
          });
        }
      });
    }
    super.onReady();
  }

  getStats() {
    GlobalVariable.internetErr(false);
    GlobalVariable.showLoader.value = true;
    ApiBaseHelper()
        .getMethod(url: Urls.getSellerOrdersStats, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        vendorStats.value = VendorStats.fromJson(parsedJson['data']);

      }
    }).catchError((e) {
     // GlobalVariable.internetErr(true);
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  getOrders() {
    if (pageNo == 0
        ? true
        : (scrollController.hasClients &&
            scrollController.position.maxScrollExtent ==
                scrollController.offset)) {
      pageNo++;
      showLoader.value = true;

      ApiBaseHelper()
          .getMethod(
              url: Urls.getVendorOrdersForDashboard + pageNo.toString(),
              withAuthorization: true)
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data'] != null) {
          var data = parsedJson['data'] as List;
          if (data.isEmpty) {
            scrollController.dispose();
          }
          ordersList.addAll(data.map((e) => VendorOrder.fromJson(e)));
          showLoader.value = false;
        } else {
          AppConstant.displaySnackBar(langKey.errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
      });
    }
  }
}

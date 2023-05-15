import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class OrderController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  final OrderProvider _orderProvider;

  OrderController(this._orderProvider);

  GlobalKey<FormState> reviewFormKey = GlobalKey<FormState>();
  RxDouble rating = 5.0.obs;
  TextEditingController reviewTxtFieldController = TextEditingController();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var reviewController = TextEditingController();

  late var tabController;

  var isLoading = false.obs;

  var disputeAttachImgPath = "".obs;

  var recentBuyerOrdersList = <OrderModel>[].obs;
  var recentVendorOrdersList = <VendorOrder>[].obs;

  var _orderDetailsModel = OrderModel().obs;
  var _orderStats = OrderStats().obs;
  var _vendorStats = VendorStats().obs;

  OrderModel? get orderDetailsModel => _orderDetailsModel.value;

  OrderStats? get orderStats => _orderStats.value;

  VendorStats? get vendorStats => _vendorStats.value;

  CoinsModel? get coinsModel => authController.coinsModel;

  fetchBuyerOrderStats() async {
    isLoading(true);

    await _orderProvider
        .getBuyerOrderStats(token: authController.userToken!)
        .then((OrderResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          _orderStats(OrderStats.fromJson(response.data));
        } else
          showSnackBar(message: response.message);
      }
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>>FetchBuyerOrderStats: $error");
    });
  }

  fetchOrderById(orderId) async {
    // change(null, status: RxStatus.loading());
    await _orderProvider
        .getBuyerOrdersDetails(
            token: authController.userToken, orderId: orderId)
        .then((data) {
      _orderDetailsModel(data);
      //change(data, status: RxStatus.success());
    }).catchError((error) {
      debugPrint(">>>>fetchOrderById: $error");
      // change(null, status: RxStatus.error(error));
    });
  }

  fetchOrders() async {
    change(null, status: RxStatus.loading());
    recentBuyerOrdersList.clear();
    await _orderProvider
        .getBuyerOrders(token: authController.userToken)
        .then((data) {
      change(data, status: RxStatus.success());
      recentBuyerOrdersList.addAll(data);
    }).catchError((error) {
      debugPrint(">>>>FetchOrderStats: $error");
      change(null, status: RxStatus.error(error));
    });
  }

  fetchVendorOrderById(orderId) async {
    change(null, status: RxStatus.loading());
    await _orderProvider
        .getVendorOrdersDetails(
            token: authController.userToken, orderId: orderId)
        .then((value) {
      _orderDetailsModel(value);
      change(value, status: RxStatus.success());
    }).catchError((error) {
      debugPrint(">>>>fetchVendorOrderById: $error");
      change(null, status: RxStatus.error(error));
    });
  }

  fetchVendorOrders({String? status}) async {
    change(null, status: RxStatus.loading());
    recentVendorOrdersList.clear();
    isLoading(true);
    await _orderProvider
        .getVendorOrders(token: authController.userToken, status: status!)
        .then((data) {
      isLoading(false);
      change(data, status: RxStatus.success());
      recentVendorOrdersList.addAll(data);
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>>fetchVendorOrders: $error");
      change(null, status: RxStatus.error(error));
    });
  }

  fetchVendorOrderStats() async {
    isLoading(true);

    await _orderProvider
        .getVendorOrderStats(token: authController.userToken!)
        .then((OrderResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          _vendorStats(VendorStats.fromJson(response.data));
        } else
          showSnackBar(message: response.message);
      }
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>>FetchVendorOrderStats: $error");
    });
  }

  disputeOnOrders({OrderItem? orderItem, orderId}) async {
    isLoading(true);
    String title = titleController.text;
    String description = descriptionController.text;

    await _orderProvider
        .createDispute(authController.userToken, title, description,
            orderItem!.id, pickedImagesList)
        .then((ApiResponse? apiResponse) {
      isLoading(false);
      if (apiResponse != null) {
        if (apiResponse.success!) {
          fetchOrderById(orderId);
          Get.back();
          clearControllers();
          showSnackBar(
              title: langKey.successTitle.tr, message: apiResponse.message);
        } else
          showSnackBar(message: apiResponse.message);
      } else {
        showSnackBar();
      }
    });
  }

  deleteTicket(String ticketId, String orderId) {
    print('bangash');
    // isLoading(true);
    ApiBaseHelper()
        .deleteMethod(url: Urls.deleteTickets + ticketId, withBearer: false)
        .then((parsedJson) {
      // isLoading(false);
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        fetchOrderById(orderId);
        AppConstant.displaySnackBar(
          langKey.success.tr,
          langKey.disputeDeleted.tr,
        );
      } else {
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          langKey.recordDoNotExist.tr,
        );
      }
    }).catchError((e) {
      // isLoading(false);
      print(e);
    });
    print('bangash');
  }

  var _picker = ImagePicker();
  var pickedImagesList = <File>[].obs;
  var imagesSizeInMb = 0.0.obs;

  pickMultipleImages() async {
    await PermissionsHandler().checkPermissions().then((isGranted) async {
      if (isGranted) {
        try {
          List<XFile> images = await _picker.pickMultiImage(imageQuality: 100);
          if (images.isNotEmpty) {
            images.forEach((XFile? file) async {
              var compressedFile = await FlutterNativeImage.compressImage(
                  file!.path,
                  quality: 100,
                  percentage: 25);
              var lengthInMb = compressedFile.lengthSync() * 0.000001;

              imagesSizeInMb.value += lengthInMb;
              if (lengthInMb > 2) {
                showSnackBar(message: langKey.fileMustBe.tr + ' 2MB');
              } else {
                //: needs to add check if file exist
                pickedImagesList.add(compressedFile);
              }
            });
          } else {
            print("No Images were selected");
          }
        } on PlatformException catch (e) {
          print(e);
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            langKey.invalidImageFormat.tr,
          );
        }
      } else {
        print("called");
        await PermissionsHandler().requestPermissions();
      }
    });
  }

  clearControllers() {
    titleController.clear();
    descriptionController.clear();
    reviewController.clear();
    pickedImagesList.clear();
  }

  @override
  void onClose() {
    super.onClose();
    clearControllers();
    reviewTxtFieldController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    fetchBuyerOrderStats();
    fetchVendorOrderStats();

    authController.fetchUserCoins();
  }

  submitReviewBtn({OrderItem? orderItem}) async {
    if (reviewFormKey.currentState?.validate() ?? false) {
      isLoading(true);
      JSON data = {
        "text": reviewTxtFieldController.text,
        "rating": rating.value,
        "productId": orderItem!.product!.id,
        "orderItemId": orderItem.id
      };
      await _orderProvider
          .createReview(token: authController.userToken, data: data)
          .then((ApiResponse? apiResponse) {
        print(apiResponse?.message);
        isLoading(false);
        if (apiResponse != null) {
          if (apiResponse.success!) {
            Get.back();
            rating.value = 0;
            reviewTxtFieldController.clear();
            showSnackBar(
                title: langKey.successTitle.tr, message: apiResponse.message);
          } else
            showSnackBar(message: apiResponse.message);
        } else {
          showSnackBar();
        }
      }).catchError((e) {
        isLoading(false);
        print(">>>Dispute $e");
      });
    }
  }

  void showSnackBar({title = 'error', message = "Something went wrong!"}) {
    AppConstant.displaySnackBar(title, message);
  }
}

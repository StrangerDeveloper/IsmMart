import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../helper/permission_handler.dart';

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

  var _orderDetailsModel = OrderModel().obs;
  var _vendorStats = VendorStats().obs;

  OrderModel? get orderDetailsModel => _orderDetailsModel.value;

  VendorStats? get vendorStats => _vendorStats.value;

  CoinsModel? get coinsModel => authController.coinsModel;

  fetchOrderById(orderId) async {
    await _orderProvider
        .getBuyerOrdersDetails(
            token: authController.userToken, orderId: orderId)
        .then((data) {
      _orderDetailsModel(data);
    }).catchError((error) {
      debugPrint(">>>>fetchOrderById: $error");
    });
  }

  fetchVendorOrderById(orderId) async {
    await _orderProvider
        .getVendorOrdersDetails(
            token: authController.userToken, orderId: orderId)
        .then((value) {
      _orderDetailsModel(value);
    }).catchError((error) {
      debugPrint(">>>>fetchVendorOrderById: $error");
    });
  }

  disputeOnOrders({OrderItem? orderItem, orderId}) async {
    isLoading(true);
    String title = titleController.text;
    String description = descriptionController.text;
    final url = "tickets/add";

    var data = {
      'title': '$title',
      "description": "$description",
      "orderItemsId": '${orderItem!.id}',
    };
    var imageList = <http.MultipartFile>[];
    for (var image in pickedImagesList) {
      imageList.add(await http.MultipartFile.fromPath('images', image.path,
          contentType: MediaType.parse('image/jpeg')));
    }

    ApiBaseHelper()
        .postMethodForImage(
            url: url, files: imageList, fields: data, withAuthorization: true)
        .then((parsedJson) {
      isLoading(false);
      ApiResponse? apiResponse = ApiResponse.fromJson(parsedJson);

      if (apiResponse.success!) {
        fetchOrderById(orderId);
        Get.back();
        clearControllers();
        showSnackBar(
            title: langKey.successTitle.tr, message: apiResponse.message);
      } else
        showSnackBar(message: apiResponse.message);
    }).catchError((error) {
      isLoading(false);
      print("Dispute: $error");
      showSnackBar();
    });
  }

  deleteTicket(String ticketId, String orderId) {
    ApiBaseHelper()
        .deleteMethod(url: Urls.deleteTickets + ticketId, withBearer: false)
        .then((parsedJson) {
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
      print(e);
    });
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

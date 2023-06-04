import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:http_parser/src/media_type.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/controllers.dart';
import '../../api_helper/api_base_helper.dart';
import '../../api_helper/global_variables.dart';
import '../../models/product/product_model.dart';
import '../../utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../utils/helpers/permission_handler.dart';
import 'package:http/http.dart' as http;

class UpdateProductViewModel extends GetxController {

  @override
  void onInit() {
    getUserToken();
    super.onInit();
  }

  @override
  void onClose() {
    thumbnailNotAvailable(false);
    thumbnailImageSizeInMb.value = 0.0;
    imagesToDelete.clear();
    imagesToUpdate.clear();
    prodNameController.clear();
    prodStockController.clear();
    prodBrandController.clear();
    prodDiscountController.clear();
    prodSKUController.clear();
    prodPriceController.clear();
    priceAfterCommission(0);
    imagesSize(0.0);
    sellersController.thumbnailImagePath('');
    sellersController.thumbnailImageUrl('');
    super.onClose();
  }

  getUserToken()async{
    GlobalVariable.userModel = await LocalStorageHelper.getStoredUser();
  }

  ProductModel? productModel;
  RxString userToken = ''.obs;
  RxBool thumbnailNotAvailable = false.obs;
  RxDouble thumbnailImageSizeInMb = 0.0.obs;
  List imagesToDelete = [].obs;
  List<File> imagesToUpdate = <File>[].obs;

  var formKey = GlobalKey<FormState>();

  TextEditingController prodNameController = TextEditingController();
  TextEditingController prodStockController = TextEditingController();
  TextEditingController prodBrandController = TextEditingController();
  TextEditingController prodDiscountController = TextEditingController();
  TextEditingController prodDescriptionController = TextEditingController();
  TextEditingController prodSKUController = TextEditingController();
  TextEditingController prodPriceController = TextEditingController();
  RxBool showPriceAfterCommission = false.obs;
  RxInt priceAfterCommission = 0.obs;
  RxString thumbnailUrl = ''.obs;
  var thumbnailPath = ''.obs;
  RxString discountMessage = "".obs;
  RxBool isLoading = false.obs;
  RxInt imageIndex = 0.obs;
  RxDouble imagesSize = 0.0.obs;

  RxList<ProductImages> productImages = <ProductImages>[].obs;

  static var _picker = ImagePicker();

  void setDiscount(int? discount) {
    if (discount! > 0 && discount < 10) {
      discountMessage(langKey.discountMinValue.tr);
    } else if (discount > 90) {
      discountMessage(langKey.discountMaxValue.tr);
    } else {
      discountMessage("");
    }
  }

  getProductById(id) async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: 'products/$id').then((response) {
      if (response['success'] == true && response['data'] != null) {
        GlobalVariable.showLoader.value = false;
        productModel = ProductModel.fromJson(response['data']);
        productImages.clear();
        initializeValues();
      } else {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.errorMsg.tr);
      }
    }).catchError((error) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.errorMsg.tr);
    });
  }

  void initializeValues() {
    if (productModel != null) {
      prodNameController.text = productModel!.name!;
      prodPriceController.text = productModel!.price!.toString();
      prodStockController.text = productModel!.stock!.toString();
      prodDiscountController.text =
      productModel!.discount == 0 ? '' : productModel!.discount!.toString();
      prodDescriptionController.text = productModel!.description!;
      priceAfterCommission(productModel!.price!.toInt());
      thumbnailUrl.value = productModel!.thumbnail.toString();
      if (productModel!.images!.isNotEmpty) {
        productImages.addAll(productModel!.images!);
      }
      imagesToDelete.clear();
      imagesToUpdate.clear();
    }
  }

  void totalTax() {
    var price = int.parse(prodPriceController.text.toString());
    var a = (5 / 100) * price;
    priceAfterCommission.value = priceAfterCommission.value + a.toInt();
  }

  updateProduct({ProductModel? model}) async {
    GlobalVariable.showLoader.value = true;
    model!.name = prodNameController.text;
    model.price = int.parse("${priceAfterCommission.value}");
    model.discount =
    prodDiscountController.text == '' || prodDiscountController.text.isEmpty
        ? 0
        : int.parse(prodDiscountController.text);
    model.description = prodDescriptionController.text;
    model.stock = int.parse("${prodStockController.text}");

    List<int> passedImagesToDelete = [];
    List<File> passedImagesToUpdate = [];

    if (imagesToDelete.isEmpty) {
      passedImagesToDelete = [];
    }
    else {
      imagesToDelete.forEach((element) {
        passedImagesToDelete.add(element);
      });
    }

    if (imagesToUpdate.isEmpty) {
      passedImagesToUpdate = [];
    }
    else {
      imagesToUpdate.forEach((element) {
        passedImagesToUpdate.add(element);
      });
    }

    String baseURL = ApiConstant.baseUrl;
    String endPoint = '$baseURL/vendor/products/update';
    String token = GlobalVariable.userModel!.token.toString();
    print(GlobalVariable.userModel!.token);
    Map<String, String> headers = {
      'authorization': token,
      'Cookie': 'XSRF-token=$token'
    };
    final request = http.MultipartRequest('PATCH', Uri.parse(endPoint));
    request.headers.addAll(headers);

    request.fields.addAll({
      'name': '${model.name}',
      'id': '${model.id}',
      'price': '${model.price}',
      'stock': '${model.stock}',
      'description': '${model.description}',
      if (model.discount != null &&
          model.discount! >= 10 &&
          model.discount! <= 90 || model.discount == 0)
        'discount': '${model.discount}',

      if(imagesToDelete != [])
        for(int i = 0; i<imagesToDelete.length; i++)
          'deleteImages[$i]': "${imagesToDelete[i]}"
    });

    if(thumbnailPath.value == '') {
      null;
    }
    else{
      request.files.add(await http.MultipartFile.fromPath(
        'thumbnail',
        thumbnailPath.toString(),
        contentType: MediaType.parse('image/jpeg'),
      ));
    }

    if(imagesToUpdate != []){
      for(File image in imagesToUpdate){
        request.files.add(await http.MultipartFile.fromPath(
          'addImages',
          image.path,
          contentType: MediaType.parse('image/jpeg'),
        ));
      }
    }

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      GlobalVariable.showLoader.value = false;
      await sellersController.fetchMyProducts();
      Get.back();
      AppConstant.displaySnackBar(langKey.success.tr, data['message']);
    } else {
      GlobalVariable.showLoader.value = false;
      http.StreamedResponse res = await handleStreamResponse(response);
      final data = json.decode(await res.stream.bytesToString());
      AppConstant.displaySnackBar(langKey.errorTitle.tr, data['message']);
    }
  }

  pickThumbnail(ImageSource src) async {
    await PermissionsHandler().checkPermissions().then((isGranted) async {
      if (isGranted) {
        try {
          XFile? thumbnailImage = await _picker.pickImage(source: src);
          if (thumbnailImage!.path != '') {
            await thumbnailImage.length().then((length) async {
              await AppConstant.compressImage(
                  thumbnailImage.path, fileLength: length)
                  .then((compressedFile) {
                var lengthInMb = compressedFile.lengthSync() * 0.000001;
                if (lengthInMb > 2) {
                  AppConstant.displaySnackBar(
                      langKey.errorTitle.tr, '${langKey.fileMustBe.tr} + 2MB');
                }
                else {
                  thumbnailImageSizeInMb.value += lengthInMb;
                  thumbnailPath.value = compressedFile.path;
                  thumbnailNotAvailable(false);
                }
              });
            });
          }
        } on PlatformException {
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, langKey.invalidImageFormat.tr);
        }
      } else {
        await PermissionsHandler().requestPermissions();
      }
    });
    Get.back();
  }

  pickMultipleImages() async {
    await PermissionsHandler().checkPermissions().then((isGranted) async {
      if (isGranted) {
        try {
          List<XFile> images = await _picker.pickMultiImage(imageQuality: 100);
          if (images.isNotEmpty) {
            images.forEach((XFile? file) async {
              await file!.length().then((length) async {
                await AppConstant.compressImage(file.path, fileLength: length)
                    .then((compressedFile) {
                  var lengthInMb = compressedFile.lengthSync() * 0.000001;
                  if (lengthInMb > 2) {
                    AppConstant.displaySnackBar(langKey.errorTitle.tr,
                        '${langKey.fileMustBe.tr} + 2MB');
                  } else {
                    imagesSize.value += lengthInMb;
                    imagesToUpdate.add(compressedFile);
                  }
                });
              });
            });
          }
        } on PlatformException catch (e) {
          print(e);
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            langKey.invalidImageFormat.tr,
          );
        }
      } else {
        await PermissionsHandler().requestPermissions();
      }
    });
  }
}
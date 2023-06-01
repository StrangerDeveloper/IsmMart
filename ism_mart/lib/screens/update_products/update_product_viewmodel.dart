import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/controllers/controllers.dart';
import '../../api_helper/global_variables.dart';
import '../../models/api_response/api_response_model.dart';
import '../../models/product/product_model.dart';
import '../../utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

import '../../utils/helpers/permission_handler.dart';
import '../../widgets/custom_text.dart';

class UpdateProductViewModel extends GetxController{

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
  var thumbnailNotAvailable = false.obs;
  var thumbnailImageSizeInMb = 0.0.obs;
  var imagesToDelete = [].obs;
  var imagesToUpdate = [].obs;

  var prodNameController = TextEditingController();
  var prodStockController = TextEditingController();
  var prodBrandController = TextEditingController();
  var prodDiscountController = TextEditingController();
  var prodDescriptionController = TextEditingController();
  var prodSKUController = TextEditingController();

  var prodPriceController = TextEditingController();
  var priceAfterCommission = 0.obs;
  void totalTax() {
    var price = int.parse(prodPriceController.text.toString());
    var a = (5 / 100) * price;

    priceAfterCommission.value = priceAfterCommission.value + a.toInt();
    // print(" percentage after tax $a   total ${priceAfterCommission.value}");
  }

  var discountMessage = "".obs;

  void setDiscount(int? discount) {
    if (discount! > 0 && discount < 10) {
      discountMessage(langKey.discountMinValue.tr);
    } else if (discount > 90) {
      discountMessage(langKey.discountMaxValue.tr);
    } else {
      discountMessage("");
    }
  }

  updateProduct({ProductModel? model}) async {
    // isLoading(true);
    GlobalVariable.showLoader.value=true;
    model!.name = prodNameController.text;
    model.price = int.parse("${priceAfterCommission.value}");
    model.discount = prodDiscountController.text == '' || prodDiscountController.text.isEmpty ? 0 : int.parse(prodDiscountController.text);
    model.description = prodDescriptionController.text;
    model.stock = int.parse("${prodStockController.text}");

    List<int> passedImagesToDelete = [];
    List<File> passedImagesToUpdate = [];

    if(imagesToDelete.isEmpty){
      passedImagesToDelete = [];
    }
    else{
      imagesToDelete.forEach((element) {
        passedImagesToDelete.add(element);
      });
    }

    if(imagesToUpdate.isEmpty){
      passedImagesToUpdate = [];
    }
    else{
      imagesToUpdate.forEach((element) {
        passedImagesToUpdate.add(element);
      });
    }

    await sellersController.apiProvider
        .updateProduct(
        token: authController.userToken,
        model: model,
        imagesToDelete: passedImagesToDelete,
        imagesToUpdate: passedImagesToUpdate,
      thumbnailImage: sellersController.thumbnailImagePath.value
    ).then((ApiResponse? response) async {
      //isLoading(false);
      GlobalVariable.showLoader.value=false;
      if (response != null) {
        if (response.success!) {
          sellersController.myProductsList.clear();
          await sellersController.fetchMyProducts();
          sellersController.thumbnailImagePath('');
          sellersController.thumbnailImageUrl('');
          imagesToUpdate.clear();
          imagesToDelete.clear();
          Get.back();
          AppConstant.displaySnackBar(
              langKey.success.tr, "${response.message}");
          // clearControllers();
        } else {
          GlobalVariable.showLoader.value=false;
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, "${response.message}");
        }
      } else{
        GlobalVariable.showLoader.value=false;
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.someThingWentWrong.tr);
      }
    }).catchError((e){
      GlobalVariable.showLoader.value=false;
      print(e);
    });
  }

  onError(e) async {
    // isLoading(false);
    print(">>>SellerController: $e");
    // showSnackBar(title: langKey.errorTitle.tr, message: e.toString());
  }

  static var _picker = ImagePicker();

  pickThumbnail(ImageSource src)async{
    await PermissionsHandler().checkPermissions().then((isGranted) async {
      if(isGranted){
        try{
          XFile? thumbnailImage = await _picker.pickImage(source: src);
          if(thumbnailImage!.path != ''){
            await thumbnailImage.length().then((length) async{
              await AppConstant.compressImage(thumbnailImage.path, fileLength: length)
                  .then((compressedFile) {
                var lengthInMb = compressedFile.lengthSync() * 0.000001;
                if(lengthInMb > 2){
                  AppConstant.displaySnackBar(langKey.errorTitle.tr, '${langKey.fileMustBe.tr} + 2MB');
                }
                else{
                  thumbnailImageSizeInMb.value += lengthInMb;
                  sellersController.thumbnailImagePath.value = compressedFile.path;
                  thumbnailNotAvailable(false);
                }
              });
            });
          }
        } on PlatformException{
          AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.invalidImageFormat.tr);
        }
      } else{
        await PermissionsHandler().requestPermissions();
      }
    });
    Get.back();
  }

  var imagesSize = 0.0.obs;

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
                    AppConstant.displaySnackBar(langKey.errorTitle.tr, '${langKey.fileMustBe.tr} + 2MB');
                  } else {
                    imagesSize.value += lengthInMb;
                    imagesToUpdate.add(compressedFile);
                  }
                });
              });
            });
  //          Get.back();
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

  pickImage({calledForThumbnail = true}) {
    Get.defaultDialog(
      title: langKey.pickFrom.tr,
      contentPadding: const EdgeInsets.all(10),
      titleStyle: appBarTitleSize,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _imageBtn(
            onTap: () => pickThumbnail(ImageSource.camera),
            title: langKey.camera.tr,
            icon: Icons.camera_alt_rounded,
            color: Colors.blue,
          ),
          _imageBtn(
            onTap: () => pickThumbnail(ImageSource.gallery),
            title: langKey.gallery.tr,
            icon: Icons.photo_library_rounded,
            color: Colors.redAccent,
          ),
        ],
      ),
      //onCancel: ()=>Get.back()
    );
  }

  static Widget _imageBtn({onTap, icon, title, color}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          AppConstant.spaceWidget(height: 10),
          CustomText(
            title: title,
            color: color,
          )
        ],
      ),
    );
  }

}
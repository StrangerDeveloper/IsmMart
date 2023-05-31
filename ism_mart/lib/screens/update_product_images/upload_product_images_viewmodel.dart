import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../models/api_response/api_response_model.dart';
import '../../models/product/product_model.dart';
import '../../utils/helpers/permission_handler.dart';
import '../../widgets/custom_text.dart';

class UpdateProductImagesViewModel extends GetxController {
  UpdateProductImagesViewModel({this.id});
  final int? id;
  // final List<ProductImages>? imagesList;

  // @override
  // void onInit() {
  //   ProductController productController = Get.find();
  //   // productController.fetchProduct()
  //   super.onInit();
  // }

  var thumbnailImageSizeInMb = 0.0.obs;
  var imagesListForUI = <ProductImages>[].obs;
  var imagesToDelete = [].obs;
  var imagesToUpdate = [].obs;

  createLists(List<ProductImages>? imagesList) {
    imagesListForUI.clear();
    for (int i = 0; i <= imagesList!.length - 1; i++) {
      imagesListForUI.add(imagesList[i]);
    }
    imagesListForUI.refresh();
  }

  static var _picker = ImagePicker();
  pickThumbnail(ImageSource src) async {
    await PermissionsHandler().checkPermissions().then((isGranted) async {
      if (isGranted) {
        try {
          XFile? thumbnailImage = await _picker.pickImage(source: src);
          if (thumbnailImage!.path != '') {
            await thumbnailImage.length().then((length) async {
              await AppConstant.compressImage(thumbnailImage.path,
                      fileLength: length)
                  .then((compressedFile) {
                var lengthInMb = compressedFile.lengthSync() * 0.000001;
                if (lengthInMb > 2) {
                  AppConstant.displaySnackBar(
                      langKey.errorTitle.tr, '${langKey.fileMustBe.tr} + 2MB');
                } else {
                  thumbnailImageSizeInMb.value += lengthInMb;
                  imagesToUpdate.add(compressedFile);
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

  fetchProduct(int? productID) async {
    var request = http.Request('GET',
        Uri.parse('https://ismmart-backend.com/api/products/$productID'));

    http.StreamedResponse response = await request.send();

    var data = await http.Response.fromStream(response);
    var res = jsonDecode(data.body);

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(res);
    }
  }
}

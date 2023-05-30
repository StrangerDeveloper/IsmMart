import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:flutter/material.dart';
import '../../models/product/product_model.dart';
import '../../utils/helpers/permission_handler.dart';
import '../../widgets/custom_text.dart';

class UpdateProductImagesViewModel extends GetxController {
  UpdateProductImagesViewModel();

  // final List<ProductImages>? imagesList;

  @override
  void onInit() {
    //ProductController productController = Get.find();
    // productController.fetchProduct()
    super.onInit();
  }

  var thumbnailImageSizeInMb = 0.0.obs;
  var thumbnailURl = ''.obs;
  var thumbnailID = 0.obs;
  var thumbnailPath = <File>[].obs;
  var imagesListForUI = [].obs;

  createLists(List<ProductImages>? imagesList) {
    thumbnailURl.value = imagesList![0].url.toString();
    thumbnailID.value = imagesList[0].id!;

    for (int i = 1; i <= imagesList.length; i++) {
      imagesListForUI.add(imagesList[i]);
      imagesListForUI.refresh();
    }
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
                  thumbnailPath.add(compressedFile);
                }
              });
            });
          }
        } on PlatformException catch (e) {
          print("PlatformExcetion: $e");
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
}

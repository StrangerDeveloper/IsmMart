import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/widgets/single_order_details_ui.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class PickImage {
  File? selectedImage;

  Future<File?> actionsBottomSheet() async {
    await showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      langKey.pickImage,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              Divider(),
              BottomSheetItemRow(
                title: langKey.gallery,
                icon: IconlyLight.image,
                isDisabled: false,
                onTap: () async {
                  selectedImage = await imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              BottomSheetItemRow(
                title: langKey.camera,
                icon: IconlyLight.camera,
                isDisabled: false,
                onTap: () async {
                  selectedImage = await imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
    return selectedImage;
  }

  Future<File?> imgFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      print('object');
      print(await compressImage(file));
      return await compressImage(file);
    }
  }

  Future<File?> imgFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      var a = await compressImage(file);
      return await compressImage(file);
    }
  }

  Future<File?> compressImage(File image) async {
    File? file = await AppConstant.compressImage(image.path,
        fileLength: await image.length());

    var lengthInMb = await file.lengthSync() * 0.000001;
    if (lengthInMb > 2) {
      AppConstant.displaySnackBar(
          langKey.errorTitle.tr, langKey.imageSizeDesc.tr + ' 2MB');
      return null;
    }
    return file;
  }
}

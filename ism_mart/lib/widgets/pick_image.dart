import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/single_order_details_ui.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class PickImage {
  File? selectedImage;

  //////////////////////////////////////////////////////////////////
  ////////////////////////// Single Image //////////////////////////
  //////////////////////////////////////////////////////////////////

  Future<File?> pickSingleImage() async {
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
                      langKey.pickImage.tr,
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
                title: langKey.gallery.tr,
                icon: IconlyLight.image,
                isDisabled: false,
                onTap: () async {
                  selectedImage = await imgFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              BottomSheetItemRow(
                title: langKey.camera.tr,
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
      return await compressSingleImage(pickedFile);
    }
    return null;
  }

  Future<File?> imgFromGallery() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return await compressSingleImage(pickedFile);
    }
    return null;
  }

  Future<File?> compressSingleImage(XFile image) async {
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/$timeStamp.jpg';

    final result =
        await FlutterImageCompress.compressAndGetFile(image.path, targetPath,
            minHeight: 1080, //you can play with this to reduce siz
            minWidth: 1080,
            quality: 100);

    double length = await checkImageSize(result!);

    if (length > 2) {
      AppConstant.displaySnackBar(
          langKey.errorTitle.tr, langKey.imageSizeDesc.tr + ' 2MB');
      return null;
    }

    File file = File(result.path);
    return file;
  }

  //////////////////////////////////////////////////////////////////
  ////////////////////// / Multiple Image //////////////////////////
  //////////////////////////////////////////////////////////////////

  List<File> imageList = <File>[];

  Future<List<File>> pickMultipleImage() async {
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
                      langKey.pickImage.tr,
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
                title: langKey.gallery.tr,
                icon: IconlyLight.image,
                isDisabled: false,
                onTap: () async {
                  imageList.addAll(await multipleImgFromGallery());
                  Navigator.of(context).pop();
                },
              ),
              BottomSheetItemRow(
                title: langKey.camera.tr,
                icon: IconlyLight.camera,
                isDisabled: false,
                onTap: () async {
                  selectedImage = await imgFromCamera();
                  if (selectedImage != null) {
                    imageList.add(selectedImage!);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
    return imageList;
  }

  Future<List<File>> multipleImgFromGallery() async {
    List<XFile> pickedFile = await ImagePicker().pickMultiImage();

    if (pickedFile.isNotEmpty) {
      return await compressMultipleImage(pickedFile);
    } else {
      return [];
    }
  }

  Future<List<File>> compressMultipleImage(List<XFile> images) async {
    List<File> tempList = <File>[];
    if (images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
        final dir = await path_provider.getTemporaryDirectory();
        final targetPath = '${dir.absolute.path}/$timeStamp.jpg';

        final result = await FlutterImageCompress.compressAndGetFile(
          images[i].path, targetPath,
          minHeight: 1080, //you can play with this to reduce siz
          minWidth: 1080,
          quality: 100,
        );

        double length = await checkImageSize(result!);

        if (length > 2) {
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, langKey.imageSizeDesc.tr + ' 2MB');
        } else {
          File file = File(result.path);
          tempList.add(file);
        }
      }

      return tempList;
    } else {
      return [];
    }
  }

  Future<double> checkImageSize(XFile file) async {
    final data = await file.readAsBytes();
    final newKb = data.length / 1024;
    final newMb = newKb / 1024;
    print('IMAGE SIZE : $newMb');
    return newMb;
  }
}

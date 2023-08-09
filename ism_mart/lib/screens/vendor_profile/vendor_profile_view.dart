import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/vendor_profile/vendor_profile_viewmodel.dart';

class VendorProfileView extends StatelessWidget {
  VendorProfileView({Key? key}) : super(key: key);
  final VendorProfileViewModel viewModel = Get.put(VendorProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 190,
                child: Stack(
                  children: [
                    coverImage(),
                    profileImage(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomTextBtn(
                width: Get.width * 0.5,
                onPressed: () {
                  Get.toNamed(Routes.updateVendor,
                      arguments: {'isRegisterScreen': false});
                },
                title: langKey.updateBtn.tr,
              ),
              storeInfo(),
              bankDetail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget coverImage() {
    return Obx(
      () => CachedNetworkImage(
        height: 140,
        width: double.infinity,
        imageUrl: viewModel.userModel.value?.vendor?.coverImage ?? '',
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: AssetImage('assets/images/no_image_found.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 0.5),
          );
        },
      ),
    );
  }

  Widget profileImage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(3.5),
        child: Obx(
          () => CachedNetworkImage(
            height: 95,
            width: 95,
            imageUrl: viewModel.userModel.value?.vendor?.storeImage ?? '',
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/no_image_found.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 0.5),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget storeInfo() {
    return containerDecoration(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          containerTitleItem(langKey.storeInfo.tr),
          Divider(height: 30),
          titleItem(langKey.storeName.tr),
          Obx(
            () => valueItem(
              viewModel.userModel.value?.vendor?.storeName ?? 'N/A',
            ),
          ),
          titleItem(langKey.phone.tr),
          Obx(
            () => valueItem(
              viewModel.userModel.value?.vendor?.phone ?? 'N/A',
            ),
          ),
          titleItem(langKey.description.tr),
          Obx(
            () => valueItem(
              viewModel.userModel.value?.vendor?.storeDesc ?? 'N/A',
            ),
          ),
          titleItem(langKey.city.tr),
          Obx(
            () => valueItem(
              viewModel.userModel.value?.city?.name ?? 'N/A',
            ),
          ),
        ],
      ),
    );
  }

  Widget bankDetail() {
    return containerDecoration(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          containerTitleItem(langKey.bankDetails.tr),
          Divider(height: 30),
          titleItem(langKey.bankName.tr),
          Obx(
            () => valueItem(
              viewModel.userModel.value?.vendor?.bankName ?? 'N/A',
            ),
          ),
          titleItem(langKey.bankAccountHolder.tr),
          Obx(
            () => valueItem(
              viewModel.userModel.value?.vendor?.accountTitle ?? 'N/A',
            ),
          ),
          titleItem(langKey.branchCode.tr),
          Obx(
            () => valueItem(
              viewModel.userModel.value?.vendor?.accountNumber ?? 'N/A',
            ),
          ),
        ],
      ),
    );
  }

  Widget containerTitleItem(String value) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        value,
        style: GoogleFonts.lato(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget titleItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Text(
        value,
        style: GoogleFonts.lato(
          fontSize: 13,
        ),
      ),
    );
  }

  Widget valueItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        value,
        style: GoogleFonts.lato(
          fontSize: 15.5,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget containerDecoration({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black.withOpacity(0.08),
        ),
      ),
      child: child,
    );
  }
}

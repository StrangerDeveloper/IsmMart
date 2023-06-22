import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/buyer_profile/buyer_profile_viewmodel.dart';
import 'package:ism_mart/widgets/loader_view.dart';

import '../../helper/no_internet_view.dart';
import '../../widgets/custom_appbar.dart';

class BuyerProfileView extends StatelessWidget {
  BuyerProfileView({Key? key}) : super(key: key);
  final BuyerProfileViewModel viewModel = Get.put(BuyerProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: langKey.profile.tr),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  profileImage(),
                  storeInfo(),
                  buttons(),
                ],
              ),
            ),
            NoInternetView(
              onPressed: () {
                viewModel.getData();
              },
            ),
            LoaderView(),
          ],
        ),
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
            imageUrl: viewModel.buyerProfileModel.value.image ?? '',
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
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: containerDecoration(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            containerTitleItem(langKey.personalInfo.tr),
            Divider(height: 30),
            titleItem(langKey.firstName.tr),
            Obx(
              () => valueItem(
                viewModel.buyerProfileModel.value.firstName ?? 'N/A',
              ),
            ),
            titleItem(langKey.lastName.tr),
            Obx(
              () => valueItem(
                viewModel.buyerProfileModel.value.lastName ?? 'N/A',
              ),
            ),
            titleItem(langKey.phone.tr),
            Obx(
              () => valueItem(
                viewModel.buyerProfileModel.value.phone ?? 'N/A',
              ),
            ),
            titleItem(langKey.address.tr),
            Obx(
              () => valueItem(
                viewModel.buyerProfileModel.value.address ?? 'N/A',
              ),
            ),
          ],
        ),
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

  Widget buttons() {
    return Row(
      children: [
        Expanded(
          child: CustomTextBtn(
            backgroundColor: Colors.red.shade700,
            onPressed: () {
              showDeleteQuestionDialog();
            },
            child: Text(langKey.deactivateBtn.tr),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: CustomTextBtn(
            onPressed: () {
              Get.toNamed(Routes.updateBuyerProfile,
                  arguments: {'model': viewModel.buyerProfileModel.value});
            },
            child: Text(langKey.updateProfile.tr),
          ),
        ),
      ],
    );
  }

  Future showDeleteQuestionDialog() async {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(langKey.deactivateBtn.tr),
          content: Text(langKey.deActivateMsg.tr),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: Text(
                      langKey.noBtn.tr,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: Text(
                      langKey.yesBtn.tr,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(Get.context!).pop();
                      viewModel.deleteAccount();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/screens/buyer_profile/buyer_profile_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/pick_image.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class BuyerProfileView extends StatelessWidget {
  BuyerProfileView({Key? key}) : super(key: key);
  final BuyerProfileViewModel viewModel = Get.put(BuyerProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Form(
              key: viewModel.buyerProfileFormKey,
              child: Column(
                children: [
                  profileImage(),
                  firstNameTextField(),
                  lastNameTextField(),
                  phoneTextField(),
                  addressTextField(),
                  SizedBox(height: 25),
                  updateBtn(),
                ],
              ),
            ),
          ),
          NoInternetView(
            onPressed: () {
              viewModel.getData();
              viewModel.updateData();
            },
          ),
          LoaderView(),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(title: profile.tr, style: appBarTitleSize),
    );
  }

  Widget profileImage() {
    print(viewModel.imageFile.value?.path);
    print(viewModel.buyerProfileNewModel.value.image);
    return Stack(
      children: [
        Obx(
          () => (viewModel.imageFile.value?.path != "")
              ? Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(viewModel.imageFile.value!),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  height: 100,
                  width: 100,
                  imageUrl: viewModel.buyerProfileNewModel.value.image ?? '',
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
        Positioned(
          right: 10,
          bottom: 6,
          child: InkWell(
            onTap: () async {
              viewModel.imageFile.value = await PickImage().pickSingleImage();
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 13,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget firstNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20),
      child: CustomTextField2(
        label: langKey.firstName.tr,
        controller: viewModel.firstNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateName(value);
        },
      ),
    );
  }

  Widget lastNameTextField() {
    return CustomTextField2(
      label: langKey.lastName.tr,
      controller: viewModel.lastNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateName(value);
      },
    );
  }

  Widget phoneTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField2(
        label: langKey.phone.tr,
        controller: viewModel.phoneController,
        keyboardType: TextInputType.phone,
        inputFormatters: Validator().phoneNumberFormatter,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validatePhoneNumber(value);
        },
      ),
    );
  }

  Widget addressTextField() {
    return CustomTextField2(
      label: langKey.address.tr,
      controller: viewModel.addressController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateDefaultTxtField(value);
      },
    );
  }

  Widget updateBtn() {
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
              viewModel.updateData();
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
          title: Text(deactivateBtn.tr),
          content: Text(deActivateMsg.tr),
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
                      noBtn.tr,
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
                      yesBtn.tr,
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

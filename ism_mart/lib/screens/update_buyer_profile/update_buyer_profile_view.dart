import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/screens/update_buyer_profile/update_buyer_profile_viewmodel.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/pick_image.dart';

import '../../helper/validator.dart';

class UpdateBuyerProfileView extends StatelessWidget {
  UpdateBuyerProfileView({Key? key}) : super(key: key);
  final UpdateBuyerProfileViewModel viewModel =
      Get.put(UpdateBuyerProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: langKey.profile.tr,
      ),
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
              // viewModel.getData();
              viewModel.updateData();
            },
          ),
          LoaderView(),
        ],
      ),
    );
  }

  Widget profileImage() {
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
    return CustomTextBtn(
      onPressed: () {
        viewModel.updateData();
      },
      child: Text(langKey.updateProfile.tr),
    );
  }
}
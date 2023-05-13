import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class RegisterVendorUI extends GetView<AuthController> {
  const RegisterVendorUI({
    Key? key,
    // this.isCalledForUpdate,
    this.model,
  }) : super(key: key);

  // final bool? isCalledForUpdate;
  final SellerModel? model;

  @override
  Widget build(BuildContext context) {
    if (model != null) {
      controller.storeNameController.text = model?.storeName ?? "";
      controller.storeDescController.text = model?.storeDesc ?? "";
      controller.phoneController.text = model?.phone ?? "";
      controller.bankNameController.text = model?.bankName ?? "";
      controller.bankAccController.text = model?.accountNumber ?? "";
      controller.bankHolderTitleController.text = model?.accountTitle ?? "";
      controller.ownerNameController.text = model?.ownerName ?? "";
    }

    return Scaffold(
      body: SafeArea(
          child: ListView(
        shrinkWrap: true,
        children: [
          AppConstant.spaceWidget(height: AppConstant.getSize().height * 0.045),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: model != null
                      ? langKey.updateVendorDetails.tr
                      : langKey.vendorRegistration.tr,
                  style: headline2,
                ),
                CustomActionIcon(
                  onTap: () => Get.back(),
                  hasShadow: false,
                  icon: Icons.close_rounded,
                  bgColor: kPrimaryColor.withOpacity(0.2),
                  iconColor: kPrimaryColor,
                ),
              ],
            ),
          ),

          ///background and profile
          SizedBox(
            height: AppConstant.getSize().height * 0.2,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => _pickImage(calledForProfile: false),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: AppConstant.getSize().width * 0.95,
                      // alignment: Alignment.center,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Obx(
                          () => (controller.coverImgPath.value.isEmpty &&
                                  model?.coverImage != null)
                              ? Center(
                                  child: CustomNetworkImage(
                                    imageUrl: model!.coverImage!,
                                    fit: BoxFit.fill,
                                    width: AppConstant.getSize().width,
                                  ),
                                )
                              : (controller.coverImgPath.value.isNotEmpty
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Image.file(
                                        File(controller.coverImgPath.value),
                                      ),
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.cloud_upload_rounded,
                                            size: 30,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            langKey.clickHereToUpload.tr,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: InkWell(
                    onTap: () => _pickImage(calledForProfile: false),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.add_a_photo, color: kPrimaryColor),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 0),
                            color: kPrimaryColor.withOpacity(0.3),
                            blurRadius: 10.78,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.22),
                                offset: Offset(0, 0),
                                blurRadius: 10.78,
                              ),
                            ],
                          ),
                          child: Obx(
                            () => (controller.profileImgPath.value.isEmpty &&
                                    model?.storeImage != null)
                                ? profileImage(
                                    model!.storeImage!,
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: controller
                                            .profileImgPath.value.isNotEmpty
                                        ? FileImage(
                                            File(controller
                                                .profileImgPath.value),
                                          )
                                        : null,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: InkWell(
                            onTap: () => _pickImage(),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.add_a_photo,
                                    color: kPrimaryColor),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      color: kPrimaryColor.withOpacity(0.3),
                                      blurRadius: 10.78,
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: CustomText(title: "${langKey.yourCoverAndProfile} 2 MB"),
          ),
          _formData()
        ],
      )),
    );
  }

  Widget profileImage(String url) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: url,
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
    );
  }

  void _pickImage({calledForProfile = true}) {
    Get.defaultDialog(
      title: langKey.pickFrom,
      contentPadding: const EdgeInsets.all(10),
      titleStyle: appBarTitleSize,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _imageBtn(
            onTap: () => controller.pickOrCaptureImageGallery(0,
                calledForProfile: calledForProfile),
            title: langKey.camera.tr,
            icon: Icons.camera_alt_rounded,
            color: Colors.blue,
          ),
          _imageBtn(
            onTap: () => controller.pickOrCaptureImageGallery(
              1,
              calledForProfile: calledForProfile,
            ),
            title: langKey.gallery.tr,
            icon: Icons.photo_library_rounded,
            color: Colors.redAccent,
          ),
        ],
      ),
      //onCancel: ()=>Get.back()
    );
  }

  Widget _imageBtn({onTap, icon, title, color}) {
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

  Widget _formData() {
    var formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            FormInputFieldWithIcon(
              controller: controller.ownerNameController,
              iconPrefix: Icons.store_rounded,
              labelText: langKey.ownerName.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? langKey.ownerNameReq.tr : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 15),
            FormInputFieldWithIcon(
              controller: controller.storeNameController,
              iconPrefix: Icons.store_rounded,
              labelText: langKey.storeName.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? langKey.storeNameReq.tr : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 15),
            FormInputFieldWithIcon(
              controller: controller.phoneController,
              iconPrefix: Icons.phone_iphone_rounded,
              labelText: langKey.phone.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  !GetUtils.isPhoneNumber(value!) ? langKey.phoneReq.tr : null,
              keyboardType: TextInputType.phone,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 15),
            FormInputFieldWithIcon(
              controller: controller.storeDescController,
              iconPrefix: Icons.description,
              labelText: langKey.description.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? langKey.descriptionReq.tr : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 15),
            FormInputFieldWithIcon(
              controller: controller.bankNameController,
              iconPrefix: Icons.account_balance_rounded,
              labelText: langKey.bankName.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? langKey.bankNameReq.tr : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 15),
            FormInputFieldWithIcon(
              controller: controller.bankHolderTitleController,
              iconPrefix: Icons.person_rounded,
              labelText: langKey.bankAccountHolder.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => GetUtils.isBlank(value!)!
                  ? langKey.bankAccHolderReq.tr
                  : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 15),
            FormInputFieldWithIcon(
              controller: controller.bankAccController,
              iconPrefix: Icons.account_balance_wallet_rounded,
              labelText: langKey.bankAccount.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? langKey.bankAccountReq.tr : null,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 40),
            Obx(
              () => controller.isLoading.isTrue
                  ? CustomLoading(isItBtn: true)
                  : CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await controller.registerStore();
                        }
                      },
                      text: model != null
                          ? langKey.updateBtn.tr
                          : langKey.register.tr,
                      height: 40,
                      width: 150,
                    ),
            ),
            AppConstant.spaceWidget(height: 10),
          ],
        ),
      ),
    );
  }
}

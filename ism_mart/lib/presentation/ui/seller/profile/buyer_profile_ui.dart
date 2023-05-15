import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

import '../../../../controllers/buyer/image_controller.dart';

class ProfileUI extends GetView<AuthController> {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(
        "image is m0del => ${controller.userModel!.imageUrl} \n image controller ${controller.profileImgPath.value}");
    return Obx(
      () => SafeArea(
        child: controller.isLoading.isTrue
            ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
            : CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        CustomHeader(title: langKey.profile.tr),
                        _body(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _body() {
    //  var field = {'field': 'firstName', 'field': 'lastName'};
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ///Personal Information
          CustomGreyBorderContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // Stack(
                  //   children: [
                  //     Container(
                  //       height: 90,
                  //       width: 90,
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(50),
                  //         color: Colors.white,
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: kPrimaryColor.withOpacity(0.22),
                  //             offset: Offset(0, 0),
                  //             blurRadius: 10.78,
                  //           ),
                  //         ],
                  //       ),
                  //       child:
                  //        Obx(() => controller.profileImgPath.value == ''
                  //           ? CircleAvatar(
                  //               radius: 40,
                  //               backgroundColor: Colors.grey[200],
                  //               backgroundImage: NetworkImage(
                  //                   controller.userModel!.imageUrl.toString()))
                  //           : CircleAvatar(
                  //               radius: 40,
                  //               backgroundColor: Colors.grey[200],
                  //               backgroundImage: FileImage(
                  //                   File(controller.profileImgPath.value)))),
                  //     ),
                  //     Positioned(
                  //       bottom: 1,
                  //       right: 1,
                  //       child: InkWell(
                  //         onTap: () {
                  //           _pickImage();
                  //         },
                  //         child: Container(
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(2.0),
                  //             child:
                  //                 Icon(Icons.add_a_photo, color: kPrimaryColor),
                  //           ),
                  //           decoration: BoxDecoration(
                  //               border: Border.all(
                  //                 width: 3,
                  //                 color: Colors.white,
                  //               ),
                  //               borderRadius: BorderRadius.all(
                  //                 Radius.circular(50),
                  //               ),
                  //               color: Colors.white,
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   offset: Offset(0, 0),
                  //                   color: kPrimaryColor.withOpacity(0.3),
                  //                   blurRadius: 10.78,
                  //                 ),
                  //               ]),
                  //         ),
                  //       ),
                  //     ),

                  //   ],
                  // ),

                  StickyLabel(text: langKey.personalInfo.tr),
                  //Profile data
                  Obx(
                    () => Column(
                      children: controller.getProfileData().map((profile) {
                        print("map is $profile");
                        return profileCards(
                            profile["title"],
                            profile["subtitle"],
                            profile["icon"],
                            profile['field']);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppConstant.spaceWidget(height: 40),

          ///delete account button

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => controller.isLoading.isTrue
                    ? CustomLoading(
                        isItBtn: true,
                      )
                    : InkWell(
                        onTap: () => showConfirmDeleteDialog(
                            userModel: controller.userModel!),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            //color: kRedColor,
                            borderRadius: BorderRadius.circular(8),
                            //border: Border.all(color: kRedColor),
                            boxShadow: [
                              BoxShadow(
                                color: kRedColor,
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              )
                            ],
                          ),
                          child: CustomText(
                            title: langKey.deactivateBtn.tr,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget profileCards(String title, subtitle, icon, field) {
    return (title.toLowerCase().contains("country") ||
            title.toLowerCase().contains("city"))
        ? SizedBox()
        : Container(
            width: 320,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kPrimaryColor.withOpacity(0.7)),
            ),
            margin: EdgeInsets.only(left: 8, top: 12, right: 8, bottom: 3),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
              title: CustomText(
                title: title,
                color: Colors.black54,
                weight: FontWeight.w600,
              ),
              subtitle: CustomText(
                title: subtitle,
                style: bodyText1,
              ),
              leading: Icon(icon),
              trailing: InkWell(
                onTap: () => showEditDialog(title, subtitle, field),
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: kPrimaryColor.withOpacity(0.8),
                ),
              ),
            ),
          );
  }

  void showEditDialog(title, subtitle, field) {
    controller.editingTextController.text = subtitle;
    var _formKey = GlobalKey<FormState>();
    Get.defaultDialog(
      title: "${langKey.updateBtn} $title",
      titleStyle: appBarTitleSize,
      contentPadding: const EdgeInsets.all(20),
      content: Form(
        key: _formKey,
        child: FormInputFieldWithIcon(
          controller: controller.editingTextController,
          iconPrefix: Icons.title,
          labelText: title,
          autofocus: false,
          iconColor: kPrimaryColor,
          textStyle: bodyText1,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (title.toString().toLowerCase() == "phone")
              return Validator().phone(value);
            return GetUtils.isBlank(value!)!
                ? langKey.titleReq.trParams({"title": "$title"})
                : null;
          },
          keyboardType: title.toString().toLowerCase() == "phone"
              ? TextInputType.phone
              : TextInputType.text,
          onChanged: (value) => null,
          onSaved: (value) => null,
        ),
      ),
      confirm: Obx(
        () => controller.isLoading.isTrue
            ? CustomLoading(isItBtn: true)
            : CustomButton(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await controller.updateUser(
                        title: title,
                        value: controller.editingTextController.text,
                        field: field);
                    controller.login();
                    var imgController = Get.put(ImageController());

                    // await imgController.updateUser(
                    //   field: field,
                    //   title: title,
                    // );

                    //Get.back();
                  }
                },
                text: langKey.updateBtn.tr,
                height: 40,
                width: 200,
              ),
      ),
    );
  }

  void showConfirmDeleteDialog({UserModel? userModel}) {
    Get.defaultDialog(
      title: langKey.deleteBtn.tr,
      titleStyle: appBarTitleSize,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomText(
              title: langKey.deActivateMsg.tr,
              weight: FontWeight.w600,
            ),
            AppConstant.spaceWidget(height: 10),
            buildConfirmDeleteIcon(),
            AppConstant.spaceWidget(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  text: langKey.noBtn.tr,
                  width: 100,
                  height: 35,
                  color: kRedColor,
                ),
                CustomButton(
                  onTap: () {
                    Get.back();
                    controller.deActivateAccount();
                  },
                  text: langKey.yesBtn.tr,
                  width: 100,
                  height: 35,
                  color: kRedColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

//image picker

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
}

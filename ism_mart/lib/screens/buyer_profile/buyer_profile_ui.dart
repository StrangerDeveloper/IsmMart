import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class ProfileUI extends GetView<AuthController> {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              AppConstant.spaceWidget(height: 50),

              ///Personal Information
              CustomGreyBorderContainer(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AppConstant.spaceWidget(height: 30),
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
                            onTap: () => AppConstant.showConfirmDeleteDialog(
                              ontap: () => controller.deActivateAccount(),
                              passedBodyLangKey: langKey.deActivateMsg.tr,
                              givenFontSize: 18
                            ),
                            child: Container(
                              width: 150,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
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
          Align(alignment: Alignment.center, child: _profileCircularImage()),
        ],
      ),
    );
  }

  Widget _profileCircularImage() {
    return Stack(
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
            () => CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[200],
              backgroundImage:
                  NetworkImage(controller.userModel!.imageUrl.toString()),
            ),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: InkWell(
            onTap: () {
              AppConstant.pickImage(
                  calledForProfile: true, calledBuyerProfile: true);
            },
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
                  ]),
            ),
          ),
        ),
      ],
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
      title: "${langKey.updateBtn.tr} $title",
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
          inputFormatters: [
            if (title == "phone")
              FilteringTextInputFormatter.allow(RegExp(r'^(?:[+])?\d*'))
          ],
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (title == "First Name" || title == "Last Name") {
              return Validator().name(value, title: title);
            } else if (title.toString().toLowerCase() == "phone")
              return Validator().validatePhoneNumber(value);
            return GetUtils.isBlank(value!)! ? "$title is required" : null;
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
                    Get.back();
                    await controller.updateUser(
                        title: title,
                        value: controller.editingTextController.text,
                        field: field);
                    _formKey.currentState!.reset();
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
                  color: kPrimaryColor,
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
}

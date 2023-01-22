import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
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
                      delegate: SliverChildListDelegate([
                    CustomHeader(
                      title: langKey.profile.tr,
                    ),
                    _body(),
                  ])),
                ],
              ),
      ),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          StickyLabel(text: langKey.personalInfo.tr),
          AppConstant.spaceWidget(height: 10),
          CustomGreyBorderContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ///Profile
                  /*Stack(
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
                            backgroundImage: NetworkImage(
                                controller.userModel!.imageUrl ??
                                    AppConstant.defaultImgUrl),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: InkWell(
                          onTap: () {
                              Get.defaultDialog(
                              title: "Choose Profile Avatar",
                              titleStyle: AppThemes.dialogTitleHeader
                                  .copyWith(color: AppThemes.DEEP_ORANGE),
                              content: _profileIconsContent(),
                              //confirm: _btnSCameraAndGallery(),
                            );
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child:
                                  Icon(Icons.add_a_photo, color: kPrimaryColor),
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
                  ),*/

                  //Profile data
                  Column(
                    children: controller
                        .getProfileData()
                        .map(
                          (profile) => profileCards(profile["title"],
                              profile["subtitle"], profile["icon"]),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileCards(String title, subtitle, icon) {
    return Container(
      width: 290,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kPrimaryColor.withOpacity(0.7)),
      ),
      margin: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 3),
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
          onTap: () => showEditDialog(title, subtitle),
          child: Icon(
            Icons.edit,
            size: 20,
            color: kPrimaryColor.withOpacity(0.8),
          ),
        ),
      ),
    );
  }

  void showEditDialog(title, subtitle) {
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
              return !GetUtils.isPhoneNumber(value!)
                  ? langKey.phoneReq.tr
                  : null;
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
                        value: controller.editingTextController.text);
                  }
                },
                text: langKey.updateBtn.tr,
                height: 40,
                width: 200,
              ),
      ),
    );
  }
}

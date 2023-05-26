import 'package:flutter/material.dart';
import 'package:ism_mart/api_helper/local_storage/local_storage_helper.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/widgets/form_input_field_with_icon.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_button.dart';

class EmailVerificationView extends GetView<AuthController> {
  EmailVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                langKey.emailVerification.tr,
                style: headline1.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10),
              Text(
                langKey.emailVerificationLink.tr,
                style: bodyText2Poppins.copyWith(
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 40),
              Text(
                langKey.enterEmail.tr,
                style: headline2,
              ),
              emailTextField(),
              buttons(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          controller.clearLoginController();
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      child: Form(
        key: controller.emailVerificationFormKey,
        child: FormInputFieldWithIcon(
          controller: controller.emailController,
          iconPrefix: Icons.email,
          labelText: langKey.email.tr,
          iconColor: kPrimaryColor,
          autofocus: false,
          textStyle: bodyText1,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return langKey.emailReq.tr;
            } else
              return !GetUtils.isEmail(value) ? langKey.emailReq.tr : null;
          },
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {},
          onSaved: (value) {},
        ),
      ),
    );
  }

  Widget buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomButton(
            onTap: () {
              Get.back();
            },
            text: langKey.cancelBtn.tr,
            height: 40,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: CustomButton(
            onTap: () async {
              if (controller.emailVerificationFormKey.currentState!.validate()) {
                await controller.resendEmailVerificationLink();
                await LocalStorageHelper.storeEmailVerificationDetails();
              }
            },
            text: langKey.send.tr,
            height: 40,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}

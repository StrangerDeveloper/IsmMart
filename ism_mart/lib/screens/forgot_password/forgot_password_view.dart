import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({Key? key, this.email}) : super(key: key);
  final String? email;

  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordEmailController.text = email.toString();
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                langKey.forgotPassword.tr,
                style: headline1.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10),
              Text(
                langKey.forgotPasswordDesc.tr,
                style: bodyText2Poppins.copyWith(
                  fontSize: 13,
                ),
              ),
              //header(),
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
          controller.clearForgotPasswordControllers();
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
        key: controller.forgotPasswordFormKey,
        child: FormInputFieldWithIcon(
          controller: controller.forgotPasswordEmailController,
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
              return !GetUtils.isEmail(value) ? langKey.invalidEmail.tr : null;
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Expanded(
        //   child: CustomButton(
        //     onTap: () {
        //       Get.back();
        //     },
        //     text: langKey.cancelBtn.tr,
        //     height: 40,
        //     color: kPrimaryColor,
        //   ),
        // ),
        // SizedBox(width: 15),

        Obx(
          () => controller.isLoading.isTrue
              ? CustomLoading(isItBtn: true)
              : CustomButton(
                  onTap: () async {
                    if (controller.forgotPasswordFormKey.currentState!
                        .validate()) {
                      await controller.forgotPasswordWithEmail();
                    }
                  },
                  text: langKey.send.tr,
                  width: 200,
                  height: 40,
                  color: kPrimaryColor,
                ),
        )
      ],
    );
  }
}

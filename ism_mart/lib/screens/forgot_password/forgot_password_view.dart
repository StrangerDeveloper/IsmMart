import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/utils/routes.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_button.dart';
import 'package:ism_mart/widgets/form_input_field_with_icon.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

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
          controller.forgotPasswordEmailController.clear();
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
              return langKey.emptyField.tr;
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
              if (controller.forgotPasswordFormKey.currentState!.validate()) {
                await controller.forgotPasswordWithEmail().then((value) {
                  if (value == true) {
                    Navigator.pop(Get.context!);
                    Get.toNamed(Routes.resetPasswordRoute);
                    controller.forgotPasswordEmailController.clear();
                  }
                });
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
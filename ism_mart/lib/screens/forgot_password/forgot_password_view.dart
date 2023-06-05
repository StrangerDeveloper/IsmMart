import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/forgot_password/forgot_password_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({Key? key}) : super(key: key);
  final ForgotPasswordViewModel viewModel = Get.put(ForgotPasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Text(
                  langKey.forgotPasswordDesc.tr,
                  style: bodyText2Poppins.copyWith(
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                langKey.enterEmail.tr,
                style: headline2.copyWith(fontSize: 16),
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
        key: viewModel.forgotPasswordFormKey,
        child: CustomTextField2(
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          controller: viewModel.emailController,
          prefixIcon: Icons.email,
          label: langKey.email.tr,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator().validateEmail(value);
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }

  Widget buttons() {
    return Obx(
      () => GlobalVariable.showLoader.value
          ? CustomLoading(isItBtn: true)
          : CustomTextBtn(
              title: langKey.send.tr,
              height: 48,
              onPressed: () {
                viewModel.sendBtn();
              },
            ),
    );
  }
}

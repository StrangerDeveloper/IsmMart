import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/forgot_password1/forgot_password1_viewmodel.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_appbar.dart';
import '../../helper/validator.dart';

class ForgotPassword1View extends StatelessWidget {
  ForgotPassword1View({Key? key}) : super(key: key);
  final ForgotPassword1ViewModel viewModel =
      Get.put(ForgotPassword1ViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
              sendBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 25),
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

  Widget sendBtn() {
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
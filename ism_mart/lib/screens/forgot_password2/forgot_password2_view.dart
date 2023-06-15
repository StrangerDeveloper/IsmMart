import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/forgot_password2/forgot_password2_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/obscure_suffix_icon.dart';

class ForgotPassword2View extends GetView<AuthController> {
  ForgotPassword2View({Key? key}) : super(key: key);
  final ForgotPassword2ViewModel viewModel =
      Get.put(ForgotPassword2ViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Form(
            key: viewModel.forgotPassword2FormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  langKey.verification.tr,
                  style: headline1.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Text(
                    langKey.enterDetails.tr,
                    style: bodyText2Poppins.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ),
                otpTxtField(),
                newPasswordTxtField(),
                confirmPasswordTxtField(),
                SizedBox(height: 30),
                sendBtn(),
              ],
            ),
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

  Widget otpTxtField() {
    return CustomTextField2(
      prefixIcon: Icons.title,
      label: langKey.otp.tr,
      controller: viewModel.otpController,
      keyboardType: TextInputType.number,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateDefaultTxtField(value);
      },
    );
  }

  Widget newPasswordTxtField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomTextField2(
          prefixIcon: Icons.lock_rounded,
          label: langKey.newPassword.tr,
          controller: viewModel.newPasswordController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator().validatePassword(value);
          },
          obscureText: viewModel.obscureNewPassword.value ? true : false,
          suffixIcon: ObscureSuffixIcon(
            isObscured: viewModel.obscureConfirmPassword.value ? true : false,
            onPressed: () {
              viewModel.obscureConfirmPassword.value =
                  !viewModel.obscureConfirmPassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget confirmPasswordTxtField() {
    return Obx(
      () => CustomTextField2(
        prefixIcon: Icons.lock_rounded,
        label: langKey.confirmPass.tr,
        controller: viewModel.confirmPasswordController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return viewModel.validateConfirmPassTxtField(value);
        },
        obscureText: viewModel.obscureConfirmPassword.value ? true : false,
        suffixIcon: ObscureSuffixIcon(
          isObscured: viewModel.obscureConfirmPassword.value ? true : false,
          onPressed: () {
            viewModel.obscureConfirmPassword.value =
                !viewModel.obscureConfirmPassword.value;
          },
        ),
      ),
    );
  }

  Widget sendBtn() {
    return Obx(
      () => GlobalVariable.showLoader.value
          ? CustomLoading(isItBtn: true)
          : CustomTextBtn(
              title: langKey.proceed.tr,
              height: 48,
              onPressed: () async {
                viewModel.submitBtn();
              },
            ),
    );
  }
}

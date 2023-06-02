import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/change_password/change_password_viewmodel.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/loader_view.dart';
import '../../utils/constants.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  final ChangePasswordViewModel viewModel = Get.put(ChangePasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: "Fill the following details to change password",
                    textAlign: TextAlign.center,
                    style: headline2,
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: viewModel.changePasswordFormKey,
                    child: Column(
                      children: [
                        newPasswordTxtField(),
                        confirmPasswordTxtField(),
                        proceedBtn(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  Widget newPasswordTxtField() {
    return Obx(
      () => CustomTextField2(
        label: langKey.newPassword.tr,
        controller: viewModel.newPasswordController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return viewModel.validateNewPassTxtField(value);
        },
        obscureText: viewModel.obscureNewPassword.value ? true : false,
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.obscureNewPassword.value
                ? CupertinoIcons.eye_slash
                : CupertinoIcons.eye,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            viewModel.obscureNewPassword.value =
                !viewModel.obscureNewPassword.value;
          },
        ),
      ),
    );
  }

  Widget confirmPasswordTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField2(
        label: langKey.confirmPass.tr,
        controller: viewModel.confirmPasswordController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return viewModel.validateConfirmPassTxtField(value);
        },
        obscureText: viewModel.obscureConfirmPassword.value ? true : false,
        suffixIcon: IconButton(
          icon: Icon(
            viewModel.obscureConfirmPassword.value
                ? CupertinoIcons.eye_slash
                : CupertinoIcons.eye,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            viewModel.obscureConfirmPassword.value =
                !viewModel.obscureConfirmPassword.value;
          },
        ),
      ),
    );
  }

  Widget proceedBtn() {
    return CustomTextBtn(
      title: langKey.proceed.tr,
      onPressed: () {
        viewModel.updatePassword();
      },
    );
  }
}

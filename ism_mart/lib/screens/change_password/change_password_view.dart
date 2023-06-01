import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/models/api_response/api_response_model.dart';
import 'package:ism_mart/screens/change_password/change_password_viewmodel.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../utils/constants.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  final ChangePasswordViewModel viewModel = Get.put(ChangePasswordViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: appBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomText(
                  title: "Fill the following details to change password",
                  style: headline2,
                ),
              ),

              SizedBox(
                height: 45,
              ),
              Form(
                key: viewModel.changePasswordFormKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // AppConstant.spaceWidget(height: 20),

                    FormPasswordInputFieldWithIcon(
                      controller: viewModel.newPasswordController,
                      iconColor: kPrimaryColor,
                      textStyle: bodyText1,
                      labelText: langKey.newPassword.tr,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value!.isEmpty
                          ? langKey.newPassReq.tr
                          : value.length < 8
                              ? langKey.passwordLengthReq.tr
                              : null,
                      obscureText: true,
                      onChanged: (value) {
                        if (value.toLowerCase().trim() ==
                            viewModel.confirmPasswordController.text
                                .toLowerCase()
                                .trim()) {
                          viewModel.passwordNotMatched(false);
                        } else {
                          viewModel.passwordNotMatched(true);
                        }
                      },
                      maxLines: 1,
                    ),
                    AppConstant.spaceWidget(height: 20),
                    FormPasswordInputFieldWithIcon(
                      controller: viewModel.confirmPasswordController,
                      iconColor: kPrimaryColor,
                      textStyle: bodyText1,
                      labelText: langKey.confirmPass.tr,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value!.isEmpty
                          ? langKey.confirmPassReq.tr
                          : value.length < 8
                              ? langKey.passwordLengthReq.tr
                              : null,
                      obscureText: true,
                      onChanged: (value) {
                        if (value.toLowerCase().trim() ==
                            viewModel.newPasswordController.text
                                .toLowerCase()
                                .trim()) {
                          viewModel.passwordNotMatched(false);
                        } else {
                          viewModel.passwordNotMatched(true);
                        }
                      },
                      maxLines: 1,
                    ),

                    AppConstant.spaceWidget(height: 20),
                    Obx(
                      () => Visibility(
                          visible: viewModel.passwordNotMatched.value,
                          child: CustomText(
                            title: langKey.passwordNotMatched.tr,
                            color: kRedColor,
                          )),
                    ),
                    AppConstant.spaceWidget(height: 8),
                    CustomButton(
                      onTap: () async {
                        if (viewModel.changePasswordFormKey.currentState!
                            .validate()) {
                          if (viewModel.passwordNotMatched == false) {
                            final ApiResponse apiCall =
                                await viewModel.updatePassword();
                            if (apiCall.success!) {
                              viewModel.clearControllers();
                              Get.back();
                              AppConstant.displaySnackBar(
                                  langKey.successTitle.tr, apiCall.message);
                            } else {
                              AppConstant.displaySnackBar(
                                  langKey.errorTitle.tr, apiCall.message);
                            }
                          }
                        }
                      },
                      text: langKey.proceed.tr,
                      width: 120,
                      height: 40,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

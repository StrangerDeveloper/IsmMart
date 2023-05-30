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
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //     'Change Password',
                //   style: headline1.copyWith(
                //     fontSize: 25,
                //     fontWeight: FontWeight.w800
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Fill the following details to change password',
                  style: bodyText2Poppins.copyWith(
                    fontSize: 14
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
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                      //   child: Text(
                      //     'Current Password',
                      //     style: bodyText2.copyWith(
                      //       color: Colors.grey
                      //     ),
                      //   ),
                      // ),
                      // Obx(() => CustomTextField1(
                      //    controller: viewModel.currentPasswordController,
                      //     onChanged: (value) => {},
                      //     autoValidateMode: AutovalidateMode.onUserInteraction,
                      //       validator:
                      //           (value) => //!GetUtils.isPassport(value!)
                      //       value!.isEmpty
                      //           ? langKey.currentPassword.tr
                      //           : null,
                      //     // minLines: 1,
                      //   obscureText: viewModel.currentPasswordIconVisibility.isTrue,
                      //     suffixIcon: GestureDetector(
                      //       onTap: ()=> viewModel.changeIcon(viewModel.currentPasswordIconVisibility),
                      //       child: Icon(viewModel.currentPasswordIconVisibility.isTrue
                      //           ? Icons.visibility_off : Icons.visibility,
                      //         color: Colors.black, size: 22,),
                      //     ),
                      //   ),
                      // ),
                      // AppConstant.spaceWidget(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'New Password',
                            style: bodyText2.copyWith(
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      Obx(() => CustomTextField1(
                        controller: viewModel.newPasswordController,
                        onChanged: (value) {
                          if(viewModel.confirmPasswordController.text.isEmpty ||
                              viewModel.confirmPasswordController.text == ''){
                            return;
                          }
                          else {
                            if (value.toLowerCase().trim() ==
                                viewModel.confirmPasswordController.text
                                    .toLowerCase()
                                    .trim()) {
                              viewModel.passwordNotMatched(false);
                            } else {
                              viewModel.passwordNotMatched(true);
                            }
                          }
                        },
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator:
                            (value) => //!GetUtils.isPassport(value!)
                        value!.isEmpty
                            ? langKey.newPassReq.tr
                            : value.length < 8
                            ? langKey.passwordLengthReq.tr
                            : null,
                        minLines: 1,
                        obscureText: viewModel.newPasswordIconVisibility.isTrue,
                        suffixIcon: GestureDetector(
                          onTap: ()=> viewModel.changeIcon(viewModel.newPasswordIconVisibility),
                          child: Icon(viewModel.newPasswordIconVisibility.isTrue
                              ? Icons.visibility_off : Icons.visibility,
                            color: Colors.black, size: 22,),
                        ),
                      ),
                      ),
                      AppConstant.spaceWidget(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Confirm Password',
                            style: bodyText2.copyWith(
                                color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      Obx(() => CustomTextField1(
                        controller: viewModel.confirmPasswordController,
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
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        validator:
                            (value) => //!GetUtils.isPassport(value!)
                            value!.isEmpty
                                ? langKey.confirmPassReq.tr
                                : value.length < 8
                                ? langKey.passwordLengthReq.tr : null,
                        minLines: 1,
                        obscureText: viewModel.confirmPasswordIconVisibility.isTrue,
                        suffixIcon: GestureDetector(
                          onTap: ()=> viewModel.changeIcon(viewModel.confirmPasswordIconVisibility),
                          child: Icon(viewModel.confirmPasswordIconVisibility.isTrue
                              ? Icons.visibility_off : Icons.visibility,
                            color: Colors.black, size: 22,),
                        ),
                      ),
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
                          if(viewModel.changePasswordFormKey.currentState!.validate()){
                            if(viewModel.passwordNotMatched == false){
                              final ApiResponse apiCall = await viewModel.updatePassword();
                              if(apiCall.success!){
                                viewModel.clearControllers();
                                Get.back();
                                AppConstant.displaySnackBar(
                                  langKey.successTitle.tr,
                                  apiCall.message
                                );
                              }
                              else{
                                AppConstant.displaySnackBar(
                                  langKey.errorTitle.tr,
                                  apiCall.message
                                );
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
      ),
    );
  }
}
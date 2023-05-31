import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/utils/svg_helper.dart';

class ResetForgotPassword extends GetView<AuthController> {
  const ResetForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildSvgLogo(),
                    InkWell(
                      onTap: () {
                        controller.clearForgotPasswordControllers();
                        Get.back();
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      langKey.enterDetails.tr,
                      style: headline2,
                    ),
                  ),
                  AppConstant.spaceWidget(height: 40),
                  Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            StickyLabel(text: langKey.verification.tr),
                            AppConstant.spaceWidget(height: 15),
                            FormInputFieldWithIcon(
                              controller: controller.otpController,
                              iconPrefix: Icons.title,
                              labelText: langKey.otp.tr,
                              iconColor: kPrimaryColor,
                              autofocus: false,
                              textStyle: bodyText1,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) => GetUtils.isBlank(value!)!
                                  ? langKey.otpReq.tr
                                  : null,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              onSaved: (value) {},
                            ),
                            AppConstant.spaceWidget(height: 30),
                            FormPasswordInputFieldWithIcon(
                              controller: controller.passwordController,
                              iconPrefix: Icons.lock_rounded,
                              iconColor: kPrimaryColor,
                              textStyle: bodyText1,
                              labelText: langKey.newPassword.tr,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator:
                                  (value) => //!GetUtils.isPassport(value!)
                                      value!.isEmpty
                                          ? langKey.newPassReq.tr
                                          : value.length < 8
                                              ? langKey.passwordLengthReq.tr
                                              : null,
                              obscureText: true,
                              onChanged: (value) => {},
                              maxLines: 1,
                            ),
                            AppConstant.spaceWidget(height: 30),
                            FormPasswordInputFieldWithIcon(
                              controller: controller.confirmPassController,
                              iconPrefix: Icons.lock_rounded,
                              iconColor: kPrimaryColor,
                              textStyle: bodyText1,
                              labelText: langKey.confirmPass.tr,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator:
                                  (value) => //!GetUtils.isPassport(value!)
                                      value!.isEmpty
                                          ? langKey.confirmPassReq.tr
                                          : value.length < 8
                                              ? langKey.passwordLengthReq.tr
                                              : null,
                              obscureText: true,
                              onChanged: (value) {
                                if (value.toLowerCase().trim() ==
                                    controller.passwordController.text
                                        .toLowerCase()
                                        .trim()) {
                                  controller.showPasswordNotMatched(false);
                                } else {
                                  controller.showPasswordNotMatched(true);
                                }
                              },
                              maxLines: 1,
                            ),
                            AppConstant.spaceWidget(height: 30),
                            Obx(
                              () => Visibility(
                                  visible:
                                      controller.showPasswordNotMatched.value,
                                  child: CustomText(
                                    title: langKey.passwordNotMatched.tr,
                                    color: kRedColor,
                                  )),
                            ),
                            AppConstant.spaceWidget(height: 20),
                            Obx(
                              () => controller.isLoading.isTrue
                                  ? CustomLoading(isItBtn: true)
                                  : CustomButton(
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          if (controller
                                                  .showPasswordNotMatched ==
                                              false) {
                                            await controller
                                                .forgotPasswordOtp();
                                          }
                                        }
                                      },
                                      text: langKey.proceed.tr,
                                      width: 200,
                                      height: 40,
                                      color: kPrimaryColor,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

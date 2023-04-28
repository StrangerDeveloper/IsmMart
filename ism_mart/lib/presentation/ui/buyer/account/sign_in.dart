import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SignInUI extends GetView<AuthController> {
  const SignInUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100.0,
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
                      onTap: () => Get.back(),
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
                    child: CustomText(
                      title: langKey.loginGreetings.tr,
                      style: headline2,
                    ),
                  ),
                  AppConstant.spaceWidget(height: 40),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12),
                      child: Column(
                        children: [
                          FormInputFieldWithIcon(
                            controller: controller.emailController,
                            iconPrefix: Icons.email,
                            labelText: langKey.email.tr,
                            iconColor: kPrimaryColor,
                            autofocus: false,
                            textStyle: bodyText1,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => !GetUtils.isEmail(value!)
                                ? langKey.emailReq.tr
                                : null,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {},
                            onSaved: (value) {},
                          ),
                          AppConstant.spaceWidget(height: 20),
                          FormPasswordInputFieldWithIcon(
                            controller: controller.passwordController,
                            iconPrefix: Icons.lock_rounded,
                            iconColor: kPrimaryColor,
                            textStyle: bodyText1,
                            labelText: langKey.password.tr,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => //!GetUtils.isPassport(value!)
                                value!.length < 6
                                    ? langKey.passwordLengthReq.tr
                                    : null,
                            obscureText: true,
                            onChanged: (value) => {},
                            maxLines: 1,
                          ),
                          AppConstant.spaceWidget(height: 40),
                          Obx(
                            () => controller.isLoading.isTrue
                                ? CustomLoading(isItBtn: true)
                                : CustomButton(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.login();
                                      }
                                    },
                                    text: langKey.signIn.tr,
                                    height: 50,
                                    width: 300,
                                  ),
                          ),
                          AppConstant.spaceWidget(height: 10),
                          Container(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => showForgotPasswordDialog(),
                              child: Text(
                                langKey.forgotPassword.tr,
                                style: headline3.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                          AppConstant.spaceWidget(height: 20),
                          Center(
                            child: InkWell(
                              onTap: () => Get.toNamed(Routes.registerRoute),
                              child: Column(
                                children: [
                                  Text(langKey.donTHaveAccount.tr,
                                      style: bodyText1),
                                  Text(
                                    langKey.signUp.tr,
                                    style: bodyText1.copyWith(
                                        decoration: TextDecoration.underline,
                                        color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          /* AppConstant.spaceWidget(height: 20),
                          Center(
                            child: InkWell(
                              onTap: () => showResendVerificationLinkDialog(),
                              child: Column(
                                children: [
                                  Text("Email verification Link expired?",
                                      style: bodyText1),
                                  Text(
                                    "Resend link here",
                                    style: bodyText1.copyWith(
                                        color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                        ],
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

  void showForgotPasswordDialog() {
    final formKey = GlobalKey<FormState>();
    Get.defaultDialog(
      title: "Reset Password",
      titleStyle: appBarTitleSize,
      content: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppConstant.spaceWidget(height: 20),
              FormInputFieldWithIcon(
                controller: controller.emailController,
                iconPrefix: Icons.email,
                labelText: langKey.email.tr,
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    !GetUtils.isEmail(value!) ? langKey.emailReq.tr : null,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onTap: () {
                      Get.back();
                    },
                    text: langKey.cancelBtn.tr,
                    width: 100,
                    height: 35,
                    color: kPrimaryColor,
                  ),
                  CustomButton(
                    onTap: () async {
                      await controller.forgotPasswordWithEmail().then((value) {
                        controller.emailController.clear();
                        Get.back();
                        showRenewPasswordBottomSheet();
                      });
                    },
                    text: langKey.send.tr,
                    width: 100,
                    height: 35,
                    color: kPrimaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showRenewPasswordBottomSheet() {
    final formKey = GlobalKey<FormState>();
    AppConstant.showBottomSheet(
      widget: Form(
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
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      GetUtils.isBlank(value!)! ? langKey.otpReq.tr : null,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                  onSaved: (value) {},
                ),
                AppConstant.spaceWidget(height: 10),
                FormPasswordInputFieldWithIcon(
                  controller: controller.passwordController,
                  iconPrefix: Icons.lock_rounded,
                  iconColor: kPrimaryColor,
                  textStyle: bodyText1,
                  labelText: langKey.newPassword.tr,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => //!GetUtils.isPassport(value!)
                      value!.isEmpty
                          ? langKey.newPassReq.tr
                          : value.length < 8
                              ? langKey.passwordLengthReq.tr
                              : null,
                  obscureText: true,
                  onChanged: (value) => {},
                  maxLines: 1,
                ),
                AppConstant.spaceWidget(height: 10),
                FormPasswordInputFieldWithIcon(
                  controller: controller.confirmPassController,
                  iconPrefix: Icons.lock_rounded,
                  iconColor: kPrimaryColor,
                  textStyle: bodyText1,
                  labelText: langKey.confirmPass.tr,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => //!GetUtils.isPassport(value!)
                      value!.isEmpty
                          ? langKey.confirmPassReq.tr
                          : value.length < 8
                              ? langKey.passwordLengthReq.tr
                              : null,
                  obscureText: true,
                  onChanged: (value) {
                    if (value != controller.passwordController.text) {
                      print("change value $value");
                      controller.getpassmatchFu(true);
                    } else
                      controller.getpassmatchFu(false);
                  },
                  maxLines: 1,
                ),
                AppConstant.spaceWidget(height: 10),
                Obx(
                  () => Visibility(
                      visible: controller.isPasswordMatched.value,
                      child: CustomText(
                        title: langKey.passwordNotMatched.tr,
                        color: kRedColor,
                      )),
                ),
                AppConstant.spaceWidget(height: 20),
                CustomButton(
                  onTap: () async {
                    await controller.forgotPasswordOtp();
                  },
                  text: langKey.send.tr,
                  width: 120,
                  height: 40,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showResendVerificationLinkDialog() {
    final formKey = GlobalKey<FormState>();
    Get.defaultDialog(
        title: "Resend Verification Link",
        content: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppConstant.spaceWidget(height: 20),
                FormInputFieldWithIcon(
                  controller: controller.emailController,
                  iconPrefix: Icons.email,
                  labelText: 'Email',
                  iconColor: kPrimaryColor,
                  autofocus: false,
                  textStyle: bodyText1,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => !GetUtils.isEmail(value!)
                      ? "Invalid Email Format?"
                      : null,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                  onSaved: (value) {},
                ),
                AppConstant.spaceWidget(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      onTap: () {
                        Get.back();
                      },
                      text: "Cancel",
                      width: 100,
                      height: 35,
                      color: kPrimaryColor,
                    ),
                    CustomButton(
                      onTap: () async {
                        await controller.resendEmailVerificationLink();
                      },
                      text: "Send",
                      width: 100,
                      height: 35,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

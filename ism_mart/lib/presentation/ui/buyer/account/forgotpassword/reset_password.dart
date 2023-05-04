import 'package:flutter/material.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:ism_mart/presentation/widgets/form_input_field_with_icon.dart';
import 'package:ism_mart/presentation/widgets/custom_button.dart';
import 'package:ism_mart/utils/svg_helper.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/form_password_input_field_with_icon.dart';
import '../../../../widgets/sticky_labels.dart';

class ForgotPassword extends GetView<AuthController> {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
        child: Scaffold(
            body: CustomScrollView(slivers: [
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
              child: Text(
                'Enter Details To Create New Password',
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
                        autoValidateMode: AutovalidateMode.onUserInteraction,
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
                      AppConstant.spaceWidget(height: 30),
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
                          if (value.toLowerCase().trim() ==
                              controller.passwordController.text
                                  .toLowerCase()
                                  .trim()) {
                            controller.isPasswordMatched(true);
                          } else
                            controller.isPasswordMatched(false);
                        },
                        maxLines: 1,
                      ),
                      AppConstant.spaceWidget(height: 30),
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
          ],
        ),
      ),
    ])));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SignUpUI extends GetView<AuthController> {
  const SignUpUI({Key? key}) : super(key: key);

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: CustomText(
                      title: langKey.registerGreetings.tr,
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
                          AppConstant.spaceWidget(height: 15),
                          FormInputFieldWithIcon(
                            controller: controller.firstNameController,
                            iconPrefix: Icons.title,
                            labelText: langKey.fullName.tr,
                            iconColor: kPrimaryColor,
                            autofocus: false,
                            textStyle: bodyText1,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => GetUtils.isBlank(value!)!
                                ? langKey.fullNameReq.tr
                                : null,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                            onSaved: (value) {},
                          ),
                          AppConstant.spaceWidget(height: 15),
                          FormInputFieldWithIcon(
                            controller: controller.emailController,
                            iconPrefix: Icons.email_outlined,
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
                          AppConstant.spaceWidget(height: 15),
                          FormPasswordInputFieldWithIcon(
                            controller: controller.passwordController,
                            iconPrefix: Icons.lock_outline_rounded,
                            iconColor: kPrimaryColor,
                            textStyle: bodyText1,
                            labelText: langKey.password.tr,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => //!GetUtils.isPassport(value!)
                                value!.length < 8
                                    ? langKey.passwordLengthReq.tr
                                    : null,
                            obscureText: true,
                            onChanged: (value) => {},
                            maxLines: 1,
                          ),
                          AppConstant.spaceWidget(height: 15),
                          FormInputFieldWithIcon(
                            controller: controller.phoneController,
                            iconPrefix: Icons.phone_iphone_outlined,
                            iconColor: kPrimaryColor,
                            textStyle: bodyText1,
                            autofocus: false,
                            labelText:
                                '${langKey.phone.tr} (${langKey.optional.tr})',
                            /*autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                !GetUtils.isPhoneNumber(value!)
                                    ? "Invalid phone number format"
                                    : null,*/
                            onChanged: (value) => {},
                            onSaved: (value) {},
                            maxLines: 1,
                          ),
                          AppConstant.spaceWidget(height: 40),
                          Obx(() => controller.isLoading.isTrue
                              ? CustomLoading(isItBtn: true)
                              : CustomButton(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      await controller.register();
                                    }
                                  },
                                  text: langKey.signUp.tr,
                                  height: 50,
                                  width: 300,
                                )),
                          AppConstant.spaceWidget(height: 20),
                          Center(
                            child: InkWell(
                              onTap: () => Get.offNamed(Routes.loginRoute),
                              child: Column(
                                children: [
                                  CustomText(
                                      title: langKey.alreadyHaveAccount.tr,
                                      style: bodyText1),
                                  CustomText(
                                    title: langKey.signIn.tr,
                                    style: bodyText1.copyWith(
                                        decoration: TextDecoration.underline,
                                        color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
}

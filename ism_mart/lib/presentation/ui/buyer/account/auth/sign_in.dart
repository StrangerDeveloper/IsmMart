import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: CustomText(
                      title:
                          "Greetings! Welcome back!\nSign in to your Account",
                      style: headline3,
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
                            labelText: 'Email',
                            iconColor: kPrimaryColor,
                            autofocus: false,
                            textStyle: bodyText1,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => !GetUtils.isEmail(value!)
                                ? "Invalid Email Format?"
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
                            labelText: 'Password',
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => !GetUtils.isPassport(value!)
                                ? "Password must be at least 6 characters long?"
                                : null,
                            obscureText: true,
                            onChanged: (value) => {},
                            maxLines: 1,
                          ),
                          AppConstant.spaceWidget(height: 40),
                          Obx(
                            () => controller.isLoading.isTrue
                                ? CustomLoading(isItForWidget: true, color: kPrimaryColor,)
                                : CustomButton(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        controller.login();
                                      }
                                    },
                                    text: "Sign In",
                                    height: 50,
                                    width: 300,
                                  ),
                          ),
                          AppConstant.spaceWidget(height: 10),
                          Container(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () => {},
                              child: CustomText(
                                title: "Forgot your Password?",
                                style: bodyText3,
                              ),
                            ),
                          ),
                          AppConstant.spaceWidget(height: 20),
                          Center(
                            child: InkWell(
                              onTap: () => Get.toNamed(Routes.registerRoute),
                              child: Column(
                                children: [
                                  Text("Don't have an Account?",
                                      style: bodyText1),
                                  Text(
                                    "Sign up here",
                                    style: bodyText1.copyWith(
                                        color: kPrimaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          AppConstant.spaceWidget(height: 20),
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

  void showResendVerificationLinkDialog(){
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
                autoValidateMode:
                AutovalidateMode.onUserInteraction,
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
                    onTap: () async{
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
      )
    );
  }
}

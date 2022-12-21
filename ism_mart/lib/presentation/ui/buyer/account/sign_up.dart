import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

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
                      title: "Create an ISMMART Account!",
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
                          AppConstant.spaceWidget(height: 15),
                          FormInputFieldWithIcon(
                            controller: controller.firstNameController,
                            iconPrefix: Icons.title,
                            labelText: 'Full Name',
                            iconColor: kPrimaryColor,
                            autofocus: true,
                            textStyle: bodyText1,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => GetUtils.isBlank(value!)!
                                ? "Full Name is Required!"
                                : null,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {},
                            onSaved: (value) {},
                          ),
                          AppConstant.spaceWidget(height: 15),
                          FormInputFieldWithIcon(
                            controller: controller.emailController,
                            iconPrefix: Icons.email,
                            labelText: 'Email',
                            iconColor: kPrimaryColor,
                            autofocus: true,
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
                          AppConstant.spaceWidget(height: 15),
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
                          AppConstant.spaceWidget(height: 15),
                          FormInputFieldWithIcon(
                            controller: controller.phoneController,
                            iconPrefix: Icons.phone_iphone_rounded,
                            iconColor: kPrimaryColor,
                            textStyle: bodyText1,
                            autofocus: false,
                            labelText: 'Phone',
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                !GetUtils.isPhoneNumber(value!)
                                    ? "Invalid phone number format"
                                    : null,
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
                                  text: "Register",
                                  height: 50,
                                  width: 300,
                                )),
                          AppConstant.spaceWidget(height: 20),
                          Center(
                            child: InkWell(
                              onTap: () => Get.offNamed(Routes.loginRoute),
                              child: Column(
                                children: [
                                  Text("Already have an Account?",
                                      style: bodyText1),
                                  Text(
                                    "Sign In here",
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:ism_mart/screens/signin/signin_viewmodel.dart';
import 'package:ism_mart/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/obscure_suffix_icon.dart';

import '../../helper/validator.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);
  final SignInViewModel viewModel = Get.put(SignInViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: viewModel.signInFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    logoCloseIcon(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      child: CustomText(
                        title: langKey.loginGreetings.tr,
                        style: headline2,
                      ),
                    ),
                    emailTextField(),
                    passwordTextField(),
                    signInBtn(),
                    forgotPassword(),
                    doNotHaveAnAccount(),
                  ],
                ),
              ),
            ),
            NoInternetView(
              onPressed: () => viewModel.signIn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget logoCloseIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 70,
          child: FittedBox(
            child: buildSvgLogo(),
          ),
        ),
        IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget emailTextField() {
    return CustomTextField2(
      contentPadding: EdgeInsets.symmetric(vertical: 16),
      label: langKey.email.tr,
      controller: viewModel.emailController,
      prefixIcon: Icons.email,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateEmail(value);
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        child: CustomTextField2(
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          controller: viewModel.passwordController,
          prefixIcon: Icons.lock_rounded,
          label: langKey.password.tr,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator().validateDefaultTxtField(value);
          },
          obscureText: viewModel.obscurePassword.value ? true : false,
          suffixIcon: ObscureSuffixIcon(
            isObscured: viewModel.obscurePassword.value ? true : false,
            onPressed: () {
              viewModel.obscurePassword.value =
                  !viewModel.obscurePassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget signInBtn() {
    return Obx(
      () => GlobalVariable.showLoader.value
          ? CustomLoading(isItBtn: true)
          : CustomTextBtn(
              title: langKey.signIn.tr,
              height: 48,
              onPressed: () {
                viewModel.signIn();
              },
            ),
    );
  }

  Widget forgotPassword() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.forgotPassword1, arguments: {
            'email': GetUtils.isEmail(viewModel.emailController.text)
                ? viewModel.emailController.text
                : ''
          });
        },
        child: Text(
          langKey.forgotPassword.tr + '?',
          style: headline3.copyWith(
            decoration: TextDecoration.underline,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget doNotHaveAnAccount() {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.offNamed(Routes.registerRoute);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            children: [
              Text(
                langKey.donTHaveAccount.tr,
                style: bodyText1.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 3),
              Text(
                langKey.signUp.tr,
                style: bodyText1.copyWith(
                  decoration: TextDecoration.underline,
                  color: kPrimaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/screens/signin/signin_viewmodel.dart';
import 'package:ism_mart/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../forgot_password/forgot_password_view.dart';

class SignInView extends StatelessWidget {
  SignInView({Key? key}) : super(key: key);
  final SignInViewModel viewModel = Get.put(SignInViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
    return FormInputFieldWithIcon(
      controller: viewModel.emailController,
      iconPrefix: Icons.email,
      labelText: langKey.email.tr,
      iconColor: kPrimaryColor,
      autofocus: false,
      textStyle: bodyText1,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateEmail(value);
      },
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {},
      onSaved: (value) {},
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: FormPasswordInputFieldWithIcon(
        controller: viewModel.passwordController,
        iconPrefix: Icons.lock_rounded,
        iconColor: kPrimaryColor,
        textStyle: bodyText1,
        labelText: langKey.password.tr,
        validator: (value) {
          return Validator().validateDefaultTxtField(value);
        },
        obscureText: true,
        onChanged: (value) => {},
        maxLines: 1,
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
      margin: EdgeInsets.only(top: 10, bottom: 20),
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Get.to(() => ForgotPasswordView(
              email: GetUtils.isEmail(viewModel.emailController.text)
                  ? viewModel.emailController.text
                  : ''));
        },
        child: Text(
          langKey.forgotPassword.tr + '?',
          style: headline3.copyWith(decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget doNotHaveAnAccount() {
    return Center(
      child: InkWell(
        onTap: () {
          Get.offNamed(Routes.registerRoute);
        },
        child: Column(
          children: [
            Text(langKey.donTHaveAccount.tr, style: bodyText1),
            Text(
              langKey.signUp.tr,
              style: bodyText1.copyWith(
                  decoration: TextDecoration.underline, color: kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

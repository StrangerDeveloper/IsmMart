import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/exports/export_account.dart';
import 'package:ism_mart/screens/signup/signup_viewmodel.dart';
import 'package:ism_mart/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/obscure_suffix_icon.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final SignUpViewModel viewModel = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: viewModel.signUpFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logoCloseIcon(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 40),
                  child: CustomText(
                    title: langKey.registerGreetings.tr,
                    style: headline2,
                  ),
                ),
                fullNameField(),
                emailTextField(),
                passwordTextField(),
                phoneNumberTextField(),
                signUpBtn(),
                SizedBox(height: 20),
                alreadyHaveAnAccount(),
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

  Widget fullNameField() {
    return CustomTextField2(
      contentPadding: EdgeInsets.symmetric(vertical: 16),
      label: langKey.fullName.tr,
      controller: viewModel.fullNameController,
      prefixIcon: Icons.title,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateName(value);
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField2(
        contentPadding: EdgeInsets.symmetric(vertical: 16),
        label: langKey.email.tr,
        controller: viewModel.emailController,
        prefixIcon: Icons.email_outlined,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateEmail(value);
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => CustomTextField2(
        contentPadding: EdgeInsets.symmetric(vertical: 16),
        controller: viewModel.passwordController,
        prefixIcon: Icons.lock_rounded,
        label: langKey.password.tr,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validatePassword(value);
        },
        obscureText: viewModel.obscurePassword.value ? true : false,
        suffixIcon: ObscureSuffixIcon(
          isObscured: viewModel.obscurePassword.value ? true : false,
          onPressed: () {
            viewModel.obscurePassword.value = !viewModel.obscurePassword.value;
          },
        ),
      ),
    );
  }

  Widget phoneNumberTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: CountryCodePickerTextField(
          keyboardType: TextInputType.number,
          controller: viewModel.phoneNumberController,
          initialValue: viewModel.countryCode.value,
          textStyle: bodyText1,
          labelText: langKey.phone.tr,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+?\d*')),
          ],
          errorText: viewModel.phoneErrorText.value,
          onPhoneFieldChange: (value) {
            String newPhoneValue = viewModel.countryCode.value + value;
            viewModel.validatorPhoneNumber(newPhoneValue);
          },
          onChanged: (value) {
            viewModel.countryCode.value = value.dialCode ?? '+92';
            String newPhoneValue = viewModel.countryCode.value + viewModel.phoneNumberController.text;
            viewModel.validatorPhoneNumber(newPhoneValue);
          },
        ),
      ),
    );
  }

  Widget signUpBtn() {
    return Obx(
      () => GlobalVariable.showLoader.value
          ? CustomLoading(isItBtn: true)
          : CustomTextBtn(
              title: langKey.signUp.tr,
              height: 48,
              onPressed: () {
                viewModel.signUp();
              },
            ),
    );
  }

  Widget alreadyHaveAnAccount() {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.off(()=>SignInView());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            children: [
              Text(
                langKey.alreadyHaveAccount.tr,
                style: bodyText1.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 3),
              Text(
                langKey.signIn.tr,
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

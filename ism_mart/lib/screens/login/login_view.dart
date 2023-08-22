import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/login/login_viewmodel.dart';
import 'package:ism_mart/screens/product_detail/product_detail_view.dart';
import 'package:ism_mart/widgets/back_button.dart';
import 'package:ism_mart/widgets/become_vendor.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:ism_mart/widgets/obscure_suffix_icon.dart';
import 'package:ism_mart/widgets/scrollable_column.dart';

import '../../helper/validator.dart';

class LogInView extends StatelessWidget {
  LogInView({Key? key}) : super(key: key);
  final LogInViewModel viewModel = Get.put(LogInViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Form(
              key: viewModel.signInFormKey,
              child: ScrollableColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleAndBackBtn(),
                  Spacer(),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20, bottom: 10, left: 20),
                    child: CustomText(
                      title: langKey.welcome.tr + '!',
                      style: newFontStyle2.copyWith(
                        fontSize: 20,
                        color: newColorDarkBlack2,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                    child: Text(
                      langKey.seamlessShopping.tr,
                      style: newFontStyle0.copyWith(
                        color: newColorLightGrey2,
                      ),
                    ),
                  ),
                  emailTextField(),
                  passwordTextField(),
                  forgotPassword(),
                  logInBtn(),
                  or(),
                  googlelogInBtn(),
                  facebooklogInBtn(),
                  applelogInBtn(),
                  Spacer(),
                  doNotHaveAnAccount(),
                  BecomeVendor(),
                ],
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

  Widget titleAndBackBtn() {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 30),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              langKey.login.tr,
              style: dmSerifDisplay1.copyWith(
                fontSize: 32,
              ),
            ),
          ),
          CustomBackButton(
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomTextField3(
        title: langKey.email.tr,
        hintText: 'asha****iq11@gmail.com',
        controller: viewModel.emailController,
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
          () => Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: CustomTextField3(
          controller: viewModel.passwordController,
          title: langKey.password.tr,
          hintText: '● ● ● ● ● ● ● ● ● ●',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator().validateDefaultTxtField(value,
                errorPrompt: langKey.passwordIsRequired.tr);
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


//Google Button
  Widget googlelogInBtn() { return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child:    CustomRoundedTextBtn(
      borderSide:  BorderSide(
        color: newColorDarkBlack, // your color here
        width: 1,
      ),
      backgroundColor: kWhiteColor,
      foregroundColor: newColorDarkBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image.asset(
              'assets/logo/google_logo.png',
              width: 36,
              height: 36,
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),
          SizedBox(
            width:5,
          ),
          Text(
            "Continue in with Google",
            style: newFontStyle3,
          ),
        ],),
      onPressed: () {
        viewModel.signInWithApple();
      },
    ),



    // Obx(
    //       () => GlobalVariable.showLoader.value
    //       ? CustomLoading(isItBtn: true)
    //       :
    //
    //       CustomRoundedTextBtn(
    //     borderSide:  BorderSide(
    //       color: newColorDarkBlack, // your color here
    //       width: 1,
    //     ),
    //     backgroundColor: kWhiteColor,
    //     foregroundColor: newColorDarkBlack,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         ClipRRect(
    //           child: Image.asset(
    //             'assets/logo/google_logo.png',
    //             width: 36,
    //             height: 36,
    //           ),
    //           borderRadius: BorderRadius.circular(50.0),
    //         ),
    //         SizedBox(
    //           width:5,
    //         ),
    //         Text(
    //           "Continue in with Google",
    //           style: newFontStyle3,
    //         ),
    //       ],),
    //     onPressed: () {
    //       viewModel.signInWithApple();
    //     },
    //   ),
    //
    // ),
    //
  );
  }

  //Facebook Button
  Widget facebooklogInBtn() { return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
    child: CustomRoundedTextBtn(
      borderSide:  BorderSide(
        color: newColorDarkBlack, // your color here
        width: 1,
      ),
      backgroundColor: kWhiteColor,
      foregroundColor: newColorDarkBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image.asset(
              'assets/logo/fb_logo.png',
              width: 36,
              height: 36,
            ),
            borderRadius: BorderRadius.circular(50.0),
          ),
          SizedBox(
            width:5,
          ),
          Text(
            "Continue in with Facebok",
            style: newFontStyle3,
          ),
        ],),
      onPressed: () {
        viewModel.signInWithApple();
      },
    ),

    // Obx(
    //       () => GlobalVariable.showLoader.value
    //       ? CustomLoading(isItBtn: true)
    //       :
    //       CustomRoundedTextBtn(
    //     borderSide:  BorderSide(
    //       color: newColorDarkBlack, // your color here
    //       width: 1,
    //     ),
    //     backgroundColor: kWhiteColor,
    //     foregroundColor: newColorDarkBlack,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         ClipRRect(
    //           child: Image.asset(
    //             'assets/logo/fb_logo.png',
    //             width: 36,
    //             height: 36,
    //           ),
    //           borderRadius: BorderRadius.circular(50.0),
    //         ),
    //         SizedBox(
    //           width:5,
    //         ),
    //         Text(
    //           "Continue in with Facebok",
    //           style: newFontStyle3,
    //         ),
    //       ],),
    //     onPressed: () {
    //       viewModel.signInWithApple();
    //     },
    //   ),
    //
    // ),

  );
  }

//Apple Button
  Widget applelogInBtn() { return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
    child: Obx(
          () =>viewModel.applelLoader.value
          ? CustomLoading(isItBtn: viewModel.applelLoader.value)
          : CustomRoundedTextBtn(
        borderSide:  BorderSide(
          color: newColorDarkBlack, // your color here
          width: 1,
        ),
        backgroundColor: kWhiteColor,
        foregroundColor: newColorDarkBlack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              child: Image.asset(
                'assets/logo/apple_logo.png',
                width: 36,
                height: 36,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            SizedBox(
              width:5,
            ),
            Text(
              "Continue with Apple ID",
              style: newFontStyle3,
            ),
          ],),
        onPressed: () {
          viewModel.signInWithApple();
        },
      ),
    ),
  );
  }

  Widget logInBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
      child: Obx(
            () => GlobalVariable.showLoader.value
            ? CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
          backgroundColor: newColorDarkBlack,
          child: Text(
            langKey.login.tr,
            style: newFontStyle3,
          ),
          onPressed: () {
            viewModel.signIn();
          },
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 10, top: 10),
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.forgotPassword1, arguments: {
            'email': GetUtils.isEmail(viewModel.emailController.text)
                ? viewModel.emailController.text
                : ''
          });
        },
        child: Text(langKey.forgotPassword.tr, style: newFontStyle1),
      ),
    );
  }

  Widget or() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: newColorLightGrey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            langKey.or.tr,
            style: newFontStyle4,
          ),
        ),

        Expanded(
          child: Divider(
            color: newColorLightGrey,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget doNotHaveAnAccount() {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.offNamed(Routes.registerRoute);
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: langKey.donTHaveAccount.tr + ' ',
                style: newFontStyle0.copyWith(
                  color: newColorLightGrey2,
                ),
              ),
              TextSpan(
                text: langKey.signUp.tr,
                style: newFontStyle2.copyWith(
                  color: newColorDarkBlack2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

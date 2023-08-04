import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/models/user/country_city_model.dart';
import 'package:ism_mart/screens/login/login_view.dart';
import 'package:ism_mart/screens/signup/signup_viewmodel.dart';
import 'package:ism_mart/widgets/back_button.dart';
import 'package:ism_mart/widgets/become_vendor.dart';
import 'package:ism_mart/widgets/custom_checkbox.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:ism_mart/widgets/obscure_suffix_icon.dart';

import '../../helper/validator.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final SignUpViewModel viewModel = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: viewModel.signUpFormKey,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleAndBackBtn(),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 10),
                            child: CustomText(
                              title: langKey.createAnAccount.tr,
                              style: newFontStyle2.copyWith(
                                fontSize: 20,
                                color: newColorDarkBlack2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Text(
                              langKey.getOnboardUser.tr,
                              style: newFontStyle0.copyWith(
                                color: newColorLightGrey2,
                              ),
                            ),
                          ),
                          firstNameField(),
                          lastNameField(),
                          emailTextField(),
                          phoneNumberTextField(),
                          passwordTextField(),
                          confirmPasswordTextField(),
                          countryPicker(),
                          cityPicker(),
                          checkBoxTermCondition(),
                          signUpBtn(),
                          alreadyHaveAnAccount(),
                        ],
                      ),
                    ),
                  ),
                  BecomeVendor(),
                ],
              ),
            ),
            NoInternetView(
              onPressed: () => viewModel.signUp(),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleAndBackBtn() {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              langKey.signUp.tr,
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

  Widget firstNameField() {
    return CustomTextField3(
      title: langKey.firstName.tr,
      hintText: 'John',
      controller: viewModel.firstNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateName(value, fieldType: langKey.FirstNameReq.tr);
      },
    );
  }

  Widget lastNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField3(
        title: langKey.lastName.tr,
        hintText: 'Kel',
        controller: viewModel.lastNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateName(value, fieldType: langKey.LastNameReq.tr);
        },
      ),
    );
  }

  Widget emailTextField() {
    return CustomTextField3(
      title: langKey.email.tr,
      hintText: 'asha****iq11@gmail.com',
      controller: viewModel.emailController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateEmail(value);
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget phoneNumberTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: CountryCodePickerTextField2(
          validator: (value){
            return Validator().validatePhoneNumber(value);
          },
          title: langKey.phoneNumber.tr,
          hintText: '336 5563138',
          keyboardType: TextInputType.number,
          controller: viewModel.phoneNumberController,
          initialValue: viewModel.countryCode.value,
          textStyle: bodyText1,
          autoValidateMode: AutovalidateMode.onUserInteraction,
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
            String newPhoneValue = viewModel.countryCode.value +
                viewModel.phoneNumberController.text;
            viewModel.validatorPhoneNumber(newPhoneValue);
          },
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => CustomTextField3(
        controller: viewModel.passwordController,
        title: langKey.password.tr,
        hintText: '● ● ● ● ● ● ● ● ● ●',
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

  Widget confirmPasswordTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomTextField3(
          controller: viewModel.confirmPasswordController,
          title: langKey.confirmPass.tr,
          hintText: '● ● ● ● ● ● ● ● ● ●',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator().validateConfirmPassword(value, viewModel.passwordController.text);
          },
          obscureText: viewModel.obscureConfirmPassword.value ? true : false,
          suffixIcon: ObscureSuffixIcon(
            isObscured: viewModel.obscureConfirmPassword.value ? true : false,
            onPressed: () {
              viewModel.obscureConfirmPassword.value =
                  !viewModel.obscureConfirmPassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget countryPicker() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              langKey.country.tr,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: newColorDarkBlack2,
              ),
            ),
          ),
          DropdownSearch<CountryModel>(
            popupProps: PopupProps.dialog(
              showSearchBox: true,
              dialogProps: DialogProps(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              searchFieldProps: AppConstant.searchFieldProp(),
            ),
            items: cityViewModel.authController.countries,
            itemAsString: (model) => model.name ?? "",
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: newFontStyle0.copyWith(
                color: newColorDarkBlack2,
                fontSize: 15,
              ),
              dropdownSearchDecoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 13.5),
                suffixIconColor: Color(0xffADBCCB),
                isDense: true,
                hintText: langKey.chooseCountry.tr,
                hintStyle: TextStyle(color: Colors.black),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEEEEEE)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff929AAB)),
                ),
              ),
            ),
            onChanged: (CountryModel? newValue) {
              cityViewModel.setSelectedCountry(newValue!);
              viewModel.countryID.value = newValue.id!;
              cityViewModel.selectedCity.value = CountryModel();
              cityViewModel.cityId.value = 0;
              cityViewModel.authController.selectedCity.value = CountryModel();
              viewModel.countryErrorVisibility.value = false;
            },
            selectedItem: authController.newAcc.value == true
                ? cityViewModel.selectedCountry.value
                : cityViewModel.authController.selectedCountry.value,
          ),
          Obx(() => Visibility(
            visible: viewModel.countryErrorVisibility.value,
            child: Text(
              langKey.countryReq.tr,
              style: GoogleFonts.dmSans(
                color: Colors.red.shade700,
              ),
            ),
          ),
          )
        ],
      ),
    );
  }

  Widget cityPicker() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Obx(
        () => authController.cities.isEmpty
            ? Container()
            : authController.isLoading.isTrue
                ? CustomLoading(
                    isItForWidget: true,
                    color: kPrimaryColor,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          langKey.city.tr,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: newColorDarkBlack2,
                          ),
                        ),
                      ),
                      DropdownSearch<CountryModel>(
                        popupProps: PopupProps.dialog(
                          showSearchBox: true,
                          dialogProps: DialogProps(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          searchFieldProps: AppConstant.searchFieldProp(),
                        ),
                        items: cityViewModel.authController.cities,
                        itemAsString: (model) => model.name ?? "",
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: newFontStyle0.copyWith(
                            color: newColorDarkBlack2,
                            fontSize: 15,
                          ),
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 13.5),
                            suffixIconColor: Color(0xffADBCCB),
                            isDense: true,
                            hintText: langKey.chooseCountry.tr,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffEEEEEE)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff929AAB)),
                            ),
                          ),
                        ),
                        onChanged: (CountryModel? newValue) {
                          cityViewModel.selectedcity.value =
                              newValue!.name ?? "";
                          cityViewModel.setSelectedCity(newValue);
                          viewModel.cityID.value = newValue.id!;
                          viewModel.cityErrorVisibility.value = false;
                        },
                        selectedItem: authController.newAcc.value == true
                            ? cityViewModel.selectedCity.value
                            : cityViewModel.authController.selectedCity.value,
                      ),
                      Obx(() => Visibility(
                        visible: viewModel.cityErrorVisibility.value,
                        child: Text(
                          langKey.cityReq.tr,
                          style: GoogleFonts.dmSans(
                            color: Colors.red.shade700,
                          ),
                        ),
                      ),
                      )
                    ],
                  ),
      ),
    );
  }

  Widget checkBoxTermCondition() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 25, top: 5),
        child: CustomCheckBox(
          title: langKey.termsAndConditionsCheckbox.tr,
          value: viewModel.termAndCondition.value,
          onChanged: (value) {
            viewModel.termAndCondition.value = value;
          },
        ),
      ),
    );
  }

  Widget signUpBtn() {
    return Obx(
      () => GlobalVariable.showLoader.value
          ? CustomLoading(isItBtn: true)
          : CustomRoundedTextBtn(
              title: langKey.signUp.tr,
              onPressed: () {
                print('Sign Up Button Pressed');
                viewModel.signUp();
              },
            ),
    );
  }

  Widget alreadyHaveAnAccount() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Get.off(() => LogInView());
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: langKey.alreadyHaveAccount.tr + ' ',
                  style: newFontStyle0.copyWith(
                    color: newColorLightGrey2,
                  ),
                ),
                TextSpan(
                  text: langKey.signIn.tr,
                  style: newFontStyle2.copyWith(
                    color: newColorDarkBlack2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

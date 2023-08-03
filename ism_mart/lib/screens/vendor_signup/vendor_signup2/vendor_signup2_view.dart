import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/vendor_signup/vendor_signup2/vendor_signup2_viewmodel.dart';
import 'package:ism_mart/screens/vendor_signup/vendor_signup3/vendor_signup3_view.dart';
import 'package:ism_mart/widgets/back_button.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../helper/validator.dart';

class VendorSignUp2View extends StatelessWidget {
  VendorSignUp2View({Key? key}) : super(key: key);
  final VendorSignUp2ViewModel viewModel = Get.put(VendorSignUp2ViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: viewModel.vendorSignUp2FormKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleAndBackBtn(),
                      createAVendorAccount(),
                      progress(),
                      shopNameField(),
                      shopAddressField(),
                      ntnTextField(),
                      phoneNumberTextField(),
                      imageLayoutContainer(
                        title: 'CNIC',
                        subTitle: langKey.frontSide.tr,
                        filePath: '',
                        onTap: () {},
                      ),
                      imageLayoutContainer(
                        title: 'CNIC',
                        subTitle: langKey.backSide.tr,
                        filePath: '',
                        onTap: () {},
                      ),
                      imageLayoutContainer(
                        title: langKey.legalDocument.tr,
                        filePath: '',
                        onTap: () {},
                      ),
                      imageLayoutContainer(
                        title: langKey.shopLogoImage.tr,
                        filePath: '',
                        onTap: () {},
                      ),
                      submitBtn(),
                    ],
                  ),
                ),
              ),
            ),
            NoInternetView(
              onPressed: () {
                // viewModel.signUp();
              },
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
              'ISMMART',
              style: GoogleFonts.dmSerifText(
                color: Color(0xff333333),
                fontSize: 20,
                fontWeight: FontWeight.w400,
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

  Widget createAVendorAccount() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: langKey.add.tr,
              style: newFontStyle2.copyWith(
                fontSize: 20,
                color: newColorDarkBlack2,
              ),
            ),
            TextSpan(
              text: ' ${langKey.business.tr} ',
              style: newFontStyle2.copyWith(
                fontSize: 20,
                color: newColorBlue,
              ),
            ),
            TextSpan(
              text: langKey.information.tr,
              style: newFontStyle2.copyWith(
                fontSize: 20,
                color: newColorDarkBlack2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget progress() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  langKey.vendorAccountCreation.tr,
                  style: newFontStyle1.copyWith(
                    color: newColorBlue2,
                  ),
                ),
                SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: langKey.next.tr + '  ',
                        style: newFontStyle1.copyWith(
                          fontSize: 12,
                          color: newColorBlue4,
                        ),
                      ),
                      TextSpan(
                        text: langKey.profileStatus.tr,
                        style: newFontStyle1.copyWith(
                          fontSize: 12,
                          color: newColorBlue3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 33,
            lineWidth: 6,
            percent: 0.7,
            backgroundColor: Color(0xffEBEFF3),
            progressColor: Color(0xff0CBC8B),
            center: new Text(
              "2 of 3",
              style: poppinsH2.copyWith(
                color: newColorBlue2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget shopNameField() {
    return CustomTextField3(
      title: langKey.shopName.tr,
      hintText: langKey.youShopName.tr,
      //controller: viewModel.firstNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateName(value);
      },
    );
  }

  Widget shopAddressField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField3(
        title: langKey.shopAddress.tr,
        hintText: langKey.youShopAddress.tr,
        //controller: viewModel.fullNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateName(value);
        },
      ),
    );
  }

  Widget ntnTextField() {
    return CustomTextField3(
      title: 'NTN (${langKey.ifAvailable.tr})',
      hintText: langKey.yourShopNTNNumber.tr,
      //controller: viewModel.emailController,
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
          title: langKey.shopNumber.tr,
          hintText: '336 5563138',
          keyboardType: TextInputType.number,
          controller: viewModel.phoneNumberController,
          initialValue: viewModel.countryCode.value,
          textStyle: bodyText1,
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

  Widget submitBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: Obx(
        () => GlobalVariable.showLoader.value
            ? CustomLoading(isItBtn: true)
            : CustomRoundedTextBtn(
                title: langKey.submit.tr,
                onPressed: () {
                  Get.to(() => VendorSignUp3View());
                },
              ),
      ),
    );
  }

  Widget imageLayoutContainer({
    required void Function() onTap,
    required String title,
    String? subTitle,
    required String filePath,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: newFontStyle2.copyWith(
                color: newColorDarkBlack,
              ),
            ),
            if (subTitle != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  subTitle,
                  style: newFontStyle0.copyWith(
                    color: newColorBlue4,
                  ),
                ),
              ),
            Spacer(),
            Text(
              langKey.lessThanMb.tr,
              style: newFontStyle0.copyWith(
                color: newColorBlue4,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            InkWell(
              onTap: onTap,
              child: Text(
                langKey.chooseFile.tr,
                style: newFontStyle0.copyWith(
                  color: red2,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(width: 4),
            Text(
              filePath == '' ? langKey.noFileChosen.tr : filePath,
              style: newFontStyle0.copyWith(
                color: newColorBlue4,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xffEEEEEE),
          thickness: 1,
          height: 30,
        ),
      ],
    );
  }
}

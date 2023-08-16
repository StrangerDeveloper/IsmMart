import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/vendor_signup/vendor_signup3/vendor_signup3_viewmodel.dart';
import 'package:ism_mart/widgets/back_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../helper/validator.dart';
import '../../../widgets/image_layout_container.dart';

class VendorSignUp3View extends StatelessWidget {
  VendorSignUp3View({Key? key}) : super(key: key);
  final VendorSignUp3ViewModel viewModel = Get.put(VendorSignUp3ViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: viewModel.vendorSignUp3FormKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleAndBackBtn(),
                      createAVendorAccount(),
                      progress(),
                      bankNameTextField(),
                      bankAccountTitleTextField(),
                      bankAccountNumberTextField(),
                      Obx(() => branchCodeTextField()),
                      SizedBox(height: 20),

                      Obx(() => ImageLayoutContainer(
                        description: true,
                          title: langKey.chequeImage.tr,
                          filePath: viewModel.bankChequeImage.value == '' ? '' : basename(viewModel.bankChequeImage.value),
                          onTap: ()async{
                            await viewModel.selectImage(viewModel.bankChequeImage, viewModel.chequeImageErrorVisibility);
                          },
                          errorVisibility: viewModel.chequeImageErrorVisibility.value,
                          errorPrompt: langKey.chequeImageReq.tr
                        ),
                      ),
                      submitBtn(),
                    ],
                  ),
                ),
              ),
            ),
            // NoInternetView(
            //   onPressed: () {
            //     viewModel.signUp();
            //   },
            // ),
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
                  langKey.vendorBankAccount.tr,
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
              "3 of 4",
              style: poppinsH2.copyWith(
                color: newColorBlue2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bankNameTextField() {
    return CustomTextField3(
      title: langKey.bankName.tr,
      hintText: langKey.enterBankName.tr,
      controller: viewModel.bankNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateName(value, errorToPrompt: langKey.bankNameReq.tr);
      },
      keyboardType: TextInputType.text,
    );
  }

  Widget bankAccountTitleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField3(
        title: langKey.accountTitle.tr,
        hintText: langKey.enterAccountTitle.tr,
        controller: viewModel.bankAccTitleController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateName(value, errorToPrompt: langKey.bankAccHolderReq.tr);
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget bankAccountNumberTextField() {
    return CustomTextField3(
      title: langKey.bankAccountNumber.tr,
      hintText: langKey.enterAccountNumberOrIban.tr,
      controller: viewModel.bankAccNumberController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateBankAcc(value);
      },
      keyboardType: TextInputType.text,
    );
  }

  Widget branchCodeTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: CustomTextField3(
        enabled: viewModel.enableBranchCode.value,
          required: false,
          title: langKey.branchCode.tr,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            FilteringTextInputFormatter.digitsOnly,
          ],
          hintText: langKey.enterBranchCode.tr,
          controller: viewModel.branchCodeController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator().validateBranchCode(value, viewModel.bankAccNumberController.text);
          },
          keyboardType: TextInputType.number,
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
                onPressed: () async{
                  await viewModel.signUp();
                  // Get.to(() => VendorSignUp3View());
                },
              ),
      ),
    );
  }
}
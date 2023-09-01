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
import 'package:ism_mart/screens/update_vendor_profile/update_vendor_profile_viewmodel.dart';
import 'package:ism_mart/widgets/back_button.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../helper/validator.dart';

import '../../widgets/loader_view.dart';
import '../categories/model/category_model.dart';

class UpdateVendorProfileView extends StatelessWidget {
  UpdateVendorProfileView({super.key});

  // final VendorSignUp2ViewModel viewModel = Get.put(VendorSignUp2ViewModel());
  final UpdateVendorProfileViewModel viewModel =
      Get.put(UpdateVendorProfileViewModel(Get.find()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: viewModel.vendorUpdateProfileFormKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleAndBackBtn(),
                    createAVendorAccount(),
                    progress(),
                    shopNameField(),
                    shopCategoryField(),
                    shopAddressField(),
                    shopDescriptionTextField(),

                    GestureDetector(
                        onTap: () => showTermsAndConditionDialog(),
                        //_showMyDialog(context),
                        child: cnicFunctionlaity()),
                    //   ntnTextField(),
                    Obx(
                      () => viewModel.clickOnPhoneField.value
                          ? shopPhoneNoTextField()
                          : GestureDetector(
                              onTap: () {
                                viewModel.clickOnPhoneField.value = true;
                              },
                              child: phoneFunctionlaity()),
                    ),

                    //  ownerCNICField(),
                    countryPicker(),
                    cityPicker(),
                    // Obx(() => ImageLayoutContainer(
                    //     title: 'CNIC',
                    //     subTitle: langKey.frontSide.tr,
                    //     filePath: viewModel.cnicFrontImage.value == '' ? '' : basename(viewModel.cnicFrontImage.value),
                    //     onTap: () async{
                    //       await viewModel.selectImage(viewModel.cnicFrontImage, viewModel.cnicFrontErrorVisibility);
                    //     },
                    //     errorVisibility: viewModel.cnicFrontErrorVisibility.value,
                    //     errorPrompt: langKey.frontSideReq.tr
                    // ),
                    // ),
                    // Obx(()
                    // => ImageLayoutContainer(
                    //     title: 'CNIC',
                    //     subTitle: langKey.backSide.tr,
                    //     filePath: viewModel.cnicBackImage.value == '' ? '' : basename(viewModel.cnicBackImage.value),
                    //     onTap: () async{
                    //       await viewModel.selectImage(viewModel.cnicBackImage, viewModel.cnicBackErrorVisibility);
                    //     },
                    //     errorVisibility: viewModel.cnicBackErrorVisibility.value,
                    //     errorPrompt: langKey.backSideReq.tr
                    // )),
                    // Obx(() => ImageLayoutContainer(
                    //     title: langKey.storeLogoImage.tr,
                    //     filePath: viewModel.shopLogoImage.value == '' ? '' : basename(viewModel.shopLogoImage.value),
                    //     onTap: () async{
                    //       await viewModel.selectImage(viewModel.shopLogoImage, viewModel.shopImageErrorVisibility);
                    //     },
                    //     errorVisibility: viewModel.shopImageErrorVisibility.value,
                    //     errorPrompt: langKey.storeLogoImageReq.tr
                    // ),
                    // ),
                    //

                    submitBtn(),
                  ],
                ),
              ),
            ),
          ),
          NoInternetView(
            onPressed: () {
              viewModel.updateData();
            },
          ),
          LoaderView(),
        ],
      ),
    );
  }

  Widget phoneFunctionlaity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cnicText(langKey.storeNumber.tr, 16.0),
        SizedBox(
          height: 10,
        ),
        Obx(() => cnicText(viewModel.phone.value.toString(), 14.0,
            style: newFontStyle0.copyWith(
              color: newColorLightGrey2,
            ))),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget cnicFunctionlaity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cnicText("CNIC", 16.0),
        SizedBox(
          height: 10,
        ),
        Obx(() => cnicText(viewModel.cnic.value, 14.0,
            style: newFontStyle0.copyWith(
              color: newColorLightGrey2,
            ))),
        SizedBox(
          height: 20,
        )
      ],
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
              text: "Update",
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
                  "Vendor Account Updation",
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
                        text: langKey.bankDetails.tr,
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
          CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 33,
            lineWidth: 6,
            percent: 0.5,
            backgroundColor: Color(0xffEBEFF3),
            progressColor: Color(0xff0CBC8B),
            center: new Text(
              "2 of 4",
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
      keyboardType: TextInputType.text,
      title: langKey.storeName.tr,
      hintText: langKey.enterStoreName.tr,
      controller: viewModel.shopNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator()
            .validateName(value, errorToPrompt: langKey.storeNameReq.tr);
      },
    );
  }

  Widget shopCategoryField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: RichText(
                text: TextSpan(
                    text: langKey.storeCategory.tr,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: newColorDarkBlack2,
                    ),
                    children: [
                      TextSpan(
                        text: '*',
                        style: TextStyle(color: Colors.red),
                      )
                    ]),
              ),
            ),
            DropdownSearch<CategoryModel>(
              popupProps: PopupProps.dialog(
                showSearchBox: true,
                dialogProps: DialogProps(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                searchDelay: const Duration(milliseconds: 0),
                searchFieldProps: AppConstant.searchFieldProp(),
              ),
              items: viewModel.categoriesList,
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
              onChanged: (CategoryModel? newValue) {
                //  newValue!.id = viewModel.shopCategoryId.value;
                viewModel.selectedCategory.value = newValue!;
                viewModel.shopCategoryId.value = newValue.id!.toInt();
                viewModel.categoryErrorVisibility.value = false;
                print("cat--==---${viewModel.shopCategoryId.value}");
              },
              selectedItem: viewModel.selectedCategory.value,
            ),
            Visibility(
              visible: viewModel.categoryErrorVisibility.value,
              child: Text(
                langKey.categoryReq.tr,
                style: GoogleFonts.dmSans(
                  color: Colors.red.shade700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget shopAddressField() {
    return CustomTextField3(
      keyboardType: TextInputType.text,
      title: langKey.storeAddress.tr,
      hintText: langKey.enterShopAddress.tr,
      controller: viewModel.shopAddressController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateAddress(value);
      },
    );
  }

  Widget shopPhoneNoTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: CountryCodePickerTextField2(
          validator: (value) {
            return Validator().validatePhoneNumber(value);
          },
          title: langKey.storeNumber.tr,
          hintText: '336 5563138',
          keyboardType: TextInputType.number,
          autoValidateMode: AutovalidateMode.onUserInteraction,
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

  Widget countryPicker() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: RichText(
              text: TextSpan(
                text: langKey.storeCountry.tr,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: newColorDarkBlack2,
                ),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  )
                ],
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
            items: viewModel.countries,
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
              cityViewModel.selectedCity.value = CountryModel();
              cityViewModel.cityId.value = 0;
              viewModel.selectedCountry(newValue!);
              viewModel.countryID.value = newValue.id!;
              viewModel.getCitiesByCountry(countryId: newValue.id!);
              viewModel.countryErrorVisibility.value = false;
              viewModel.countryID.value = newValue.id!;
              print(
                  "country id ${newValue.id!} = ${viewModel.countryID.value}");
            },
            selectedItem: viewModel.selectedCountry.value,
          ),
          Visibility(
            visible: viewModel.countryErrorVisibility.value,
            child: Text(
              langKey.countryReq.tr,
              style: GoogleFonts.dmSans(
                color: Colors.red.shade700,
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
        () => viewModel.cities.isEmpty
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
                        child: RichText(
                          text: TextSpan(
                            text: langKey.storeCity.tr,
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: newColorDarkBlack2,
                            ),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
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
                        items: viewModel.cities,
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
                          viewModel.selectedCity(newValue!);
                          viewModel.cityErrorVisibility.value = false;
                          viewModel.cityID.value = newValue.id!;
                          print(
                              "selected city ${viewModel.cityID.value} = ${newValue.id!}");
                        },
                        selectedItem: viewModel.selectedCity.value,
                      ),
                      Visibility(
                        visible: viewModel.cityErrorVisibility.value,
                        child: Text(
                          langKey.cityReq.tr,
                          style: GoogleFonts.dmSans(
                            color: Colors.red.shade700,
                          ),
                        ),
                      )
                    ],
                  ),
      ),
    );
  }

  Widget ownerNameField() {
    return CustomTextField3(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]+|\s')),
      ],
      title: langKey.ownerName.tr,
      hintText: langKey.enterOwnerName.tr,
      controller: viewModel.ownerNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator()
            .validateName(value, errorToPrompt: langKey.ownerName.tr);
      },
    );
  }

  Widget cnicText(title, size, {style}) {
    return CustomText(
      title: title,
      style: style ??
          GoogleFonts.dmSans(
            fontSize: size,
            fontWeight: FontWeight.w700,
            color: newColorDarkBlack2,
          ),
    );
  }

  Widget ownerCNICField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField3(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly,
        ],
        title: langKey.vendorCNIC.tr,
        hintText: langKey.enterCNIC.tr,
        controller: viewModel.ownerCnicController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateCNIC(value);
        },
      ),
    );
  }

  Widget ntnTextField() {
    return CustomTextField3(
      required: false,
      title: 'NTN (${langKey.ifAvailable.tr})',
      hintText: langKey.enterNTNNumber.tr,
      controller: viewModel.ntnController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateNTN(value);
      },
      keyboardType: TextInputType.number,
    );
  }

  Widget shopDescriptionTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField3(
        title: langKey.storeDescription.tr,
        hintText: langKey.enterStoreDescription.tr,
        controller: viewModel.shopDescController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateDefaultTxtField(value,
              errorPrompt: langKey.storeDescReq.tr);
        },
        keyboardType: TextInputType.text,
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
                onPressed: () async {
                  await viewModel.updateData();
                  // Get.to(() => VendorSignUp3View());
                },
              ),
      ),
    );
  }

  // Future<void> _showMyDialog(context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'AlertDialog Title',
  //           style: GoogleFonts.dmSans(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w700,
  //             color: Colors.red,
  //           ),
  //         ),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(
  //                 'You can email us for Change your CNIC NO Photos and anyother senstive Information.',
  //                 style: newFontStyle0.copyWith(
  //                   color: newColorLightGrey2,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Text(
  //                 'support@ismmart.com',
  //                 style: GoogleFonts.dmSans(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w700,
  //                   color: newColorDarkBlack2,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text("ok",
  //                 style: GoogleFonts.dmSans(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w700,
  //                   color: Colors.green,
  //                 )),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  //dilaog box

  Future showTermsAndConditionDialog() async {
    return showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          content: Stack(
            alignment: Alignment.topRight,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Terms & conditions',
                      style: headline1.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 22, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'You can email us for Change your CNIC NO Photos and anyother senstive Information.',
                            style: newFontStyle0.copyWith(
                              color: newColorLightGrey2,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'support@ismmart.com',
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: newColorDarkBlack2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          actions: <Widget>[
            CustomRoundedTextBtn(
              width: 100,
              title: "Cancel",
              onPressed: () async {
                Get.back();
                // Get.to(() => VendorSignUp3View());
              },
            ),
          ],
        );
      },
    );
  }
}

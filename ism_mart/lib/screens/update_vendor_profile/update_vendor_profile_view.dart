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
import 'package:ism_mart/screens/vendor_signup/vendor_signup2/vendor_signup2_viewmodel.dart';
import 'package:ism_mart/widgets/back_button.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:path/path.dart';
import '../../../helper/validator.dart';
import '../../../widgets/image_layout_container.dart';
import '../categories/model/category_model.dart';

class UpdateVendorProfileView extends StatelessWidget {
   UpdateVendorProfileView({super.key});
  // final VendorSignUp2ViewModel viewModel = Get.put(VendorSignUp2ViewModel());
   final UpdateVendorProfileViewModel viewModel = Get.put(UpdateVendorProfileViewModel(Get.find()));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                    shopCategoryField(),
                    shopAddressField(),
                    shopDescriptionTextField(),
                //   ntnTextField(),
                    shopPhoneNoTextField(),
                    ownerCNICField(),
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
              viewModel.proceed();
            },
          ),
        ],
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
        return Validator().validateName(value, errorToPrompt: langKey.storeNameReq.tr);
      },
    );
  }

  Widget shopCategoryField() {
    return Obx(
          () =>
          Padding(
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
                        ]
                    ),
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
                    newValue!.id=    viewModel.  shopCategoryId.value;
                    viewModel.selectedCategory.value = newValue!;
                    // viewModel.shopCategoryId.value = newValue.id!.toInt();
                    viewModel.categoryErrorVisibility.value = false;
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
          validator: (value){
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
              viewModel. selectedCountry(newValue!);
              viewModel.countryID.value = newValue.id!;
            viewModel.  countryID.value=newValue.id!;
              viewModel.countryErrorVisibility.value = false;
            },
            selectedItem: viewModel. selectedCountry.value,
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
                // viewModel.selectedcity.value =
                //     newValue!.name ?? "";
                viewModel.selectedCity(newValue);
               // viewModel.cityID.value = newValue.id!;
                viewModel.cityErrorVisibility.value = false;
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
        return Validator().validateName(value, errorToPrompt: langKey.ownerName.tr);
      },
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
          return Validator().validateDefaultTxtField(value, errorPrompt: langKey.storeDescReq.tr);
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
          onPressed: () async{
            await viewModel.proceed();
            // Get.to(() => VendorSignUp3View());
          },
        ),
      ),
    );
  }
}






// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ism_mart/controllers/controllers.dart';
// import 'package:ism_mart/exports/export_presentation.dart';
// import 'package:ism_mart/exports/exports_model.dart';
// import 'package:ism_mart/exports/exports_utils.dart';
// import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
// import 'package:ism_mart/screens/update_vendor_profile/update_vendor_profile_viewmodel.dart';
// import 'package:ism_mart/widgets/custom_appbar.dart';
// import 'package:ism_mart/widgets/loader_view.dart';
// import 'package:ism_mart/widgets/pick_image.dart';
//
// import '../../helper/validator.dart';
//
// class UpdateVendorProfileView extends StatelessWidget {
//   UpdateVendorProfileView({super.key});
//
//   final UpdateVendorProfileViewModel viewModel =
//       Get.put(UpdateVendorProfileViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: viewModel.isRegisterScreen
//             ? langKey.vendorRegistration.tr
//             : langKey.updateVendorDetails.tr,
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//             child: Form(
//               key: viewModel.updateVendorFormKey,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 190,
//                     child: Stack(
//                       children: [
//                         coverImage(),
//                         profileImage(),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 5),
//                     child: CustomText(
//                       title: "${langKey.yourCoverAndProfile.tr} 2 MB",
//                       color: Colors.grey,
//                     ),
//                   ),
//                   ownerNameTextField(),
//                   storeNameTextField(),
//                   phoneTextField(),
//                   countryPicker(),
//                   SizedBox(height: 20),
//                   cityPicker(),
//                   SizedBox(height: 20),
//                   descriptionTextField(),
//                   bankNameTextField(),
//                   accountTitleTextField(),
//                   accountNumberTextField(),
//                   updateBtn(),
//                 ],
//               ),
//             ),
//           ),
//           LoaderView(),
//         ],
//       ),
//     );
//   }
//
//   Widget coverImage() {
//     return Obx(
//       () => Stack(
//         children: [
//           viewModel.coverImageFile.value?.path != ""
//               ? Container(
//                   height: 140,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(18),
//                     image: DecorationImage(
//                       image: FileImage(viewModel.coverImageFile.value!),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 )
//               : CachedNetworkImage(
//                   height: 140,
//                   width: double.infinity,
//                   imageUrl: viewModel.userModel.value?.vendor?.coverImage ?? '',
//                   imageBuilder: (context, imageProvider) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(18),
//                         image: DecorationImage(
//                           image: imageProvider,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },
//                   errorWidget: (context, url, error) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(18),
//                         image: DecorationImage(
//                           image: AssetImage('assets/images/no_image_found.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },
//                   placeholder: (context, url) {
//                     return const Center(
//                       child: CircularProgressIndicator(strokeWidth: 0.5),
//                     );
//                   },
//                 ),
//           Positioned(
//             right: 10,
//             bottom: 6,
//             child: InkWell(
//               onTap: () async {
//                 viewModel.coverImageFile.value =
//                     await PickImage().pickSingleImage();
//               },
//               child: Container(
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.edit_outlined,
//                   size: 13,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget profileImage() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//             ),
//             padding: EdgeInsets.all(3.5),
//             child: Obx(
//               () => viewModel.profileImageFile.value?.path != ""
//                   ? Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: FileImage(viewModel.profileImageFile.value!),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     )
//                   : CachedNetworkImage(
//                       height: 95,
//                       width: 95,
//                       imageUrl:
//                           viewModel.userModel.value?.vendor?.storeImage ?? '',
//                       imageBuilder: (context, imageProvider) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                               image: imageProvider,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         );
//                       },
//                       errorWidget: (context, url, error) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                               image: AssetImage(
//                                   'assets/images/no_image_found.jpg'),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       },
//                       placeholder: (context, url) {
//                         return const Center(
//                           child: CircularProgressIndicator(strokeWidth: 0.5),
//                         );
//                       },
//                     ),
//             ),
//           ),
//           Positioned(
//             right: 10,
//             bottom: 6,
//             child: InkWell(
//               onTap: () async {
//                 viewModel.profileImageFile.value =
//                     await PickImage().pickSingleImage();
//               },
//               child: Container(
//                 padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.edit_outlined,
//                   size: 13,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget ownerNameTextField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 25, bottom: 20),
//       child: CustomTextField2(
//         label: langKey.ownerName.tr,
//         controller: viewModel.ownerNameController,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateName(value, errorToPrompt: langKey.ownerName.tr);
//         },
//       ),
//     );
//   }
//
//   Widget storeNameTextField() {
//     return CustomTextField2(
//       label: langKey.storeName.tr,
//       controller: viewModel.storeNameController,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       validator: (value) {
//         return Validator().validateDefaultTxtField(value);
//       },
//     );
//   }
//
//   Widget phoneTextField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: CustomTextField2(
//         label: langKey.phone.tr,
//         controller: viewModel.phoneController,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validatePhoneNumber(value);
//         },
//       ),
//     );
//   }
//
//   Widget countryPicker() {
//     return Obx(
//       () => DropdownSearch<CountryModel>(
//         popupProps: PopupProps.dialog(
//           showSearchBox: true,
//           dialogProps: DialogProps(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           searchFieldProps: AppConstant.searchFieldProp(),
//         ),
//         items: cityViewModel.authController.countries,
//         itemAsString: (model) => model.name ?? "",
//         dropdownDecoratorProps: DropDownDecoratorProps(
//           baseStyle: bodyText1,
//           dropdownSearchDecoration: InputDecoration(
//             isDense: true,
//             labelText: langKey.selectCountry.tr,
//             labelStyle: bodyText1,
//             hintText: langKey.chooseCountry.tr,
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.black,
//                 width: 1,
//                 style: BorderStyle.solid,
//               ),
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//         onChanged: (CountryModel? newValue) {
//           cityViewModel.setSelectedCountry(newValue!);
//         },
//         selectedItem: authController.newAcc.value == true
//             ? cityViewModel.selectedCountry.value
//             : cityViewModel.authController.selectedCountry.value,
//       ),
//     );
//   }
//
//   Widget cityPicker() {
//     return Obx(
//       () => authController.cities.isEmpty
//           ? Container()
//           : authController.isLoading.isTrue
//               ? CustomLoading(
//                   isItForWidget: true,
//                   color: kPrimaryColor,
//                 )
//               : DropdownSearch<CountryModel>(
//                   popupProps: PopupProps.dialog(
//                     showSearchBox: true,
//                     dialogProps: DialogProps(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     searchFieldProps: AppConstant.searchFieldProp(),
//                   ),
//                   items: cityViewModel.authController.cities,
//                   itemAsString: (model) => model.name ?? "",
//                   dropdownDecoratorProps: DropDownDecoratorProps(
//                     baseStyle: bodyText1,
//                     dropdownSearchDecoration: InputDecoration(
//                       isDense: true,
//                       labelText: langKey.selectCity.tr,
//                       labelStyle: bodyText1,
//                       hintText: langKey.chooseCity.tr,
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                             color: Colors.black,
//                             width: 1,
//                             style: BorderStyle.solid), //B
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                   onChanged: (CountryModel? newValue) {
//                     cityViewModel.selectedcity.value = newValue!.name ?? "";
//                     cityViewModel.setSelectedCity(newValue);
//                   },
//                   selectedItem: authController.newAcc.value == true
//                       ? cityViewModel.selectedCity.value
//                       : cityViewModel.authController.selectedCity.value,
//                 ),
//     );
//   }
//
//   Widget descriptionTextField() {
//     return CustomTextField2(
//       label: langKey.description.tr,
//       controller: viewModel.descriptionController,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       validator: (value) {
//         return Validator().validateDefaultTxtField(value);
//       },
//     );
//   }
//
//   Widget bankNameTextField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: CustomTextField2(
//         label: langKey.bankName.tr,
//         controller: viewModel.bankNameController,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateDefaultTxtField(value);
//         },
//       ),
//     );
//   }
//
//   Widget accountTitleTextField() {
//     return CustomTextField2(
//       label: langKey.bankAccountHolder.tr,
//       controller: viewModel.accountTitleController,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       validator: (value) {
//         return Validator().validateDefaultTxtField(value);
//       },
//     );
//   }
//
//   Widget accountNumberTextField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20, bottom: 30),
//       child: CustomTextField2(
//         label: langKey.branchCode.tr,
//         controller: viewModel.accountNumberController,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateDefaultTxtField(value);
//         },
//       ),
//     );
//   }
//
//   Widget updateBtn() {
//     return CustomTextBtn(
//       onPressed: () {
//         viewModel.updateData();
//       },
//       child: Text(
//         viewModel.isRegisterScreen ? langKey.register.tr : langKey.updateBtn.tr,
//       ),
//     );
//   }
// }

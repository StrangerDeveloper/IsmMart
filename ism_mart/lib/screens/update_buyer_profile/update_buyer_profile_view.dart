import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/screens/update_buyer_profile/update_buyer_profile_viewmodel.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/pick_image.dart';

import '../../helper/constants.dart';
import '../../helper/validator.dart';

class UpdateBuyerProfileView extends StatelessWidget {
  UpdateBuyerProfileView({Key? key}) : super(key: key);
  final UpdateBuyerProfileViewModel viewModel =
      Get.put(UpdateBuyerProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: langKey.profile.tr,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: viewModel.buyerProfileFormKey,
                child: Column(
                  children: [
                    profileImage(),
                    firstNameTextField(),
                    lastNameTextField(),
                    phoneTextField(),
                    addressTextField(),
                    selectCountry(),
                    selectCity(),
                    SizedBox(height: 25),
                    updateBtn(),
                  ],
                ),
              ),
            ),
            NoInternetView(
              onPressed: () {
                // viewModel.getData();
                viewModel.updateData();
              },
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  Widget profileImage() {
    return Stack(
      children: [
        Obx(
          () => (viewModel.imageFile.value?.path != "")
              ? Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(viewModel.imageFile.value!),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  height: 100,
                  width: 100,
                  imageUrl: viewModel.buyerProfileNewModel.value.image ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/no_image_found.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 0.5),
                    );
                  },
                ),
        ),
        Positioned(
          right: 10,
          bottom: 6,
          child: InkWell(
            onTap: () async {
              viewModel.imageFile.value = await PickImage().pickSingleImage();
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 13,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget firstNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 20),
      child: CustomTextField2(
        label: langKey.firstName.tr,
        controller: viewModel.firstNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateName(value, errorToPrompt: langKey.firstName.tr);
        },
      ),
    );
  }

  Widget lastNameTextField() {
    return CustomTextField2(
      label: langKey.lastName.tr,
      controller: viewModel.lastNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateName(value, errorToPrompt: langKey.lastName.tr);
      },
    );
  }

  Widget phoneTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField2(
        label: langKey.phone.tr,
        controller: viewModel.phoneController,
        keyboardType: TextInputType.phone,
        inputFormatters: Validator().phoneNumberFormatter,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validatePhoneNumber(value);
        },
      ),
    );
  }

  Widget addressTextField() {
    return CustomTextField2(
      label: langKey.address.tr,
      controller: viewModel.addressController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateDefaultTxtField(value);
      },
    );
  }

  Widget selectCountry() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 15),
      child: DropdownSearch<CountryModel>(
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
        items: cityViewModel.authController.countries,
        itemAsString: (model) => model.name ?? "",
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: bodyText1,
          dropdownSearchDecoration: InputDecoration(
            labelText: langKey.selectCountry.tr,
            labelStyle: headline3,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.shade700,
                width: 1,
                style: BorderStyle.solid,
              ), //B
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ), //B
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ), //B
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onChanged: (CountryModel? newValue) {
          cityViewModel.setSelectedCountry(newValue!);
          viewModel.countryID.value = newValue.id!;
          cityViewModel.selectedCity.value = CountryModel();
          cityViewModel.cityId.value = 0;
          viewModel.cityID.value = 0;
          viewModel.selectedCountry.value = newValue;
          cityViewModel.authController.selectedCity.value = CountryModel();
        },
        selectedItem: viewModel.selectedCountry.value,
        validator: (value){
          return Validator().validateCountry(viewModel.selectedCountry.value);
        },
      ),
    );
  }

  Widget selectCity() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownSearch<CountryModel>(
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
        items: cityViewModel.authController.cities,
        itemAsString: (model) => model.name ?? "",
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: bodyText1,
          dropdownSearchDecoration: InputDecoration(
            labelText: langKey.selectCity.tr,
            labelStyle: headline3,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.shade700,
                width: 1,
                style: BorderStyle.solid,
              ), //B
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ), //B
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ), //B
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onChanged: (CountryModel? newValue) {
          cityViewModel.selectedcity.value =
              newValue!.name ?? "";
          viewModel.selectedCity.value = newValue;
          cityViewModel.setSelectedCity(newValue);
          viewModel.cityID.value = newValue.id!;
        },
        selectedItem: viewModel.selectedCity.value,
        validator: (value){
          return Validator().validateCountry(viewModel.selectedCountry.value);
        },
      ),
    );
  }

  Widget updateBtn() {
    return CustomTextBtn(
      onPressed: () {
        viewModel.updateData();
      },
      child: Text(langKey.updateProfile.tr),
    );
  }
}
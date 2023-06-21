import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/screens/update_vendor/update_vendor_viewmodel.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/pick_image.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import '../../helper/validator.dart';

class UpdateVendorView extends StatelessWidget {
  UpdateVendorView({super.key});

  final UpdateVendorViewModel viewModel = Get.put(UpdateVendorViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: viewModel.isRegisterScreen
          ? langKey.vendorRegistration.tr
          : langKey.updateVendorDetails.tr,),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: viewModel.updateVendorFormKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 190,
                    child: Stack(
                      children: [
                        coverImage(),
                        profileImage(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: CustomText(
                      title: "${langKey.yourCoverAndProfile.tr} 2 MB",
                      color: Colors.grey,
                    ),
                  ),
                  ownerNameTextField(),
                  storeNameTextField(),
                  phoneTextField(),
                  countryPicker(),
                  SizedBox(height: 20),
                  cityPicker(),
                  SizedBox(height: 20),
                  descriptionTextField(),
                  bankNameTextField(),
                  accountTitleTextField(),
                  accountNumberTextField(),
                  updateBtn(),
                ],
              ),
            ),
          ),
          LoaderView(),
        ],
      ),
    );
  }

  Widget coverImage() {
    return Obx(
      () => Stack(
        children: [
          viewModel.coverImageFile.value?.path != ""
              ? Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      image: FileImage(viewModel.coverImageFile.value!),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  height: 140,
                  width: double.infinity,
                  imageUrl: viewModel.userModel.value?.vendor?.coverImage ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
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
          Positioned(
            right: 10,
            bottom: 6,
            child: InkWell(
              onTap: () async {
                viewModel.coverImageFile.value =  await PickImage().pickSingleImage();
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
      ),
    );
  }

  Widget profileImage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(3.5),
            child: Obx(
              () => viewModel.profileImageFile.value?.path != ""
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(viewModel.profileImageFile.value!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      height: 95,
                      width: 95,
                      imageUrl:
                          viewModel.userModel.value?.vendor?.storeImage ?? '',
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
                              image: AssetImage(
                                  'assets/images/no_image_found.jpg'),
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
          ),
          Positioned(
            right: 10,
            bottom: 6,
            child: InkWell(
              onTap: () async {
                viewModel.profileImageFile.value =
                    await PickImage().pickSingleImage();
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
      ),
    );
  }

  Widget ownerNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 20),
      child: CustomTextField2(
        label: langKey.ownerName.tr,
        controller: viewModel.ownerNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateName(value);
        },
      ),
    );
  }

  Widget storeNameTextField() {
    return CustomTextField2(
      label: langKey.storeName.tr,
      controller: viewModel.storeNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateDefaultTxtField(value);
      },
    );
  }

  Widget phoneTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField2(
        label: langKey.phone.tr,
        controller: viewModel.phoneController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validatePhoneNumber(value);
        },
      ),
    );
  }

  Widget countryPicker() {
    return Obx(
      () => DropdownSearch<CountryModel>(
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
          baseStyle: bodyText1,
          dropdownSearchDecoration: InputDecoration(
            labelText: langKey.selectCountry.tr,
            labelStyle: bodyText1,
            hintText: langKey.chooseCountry.tr,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onChanged: (CountryModel? newValue) {
          cityViewModel.setSelectedCountry(newValue!);
        },
        selectedItem: authController.newAcc.value == true
            ? cityViewModel.selectedCountry.value
            : cityViewModel.authController.selectedCountry.value,
      ),
    );
  }

  Widget cityPicker() {
    return Obx(
      () => authController.cities.isEmpty
          ? Container()
          : authController.isLoading.isTrue
              ? CustomLoading(
                  isItForWidget: true,
                  color: kPrimaryColor,
                )
              : DropdownSearch<CountryModel>(
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
                    baseStyle: bodyText1,
                    dropdownSearchDecoration: InputDecoration(
                      labelText: langKey.selectCity.tr,
                      labelStyle: bodyText1,
                      hintText: langKey.chooseCity.tr,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid), //B
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onChanged: (CountryModel? newValue) {
                    cityViewModel.selectedcity.value = newValue!.name ?? "";
                    cityViewModel.setSelectedCity(newValue);
                  },
                  selectedItem: authController.newAcc.value == true
                      ? cityViewModel.selectedCity.value
                      : cityViewModel.authController.selectedCity.value,
                ),
    );
  }

  Widget descriptionTextField() {
    return CustomTextField2(
      label: langKey.description.tr,
      controller: viewModel.descriptionController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateDefaultTxtField(value);
      },
    );
  }

  Widget bankNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField2(
        label: langKey.bankName.tr,
        controller: viewModel.bankNameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateDefaultTxtField(value);
        },
      ),
    );
  }

  Widget accountTitleTextField() {
    return CustomTextField2(
      label: langKey.bankAccountHolder.tr,
      controller: viewModel.accountTitleController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateDefaultTxtField(value);
      },
    );
  }

  Widget accountNumberTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: CustomTextField2(
        label: langKey.bankAccount.tr,
        controller: viewModel.accountNumberController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateDefaultTxtField(value);
        },
      ),
    );
  }

  Widget updateBtn() {
    return CustomTextBtn(
      onPressed: () {
        viewModel.updateData();
      },
      child: Text(
        viewModel.isRegisterScreen ? langKey.register.tr : langKey.updateBtn.tr,
      ),
    );
  }
}

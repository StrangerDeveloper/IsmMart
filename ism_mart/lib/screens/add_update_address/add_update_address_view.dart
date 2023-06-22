import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/add_update_address/add_update_address_viewmodel.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import '../../controllers/controllers.dart';
import '../../helper/validator.dart';
import '../../models/user/country_city_model.dart';
import '../../exports/exports_utils.dart';
import '../../widgets/loader_view.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class AddUpdateAddressView extends StatelessWidget {
  AddUpdateAddressView({super.key});

  final AddUpdateAddressViewModel viewModel =
      Get.put(AddUpdateAddressViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: viewModel.isUpdateScreen
              ? langKey.updateShippingAdd.tr
              : langKey.addShippingAdd.tr,
          leading: InkWell(
            onTap:() {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
              size: 18,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: viewModel.shippingAddressFormKey,
                child: Column(
                  children: [
                    fullNameTextField(),
                    phoneTextField(),
                    zipCodeTextField(),
                    addressTextField(),
                    countryPicker(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: cityPicker(),
                    ),
                    submitBtn(),
                  ],
                ),
              ),
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  Widget fullNameTextField() {
    return CustomTextField2(
      label: langKey.fullName.tr,
      controller: viewModel.fullNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateName(value);
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
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^(?:[+])?\d*'))
        ],
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validatePhoneNumber(value);
        },
      ),
    );
  }

  Widget zipCodeTextField() {
    return CustomTextField2(
      label: langKey.zipCode.tr,
      controller: viewModel.zipCodeController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      validator: (value) {
        return Validator().validateDefaultTxtField(value);
      },
    );
  }

  Widget addressTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField2(
        label: langKey.address.tr,
        controller: viewModel.addressController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateDefaultTxtField(value);
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
                            style: BorderStyle.solid),
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

  Widget submitBtn() {
    return CustomTextBtn(
      onPressed: () {
        viewModel.isUpdateScreen
            ? viewModel.updateShippingAddress()
            : viewModel.addShippingAddress();
      },
      child: Text(
        viewModel.isUpdateScreen ? langKey.updateBtn.tr : langKey.add.tr,
      ),
    );
  }
}
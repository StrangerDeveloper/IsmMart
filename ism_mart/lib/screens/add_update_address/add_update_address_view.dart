// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:ism_mart/exports/export_presentation.dart';
// import 'package:ism_mart/screens/add_update_address/add_update_address_viewmodel.dart';
// import '../../controllers/controllers.dart';
// import '../../models/user/country_city_model.dart';
// import '../../utils/exports_utils.dart';
// import '../../widgets/loader_view.dart';
// import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
//
// class AddUpdateAddressView extends StatelessWidget {
//   AddUpdateAddressView({super.key});
//
//   final AddUpdateAddressViewModel viewModel =
//       Get.put(AddUpdateAddressViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: appBar(),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               padding: EdgeInsets.all(16),
//               child: Form(
//                 key: viewModel.shippingAddressFormKey,
//                 child: Column(
//                   children: [
//                     nameTextField(),
//                     phoneTextField(),
//                     zipCodeTextField(),
//                     addressTextField(),
//                     countryPicker(),
//                     SizedBox(height: 20),
//                     cityPicker(),
//                     submitBtn(),
//                   ],
//                 ),
//               ),
//             ),
//             LoaderView(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   AppBar appBar() {
//     return AppBar(
//       backgroundColor: kAppBarColor,
//       leading: InkWell(
//         onTap: () => Get.back(),
//         child: Icon(
//           Icons.arrow_back_ios_new,
//           size: 18,
//           color: kPrimaryColor,
//         ),
//       ),
//       title: CustomText(title: 'Address', style: appBarTitleSize),
//     );
//   }
//
//   Widget nameTextField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 30, bottom: 20),
//       child: CustomTextField2(
//         label: langKey.firstName.tr,
//         controller: viewModel.nameController,
//         keyboardType: TextInputType.name,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateName(value);
//         },
//       ),
//     );
//   }
//
//   Widget addressTextField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: CustomTextField2(
//         label: langKey.lastName.tr,
//         controller: viewModel.addressController,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateDefaultTxtField(value);
//         },
//       ),
//     );
//   }
//
//   Widget zipCodeTextField() {
//     return CustomTextField2(
//       label: langKey.lastName.tr,
//       controller: viewModel.zipCodeController,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       keyboardType: TextInputType.number,
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
//         keyboardType: TextInputType.phone,
//         inputFormatters: [
//           FilteringTextInputFormatter.allow(RegExp(r'^(?:[+])?\d*'))
//         ],
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
//   Widget submitBtn() {
//     return CustomTextBtn(
//       onPressed: () {
//
//       },
//       child: Text(
//         true ? langKey.updateBtn.tr : langKey.add.tr,
//       ),
//     );
//   }
// }

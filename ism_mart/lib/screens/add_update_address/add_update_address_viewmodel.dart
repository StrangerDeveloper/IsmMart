// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ism_mart/helper/urls.dart';
// import '../../controllers/controllers.dart';
// import '../../helper/api_base_helper.dart';
// import '../../helper/global_variables.dart';
// import '../../models/exports_model.dart';
// import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
// import '../../widgets/getx_helper.dart';
//
// class AddUpdateAddressViewModel extends GetxController {
//
//   bool isUpdateScreen = false;
//   GlobalKey<FormState> shippingAddressFormKey = GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController zipCodeController = TextEditingController();
//   List<UserModel> shippingAddressList = <UserModel>[].obs;
//
//   @override
//   void onInit() {
//     isUpdateScreen = Get.arguments['isUpdateScreen'];
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     nameController.dispose();
//     phoneController.dispose();
//     addressController.dispose();
//     zipCodeController.dispose();
//     super.onClose();
//   }
//
//   void addShippingAddress() {
//     if (shippingAddressFormKey.currentState?.validate() ?? false) {
//       Map<String, dynamic> param = {
//         "name": nameController.text,
//         "address": addressController.text,
//         "phoneNumber": phoneController.text,
//         "zipCode": zipCodeController.text,
//         "countryId":
//             cityViewModel.authController.selectedCountry.value.id?.toString() ??
//                 '',
//         "cityId":
//             cityViewModel.authController.selectedCity.value.id?.toString() ?? ''
//       };
//
//       GlobalVariable.showLoader.value = true;
//
//       ApiBaseHelper()
//           .postMethod(url: Urls.addShippingDetails, body: param)
//           .then((parsedJson) {
//         GlobalVariable.showLoader.value = false;
//         print(parsedJson);
//
//         if (parsedJson['success'] == true) {
//           GetxHelper.showSnackBar(
//             title: langKey.successTitle.tr,
//             message: parsedJson['message'],
//           );
//         } else {
//           GetxHelper.showSnackBar(
//             title: langKey.errorTitle.tr,
//             message: parsedJson['message'],
//           );
//         }
//       }).catchError((e) {
//         print(e);
//         GlobalVariable.showLoader.value = false;
//       });
//     }
//   }
//
//   void updateShippingAddress() {
//     // if (shippingAddressFormKey.currentState?.validate() ?? false) {
//     //   Map<String, dynamic> param = {
//     //     "id": "${userModel?.id}",
//     //     "name": nameController.text,
//     //     "address": addressController.text,
//     //     "phoneNumber": phoneController.text,
//     //     "zipCode": zipCodeController.text,
//     //     "countryId": "${userModel?.country!.id}",
//     //     "cityId": "${userModel?.city!.id}"
//     //   };
//     //
//     //   GlobalVariable.showLoader.value = true;
//     //
//     //   ApiBaseHelper()
//     //       .putMethod(url: Urls.updateShippingDetails, body: param)
//     //       .then((parsedJson) {
//     //     GlobalVariable.showLoader.value = false;
//     //     print(parsedJson);
//     //
//     //     if (parsedJson['success'] == true) {
//     //       GetxHelper.showSnackBar(
//     //         title: langKey.successTitle.tr,
//     //         message: parsedJson['message'],
//     //       );
//     //     } else {
//     //       GetxHelper.showSnackBar(
//     //         title: langKey.errorTitle.tr,
//     //         message: parsedJson['message'],
//     //       );
//     //     }
//     //   }).catchError((e) {
//     //     print(e);
//     //     GlobalVariable.showLoader.value = false;
//     //   });
//     // }
//   }
// }

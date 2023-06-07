// import 'package:get/get.dart';
// import 'package:ism_mart/api_helper/api_base_helper.dart';
// import 'package:ism_mart/api_helper/global_variables.dart';
// import 'package:ism_mart/api_helper/urls.dart';
// import 'package:ism_mart/models/exports_model.dart';
// import 'package:ism_mart/utils/exports_utils.dart';
//
// class MyProductsViewModel extends GetxController {
//   List<ProductModel> myProductsList = <ProductModel>[].obs;
//   int productsLimit = 7;
//   int page = 1;
//
//   @override
//   void onReady() {
//     getData();
//     super.onReady();
//   }
//
//   getData() {
//     GlobalVariable.showLoader.value = true;
//
//     ApiBaseHelper()
//         .getMethod(
//             url: '${Urls.getMyProducts}limit=${productsLimit}&page=${page}',
//             withAuthorization: true)
//         .then((parsedJson) {
//       GlobalVariable.showLoader.value = false;
//       if (parsedJson['message'] == 'Products fetched successfully') {
//         myProductsList.clear();
//         var data = parsedJson['data'] as List;
//         myProductsList.addAll(data.map((e) => ProductModel.fromJson(e)));
//       } else {
//         AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
//       }
//     }).catchError((e) {
//       print(e);
//       GlobalVariable.showLoader.value = false;
//     });
//   }
// }

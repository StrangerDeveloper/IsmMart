// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';
// import 'package:ism_mart/exports/export_widgets.dart';
// import 'package:ism_mart/helper/constants.dart';
// import 'package:ism_mart/helper/global_variables.dart';
// import 'package:ism_mart/helper/no_internet_view.dart';
// import 'package:ism_mart/helper/validator.dart';
// import 'package:ism_mart/screens/add_product/add_product_viewmodel.dart';
// import 'package:ism_mart/screens/categories/model/category_model.dart';
// import 'package:ism_mart/screens/categories/model/product_variants_model.dart';
// import 'package:ism_mart/widgets/custom_appbar.dart';
// import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
// import 'package:ism_mart/widgets/loader_view.dart';
//
// import '../categories/model/sub_category_model.dart';
//
// class AddProductCategoryFieldsView extends StatelessWidget {
//   AddProductCategoryFieldsView({super.key});
//   final AddProductViewModel viewModel = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: CustomAppBar(
//           title: langKey.addProduct.tr,
//           leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: kPrimaryColor,
//               size: 18,
//             ),
//           ),
//         ),
//         body: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Form(
//                     key: viewModel.formKeyCategoryField,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           ///Product Category Field
//                           Obx(() => selectCategoryField()),
//
//                           ///Product Sub Category Dropdown Field
//                           Obx(() => viewModel.subCategoriesList.isEmpty
//                               ? Container()
//                               : selectSubCategoryField()),
//
//                           Obx(() => viewModel.isStockContainsInVariants.value
//                               ? Container()
//                               : stockField()),
//
//                           ///Product Category fields or variants or features
//                           productVariantsAndFeaturesField(),
//
//                           ///Product Basic Details
//
//                           SizedBox(height: 40),
//                           CustomTextBtn(
//                             onPressed: () {
//                               viewModel.addProdBtnPress();
//                             },
//                             title: langKey.addProduct.tr,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             NoInternetView(
//               onPressed: () => viewModel.addProdBtnPress(),
//             ),
//             LoaderView(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget selectCategoryField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 20.0, bottom: 15),
//       child: DropdownSearch<CategoryModel>(
//         popupProps: PopupProps.dialog(
//           showSearchBox: true,
//           dialogProps: DialogProps(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           searchDelay: const Duration(milliseconds: 0),
//           searchFieldProps: AppConstant.searchFieldProp(),
//         ),
//         items: viewModel.categoriesList,
//         itemAsString: (model) => model.name ?? "",
//         dropdownDecoratorProps: DropDownDecoratorProps(
//           baseStyle: bodyText1,
//           dropdownSearchDecoration: InputDecoration(
//             labelText: langKey.selectCategory.tr,
//             labelStyle: headline3,
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: Colors.black,
//                 width: 1,
//                 style: BorderStyle.solid,
//               ), //B
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//         onChanged: (CategoryModel? newValue) {
//           viewModel.setSelectedCategory(category: newValue!);
//         },
//         selectedItem: viewModel.selectedCategory.value,
//       ),
//     );
//   }
//
//   selectSubCategoryField() {
//     return DropdownSearch<SubCategory>(
//       popupProps: PopupProps.dialog(
//         showSearchBox: true,
//         dialogProps: DialogProps(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         searchFieldProps: AppConstant.searchFieldProp(),
//       ),
//       items: viewModel.subCategoriesList,
//       itemAsString: (model) => model.name ?? "",
//       dropdownDecoratorProps: DropDownDecoratorProps(
//         baseStyle: bodyText1,
//         dropdownSearchDecoration: InputDecoration(
//           labelText: langKey.selectSubCategory.tr,
//           labelStyle: headline3,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.black,
//               width: 1,
//               style: BorderStyle.solid,
//             ),
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       ),
//       onChanged: (SubCategory? newValue) {
//         viewModel.setSelectedSubCategory(subCategory: newValue!);
//       },
//       selectedItem: viewModel.selectedSubCategory.value,
//     );
//   }
//
//   Widget stockField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: CustomTextField2(
//         inputFormatters: [
//           FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//           FilteringTextInputFormatter.digitsOnly
//         ],
//         controller: viewModel.prodStockController,
//         prefixIcon: Icons.inventory_outlined,
//         label: langKey.prodStock.tr,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateDefaultTxtField(value);
//         },
//         keyboardType: TextInputType.number,
//       ),
//     );
//   }
//
//   Widget productVariantsAndFeaturesField() {
//     return Obx(
//       () => viewModel.productVariantsFieldsList.isEmpty
//           ? Container()
//           : Padding(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: Column(
//                 children: [
//                   CustomText(
//                     title: langKey.productVariant.tr,
//                     style: headline2,
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   GlobalVariable.showLoader.isTrue
//                       ? CustomLoading(
//                           isItBtn: true,
//                           //isItForWidget: true,
//                         )
//                       : ListView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: viewModel.productVariantsFieldsList.length,
//                           itemBuilder: (_, index) {
//                             ProductVariantsModel variantsModel =
//                                 viewModel.productVariantsFieldsList[index];
//
//                             return Column(
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 //displaying the parent one
//                                 _singleProductVariantListItem(variantsModel,
//                                     icon: Icons.add_circle_outline, onTap: () {
//                                   variantsModel.isNewField = true;
//                                   variantsModel.moreFieldOptionList!
//                                       .add(variantsModel);
//                                   viewModel.productVariantsFieldsList.refresh();
//                                 }),
//
//                                 /// after pressing AddICon more fields would be generated
//                                 if (variantsModel
//                                     .moreFieldOptionList!.isNotEmpty)
//                                   Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: variantsModel.moreFieldOptionList!
//                                         .map((element) =>
//                                             _singleProductVariantListItem(
//                                                 variantsModel,
//                                                 icon:
//                                                     Icons.remove_circle_outline,
//                                                 onTap: () {
//                                               variantsModel.isNewField = false;
//                                               variantsModel.moreFieldOptionList!
//                                                   .remove(variantsModel);
//                                               viewModel
//                                                   .productVariantsFieldsList
//                                                   .refresh();
//                                             }))
//                                         .toList(),
//                                   ),
//                               ],
//                             );
//                           },
//                         ),
//                 ],
//               ),
//             ),
//     );
//   }
//
//   Widget _singleProductVariantListItem(ProductVariantsModel model,
//       {onTap, icon}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 _categoryOptionField(model: model),
//                 SizedBox(height: 10),
//                 if (model.categoryFieldOptions!.isNotEmpty)
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: model.categoryFieldOptions!
//                         .map((element) => _categoryOptionField(
//                             model: element, icon: Icons.inventory_2_outlined))
//                         .toList(),
//                   ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: onTap,
//             icon: Icon(icon),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _categoryOptionField({ProductVariantsModel? model, icon}) {
//     return CustomTextField2(
//       prefixIcon: icon ?? IconlyLight.discovery,
//       keyboardType: TextInputType.text,
//       onChanged: (value) => viewModel.onDynamicFieldsValueChanged(value, model),
//       label: model!.label,
//       autoValidateMode: AutovalidateMode.onUserInteraction,
//       validator: (value) {
//         return Validator().validateDefaultTxtField(value);
//       },
//     );
//   }
// }

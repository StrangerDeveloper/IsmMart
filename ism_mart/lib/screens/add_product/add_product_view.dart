// import 'dart:io';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';
// import 'package:ism_mart/widgets/custom_appbar.dart';
// import 'package:ism_mart/exports/export_presentation.dart';
// import 'package:ism_mart/screens/add_product/add_product_viewmodel.dart';
// import 'package:ism_mart/exports/exports_utils.dart';
// import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
// import 'package:ism_mart/widgets/pick_image.dart';
// import '../../helper/validator.dart';
//
// class AddProductView extends StatelessWidget {
//   AddProductView({Key? key}) : super(key: key);
//   final AddProductViewModel viewModel = Get.put(AddProductViewModel());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: langKey.addProduct.tr,
//         leading: InkWell(
//           onTap: () {
//             Get.back();
//           },
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: kPrimaryColor,
//             size: 18,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Form(
//                   key: viewModel.formKey,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ///Upload Images Section
//                         _buildImageSection(),
//
//                         ///Product Basic Details
//                         nameField(),
//                         priceField(),
//                         discountField(),
//                         descriptionField(),
//                         weightAndDimensionsSection(),
//
//                         SizedBox(height: 40),
//                         CustomTextBtn(
//                           onPressed: () {
//                             //Get.to(() => AddProductCategoryFieldsView());
//                             if (viewModel.formKey.currentState!.validate())
//                               Get.toNamed(Routes.addProductCategoryFields);
//                             //viewModel.addProdBtnPress();
//                           },
//                           title: langKey.next.tr,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _showImages() {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: viewModel.productImages.length,
//       itemBuilder: (BuildContext, index) {
//         File file = viewModel.productImages[index];
//         return Container(
//           width: 60,
//           margin: EdgeInsets.all(5),
//           padding: const EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Image.file(file),
//               Positioned(
//                 right: 0,
//                 child: CustomActionIcon(
//                   width: 25,
//                   height: 25,
//                   onTap: () {
//                     viewModel.imagesSizeInMb.value -=
//                         (file.lengthSync() * 0.000001);
//                     viewModel.productImages.removeAt(index);
//                     if (viewModel.productImages.length == 0) {
//                       viewModel.uploadImagesError.value = true;
//                     }
//                   },
//                   hasShadow: false,
//                   icon: Icons.close_rounded,
//                   bgColor: kPrimaryColor.withOpacity(0.2),
//                   iconColor: kPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildImageSection() {
//     return GestureDetector(
//       onTap: () async {
//         viewModel.productImages.addAll(await PickImage().pickMultipleImage());
//         if (viewModel.productImages.isNotEmpty) {
//           viewModel.uploadImagesError.value = false;
//         }
//       },
//       child: Obx(
//         () => Column(
//           children: [
//             DottedBorder(
//               borderType: BorderType.RRect,
//               radius: const Radius.circular(10),
//               dashPattern: const [10, 4],
//               strokeCap: StrokeCap.round,
//               color: viewModel.imagesSizeInMb.value > 2.0
//                   ? kRedColor
//                   : kPrimaryColor,
//               child: Container(
//                 width: double.infinity,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: viewModel.productImages.isNotEmpty
//                     ? _showImages()
//                     : Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.cloud_upload_rounded,
//                             size: 30,
//                           ),
//                           const SizedBox(height: 5),
//                           CustomText(
//                             title: langKey.clickHereToUpload.tr,
//                             color: kLightColor,
//                           ),
//                         ],
//                       ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
//               child: CustomText(
//                 title: "${langKey.uploadImageLessThan.tr} 2MB",
//                 color: viewModel.imagesSizeInMb.value > 2.0
//                     ? kRedColor
//                     : kLightColor,
//               ),
//             ),
//             Visibility(
//               visible: viewModel.uploadImagesError.value,
//               child: CustomText(
//                 title: 'Upload images to add product',
//                 color: kRedColor,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget nameField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: CustomTextField2(
//         prefixIcon: IconlyLight.paper_plus,
//         controller: viewModel.prodNameController,
//         label: langKey.productName.tr,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateDefaultTxtField(value);
//         },
//         keyboardType: TextInputType.name,
//       ),
//     );
//   }
//
//   Widget priceField() {
//     return Padding(
//       padding: EdgeInsets.only(top: viewModel.fieldsPaddingSpace),
//       child: Column(
//         children: [
//           CustomTextField2(
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//               FilteringTextInputFormatter.digitsOnly
//             ],
//             prefixIcon: IconlyLight.wallet,
//             controller: viewModel.prodPriceController,
//             label: langKey.prodPrice.tr,
//             autoValidateMode: AutovalidateMode.onUserInteraction,
//             validator: (value) {
//               return Validator().validateDefaultTxtField(value);
//             },
//             onChanged: (value) {
//               viewModel.onPriceFieldChange(value);
//             },
//             keyboardType: TextInputType.number,
//           ),
//           // Obx(
//           //   () => Visibility(
//           //     visible: viewModel.prodPriceController.text.isNotEmpty,
//           //     child: Padding(
//           //       padding: const EdgeInsets.only(top: 4.0),
//           //       // child: CustomText(
//           //       //   title:
//           //       //       "${langKey.finalPriceWould.tr} ${viewModel.priceAfterCommission.value} ${langKey.afterPlatformFee.tr} 5%",
//           //       //   color: kRedColor,
//           //       // ),
//           //     ),
//           //   ),
//           // )
//         ],
//       ),
//     );
//   }
//
//   Widget discountField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: Column(
//         children: [
//           CustomTextField2(
//             controller: viewModel.prodDiscountController,
//             prefixIcon: IconlyLight.discount,
//             label: langKey.prodDiscount.tr,
//             onChanged: (value) {
//               int discount = value.isNotEmpty ? int.parse(value) : 0;
//               viewModel.setDiscount(discount);
//             },
//             keyboardType: TextInputType.number,
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//               FilteringTextInputFormatter.digitsOnly
//             ],
//           ),
//           Obx(
//             () => Visibility(
//               visible: viewModel.prodDiscountController.text.isNotEmpty,
//               child: CustomText(
//                 title: viewModel.discountMessage.value,
//                 color: kRedColor,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget descriptionField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: CustomTextField2(
//         controller: viewModel.prodDescriptionController,
//         label: langKey.description.tr,
//         prefixIcon: IconlyLight.document,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateDefaultTxtField(value);
//         },
//         keyboardType: TextInputType.text,
//       ),
//     );
//   }
//
//   Widget weightAndDimensionsSection() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 30.0),
//       child: Column(
//         children: [
//           CustomText(
//             title: langKey.weightAndDimension.tr,
//             style: headline2,
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           weightField(),
//           lengthField(),
//           widthField(),
//           heightField()
//         ],
//       ),
//     );
//   }
//
//   Widget weightField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: CustomTextField2(
//         controller: viewModel.prodWeightController,
//         label: langKey.weight.tr,
//         prefixIcon: Icons.scale_outlined,
//         autoValidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           return Validator().validateWeightField(value!);
//         },
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//         ],
//       ),
//     );
//   }
//
//   Widget lengthField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: CustomTextField2(
//         controller: viewModel.prodLengthController,
//         label: langKey.length.tr,
//         prefixIcon: Icons.numbers,
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//         ],
//       ),
//     );
//   }
//
//   Widget widthField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: CustomTextField2(
//         controller: viewModel.prodWidthController,
//         label: langKey.width.tr,
//         prefixIcon: Icons.numbers,
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//         ],
//       ),
//     );
//   }
//
//   Widget heightField() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: CustomTextField2(
//         controller: viewModel.prodHeightController,
//         label: langKey.height.tr,
//         prefixIcon: Icons.numbers,
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/add_product/add_product_viewmodel.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/pick_image.dart';
import '../../helper/validator.dart';

class AddProductView extends StatelessWidget {
  AddProductView({Key? key}) : super(key: key);
  final AddProductViewModel viewModel = Get.put(AddProductViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar(
          title: langKey.addProduct.tr,
          leading: InkWell(
            onTap: () {
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
              child: Column(
                children: [
                  Form(
                    key: viewModel.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///Upload Images Section
                          _buildImageSection(),

                          ///Product Category Field
                          Obx(() => selectCategoryField()),

                          ///Product Sub Category Dropdown Field
                          Obx(() => viewModel.subCategoriesList.isEmpty
                              ? Container()
                              : selectSubCategoryField()),

                          ///Product Category fields or variants or features
                          productVariantsAndFeaturesField(),

                          ///Product Basic Details
                          nameField(),
                          priceField(),
                          stockField(),
                          discountField(),
                          descriptionField(),
                          weightAndDimensionsSection(),
                          SizedBox(height: 40),
                          CustomTextBtn(
                            onPressed: () {
                              viewModel.addProdBtnPress();
                            },
                            title: langKey.addProduct.tr,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            NoInternetView(
              onPressed: () => viewModel.addProdBtnPress(),
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  // Widget _createDynamicFormFields(ProductVariantsModel model) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: TextFormField(
  //       style: bodyText1,
  //       cursorColor: kPrimaryColor,
  //       keyboardType: TextInputType.text,
  //       onChanged: (value) =>
  //           viewModel.onDynamicFieldsValueChanged(value, model),
  //       decoration: InputDecoration(
  //         labelText: model.label,
  //         labelStyle: bodyText1,
  //         prefixIcon: Icon(
  //           IconlyLight.discovery,
  //           color: kPrimaryColor,
  //         ),
  //         enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: Colors.black,
  //             width: 1,
  //             style: BorderStyle.solid,
  //           ), //B
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(
  //             color: Colors.black,
  //             width: 1,
  //             style: BorderStyle.solid,
  //           ),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //       ),
  //     ),
  //   );
  //}

  Widget _showImages() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: viewModel.productImages.length,
      itemBuilder: (BuildContext, index) {
        File file = viewModel.productImages[index];
        return Container(
          width: 60,
          margin: EdgeInsets.all(5),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(file),
              Positioned(
                right: 0,
                child: CustomActionIcon(
                  width: 25,
                  height: 25,
                  onTap: () {
                    viewModel.imagesSizeInMb.value -=
                        (file.lengthSync() * 0.000001);
                    viewModel.productImages.removeAt(index);
                    if (viewModel.productImages.length == 0) {
                      viewModel.uploadImagesError.value = true;
                    }
                  },
                  hasShadow: false,
                  icon: Icons.close_rounded,
                  bgColor: kPrimaryColor.withOpacity(0.2),
                  iconColor: kPrimaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSection() {
    return GestureDetector(
      onTap: () async {
        viewModel.productImages.addAll(await PickImage().pickMultipleImage());
        if (viewModel.productImages.isNotEmpty) {
          viewModel.uploadImagesError.value = false;
        }
      },
      child: Obx(
        () => Column(
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [10, 4],
              strokeCap: StrokeCap.round,
              color: viewModel.imagesSizeInMb.value > 2.0
                  ? kRedColor
                  : kPrimaryColor,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: viewModel.productImages.isNotEmpty
                    ? _showImages()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.cloud_upload_rounded,
                            size: 30,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            title: langKey.clickHereToUpload.tr,
                            color: kLightColor,
                          ),
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: CustomText(
                title: "${langKey.uploadImageLessThan.tr} 2MB",
                color: viewModel.imagesSizeInMb.value > 2.0
                    ? kRedColor
                    : kLightColor,
              ),
            ),
            Visibility(
              visible: viewModel.uploadImagesError.value,
              child: CustomText(
                title: 'Upload images to add product',
                color: kRedColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectCategoryField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 15),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 15),
        child: DropdownSearch<CategoryModel>(
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
            baseStyle: bodyText1,
            dropdownSearchDecoration: InputDecoration(
              labelText: langKey.selectCategory.tr,
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
          onChanged: (CategoryModel? newValue) {
            viewModel.setSelectedCategory(category: newValue!);
          },
          selectedItem: viewModel.selectedCategory.value,
          validator: (value) {
            return Validator()
                .validateCategoryField(viewModel.selectedCategory.value);
          },
        ),
      ),
    );
  }

  selectSubCategoryField() {
    return DropdownSearch<SubCategory>(
      validator: (value) {
        return Validator()
            .validateSubCategoryField(viewModel.selectedSubCategory.value);
      },
      popupProps: PopupProps.dialog(
        showSearchBox: true,
        dialogProps: DialogProps(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        searchFieldProps: AppConstant.searchFieldProp(),
      ),
      items: viewModel.subCategoriesList,
      itemAsString: (model) => model.name ?? "",
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: bodyText1,
        dropdownSearchDecoration: InputDecoration(
          labelText: langKey.selectSubCategory.tr,
          labelStyle: headline3,
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
      onChanged: (SubCategory? newValue) {
        viewModel.setSelectedSubCategory(subCategory: newValue!);
      },
      selectedItem: viewModel.selectedSubCategory.value,
    );
  }

  Widget nameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        prefixIcon: IconlyLight.paper_plus,
        controller: viewModel.prodNameController,
        label: langKey.productName.tr,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator()
              .validateName(value, errorToPrompt: langKey.productNameReq.tr);
        },
        keyboardType: TextInputType.name,
      ),
    );
  }

  Widget priceField() {
    return Padding(
      padding: EdgeInsets.only(top: viewModel.fieldsPaddingSpace),
      child: Column(
        children: [
          CustomTextField2(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
            prefixIcon: IconlyLight.wallet,
            controller: viewModel.prodPriceController,
            label: langKey.prodPrice.tr,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return Validator().validateDefaultTxtField(value,
                  errorPrompt: langKey.prodPriceReq.tr);
            },
            onChanged: (value) {
              viewModel.onPriceFieldChange(value);
            },
            keyboardType: TextInputType.number,
          ),
          // Obx(
          //   () => Visibility(
          //     visible: viewModel.prodPriceController.text.isNotEmpty,
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 4.0),
          //       // child: CustomText(
          //       //   title:
          //       //       "${langKey.finalPriceWould.tr} ${viewModel.priceAfterCommission.value} ${langKey.afterPlatformFee.tr} 5%",
          //       //   color: kRedColor,
          //       // ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget productVariantsAndFeaturesField() {
    return Obx(
      () => viewModel.productVariantsFieldsList.isEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  CustomText(
                    title: langKey.productVariant.tr,
                    style: headline2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: viewModel.productVariantsFieldsList
                        .map((variantsModel) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          //displaying the parent one
                          _singleProductVariantListItem(variantsModel,
                              icon: CupertinoIcons.add_circled_solid,
                              onTap: () {
                            variantsModel.isNewField = true;
                            variantsModel.moreFieldOptionList!
                                .add(variantsModel);
                            viewModel.productVariantsFieldsList.refresh();
                          }),

                          /// after pressing AddICon more fields would be generated
                          if (variantsModel.moreFieldOptionList!.isNotEmpty)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: variantsModel.moreFieldOptionList!
                                  .map((element) =>
                                      _singleProductVariantListItem(
                                          variantsModel,
                                          icon: CupertinoIcons.clear_circled,
                                          onTap: () {
                                        variantsModel.isNewField = false;
                                        variantsModel.moreFieldOptionList!
                                            .remove(variantsModel);
                                        viewModel.productVariantsFieldsList
                                            .refresh();
                                      }))
                                  .toList(),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _singleProductVariantListItem(ProductVariantsModel model,
      {onTap, icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                _categoryOptionField(model: model),
                // SizedBox(height: 10),
                // if (model.categoryFieldOptions!.isNotEmpty)
                //   Column(
                //     mainAxisSize: MainAxisSize.min,
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: model.categoryFieldOptions!
                //         .map((element) => _categoryOptionField(
                //             model: element, icon: Icons.inventory_2_outlined))
                //         .toList(),
                //   ),
              ],
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(icon),
          ),
        ],
      ),
    );
  }

  Widget _categoryOptionField({ProductVariantsModel? model, icon}) {
    return CustomTextField2(
      prefixIcon: icon ?? IconlyLight.discovery,
      keyboardType: TextInputType.text,
      onChanged: (value) => viewModel.onDynamicFieldsValueChanged(value, model),
      label: model!.label,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator().validateDefaultTxtField(value);
      },
    );
  }

  Widget stockField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: viewModel.prodStockController,
        prefixIcon: Icons.inventory_outlined,
        label: langKey.prodStock.tr,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator()
              .validateDefaultTxtField(value, errorPrompt: prodStockReq.tr);
        },
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget discountField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: [
          CustomTextField2(
            controller: viewModel.prodDiscountController,
            prefixIcon: IconlyLight.discount,
            label: langKey.prodDiscount.tr,
            onChanged: (value) {
              int discount = value.isNotEmpty ? int.parse(value) : 0;
              viewModel.setDiscount(discount);
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          Obx(
            () => Visibility(
              visible: viewModel.prodDiscountController.text.isNotEmpty,
              child: CustomText(
                title: viewModel.discountMessage.value,
                color: kRedColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget descriptionField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodDescriptionController,
        label: langKey.description.tr,
        prefixIcon: IconlyLight.document,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateDefaultTxtField(value,
              errorPrompt: langKey.descriptionReq.tr);
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget weightAndDimensionsSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Column(
        children: [
          CustomText(
            title: langKey.weightAndDimension.tr,
            style: headline2,
          ),
          SizedBox(
            height: 15,
          ),
          weightField(),
          lengthField(),
          widthField(),
          heightField()
        ],
      ),
    );
  }

  Widget weightField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodWeightController,
        label: langKey.weight.tr,
        prefixIcon: Icons.scale_outlined,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateWeightField(value!);
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
      ),
    );
  }

  Widget lengthField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodLengthController,
        label: langKey.length.tr,
        prefixIcon: Icons.numbers,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
      ),
    );
  }

  Widget widthField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodWidthController,
        label: langKey.width.tr,
        prefixIcon: Icons.numbers,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
      ),
    );
  }

  Widget heightField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodHeightController,
        label: langKey.height.tr,
        prefixIcon: Icons.numbers,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
      ),
    );
  }
}

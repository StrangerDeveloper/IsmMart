import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/add_product/add_product_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/pick_image.dart';

class AddProductsView extends StatelessWidget {
  AddProductsView({Key? key}) : super(key: key);
  final AddProductViewModel viewModel = Get.put(AddProductViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CustomActionIcon(
              icon: Icons.arrow_back_ios,
              iconColor: kPrimaryColor,
              size: 23,
              onTap: () => Get.back(),
            ),
          ),
          title: CustomText(
            title: langKey.addProduct.tr,
            style: headline2,
          ),
        ),
        body: Stack(
            children: [
              SingleChildScrollView(
                physics: ScrollPhysics(),
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
                            //Upload Images Section
                            _buildImageSection(),

                            //Product Category Field
                            Obx(() => selectCategoryField()
                            ),

                            //ProductSub Category Dropdown Field
                            Obx(() => viewModel.subCategoriesList.isEmpty
                                    ? Container()
                                    : selectSubCategoryField()
                            ),

                            ///Product Category fields or variants or features
                            productVariantsAndFeaturesField(),

                            AppConstant.spaceWidget(height: 15),
                            Column(
                              children: [
                                nameField(),
                                Obx(
                                      () =>
                                      Visibility(
                                        visible: viewModel
                                            .prodPriceController.text
                                            .isNotEmpty,
                                        child: CustomText(
                                          title:
                                          "${langKey.finalPriceWould
                                              .tr} ${viewModel
                                              .priceAfterCommission
                                              .value} ${langKey.afterPlatformFee
                                              .tr} 5%",
                                          color: kRedColor,
                                        ),
                                      ),
                                )
                              ],
                            ),
                            AppConstant.spaceWidget(height: 15),
                            FormInputFieldWithIcon(
                              controller: viewModel.prodStockController,
                              iconPrefix: Icons.inventory_outlined,
                              labelText: langKey.prodStock.tr,
                              iconColor: kPrimaryColor,
                              autofocus: false,
                              textStyle: bodyText1,
                              autoValidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: (value) =>
                              !GetUtils.isNumericOnly(value!)
                                  ? langKey.prodStockReq.tr
                                  : null,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              onSaved: (value) {},
                            ),
                            AppConstant.spaceWidget(height: 15),
                            Column(
                              children: [
                                FormInputFieldWithIcon(
                                  controller: viewModel.prodDiscountController,
                                  iconPrefix: IconlyLight.discount,
                                  labelText: langKey.prodDiscount.tr,
                                  iconColor: kPrimaryColor,
                                  autofocus: false,
                                  textStyle: bodyText1,
                                  keyboardType: TextInputType.number,
                                  onChanged: (String? value) {
                                    int discount =
                                    value!.isNotEmpty ? int.parse(value) : 0;
                                    viewModel.setDiscount(discount);
                                  },
                                  onSaved: (value) {},
                                ),
                                Obx(
                                      () =>
                                      Visibility(
                                        visible: viewModel
                                            .prodDiscountController.text
                                            .isNotEmpty,
                                        child: CustomText(
                                          title: viewModel.discountMessage
                                              .value,
                                          color: kRedColor,
                                        ),
                                      ),
                                )
                              ],
                            ),
                            AppConstant.spaceWidget(height: 15),
                            FormInputFieldWithIcon(
                              controller: viewModel.prodDescriptionController,
                              iconPrefix: IconlyLight.document,
                              labelText: langKey.description.tr,
                              iconColor: kPrimaryColor,
                              autofocus: false,
                              textStyle: bodyText1,
                              autoValidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                              GetUtils.isBlank(value!)!
                                  ? langKey.descriptionReq.tr
                                  : null,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                              onSaved: (value) {},
                            ),

                            AppConstant.spaceWidget(height: 40),
                            CustomButton(
                              onTap: () {
                                if (viewModel.formKey.currentState!
                                    .validate()) {
                                  if (viewModel.subCategoriesList.isNotEmpty) {
                                    if (viewModel.discountMessage.isEmpty) {
                                      if(!viewModel.uploadImagesError.value)
                                      viewModel.addProduct();
                                    } else {
                                      AppConstant.displaySnackBar(
                                        langKey.errorTitle,
                                        langKey.yourDiscountShould.tr,
                                      );
                                    }
                                  } else {
                                    AppConstant.displaySnackBar(
                                        langKey.errorTitle,
                                        langKey.plzSelectSubCategory.tr);
                                  }
                                }
                              },
                              text: langKey.addProduct.tr,
                              height: 50,
                              width: 300,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              LoaderView(),
            ]
        ),
      ),
    );
  }

  Widget _createDynamicFormFields(ProductVariantsModel model) {
    //controller.newVariantModel = model;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: bodyText1,
        cursorColor: kPrimaryColor,
        keyboardType: TextInputType.text,
        onChanged: (value) =>
            viewModel.onDynamicFieldsValueChanged(value, model),
        decoration: InputDecoration(
          labelText: model.label,
          //hintText: model.placeholder,
          labelStyle: bodyText1,
          prefixIcon: Icon(
            IconlyLight.discovery,
            color: kPrimaryColor,
          ),
          //hintStyle: bodyText2,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid), //B
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid), //B
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  _showImages() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: viewModel.productImages.length,
      itemBuilder: (_, index) {
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
                    viewModel.imagesSizeInMb.value -= (file.lengthSync() * 0.000001);
                    viewModel.productImages.removeAt(index);
                    if(viewModel.productImages.length == 0){
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

  _buildImageSection() {
    return GestureDetector(
      onTap: ()async{
        viewModel.productImages.addAll(
          await PickImage().pickMultipleImage()
        );
        if(viewModel.productImages.isNotEmpty){
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

  Padding selectCategoryField(){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 15),
      child: DropdownSearch<CategoryModel>(
        popupProps: PopupProps.dialog(
            showSearchBox: true,
            dialogProps: DialogProps(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10))),
            searchDelay: const Duration(milliseconds: 0),
            searchFieldProps:
            AppConstant.searchFieldProp()),
        //showSelectedItems: true),
        items: viewModel.categoriesList,
        itemAsString: (model) => model.name ?? "",
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: bodyText1,
          dropdownSearchDecoration: InputDecoration(
            labelText: langKey.selectCategory.tr,
            labelStyle: headline3,

            // hintText: "Choose Sub Category",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid), //B
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        onChanged: (CategoryModel? newValue) {
          viewModel.setSelectedCategory(
              category: newValue!);
          //debugPrint(">>> $newValue");
        },
        selectedItem: viewModel.selectedCategory.value,
      ),
    );
  }

  selectSubCategoryField(){
    return DropdownSearch<SubCategory>(
      popupProps: PopupProps.dialog(
        showSearchBox: true,
        dialogProps: DialogProps(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10))),
        searchFieldProps:
        AppConstant.searchFieldProp(),
      ),
      //showSelectedItems: true),

      items: viewModel.subCategoriesList,
      itemAsString: (model) => model.name ?? "",
      dropdownDecoratorProps:
      DropDownDecoratorProps(
        baseStyle: bodyText1,
        dropdownSearchDecoration: InputDecoration(
          labelText: langKey.selectSubCategory.tr,
          labelStyle: headline3,
          // hintText: "Choose Sub Category",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid), //B
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      onChanged: (SubCategory? newValue) {
        viewModel.setSelectedSubCategory(
            subCategory: newValue!);
        //debugPrint(">>> $newValue");
      },

      selectedItem: viewModel.selectedSubCategory.value,
    );
  }

  CustomTextField2 nameField(){
    return CustomTextField2(
      controller: viewModel.prodNameController,
      label: langKey.productName.tr,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        return GetUtils.isBlank(value!)! ? langKey.productNameReq.tr : null;
      },
      keyboardType: TextInputType.name,
    );
  }

  CustomTextField2 priceField(){
    return CustomTextField2(
      controller: viewModel.prodPriceController,
      label: langKey.prodPrice.tr,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value){
        return GetUtils.isBlank(value!)! ? langKey.prodPriceReq.tr : null;
      },
      onChanged: (value){
        viewModel.onPriceFieldChange(value);
      },
      keyboardType: TextInputType.number,
    );
  }

  productVariantsAndFeaturesField() {
    return Obx(() => viewModel.productVariantsFieldsList.isEmpty ?
    Container() : Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
        children: viewModel.productVariantsFieldsList.map((element) =>
            _createDynamicFormFields(element))
            .toList(),
      ),
    ),
    );
  }
}

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class AddProductsUI extends GetView<SellersController> {
  const AddProductsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: langKey.addProduct.tr,
                        style: headline2,
                      ),
                      CustomActionIcon(
                        onTap: () => Get.back(),
                        hasShadow: false,
                        icon: Icons.close_rounded,
                        bgColor: kPrimaryColor.withOpacity(0.2),
                        iconColor: kPrimaryColor,
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildImageSection(),
                        AppConstant.spaceWidget(height: 20),

                        ///TOO: Category
                        Obx(
                          () => DropdownSearch<CategoryModel>(
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
                            items: controller.categoriesList,
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
                              controller.setSelectedCategory(
                                  category: newValue!);
                              //debugPrint(">>> $newValue");
                            },
                            selectedItem: controller.selectedCategory.value,
                          ),
                        ),
                        AppConstant.spaceWidget(height: 15),

                        ///TOO: Sub Category
                        Obx(
                          () => controller.subCategoriesList.isEmpty
                              ? Container()
                              : DropdownSearch<SubCategory>(
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

                                  items: controller.subCategoriesList,
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
                                    controller.setSelectedSubCategory(
                                        subCategory: newValue!);
                                    //debugPrint(">>> $newValue");
                                  },

                                  selectedItem:
                                      controller.selectedSubCategory.value,
                                ),
                        ),
                        AppConstant.spaceWidget(height: 15),
                        Obx(() => controller.productVariantsFieldsList.isEmpty
                            ? Container()
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: controller.productVariantsFieldsList
                                    .map((element) =>
                                        _createDynamicFormFields(element))
                                    .toList(),
                              )),

                        AppConstant.spaceWidget(height: 15),
                        FormInputFieldWithIcon(
                          controller: controller.prodNameController,
                          iconPrefix: IconlyLight.paper_plus,
                          labelText: langKey.productName.tr,
                          iconColor: kPrimaryColor,
                          autofocus: false,
                          textStyle: bodyText1,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => GetUtils.isBlank(value!)!
                              ? langKey.productNameReq.tr
                              : null,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),
                        AppConstant.spaceWidget(height: 15),
                        Column(
                          children: [
                            FormInputFieldWithIcon(
                              controller: controller.prodPriceController,
                              iconPrefix: IconlyLight.wallet,
                              labelText: langKey.prodPrice.tr,
                              iconColor: kPrimaryColor,
                              autofocus: false,
                              textStyle: bodyText1,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  !GetUtils.isNumericOnly(value!)
                                      ? langKey.prodPriceReq.tr
                                      : null,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  int amount = int.parse(value);
                                  int totalAfter = amount + (amount * 0.05).round();
                                  controller.priceAfterCommission(totalAfter);
                                } else {
                                  controller.priceAfterCommission(0);
                                }
                              },
                              onSaved: (value) {},
                            ),
                            Obx(() => Visibility(
                                  visible: controller
                                      .prodPriceController.text.isNotEmpty,
                                  child: CustomText(
                                    title:
                                        "Final price would be Rs ${controller.priceAfterCommission.value} after platform fee of 5%",
                                    color: kRedColor,
                                  ),
                                ))
                          ],
                        ),
                        AppConstant.spaceWidget(height: 15),
                        FormInputFieldWithIcon(
                          controller: controller.prodStockController,
                          iconPrefix: Icons.inventory_outlined,
                          labelText: langKey.prodStock.tr,
                          iconColor: kPrimaryColor,
                          autofocus: false,
                          textStyle: bodyText1,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => !GetUtils.isNumericOnly(value!)
                              ? langKey.prodStockReq.tr
                              : null,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),
                        AppConstant.spaceWidget(height: 15),
                        FormInputFieldWithIcon(
                          controller: controller.prodDiscountController,
                          iconPrefix: IconlyLight.discount,
                          labelText: langKey.prodDiscount.tr,
                          iconColor: kPrimaryColor,
                          autofocus: false,
                          textStyle: bodyText1,
                          /* autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => !GetUtils.isNumericOnly(value!)
                              ? langKey.prodDiscountReq
                              : null,*/
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),
                        /* AppConstant.spaceWidget(height: 15),
                        FormInputFieldWithIcon(
                          controller: controller.prodSKUController,
                          iconPrefix: IconlyLight.bookmark,
                          labelText: langKey.prodSku.tr,
                          iconColor: kPrimaryColor,
                          autofocus: false,
                          textStyle: bodyText1,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => GetUtils.isBlank(value!)!
                              ? langKey.prodSkuReq.tr
                              : null,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),*/
                        AppConstant.spaceWidget(height: 15),
                        FormInputFieldWithIcon(
                          controller: controller.prodDescriptionController,
                          iconPrefix: IconlyLight.document,
                          labelText: langKey.description.tr,
                          iconColor: kPrimaryColor,
                          autofocus: false,
                          textStyle: bodyText1,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => GetUtils.isBlank(value!)!
                              ? langKey.descriptionReq.tr
                              : null,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),

                        AppConstant.spaceWidget(height: 40),
                        Obx(
                          () => controller.isLoading.isTrue
                              ? CustomLoading(isItBtn: true)
                              : CustomButton(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      if (controller.categoryController
                                          .subCategories.isNotEmpty) {
                                        controller.addProduct();
                                      } else {
                                        AppConstant.displaySnackBar('error',
                                            langKey.plzSelectSubCategory.tr);
                                      }
                                    }
                                  },
                                  text: langKey.addProduct.tr,
                                  height: 50,
                                  width: 300,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDynamicFormFields(ProductVariantsModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: bodyText1,
        cursorColor: kPrimaryColor,
        keyboardType: TextInputType.text,
        onChanged: (value) =>
            controller.onDynamicFieldsValueChanged(value, model),
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
    return FormInputFieldWithIcon(
      controller: controller.prodDescriptionController,
      iconPrefix: IconlyLight.document,
      labelText: langKey.description.tr,
      iconColor: kPrimaryColor,
      autofocus: false,
      textStyle: bodyText1,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          GetUtils.isBlank(value!)! ? langKey.descriptionReq.tr : null,
      keyboardType: TextInputType.text,
      onChanged: (value) {},
      onSaved: (value) {},
    );
  }

  /*Widget _chooseProductImage() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          title: "Pick from",
          //barrierDismissible: false,
          contentPadding: const EdgeInsets.all(10),
          titleStyle: appBarTitleSize,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _imageBtn(
                onTap: () => controller.pickOrCaptureImageGallery(0),
                title: "Camera",
                icon: Icons.camera_alt_rounded,
                color: Colors.blue,
              ),
              _imageBtn(
                onTap: () => controller.pickOrCaptureImageGallery(1),
                title: "Gallery",
                icon: Icons.photo_library_rounded,
                color: Colors.redAccent,
              ),
            ],
          ),
          //onCancel: ()=>Get.back()
        );
      },
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            */ /* Container(
                color: Colors.black12,
                width: 80,
                height: 80,
                child: controller.imagePath.value.isNotEmpty
                    ? Image.file(File(controller.imagePath.value))
                    : Icon(Icons.image)),*/ /*
            controller.pickedImagesList.isNotEmpty
                ? _showImages()
                : _buildImageSection(),
          ],
        ),
      ),
    );
  }*/

  _showImages() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: controller.pickedImagesList.length,
      itemBuilder: (_, index) {
        XFile? xFile = controller.pickedImagesList[index];
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
              Image.file(File(xFile.path)),
              Positioned(
                right: 0,
                child: CustomActionIcon(
                  width: 25,
                  height: 25,
                  onTap: () {
                    controller.pickedImagesList.removeAt(index);
                    controller.pickedImagesList.refresh();
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
      onTap: () => controller.pickMultipleImages(),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(10),
        dashPattern: const [10, 4],
        strokeCap: StrokeCap.round,
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(
            () => controller.pickedImagesList.isNotEmpty
                ? _showImages()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload_rounded,
                        size: 30,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Click here to upload',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

/* _imageBtn({onTap, icon, title, color}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          AppConstant.spaceWidget(height: 10),
          CustomText(
            title: title,
            color: color,
          )
        ],
      ),
    );
  }*/
}

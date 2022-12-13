import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class AddProductsUI extends GetView<SellersController> {
  const AddProductsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Obx(() => controller.isLoading.isTrue
        ? CustomLoading()
        : SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          title: "Add Product",
                          weight: FontWeight.bold,
                          size: 20,
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
                              _chooseProductImage(),
                              AppConstant.spaceWidget(height: 20),
                              FormInputFieldWithIcon(
                                controller: controller.prodNameController,
                                iconPrefix: Icons.shopping_bag_rounded,
                                labelText: 'Product Name',
                                iconColor: kPrimaryColor,
                                autofocus: false,
                                textStyle: bodyText2,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) => GetUtils.isBlank(value!)!
                                    ? "Name is required?"
                                    : null,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {},
                                onSaved: (value) {},
                              ),
                              AppConstant.spaceWidget(height: 15),
                              FormInputFieldWithIcon(
                                controller: controller.prodPriceController,
                                iconPrefix: Icons.attach_money_rounded,
                                labelText: 'Product Price',
                                iconColor: kPrimaryColor,
                                autofocus: false,
                                textStyle: bodyText2,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    !GetUtils.isNumericOnly(value!)
                                        ? "Price is required?"
                                        : null,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {},
                                onSaved: (value) {},
                              ),
                              AppConstant.spaceWidget(height: 15),
                              FormInputFieldWithIcon(
                                controller: controller.prodStockController,
                                iconPrefix: Icons.inventory_outlined,
                                labelText: 'Product Stock',
                                iconColor: kPrimaryColor,
                                autofocus: false,
                                textStyle: bodyText2,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) =>
                                    !GetUtils.isNumericOnly(value!)
                                        ? "Stock is required?"
                                        : null,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {},
                                onSaved: (value) {},
                              ),
                              AppConstant.spaceWidget(height: 15),
                              FormInputFieldWithIcon(
                                controller: controller.prodBrandController,
                                iconPrefix: Icons.category_rounded,
                                labelText: 'Product Brand',
                                iconColor: kPrimaryColor,
                                autofocus: false,
                                textStyle: bodyText2,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) => GetUtils.isBlank(value!)!
                                    ? "Brand is required?"
                                    : null,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {},
                                onSaved: (value) {},
                              ),
                              AppConstant.spaceWidget(height: 15),
                              FormInputFieldWithIcon(
                                controller: controller.prodSKUController,
                                iconPrefix: Icons.category_rounded,
                                labelText: 'Product sku',
                                iconColor: kPrimaryColor,
                                autofocus: false,
                                textStyle: bodyText2,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) => GetUtils.isBlank(value!)!
                                    ? "sku is required?"
                                    : null,
                                keyboardType: TextInputType.name,
                                onChanged: (value) {},
                                onSaved: (value) {},
                              ),
                              AppConstant.spaceWidget(height: 15),

                              ///TODO: Category
                              Obx(
                                () => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black87,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    style: bodyText2,
                                    hint: Text(
                                        '${controller.selectedCategory.value}'),
                                    onChanged: (newValue) {
                                      controller.setSelectedCategory(
                                          category: newValue.toString());
                                    },
                                    items: controller
                                        .categoryController.categories
                                        .map((categoryModel) {
                                      String category = categoryModel.name!;
                                      return DropdownMenuItem(
                                        child: Text(
                                          '$category',
                                        ),
                                        value: category,
                                      );
                                    }).toList(),
                                    value: controller.selectedCategory.value,
                                  ),
                                ),
                              ),
                              AppConstant.spaceWidget(height: 15),

                              ///TODO: Sub Category
                              Obx(
                                () => controller.categoryController
                                        .subCategories.isEmpty
                                    ? Container()
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black87,
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          style: bodyText2,
                                          hint: Text(
                                              '${controller.selectedSubCategory.value}'),
                                          onChanged: (newValue) {
                                            controller.setSelectedSubCategory(
                                                subCategory:
                                                    newValue.toString());
                                          },
                                          items: controller
                                              .categoryController.subCategories
                                              .map((categoryModel) {
                                            String category =
                                                categoryModel.name!;
                                            return DropdownMenuItem(
                                              child: Text(
                                                '$category',
                                              ),
                                              value: category,
                                            );
                                          }).toList(),
                                          value: controller
                                              .selectedSubCategory.value,
                                        ),
                                      ),
                              ),
                              AppConstant.spaceWidget(height: 40),
                              CustomButton(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    if (controller.categoryController
                                        .subCategories.isNotEmpty) {
                                      controller.addProduct();
                                    } else {
                                      AppConstant.displaySnackBar(
                                          'error', "Plz select Sub Category");
                                    }
                                  }
                                },
                                text: "Add Product",
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
              ],
            ),
          ));
  }

  Widget _chooseProductImage() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          title: "Pick from",
          //barrierDismissible: false,
          contentPadding: const EdgeInsets.all(10),
          titleStyle: headline4,
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
            Container(
                color: Colors.black12,
                width: 80,
                height: 80,
                child: controller.imagePath.value.isNotEmpty
                    ? Image.file(File(controller.imagePath.value))
                    : Icon(Icons.image)),
            AppConstant.spaceWidget(height: 5),
            CustomText(
              title: "Product Image",
              weight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }

  _imageBtn({onTap, icon, title, color}) {
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
  }
}

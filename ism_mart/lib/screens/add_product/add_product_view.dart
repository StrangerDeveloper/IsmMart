import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/add_product/add_product_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/pick_image.dart';

class AddProductView extends StatelessWidget {
  AddProductView({Key? key}) : super(key: key);
  final AddProductViewModel viewModel = Get.put(AddProductViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
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

  AppBar appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(
        title: langKey.addProduct.tr,
        style: headline2,
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
            viewModel.onDynamicFieldsValueChanged(value, model),
        decoration: InputDecoration(
          labelText: model.label,
          labelStyle: bodyText1,
          prefixIcon: Icon(
            IconlyLight.discovery,
            color: kPrimaryColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
              style: BorderStyle.solid,
            ), //B
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
              style: BorderStyle.solid,
            ),
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

  _buildImageSection() {
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

  Padding selectCategoryField() {
    return Padding(
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
      ),
    );
  }

  selectSubCategoryField() {
    return DropdownSearch<SubCategory>(
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

  Padding nameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        prefixIcon: IconlyLight.paper_plus,
        controller: viewModel.prodNameController,
        label: langKey.productName.tr,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateDefaultTxtField(value);
        },
        keyboardType: TextInputType.name,
      ),
    );
  }

  Padding priceField() {
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
              return Validator().validateDefaultTxtField(value);
            },
            onChanged: (value) {
              viewModel.onPriceFieldChange(value);
            },
            keyboardType: TextInputType.number,
          ),
          Obx(
            () => Visibility(
              visible: viewModel.prodPriceController.text.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: CustomText(
                  title:
                      "${langKey.finalPriceWould.tr} ${viewModel.priceAfterCommission.value} ${langKey.afterPlatformFee.tr} 5%",
                  color: kRedColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  productVariantsAndFeaturesField() {
    return Obx(
      () => viewModel.productVariantsFieldsList.isEmpty
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: viewModel.productVariantsFieldsList
                    .map((element) => _createDynamicFormFields(element))
                    .toList(),
              ),
            ),
    );
  }

  Padding stockField() {
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
          return Validator().validateDefaultTxtField(value);
        },
        keyboardType: TextInputType.number,
      ),
    );
  }

  Padding discountField() {
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

  Padding descriptionField() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: CustomTextField2(
        controller: viewModel.prodDescriptionController,
        label: langKey.description.tr,
        prefixIcon: IconlyLight.document,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator().validateDefaultTxtField(value);
        },
        keyboardType: TextInputType.text,
      ),
    );
  }
}

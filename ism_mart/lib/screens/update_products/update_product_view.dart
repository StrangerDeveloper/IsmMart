import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/single_product_full_image/single_product_full_image_view.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/update_products/update_product_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/pick_image.dart';
import '../../widgets/loader_view.dart';
import '../../widgets/single_image_view.dart';

class UpdateProductView extends StatelessWidget {
  UpdateProductView({Key? key}) : super(key: key);

  final UpdateProductViewModel viewModel = Get.put(UpdateProductViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          body: Stack(
            children: [
              AppConstant.spaceWidget(height: 20),
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Form(
                  key: viewModel.formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextField2(
                            label: langKey.productName.tr,
                            controller: viewModel.prodNameController,
                            autoValidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return GetUtils.isBlank(value)! ?
                              langKey.productNameReq.tr : null;
                            },
                          ),
                          productPriceField(),
                          productStockField(),
                          productDiscountField(),
                          productDescriptionField(),
                          imagesUpdateSection(),
                          CustomTextBtn(
                              onPressed: () {
                                viewModel.updateButtonPress();
                              },
                              title: langKey.updateBtn.tr,
                              height: 50,
                              width: 300,
                            ),
                        ]),
                  ),
                ),
              ),
              LoaderView(),
            ],
          ),
        ));
  }

  AppBar _appBar(){
    return AppBar(
      centerTitle: true,
      leading: CustomActionIcon(
        icon: Icons.arrow_back_ios,
        size: 23,
        iconColor: kPrimaryColor,
        onTap: (){
          Get.back();
        },
      ),
      title: CustomText(
        title: langKey.updateProduct.tr,
        style: headline2,
      ),
    );
  }

  Padding productPriceField(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: <Widget>[
          CustomTextField2(
            controller: viewModel.prodPriceController,
            label: langKey.prodPrice.tr,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) =>
            !GetUtils.isNumericOnly(value!)
                ? langKey.prodPriceReq.tr
                : null,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              viewModel.productPriceOnChange(value);
            },
          ),
          Obx(() => Visibility(
            visible: viewModel.showPriceAfterCommission.value,
            child: CustomText(
              title:
              "${langKey.finalPriceWould.tr} ${viewModel.priceAfterCommission.value} ${langKey.afterPlatformFee.tr} 5%",
              color: kRedColor,
            ),
          ))
        ],
      ),
    );
  }

  productStockField(){
    return CustomTextField2(
      controller: viewModel.prodStockController,
      label: langKey.prodStock.tr,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
      !GetUtils.isNumericOnly(value!)
          ? langKey.prodStockReq.tr
          : null,
      keyboardType: TextInputType.number,
    );
  }

  productDescriptionField(){
    return CustomTextField2(
      controller: viewModel.prodDescriptionController,
      label: langKey.description.tr,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
      GetUtils.isBlank(value!)! ? langKey.descriptionReq.tr : null,
      keyboardType: TextInputType.text,
    );
  }

  Padding productDiscountField(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: <Widget>[
          CustomTextField2(
            controller: viewModel.prodDiscountController,
            label: langKey.prodDiscount.tr,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            onChanged: (value){
              viewModel.productDiscountOnChange(value);
            },
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
  
  Padding imagesUpdateSection(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                title: langKey.productImageSection.tr,
                style: headline1,
              ),
            ),
          ),
          AppConstant.spaceWidget(height: 20),
          Align(
            alignment: Alignment.topCenter,
            child: CustomText(
              title: langKey.productThumbnail.tr,
              style: headline2,
            ),
          ),
          AppConstant.spaceWidget(height: 7),
          thumbnailSection(),
          AppConstant.spaceWidget(height: 20),
          productImagesSection(),
          addedImagesSection(),
          AppConstant.spaceWidget(height: 30),
          DottedBorder(
            strokeWidth: 3,
            borderType: BorderType.Circle,
            dashPattern: const [10, 4],
            strokeCap: StrokeCap.round,
            color: kPrimaryColor,
            child: Container(
              width: 55,
              height: 55,
              child: CustomActionIcon(
                onTap: ()async {
                  // await viewModel.pickMultipleImages();
                  viewModel.imagesToUpdate.addAll(
                      await PickImage().pickMultipleImage()
                  );
                },
                icon: Icons.cloud_upload_outlined,
                size: 35,
                iconColor: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  thumbnailSection() {
    return Obx(
          () =>
          Column(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color:
                viewModel.thumbnailImageSizeInMb.value > 2.0 ? kRedColor : kPrimaryColor,
                child: Container(
                    padding:
                    EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: viewModel.thumbnailUrl.value == '' && viewModel.thumbnailSelectedImage.value!.path == ''
                        ? GestureDetector(
                      onTap: () async{
                        viewModel.thumbnailSelectedImage.value = await PickImage().pickSingleImage();
                        if(viewModel.thumbnailSelectedImage.value != File('') ){
                          viewModel.thumbnailNotAvailable(false);
                        }
                      },
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
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
                    ) : showThumbnailImage()),
              ),
              AppConstant.spaceWidget(height: 6),
              Visibility(
                  visible: viewModel.thumbnailNotAvailable.value,
                  child: CustomText(
                    title: langKey.uploadThumbnail.tr,
                    color: kRedColor,
                  ))
            ],
          ),
    );
  }

  Stack showThumbnailImage() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(
          onTap: () => Get.to(() => SingleImageView(
            imageUrlOrPath: viewModel.thumbnailUrl.value == ''
                ? viewModel.thumbnailSelectedImage.value!.path
                : viewModel.thumbnailUrl.value,
            url: false,
          )),
          child: viewModel.thumbnailUrl.value != ''
              ? CustomNetworkImage(
            imageUrl: viewModel.thumbnailUrl.value,
            fit: BoxFit.fitHeight,
          )
              : Image.file(File(viewModel.thumbnailSelectedImage.value!.path)),
        ),
        Positioned(
          right: 0,
          child: CustomActionIcon(
            bgColor: Colors.grey,
            width: 25,
            icon: Icons.close_rounded,
            height: 25,
            onTap: () {
              viewModel.thumbnailCheck();
            },
          ),
        )
      ],
    );
  }
  
  Column productImagesSection(){
    return Column(
      children: <Widget>[
        Obx(() => viewModel.productImages.isNotEmpty
            ? CustomText(
          title: langKey.productImages.tr,
          style: headline2,
        )
            : Container()),
        AppConstant.spaceWidget(height: 15),
        Obx(() => viewModel.productImages.isNotEmpty ? SizedBox(
          width: AppResponsiveness.width * 0.87,
          height: AppResponsiveness.height * 0.25,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: viewModel.productImages.length,
              itemBuilder: (_, index) {
                return imageInList(index, false);
              }),
        )
            : Container(),
        ),
      ],
    );
  }

  addedImagesSection() {
    return Obx(() => viewModel.imagesToUpdate.isNotEmpty
        ? Column(
      children: [
        CustomText(
          title: langKey.addedImages.tr,
          style: headline2,
        ),
        AppConstant.spaceWidget(height: 8),
        SizedBox(
            width: AppResponsiveness.width * 0.87,
            height: AppResponsiveness.height * 0.25,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: viewModel.imagesToUpdate.length,
                itemBuilder: (_, index) {
                  return imageInList(index, true);
                })),
      ],
    ) : Container());
  }
  
  Padding imageInList(int index, bool calledForAddedImages) {
    return Padding(
        padding:
        const EdgeInsets.all(8.0),
        child: GestureDetector(
            onTap: () {
              viewModel.imageIndex(index);
              Get.to(() =>
                  SingleProductFullImageView(
                    initialImage: index,
                    imagesToUpdate: calledForAddedImages ? viewModel.imagesToUpdate : null,
                    productImages: calledForAddedImages ? null : viewModel.productImages,
                  ));
            },
            child: Container(
              width: 90,
              child: calledForAddedImages == false ? Stack(
                fit: StackFit.expand,
                children: [
                  CustomNetworkImage(
                    imageUrl: viewModel.productImages[index].url,
                    fit: BoxFit.fill,
                  ),
                  Obx(() =>
                  viewModel.productImages[index].url ==
                      viewModel.thumbnailUrl.value ? Container() :
                  Positioned(
                    right: 5,
                    top: 3,
                    child: CustomActionIcon(
                      bgColor: Colors.red,
                      width: 25,
                      icon: Icons.delete,
                      height: 25,
                      onTap: () {
                        viewModel.imagesToDelete.add(viewModel.productImages[index].id);
                        viewModel.productImages.removeAt(index);
                      },
                    ),
                  )
                  )
                ],
              ) : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      viewModel.imagesToUpdate[index],
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      right: 5,
                      top: 3,
                      child: CustomActionIcon(
                        bgColor: Colors.red,
                        width: 25,
                        icon: Icons.delete,
                        height: 25,
                        onTap: () {
                          viewModel.imagesToUpdate.removeAt(index);
                        },
                      ),
                    )
                  ]
              ),
            )
        )
    );
  }
}
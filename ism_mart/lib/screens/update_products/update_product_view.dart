import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/update_products/update_product_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/pick_image.dart';
import 'package:ism_mart/widgets/single_product_full_image_view.dart';
import '../../widgets/loader_view.dart';
import '../../widgets/single_image_view.dart';
import 'package:ism_mart/screens/single_product_full_image/single_product_full_image_view.dart';

class UpdateProductView extends GetView<SellersController> {
  UpdateProductView({Key? key, this.productId, this.images}) : super(key: key);
  final int? productId;
  final List<ProductImages>? images;
  final UpdateProductViewModel viewModel = Get.put(UpdateProductViewModel());

  @override
  Widget build(BuildContext context) {

    viewModel.getProductById(productId!);

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
                                  return GetUtils.isBlank(value)! ? langKey.productNameReq.tr : null;
                                },
                              ),
                              // FormInputFieldWithIcon(
                              //   controller: viewModel.prodNameController,
                              //   iconPrefix: IconlyLight.paper_plus,
                              //   labelText: langKey.productName.tr,
                              //   iconColor: kPrimaryColor,
                              //   autofocus: false,
                              //   textStyle: bodyText1,
                              //   autoValidateMode:
                              //       AutovalidateMode.onUserInteraction,
                              //   validator: (value) => GetUtils.isBlank(value!)!
                              //       ? langKey.productNameReq.tr
                              //       : null,
                              //   keyboardType: TextInputType.name,
                              //   onChanged: (value) {},
                              //   onSaved: (value) {},
                              // ),
                              AppConstant.spaceWidget(height: 15),
                              Column(
                                children: [
                                  FormInputFieldWithIcon(
                                    controller: viewModel.prodPriceController,
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
                                      if (value == '') {
                                        viewModel.showPriceAfterCommission.value = false;
                                      }
                                      else {
                                        viewModel.showPriceAfterCommission.value = true;
                                        viewModel.totalTax();
                                        if (value.isNotEmpty) {
                                          viewModel.priceAfterCommission.value =
                                              int.parse(value);
                                          viewModel.totalTax();
                                          viewModel.productModel!.price =
                                              viewModel.priceAfterCommission
                                                  .value;
                                        } else {
                                          // controller.priceAfterCommission(0);
                                        }
                                      }
                                    },
                                    onSaved: (value) {},
                                  ),
                                  Obx(() => Visibility(
                                        visible: viewModel
                                            .showPriceAfterCommission.value,
                                        child: CustomText(
                                          title:
                                              "${langKey.finalPriceWould.tr} ${viewModel.priceAfterCommission.value} ${langKey.afterPlatformFee.tr} 5%",
                                          color: kRedColor,
                                        ),
                                      ))
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
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                      if (value!.isNotEmpty || value != '') {
                                        int discount = int.parse(value);
                                        viewModel.setDiscount(discount);
                                      } else {
                                        int discount = 0;
                                        viewModel.setDiscount(discount);
                                      }
                                    },
                                    onSaved: (value) {},
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: viewModel
                                          .prodDiscountController.text.isNotEmpty,
                                      child: CustomText(
                                        title: viewModel.discountMessage.value,
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
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) => GetUtils.isBlank(value!)!
                                    ? langKey.descriptionReq.tr
                                    : null,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                onSaved: (value) {},
                              ),
                              AppConstant.spaceWidget(height: 20),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    title: 'Update Product Images',
                                    style: headline1,
                                  ),
                                ),
                              ),
                              AppConstant.spaceWidget(height: 20),
                              Align(
                                alignment: Alignment.topCenter,
                                child: CustomText(
                                  title: 'Product Thumbnail',
                                  style: headline2,
                                ),
                              ),
                              AppConstant.spaceWidget(height: 7),
                              Obx(
                                () => Column(
                                  children: [
                                    DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
                                      dashPattern: const [10, 4],
                                      strokeCap: StrokeCap.round,
                                      color:
                                          viewModel.thumbnailImageSizeInMb.value >
                                                  2.0
                                              ? kRedColor
                                              : kPrimaryColor,
                                      child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          width: double.infinity,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: viewModel.thumbnailUrl
                                                          .value ==
                                                      '' &&
                                                  viewModel.thumbnailPath
                                                          .value ==
                                                      ''
                                              ? GestureDetector(
                                                  onTap: () =>
                                                      pickImageDialog(),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .cloud_upload_rounded,
                                                        size: 30,
                                                      ),
                                                      const SizedBox(height: 5),
                                                      CustomText(
                                                        title: langKey
                                                            .clickHereToUpload.tr,
                                                        color: kLightColor,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : showThumbnailImage()),
                                    ),
                                    AppConstant.spaceWidget(height: 6),
                                    Visibility(
                                        visible:
                                            viewModel.thumbnailNotAvailable.value,
                                        child: CustomText(
                                          title: 'Upload Thumbnail Image',
                                          color: kRedColor,
                                        ))
                                  ],
                                ),
                              ),
                              AppConstant.spaceWidget(height: 20),
                              Obx(() => viewModel.productImages.isNotEmpty
                                  ? CustomText(
                                      title: 'Product Images',
                                      style: headline2,
                                    )
                                  : Container()),
                              AppConstant.spaceWidget(height: 15),
                              Obx(
                                () => viewModel.productImages.isNotEmpty
                                    ? SizedBox(
                                        width: AppResponsiveness.width * 0.87,
                                        height: AppResponsiveness.height * 0.25,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            //physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                viewModel.productImages.length,
                                            itemBuilder: (_, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    viewModel
                                                        .imageIndex(index);
                                                    Get.to(() =>
                                                        SingleProductFullImageView(
                                                          initialImage: index,
                                                          productImages: viewModel.productImages,
                                                        ));
                                                  },
                                                  child: Container(
                                                    width: 90,
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        CustomNetworkImage(
                                                          imageUrl: viewModel
                                                              .productImages[
                                                                  index]
                                                              .url,
                                                          fit: BoxFit.fill,
                                                        ),
                                                        Obx(()=>
                                                        viewModel.productImages
                                                        [index].url ==
                                                            viewModel.
                                                            thumbnailUrl.
                                                            value ? Container () :
                                                        Positioned(
                                                          right: 5,
                                                          top: 3,
                                                          child: CustomActionIcon(
                                                            bgColor: Colors.red,
                                                            width: 25,
                                                            icon: Icons.delete,
                                                            height: 25,
                                                            onTap: () {
                                                              viewModel
                                                                  .imagesToDelete
                                                                  .add(viewModel.productImages[index].id);
                                                              viewModel
                                                                  .productImages
                                                                  .removeAt(
                                                                      index);
                                                            },
                                                          ),
                                                        )
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    : Container(),
                              ),
                              Obx(() => viewModel.imagesToUpdate.isNotEmpty
                                  ? Column(
                                      children: [
                                        CustomText(
                                          title: 'Added Images',
                                          style: headline2,
                                        ),
                                        AppConstant.spaceWidget(height: 8),
                                        SizedBox(
                                            width: AppResponsiveness.width * 0.87,
                                            height:
                                                AppResponsiveness.height * 0.25,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                //physics: ScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: viewModel
                                                    .imagesToUpdate.length,
                                                itemBuilder: (_, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        viewModel
                                                            .imageIndex(index);
                                                        Get.to(() =>
                                                            SingleProductFullImage(
                                                              initialImage: index,
                                                              imagesToUpdate:
                                                                  viewModel
                                                                      .imagesToUpdate,
                                                            ));
                                                      },
                                                      child: Container(
                                                        width: 90,
                                                        child: Stack(
                                                          fit: StackFit.expand,
                                                          children: [
                                                            Image.file(
                                                              viewModel
                                                                      .imagesToUpdate[
                                                                  index],
                                                              fit: BoxFit.fill,
                                                            ),
                                                            Positioned(
                                                              right: 5,
                                                              top: 3,
                                                              child:
                                                                  CustomActionIcon(
                                                                bgColor:
                                                                    Colors.red,
                                                                width: 25,
                                                                icon:
                                                                    Icons.delete,
                                                                height: 25,
                                                                onTap: () {
                                                                  viewModel
                                                                      .imagesToUpdate
                                                                      .removeAt(
                                                                          index);
                                                                  // viewModel.imagesToDelete.add(controller.productImages[index].id);
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })),
                                      ],
                                    )
                                  : Container()),
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
                              AppConstant.spaceWidget(height: 40),
                              Obx(
                                () => viewModel.isLoading.isTrue
                                    ? CustomLoading(isItBtn: true)
                                    : CustomButton(
                                        onTap: () {
                                          if (viewModel.formKey.currentState!.validate()) {
                                            if (viewModel.thumbnailNotAvailable ==
                                                true) {
                                              return;
                                            } else {
                                              if (viewModel
                                                  .discountMessage.isEmpty) {
                                                viewModel.updateProduct(
                                                    model: viewModel.productModel);
                                              } else {
                                                AppConstant.displaySnackBar(
                                                  langKey.errorTitle.tr,
                                                  langKey.yourDiscountShould.tr,
                                                );
                                              }
                                            }
                                          }
                                        },
                                        text: langKey.updateBtn.tr,
                                        height: 50,
                                        width: 300,
                                      ),
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

  showThumbnailImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () => Get.to(() => SingleImageView(
                imageUrlOrPath: viewModel.thumbnailUrl.value == ''
                    ? viewModel.thumbnailPath.value
                    : viewModel.thumbnailUrl.value,
              )),
          child: viewModel.thumbnailUrl.value != ''
              ? CustomNetworkImage(
                  imageUrl: viewModel.thumbnailUrl.value,
                  fit: BoxFit.fitHeight,
                )
              : Image.file(File(viewModel.thumbnailPath.value)),
        ),
        Positioned(
          right: 0,
          child: CustomActionIcon(
            bgColor: Colors.grey,
            width: 25,
            icon: Icons.close_rounded,
            height: 25,
            onTap: () {
              if (viewModel.thumbnailUrl.value != '') {
                viewModel.thumbnailUrl.value = '';
              } else {
                viewModel.thumbnailPath.value = '';
              }
              viewModel.thumbnailNotAvailable(true);
            },
          ),
        )
      ],
    );
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

  pickImageDialog() {
    Get.defaultDialog(
      title: langKey.pickFrom.tr,
      contentPadding: const EdgeInsets.all(10),
      titleStyle: appBarTitleSize,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              CustomActionIcon(
                onTap: () => viewModel.pickThumbnail(ImageSource.camera),
                icon: Icons.camera_alt_rounded,
                iconColor: Colors.blue,
                size: 24,
              ),
              CustomText(
                title: langKey.camera.tr,
                color: Colors.blue,
              ),
            ],
          ),
          Column(
            children: [
              CustomActionIcon(
                onTap: () => viewModel.pickThumbnail(ImageSource.gallery),
                icon: Icons.photo_library_rounded,
                iconColor: Colors.redAccent,
                size: 24,
              ),
              CustomText(
                title: langKey.gallery.tr,
                color: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

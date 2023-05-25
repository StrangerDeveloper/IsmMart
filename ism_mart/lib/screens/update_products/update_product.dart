import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class UpdateProductUI extends GetView<SellersController> {
  const UpdateProductUI({Key? key, this.productId}) : super(key: key);
  final int? productId;

  @override
  Widget build(BuildContext context) {
    controller.getProductById(productId!);

    return controller.obx((state) {
      if (state == null) {
        return CustomLoading();
      }
      return _build(productModel: state);
    },
        onLoading: CustomLoading(),
        onEmpty: NoDataFound(
          text: langKey.productNotFound.tr,
        ));
  }

  Widget _build({ProductModel? productModel}) {
    var formKey = GlobalKey<FormState>();
    if (productModel != null) {
      controller.prodNameController.text = productModel.name!;
      controller.prodPriceController.text = productModel.price!.toString();
      controller.prodStockController.text = productModel.stock!.toString();
      controller.prodDiscountController.text =
          productModel.discount!.toString();
      controller.prodDescriptionController.text = productModel.description!;
      controller.priceAfterCommission(productModel.price!.toInt());
    }

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: langKey.updateProduct.tr,
                      style: headline2,
                    ),
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
                                  // int amount = int.parse(value);
                                  // int totalAfter =
                                  //     amount + (amount * 0.05).round();
                                  // controller.priceAfterCommission(amount);
                                  controller.priceAfterCommission.value =
                                      int.parse(value);
                                  controller.totalTax();
                                  productModel!.price =
                                      controller.priceAfterCommission.value;
                                } else {
                                  // controller.priceAfterCommission(0);
                                }
                              },
                              onSaved: (value) {},
                            ),
                            Obx(() => Visibility(
                                  visible: controller
                                      .prodPriceController.text.isNotEmpty,
                                  child: CustomText(
                                    title:
                                        "${langKey.finalPriceWould.tr} ${controller.priceAfterCommission.value} ${langKey.afterPlatformFee.tr} 5%",
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
                        Column(
                          children: [
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
                              onChanged: (String? value) {
                                int discount =
                                    value!.isNotEmpty || value != '' ? int.parse(value) : 0;
                                controller.setDiscount(discount);
                              },
                              onSaved: (value) {},
                            ),
                            Obx(
                              () => Visibility(
                                visible: controller
                                    .prodDiscountController.text.isNotEmpty,
                                child: CustomText(
                                  title: controller.discountMessage.value,
                                  color: kRedColor,
                                ),
                              ),
                            )
                          ],
                        ),
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
                                      if (controller.discountMessage.isEmpty) {
                                        controller.updateProduct(
                                            model: productModel);
                                      } else {
                                        AppConstant.displaySnackBar(
                                          langKey.errorTitle.tr,
                                          langKey.yourDiscountShould.tr,
                                        );
                                      }
                                    }
                                  },
                                  text: langKey.updateBtn.tr,
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
}

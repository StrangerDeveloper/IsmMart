import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class MyProducts extends GetView<SellersController> {
  const MyProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onTap: () => AppConstant.showBottomSheet(
                      widget: AddProductsUI(),
                      isGetXBottomSheet: false,
                      buildContext: context),
                  //controller.changePage(1),
                  text: langKey.addProduct.tr,
                  width: 110,
                  height: 35,
                ),
              ),
            ),
            //AppConstant.spaceWidget(height: 10),
            Expanded(child: _buildProductBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildProductBody() {
    return Obx(
      () => controller.myProductsList.isEmpty
          ? Center(
              child: NoDataFoundWithIcon(
                icon: IconlyLight.bag_2,
                title: langKey.noProductFound.tr,
                iconColor: kPrimaryColor,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return Future.delayed(Duration(seconds: 2), () {
                        controller.fetchMyProducts();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        controller: controller.scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: AppResponsiveness.getGridItemCount(),
                          //mainAxisExtent:
                          //  AppResponsiveness.getMainAxisExtentPoint30(),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio:
                              AppResponsiveness.getChildAspectRatioPoint85(),
                        ),
                        itemCount: controller.myProductsList.length,
                        itemBuilder: (_, index) {
                          ProductModel productModel =
                              controller.myProductsList[index];
                          return _buildProductItem(model: productModel);
                        },
                      ),
                    ),
                  ),
                ),
                if (controller.isLoadingMore.isTrue)
                  CustomLoading(isItForWidget: true)
              ],
            ),
    );
  }

  _buildProductItem({ProductModel? model}) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: GestureDetector(
        onTap: () {
          Get.to(SingleProductView(productId: "${model.id}", calledFor: 'seller',));
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white60,
            border: Border.all(color: Colors.grey.shade400, width: 0.5),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppResponsiveness.getHeight90_100(),
                    width: double.infinity,
                    child: CustomNetworkImage(
                        imageUrl:
                            model!.thumbnail ?? AppConstant.defaultImgUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                title: "${langKey.sold.tr}: ${model.sold!}"),
                            CustomText(
                              title: "${langKey.stock.tr}: ${model.stock!}",
                              color: kLimeGreenColor,
                            ),
                          ],
                        ),
                        CustomText(
                          title: model.name!,
                          maxLines: 1,
                        ),
                        AppConstant.spaceWidget(height: 5),
                        CustomPriceWidget(title: "${model.discountPrice!}"),
                        if (model.discount != 0)
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomPriceWidget(
                                  title: "${model.price!}",
                                  style: bodyText1.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 13,
                                      color: kLightColor)),
                              AppConstant.spaceWidget(width: 10),
                              CustomText(
                                title: "${model.discount}% ${langKey.OFF.tr}",
                                color: kOrangeColor,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        Row(
                          children: [
                            CustomText(
                              title: '${langKey.status.tr}:',
                              style: bodyText1,
                            ),
                            AppConstant.spaceWidget(width: 2),
                            CustomText(
                              title: model.status!.capitalizeFirst,
                              weight: FontWeight.w600,
                              color: getStatusColor(model),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 2,
                right: 2,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomActionIcon(
                        onTap: () {
                          AppConstant.showBottomSheet(
                              widget: UpdateProductUI(productId: model.id),
                              isGetXBottomSheet: true,
                              buildContext: Get.context!);
                        },
                        icon: Icons.edit_rounded,
                        bgColor: kPrimaryColor),
                    AppConstant.spaceWidget(width: 5),
                    CustomActionIcon(
                        onTap: () => AppConstant.showConfirmDeleteDialog(
                              ontap: () => controller.deleteProduct(id: model.id),
                          passedHeadingLangKey: langKey.areYouSure.tr,
                          passedBodyLangKey: langKey.deletionProcessDetail.tr,
                            ),
                        icon: Icons.delete_rounded,
                        bgColor: kRedColor)
                  ],
                ),
              ),
              if (model.stock == 0)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomText(
                      title: langKey.outOfStock.tr,
                      color: kWhiteColor,
                      size: 12,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color getStatusColor(ProductModel? model) {
    switch (model!.status!.toLowerCase()) {
      case "pending":
        return Colors.deepOrange;
      case "approve":
      case "completed":
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }
}

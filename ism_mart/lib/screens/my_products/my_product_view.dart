import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/exports/exports_ui.dart';
import 'package:ism_mart/screens/my_products/my_products_viewmodel.dart';
import 'package:ism_mart/screens/my_products/vendor_product_model.dart';
import 'package:ism_mart/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class MyProductView extends StatelessWidget {
  MyProductView({super.key});

  final MyProductsViewModel viewModel = Get.put(MyProductsViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            addProduct(context),
            Expanded(
              child: _buildProductBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget addProduct(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 5),
        child: CustomTextBtn(
          onPressed: () {
            Get.toNamed(Routes.addProduct);
          },
          title: langKey.addProduct.tr,
        ),
      ),
    );
  }

  Widget _buildProductBody() {
    return Obx(
      () => viewModel.myProductsList.isEmpty
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
                        viewModel.loadInitialProducts();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                        controller: viewModel.scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: AppResponsiveness.getGridItemCount(),
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio:
                              AppResponsiveness.getChildAspectRatioPoint85(),
                        ),
                        itemCount: viewModel.myProductsList.length,
                        itemBuilder: (_, index) {
                          VendorProduct productModel =
                              viewModel.myProductsList[index];
                          return _buildProductItem(
                            model: productModel,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                if (viewModel.isLoadingMore.isTrue)
                  CustomLoading(isItForWidget: true)
              ],
            ),
    );
  }

  _buildProductItem({VendorProduct? model, required int index}) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: GestureDetector(
        onTap: () {
          Get.to(
            ProductView(
              productId: "${model.id}",
              calledFor: 'seller',
            ),
          );
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
                      imageUrl: model!.thumbnail ?? AppConstant.defaultImgUrl,
                    ),
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
                              title: "${langKey.id.tr}: ${model.id!}",
                            ),
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
                            children: [
                              CustomPriceWidget(
                                title: "${model.price!}",
                                style: bodyText1.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 13,
                                  color: kLightColor,
                                ),
                              ),
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
                  children: [
                    CustomActionIcon(
                        onTap: () {
                          Get.toNamed(Routes.updateProduct, arguments: [
                            {'productId': '${model.id}'}
                          ]);
                        },
                        icon: Icons.edit_rounded,
                        bgColor: kPrimaryColor),
                    AppConstant.spaceWidget(width: 5),
                    CustomActionIcon(
                      onTap: () => AppConstant.showConfirmDeleteDialog(
                        ontap: () {
                          viewModel.deleteProduct(model.id.toString(),
                              index: index);
                        },
                        passedHeadingLangKey: langKey.areYouSure.tr,
                        passedBodyLangKey: langKey.deletionProcessDetail.tr,
                      ),
                      icon: Icons.delete_rounded,
                      bgColor: kRedColor,
                    )
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

  Color getStatusColor(VendorProduct? model) {
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

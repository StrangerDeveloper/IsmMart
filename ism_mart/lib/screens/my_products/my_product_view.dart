import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/my_products/my_products_viewmodel.dart';
import 'package:ism_mart/screens/my_products/vendor_product_model.dart';
import 'package:ism_mart/screens/product_detail/product_detail_view.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';

class MyProductView extends StatelessWidget {
  MyProductView({super.key});

  final MyProductsViewModel viewModel = Get.put(MyProductsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildProductBody(),
          NoInternetView(
            onPressed: () {
              viewModel.loadInitialProducts();
            },
          ),
          LoaderView()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        icon: Icon(Icons.add),
        onPressed: () {
          if (GlobalVariable.userModel?.infoCompleted == 1) {
            Get.toNamed(Routes.addProduct);
          } else {
            AppConstant.displaySnackBar(
                langKey.errorTitle.tr, langKey.updateInfoToProceed.tr);
          }
        },
        label: Text(langKey.addProduct.tr),
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

  Widget _buildProductItem({VendorProduct? model, required int index}) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: GestureDetector(
        onTap: () {
          if (GlobalVariable.userModel?.infoCompleted == 1) {
            Get.to(() => ProductDetailView(),
                arguments: {"isBuyer": false, "productID": model.id});
          } else {
            AppConstant.displaySnackBar(
                langKey.errorTitle.tr, langKey.updateInfoToProceed.tr);
          }
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
                            // CustomText(
                            //   title: "${langKey.stock.tr}: ${model.stock!}",
                            //   color: kLimeGreenColor,
                            // ),
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
                              title: model.status?.capitalizeFirst ?? '',
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
                          if (GlobalVariable.userModel?.infoCompleted == 1) {
                            Get.toNamed(Routes.updateProduct, arguments: [
                              {'productId': '${model.id}'}
                            ]);
                          } else {
                            AppConstant.displaySnackBar(langKey.errorTitle.tr,
                                langKey.updateInfoToProceed.tr);
                          }
                        },
                        icon: Icons.edit_rounded,
                        bgColor: kPrimaryColor),
                    AppConstant.spaceWidget(width: 5),
                    CustomActionIcon(
                      onTap: () {
                        if (GlobalVariable.userModel?.infoCompleted == 1) {
                          AppConstant.showConfirmDeleteDialog(
                            ontap: () {
                              viewModel.deleteProduct(model.id.toString(),
                                  index: index);
                            },
                            passedHeadingLangKey: langKey.areYouSure.tr,
                            passedBodyLangKey: langKey.deletionProcessDetail.tr,
                          );
                        } else {
                          AppConstant.displaySnackBar(langKey.errorTitle.tr,
                              langKey.updateInfoToProceed.tr);
                        }
                      },
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

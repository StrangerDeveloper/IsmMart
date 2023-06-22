import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/single_product_details/single_product_details_view.dart';
import 'package:ism_mart/widgets/custom_sliver_appbar.dart';

class SellerStoreDetailView extends GetView<ProductController> {
  const SellerStoreDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['storeId'] == null) {
      return const Center(child: CircularProgressIndicator());
    }

    controller.fetchStoreDetailsByID(
        storeID: int.parse(Get.parameters['storeId']!));

    return _build();
  }

  Widget _build() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        body: Stack(
          children: [
            Obx(
              () => controller.isLoading.isTrue
                  ? CustomLoading(
                      isItForWidget: true,
                      color: kPrimaryColor,
                    )
                  : controller.sellerStoreResponse.value.vendorStore == null
                      ? Center(
                          child: NoDataFoundWithIcon(
                          icon: Icons.dataset_linked_rounded,
                          title: langKey.noDataFound.tr,
                        ))
                      : CustomScrollView(
                          slivers: [
                            CustomSliverAppBar(
                              title: langKey.storeDetail.tr,
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  _storeBasicDetails(
                                      model: controller.sellerStoreResponse
                                          .value.vendorStore),
                                  _storeRatingAndCustomerCard(
                                      modelResponse:
                                          controller.sellerStoreResponse.value),
                                  _buildTopProducts(
                                      controller.vendorProductList),
                                ],
                              ),
                            ),
                          ],
                        ),
            ),
            NoInternetView(
              onPressed: () => controller.fetchStoreDetailsByID(
                  storeID: int.parse(Get.parameters['storeId']!)),
            )
          ],
        ),
      ),
    );
  }

  Widget _storeRatingAndCustomerCard({SellerModelResponse? modelResponse}) {
    return SizedBox(
      height: AppResponsiveness.getBoxHeightPoint25(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomOrderStatsItem(
                      onTap: () {},
                      title: langKey.sellerRating.tr,
                      icon: Icons.rate_review,
                      iconColor: kRedColor,
                      value: modelResponse!.vendorStore?.rating,
                    ),
                  ),
                  AppConstant.spaceWidget(width: 5),
                  Expanded(
                    flex: 3,
                    child: CustomOrderStatsItem(
                      onTap: () {},
                      title: langKey.customers.tr,
                      icon: IconlyBold.work,
                      iconColor: Colors.orange,
                      value: modelResponse.totalCustomers,
                    ),
                  ),
                ],
              ),
            ),
            AppConstant.spaceWidget(height: 5),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomOrderStatsItem(
                      onTap: () {},
                      title: langKey.totalProducts.tr,
                      icon: Icons.dataset_rounded,
                      iconColor: Colors.blue,
                      value: modelResponse.totalProducts,
                    ),
                  ),
                  AppConstant.spaceWidget(width: 5),
                  Expanded(
                    flex: 3,
                    child: CustomOrderStatsItem(
                      onTap: () {},
                      title: langKey.soldItems.tr,
                      icon: IconlyBold.bookmark,
                      iconColor: Colors.teal,
                      value: num.parse(
                          modelResponse.vendorStore!.totalSold ?? "0"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _storeBasicDetails({SellerModel? model}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomGreyBorderContainer(
        height: AppResponsiveness.getBoxHeightPoint25(),
        borderColor: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            children: [
              ///Cover Image
              Positioned(
                top: 0,
                left: 0,
                height: AppResponsiveness.getHeight90_100(),
                child: SizedBox(
                  width: AppResponsiveness.width * 0.95,
                  child: CustomNetworkImage(
                    imageUrl: model?.coverImage ?? AppConstant.defaultImgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),

              Positioned(
                top: AppResponsiveness.getHeight50_60(),
                left: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Store Image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor.withOpacity(0.22),
                                offset: Offset(0, 0),
                                blurRadius: 10.78,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            backgroundImage: NetworkImage(
                                model?.storeImage ?? AppConstant.defaultImgUrl),
                          ),
                        ),
                        AppConstant.spaceWidget(width: 33),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: langKey.thisStoreHasBeen.tr + ' ',
                                style: bodyText2.copyWith(
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              TextSpan(
                                text: AppConstant.formattedDataTime("MMM, yyyy",
                                    model?.createdAt ?? DateTime.now()),
                                style: bodyText2.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppConstant.spaceWidget(height: 10),
                    CustomText(
                      title: model?.storeName ?? model?.ownerName ?? "",
                      style: headline3,
                    ),
                    AppConstant.spaceWidget(height: 5),
                    CustomText(
                      title: model?.storeDesc ?? "",
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopProducts(List<ProductModel> list) {
    return Obx(
      () => list.isEmpty
          ? Container()
          : controller.isLoading.isTrue
              ? CustomLoading(isItForWidget: true)
              : Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: AppResponsiveness.getBoxHeightPoint30(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            title: langKey.topProducts.tr,
                            size: 18,
                            weight: FontWeight.w600,
                          ),
                          AppConstant.spaceWidget(height: 10),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                ProductModel productModel = list[index];
                                return SingleProductItems(
                                  productModel: productModel,
                                  onTap: () {
                                    Get.to(() => SingleProductDetailsView(), arguments: [{
                                      'calledFor': 'customer',
                                      'productID': "${productModel.id}"
                                    }]);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}

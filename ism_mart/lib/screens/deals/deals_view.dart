import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/screens/deals/deals_viewmodel.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../helper/constants.dart';
import '../../helper/responsiveness.dart';
import '../../models/product/product_model.dart';
import '../../widgets/loader_view.dart';

class DealsView extends StatelessWidget {
  DealsView({super.key});

  final DealsViewModel viewModel = Get.put(DealsViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => viewModel.noProductsFound.value ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NoDataFoundWithIcon(
                title: langKey.emptyProductSearch.tr,
                subTitle: langKey.emptyProductSearchMsg.tr,
              ),
              AppConstant.spaceWidget(
                  height: 18
              ),
            ],
          ),
        ) : Stack(
          children: [
            Column(
              children: [
                Material(
                  elevation: 1,
                  child: Container(
                    height: AppConstant
                        .getSize()
                        .height * 0.04,
                    color: kWhiteColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        CustomText(
                          title:
                          "${viewModel.productList.length} ${langKey
                              .itemsFound.tr}",
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(8),
                    controller: viewModel.scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                        AppResponsiveness.getGridItemCount(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: AppResponsiveness
                            .getChildAspectRatioPoint90()
                      // mainAxisExtent:
                      //     AppResponsiveness.getMainAxisExtentPoint25(),
                    ),
                    itemCount: viewModel.productList.length,
                    itemBuilder: (_, index) {
                      ProductModel productModel =
                      viewModel.productList[index];
                      return SingleProductItems(
                          productModel: productModel);
                    },
                  ),
                ),
                if (viewModel.isLoadingMore.isTrue)
                  CustomLoading(
                    isItForWidget: true,
                    color: kPrimaryColor,
                  )
              ],
            ),
            NoInternetView(
              onPressed: () async{
                await viewModel.getProducts();
              },
            ),
            LoaderView(),
          ],
        ),
        ),
      ),
    );
  }
}

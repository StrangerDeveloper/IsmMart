import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SingleProductItems extends StatelessWidget {
  const SingleProductItems(
      {Key? key,
      this.productModel,
      this.isCategoryProducts = false,
      this.onTap})
      : super(key: key);
  final ProductModel? productModel;
  final bool? isCategoryProducts;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return isCategoryProducts!
        ? _buildCategoryProductItem(model: productModel, buildContext: context)
        : _buildProductItemNew(model: productModel, buildContext: context);
  }

  _buildCategoryProductItem({ProductModel? model, BuildContext? buildContext}) {
    return AspectRatio(
      aspectRatio: 0.85,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            Get.to(SingleProductView(productId: "${model.id}", calledFor: 'customer',));
          },
          child:
          Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(right: 4, left: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
              //border: Border.all(color: Colors.grey.shade200, width: 1),
              boxShadow: [
                BoxShadow(
                    color: kPrimaryColor.withOpacity(0.2),
                    offset: const Offset(0, 0),
                    blurRadius: 8)
              ],
            ),
            child: Stack(
              //fit: StackFit.expand,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: AppResponsiveness.getHeight90_140(),
                        width: double.infinity,
                        child: Center(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CustomNetworkImage(
                                imageUrl: model!.thumbnail,
                                //fit: BoxFit.cover,
                              ),
                              if (model.stock! == 0)
                                _buildOutOfStockStack(buildContext),
                            ],
                          ),
                        )
                        //child: CustomNetworkImage(imageUrl: model!.thumbnail),
                        ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomText(
                        title: model.name!,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                if (model.stock! > 0)
                  if (model.discount != 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: kOrangeColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: CustomText(
                          title: "${model.discount}% ${langKey.OFF.tr}",
                          color: kWhiteColor,
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                //if (model.stock! == 0) _buildOutOfStockStack(buildContext)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildProductItemNew({ProductModel? model, BuildContext? buildContext}) {
    //print("This one is called>>>>>>>>>>>>>>>>>>");
    return AspectRatio(
      aspectRatio: 0.8,
      child: GestureDetector(
        onTap: onTap ??
            () {
              showModalBottomSheet(
                  //isDismissible: false,
                  isScrollControlled: true,
                  context: buildContext!,
                  backgroundColor: kWhiteColor,
                  enableDrag: true,
                  elevation: 0,
                  builder: (_) {
                    return SafeArea(
                      child: Container(
                        height: AppResponsiveness.height * 0.91,
                        child: SingleProductView(
                          productId: "${model!.id}",
                        ),
                      ),
                    );
                  });
            },
        child:

        Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          //padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: kLightGreyColor, width: 1),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: AppResponsiveness.getHeight90_140(),
                      //width: double.infinity,
                      child: Center(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CustomNetworkImage(
                              imageUrl: model!.thumbnail,
                              //fit: BoxFit.cover,
                            ),
                            if (model.stock! == 0)
                              _buildOutOfStockStack(buildContext),
                          ],
                        ),
                      )
                      //child: CustomNetworkImage(imageUrl: model!.thumbnail),
                      ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //CustomText(title: "Sold: ${model.sold!}"),
                        CustomText(
                          title: model.name!,
                          size: 16,
                          weight: FontWeight.w600,
                        ),
                        AppConstant.spaceWidget(height: 5),
                        CustomPriceWidget(title: "${model.discountPrice!}"),
                        if (model.discount != 0)
                          CustomPriceWidget(
                            title: "${model.price!}",
                            style: bodyText1.copyWith(
                                decoration: TextDecoration.lineThrough),
                          ),

                        // CustomText(
                        //   title:
                        //       "${AppConstant.getCurrencySymbol()} ${model.price!}",
                        //   style: bodyText1.copyWith(
                        //       decoration: TextDecoration.lineThrough),
                        // ),
                      ],
                    ),
                  ),
                  //AppConstant.spaceWidget(height: 10)
                ],
              ),
              if (model.stock! > 0)
                if (model.discount != 0)
                  Positioned(
                    top: 1,
                    right: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: kOrangeColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: CustomText(
                        title: "${model.discount}% ${langKey.OFF.tr}",
                        color: kWhiteColor,
                        size: 12,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
              //if (model.stock! == 0) _buildOutOfStockStack(buildContext)
            ],
          ),
        ),
      ),
    );
  }
}

_buildOutOfStockStack(BuildContext? context) {
  return Stack(
    children: [
      Container(
        color: Colors.grey.shade200.withOpacity(0.5),
        width: double.infinity,
        height: MediaQuery.of(context!).size.height,
      ),
      Positioned(
        top: 1,
        right: 1,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: kOrangeColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: CustomText(
            title: "${langKey.outOfStock.tr}",
            color: kWhiteColor,
            size: 12,
            weight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

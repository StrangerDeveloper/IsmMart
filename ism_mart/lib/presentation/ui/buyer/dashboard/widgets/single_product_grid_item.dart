import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

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
        ? _buildCategoryProductItem(model: productModel)
        : _buildProductItemNew(model: productModel, buildContext: context);
  }

  _buildCategoryProductItem({ProductModel? model}) {
    return AspectRatio(
      aspectRatio: 0.8,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/product/${model.id}',
              arguments: {"calledFor": "customer"}, preventDuplicates: false);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(right: 4, left: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey.shade200, width: 1),
            boxShadow: [
              BoxShadow(
                  color: kPrimaryColor.withOpacity(0.22),
                  offset: const Offset(0, 1),
                  blurRadius: 10)
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppResponsiveness.getHeight100_150(),
                    width: double.infinity,
                    child: CustomNetworkImage(imageUrl: model!.thumbnail),
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
              if (model.discount != 0)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomText(
                      title: "${model.discount}% OFF",
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

  _buildProductItemNew({ProductModel? model, buildContext}) {
    //print("This one is called>>>>>>>>>>>>>>>>>>");
    return AspectRatio(
      aspectRatio: 0.75,
      child: GestureDetector(
        onTap: onTap ??
            //()=>Navigator.pushReplacementNamed(Get.context!, '/product/${model!.id}', arguments: {"calledFor": "customer"}),
            () {
              // if (!Get.isOverlaysOpen) Get.toNamed('/product/${model!.id}', arguments: {"calledFor": "customer"},);
              showModalBottomSheet(
                //isDismissible: false,
                  isScrollControlled: true,
                  context: buildContext,
                  backgroundColor: kWhiteColor,
                  enableDrag: true,
                  elevation: 0,
                  builder: (_) {
                    return SafeArea(
                      child: Container(
                        height: AppResponsiveness.height*0.91,
                        child: SingleProductView(
                          productId: "${model!.id}",
                        ),
                      ),
                    );
                  });

              // AppConstant.showBottomSheet(widget: SingleProductView(productId: "${model!.id}",), isGetXBottomSheet: false, buildContext: buildContext);
            },
        // () => Get.to(() => SingleProductView(), binding: ProductBinding(), arguments: {"calledFor": "customer", "id":"${model!.id}"},  opaque: true, fullscreenDialog: true),
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          //padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: kLightGreyColor, width: 1),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppResponsiveness.getHeight90_100(),
                    width: double.infinity,
                    child: CustomNetworkImage(imageUrl: model!.thumbnail),
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
                          CustomText(
                            title:
                                "${AppConstant.getCurrencySymbol()} ${model.price!}",
                            style: bodyText1.copyWith(
                                decoration: TextDecoration.lineThrough),
                          ),
                      ],
                    ),
                  ),
                  //AppConstant.spaceWidget(height: 10)
                ],
              ),
              if (model.discount != 0)
                Positioned(
                  top: 1,
                  right: 1,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: CustomText(
                      title: "${model.discount}% OFF",
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
}

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
  }) : super(
            builder: builder,
            settings: settings,
            maintainState: true,
            fullscreenDialog: false);
}

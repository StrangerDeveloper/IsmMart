import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class MyProducts extends GetView<SellersController> {
  const MyProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("myProducts: ${controller.myProductsList.length}");

    return SafeArea(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  onTap: () =>  AppConstant.showBottomSheet(
                      widget: AddProductsUI()),
                  //controller.changePage(1),
                  text: "Add Product",
                  width: 110,
                  height: 35,
                ),
              )),
          //AppConstant.spaceWidget(height: 10),
          Expanded(child: _buildProductBody()),
        ],
      ),
    );
  }


  Widget _buildProductBody() {
    return Obx(
      () => controller.myProductsList.isEmpty
          ? Center(child: NoDataFound())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8),
                itemCount: controller.myProductsList.length,
                itemBuilder: (_, index) {
                  ProductModel productModel = controller.myProductsList[index];
                  return _buildProductItem(model: productModel);
                },
              ),
            ),
    );
  }

  _buildProductItem({ProductModel? model}) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/product/${model.id}',
              arguments: {"calledFor": "seller"});
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Get.isDarkMode ? Colors.grey.shade700 : Colors.white60,
            border: Border.all(
                color:
                    Get.isDarkMode ? Colors.transparent : Colors.grey.shade400,
                width: 0.5),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CustomNetworkImage(imageUrl: model!.thumbnail ?? AppConstant.defaultImgUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: "Sold: ${model.sold!}"),
                        CustomText(
                          title: model.name!,
                          maxLines: 1,
                        ),
                        AppConstant.spaceWidget(height: 5),
                        CustomText(
                          title:
                              "${AppConstant.getCurrencySymbol()}${model.discount != 0 ? model.discountPrice! : model.price}",
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                        if (model.discount != 0)
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                title:
                                    "${AppConstant.getCurrencySymbol()}${model.price!}",
                                style: theme.textTheme.caption?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14,
                                    color: kLightColor),
                              ),
                              AppConstant.spaceWidget(width: 10),
                              CustomText(
                                title: "${model.discount}% Off",
                                color: kOrangeColor,
                                size: 14,
                                weight: FontWeight.w600,
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
                //bottom: 10,
                right: 2,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomActionIcon(
                        onTap: () {
                          controller.updateProduct(model: model);
                        },
                        icon: Icons.edit_rounded,
                        bgColor: kPrimaryColor),
                    AppConstant.spaceWidget(width: 5),
                    CustomActionIcon(
                        onTap: () => showConfirmDeleteDialog(productModel: model),
                        icon: Icons.delete_rounded,
                        bgColor: kRedColor)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showConfirmDeleteDialog({ProductModel? productModel}) {
    Get.defaultDialog(
      title: "Delete Product",
      titleStyle: headline5,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomText(
              title: "Are you sure you want to delete?",
              weight: FontWeight.w600,
            ),
            AppConstant.spaceWidget(height: 10),
            buildConfirmDeleteIcon(),
            AppConstant.spaceWidget(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  text: "No",
                  width: 100,
                  height: 35,
                  color: kRedColor,
                ),
                CustomButton(
                  onTap: () {
                    controller.deleteProduct(id: productModel!.id);
                    Get.back();
                  },
                  text: "Yes",
                  width: 100,
                  height: 35,
                  color: kRedColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

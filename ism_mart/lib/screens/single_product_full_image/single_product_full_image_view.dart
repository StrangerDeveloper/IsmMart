import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/single_product_full_image/single_product_full_image_viewmodel.dart';
import '../../models/product/product_model.dart';
import '../../utils/constants.dart';

// ignore: must_be_immutable
class SingleProductFullImageView extends GetView<ProductController> {
  SingleProductFullImageView({this.productImages, this.initialImage, this.imagesToUpdate});

  List<ProductImages>? productImages;
  int? initialImage;
  List? imagesToUpdate;

  final SingleProductFullImageViewModel viewModel = Get.put(SingleProductFullImageViewModel());

  @override
  Widget build(BuildContext context) {
    viewModel.initalizedImageController(initialImage);
    return WillPopScope(
      onWillPop: () => controller.popProductImageView(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(Get.context!).size.height,
              child: PageView.builder(
                  controller: viewModel.imageController,
                  onPageChanged: viewModel.changeImage,
                  itemCount: productImages == null ? imagesToUpdate!.length : productImages!.length,
                  itemBuilder: (context, index) {
                    return InteractiveViewer(
                        minScale: 0.1,
                        maxScale: 2.0,
                        child: productImages != null ? CustomNetworkImage(
                          imageUrl: productImages![index].url,
                          fit: BoxFit.contain,
                        ) : Image.file(imagesToUpdate?[index], fit: BoxFit.fill,)
                    );
                  }),
            ),
            Obx(
                  () => Positioned(
                bottom: 16.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    productImages != null ? productImages!.length : imagesToUpdate!.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 6.0,
                      width: /*controller.sliderIndex.value == index ? 14.0 :*/
                      6.0,
                      margin: const EdgeInsets.only(right: 4.0),
                      decoration: BoxDecoration(
                        color: controller.imageIndex.value == index
                            ? kPrimaryColor
                            : kLightColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
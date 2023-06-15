import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/single_product_full_image/single_product_full_image_viewmodel.dart';
import '../../utils/constants.dart';

class SingleProductFullImageView extends StatelessWidget {
  SingleProductFullImageView({super.key});

  final SingleProductFullImageViewModel viewModel = Get.put(SingleProductFullImageViewModel());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => viewModel.popProductImageView(),
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
                  itemCount: viewModel.productImages.isEmpty ? viewModel.imagesToUpdate.length : viewModel.productImages.length,
                  itemBuilder: (context, index) {
                    return InteractiveViewer(
                        minScale: 0.1,
                        maxScale: 2.0,
                        child: viewModel.productImages.isNotEmpty ? CustomNetworkImage(
                          imageUrl: viewModel.productImages[index].url,
                          fit: BoxFit.contain,
                        ) : Image.file(viewModel.imagesToUpdate[index], fit: BoxFit.fill,)
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
                    viewModel.productImages.isNotEmpty ? viewModel.productImages.length : viewModel.imagesToUpdate.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 6.0,
                      width: /*controller.sliderIndex.value == index ? 14.0 :*/
                      6.0,
                      margin: const EdgeInsets.only(right: 4.0),
                      decoration: BoxDecoration(
                        color: viewModel.imageIndex.value == index
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
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/update_product_images/upload_product_images_viewmodel.dart';
import '../../models/product/product_model.dart';
import '../../utils/constants.dart';

class UpdateProductImagesView extends StatelessWidget {
  UpdateProductImagesView({Key? key, this.productId, this.imagesList})
      : super(key: key);
  final int? productId;
  final List<ProductImages>? imagesList;

  final UpdateProductImagesViewModel viewModel =
      Get.put(UpdateProductImagesViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    title: 'Update Product Images',
                    style: headline1,
                  ),
                ),
              ),
              AppConstant.spaceWidget(height: 10),
              Align(
                alignment: Alignment.topCenter,
                child: CustomText(
                  title: 'Thumbnail',
                  style: headline2,
                ),
              ),
              Obx(
                () => DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  color: viewModel.thumbnailImageSizeInMb.value > 2.0
                      ? kRedColor
                      : kPrimaryColor,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: viewModel.thumbnailURl.value != ''
                        ? showThumbnailImage()
                        : GestureDetector(
                            onTap: () => AppConstant.pickImage(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.cloud_upload_rounded,
                                  size: 30,
                                ),
                                const SizedBox(height: 5),
                                CustomText(
                                  title: langKey.clickHereToUpload.tr,
                                  color: kLightColor,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }

  showThumbnailImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        viewModel.thumbnailURl.value != ''
            ? CustomNetworkImage(imageUrl: viewModel.thumbnailURl.value)
            : Image.file(viewModel.thumbnailPath[0]),
        Positioned(
          right: 0,
          child: CustomActionIcon(
            width: 25,
            height: 25,
            onTap: () {},
          ),
        )
      ],
    );
  }
}

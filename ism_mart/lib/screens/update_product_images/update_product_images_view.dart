import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/update_product_images/upload_product_images_viewmodel.dart';
import 'package:ism_mart/widgets/single_image_view.dart';
import '../../models/product/product_model.dart';
import '../../utils/constants.dart';

class UpdateProductImagesView extends StatelessWidget {

  UpdateProductImagesView({
    Key? key,
    this.productId,
    this.imagesList
  }) : super(key: key);
  final int? productId;
  final List<ProductImages>? imagesList;

  final UpdateProductImagesViewModel viewModel = Get.put(UpdateProductImagesViewModel());

  @override
  Widget build(BuildContext context) {
    viewModel.createLists(imagesList);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate(
                    [
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
                      AppConstant.spaceWidget(height: 20),
                      Align(
                        alignment: Alignment.topCenter,
                        child: CustomText(
                            title: 'Product Thumbnail',
                          style: headline2,
                        ),
                      ),
                      AppConstant.spaceWidget(height: 7),
                      Obx(()=>DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        color: viewModel.thumbnailImageSizeInMb.value > 2.0
                            ? kRedColor
                            : kPrimaryColor,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: viewModel.imagesListForUI[0].url != ''
                              ? showThumbnailImage()
                              : GestureDetector(
                            onTap: () =>viewModel.pickImage(),
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
                      ),
                      AppConstant.spaceWidget(height: 20),
                      CustomText(title: 'Product Images'),
                      AppConstant.spaceWidget(height: 15),
                      Obx(() => GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 5,
                              childAspectRatio: 0.9
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: viewModel.imagesListForUI.length-1,
                            itemBuilder: (context, index){
                              return Container(
                                width: 250,
                                height: 300,
                                child: CustomNetworkImage(
                                    imageUrl: viewModel.imagesListForUI[index+1].url,
                                  fit: BoxFit.fill,
                                ),
                              );
                            }),
                      )
                    ]
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
  
  showThumbnailImage(){
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: ()=>Get.to(()=>SingleImageView(imageUrl: viewModel.imagesListForUI[0].url,)),
        child: viewModel.imagesListForUI[0].url != '' ?
        CustomNetworkImage(imageUrl: viewModel.imagesListForUI[0].url, fit: BoxFit.fitHeight,) :
        Image.file(viewModel.imagesToUpdate[0]),
        ),
        Positioned(
          right: 0,
          child: CustomActionIcon(
            bgColor: Colors.grey,
            width: 25,
            icon: Icons.close_rounded,
            height: 25,
            onTap: (){
              viewModel.imagesToDelete.add(viewModel.imagesListForUI[0].id);
            },
          ),
        )
      ],
    );
  }
  
}
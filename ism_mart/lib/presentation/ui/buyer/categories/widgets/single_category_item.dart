import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/models/category/category_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SingleCategoryItem extends StatelessWidget {
  const SingleCategoryItem({
    Key? key,
    this.categoryModel,
    this.onTap,
  }) : super(key: key);
  final CategoryModel? categoryModel;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return _buildCategoryNew(categoryModel!);
  }

  Widget _buildCategory(CategoryModel? category) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.searchRoute,
            arguments: {"searchText": "${category.name}"});
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(right: 3),
        child: Stack(
          children: [
            SizedBox(
              width: 130,
              height: 130,
              child: CustomNetworkImage(imageUrl: category!.image!),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(110),
                ),
                child: Center(
                  child: Text(
                    category.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: bodyText1.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryNew(CategoryModel category) {
    return InkWell(
      onTap: onTap ??
          () {
            Get.toNamed(Routes.searchRoute,
                arguments: {"searchText": "${category.name}"});
          },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: SizedBox.fromSize(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(25), // Image radius
                  child: CustomNetworkImage(imageUrl: category.image!),
                ),
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              title: category.name ?? "",
              maxLines: 2,
              textAlign: TextAlign.center,
              weight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}

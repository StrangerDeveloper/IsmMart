import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/categories/model/category_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/search_details/search_details_view.dart';

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

  Widget _buildCategoryNew(CategoryModel category) {
    return InkWell(
      onTap: () {
        Get.to(() => SearchDetailsView(
              categoryID: categoryModel!.id,
          calledToGoBackOnce: true,
            ));
        // Get.toNamed(Routes.searchRoute,
        //     arguments: {"searchText": "${category.name}"});
      },
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(bottom: 2),
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

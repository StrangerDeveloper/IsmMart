import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/screens/search_details/search_details_view.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class CategoriesView extends GetView<CategoryController> {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (state == null) {
          return CustomLoading(isDarkMode: Get.isDarkMode);
        }
        if (state is List<CategoryModel>) {
          return _build(state: state);
        }
        return NoInternetView();
      },
      onLoading: CustomLoading(isDarkMode: Get.isDarkMode),
      onEmpty: NoInternetView(
        onPressed: () => controller.fetchCategories(),
      ),
    );
  }

  Widget _build({state}) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: langKey.categories.tr,
                style: headline1.copyWith(fontSize: 22),
              ),
              AppConstant.spaceWidget(height: 15),
              Expanded(
                child: _buildBodyNew(categoryList: state),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //having split but different design
  Widget _buildBodyNew({List<CategoryModel>? categoryList}) {
    //var height = AppConstant.getSize().height;
    return Row(
      children: [
        Container(
          width: AppResponsiveness.getHeight50_100(),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            //shrinkWrap: true,
            itemCount: categoryList!.length,
            itemBuilder: (_, index) {
              CategoryModel categoryModel = categoryList[index];
              return InkWell(
                onTap: () {
                  controller.getSubcategory(categoryModel);
                },
                child: Container(
                  constraints: BoxConstraints(minHeight: 150),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color:
                        categoryModel.isPressed! ? kTransparent : kPrimaryColor,
                    border: categoryModel.isPressed! ? Border.all() : Border(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: CustomText(
                      title: categoryModel.name ?? '',
                      size: AppResponsiveness.getTextSize13_16(),
                      color:
                          categoryModel.isPressed! ? kDarkColor : kWhiteColor,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        kDivider,
        Expanded(
          flex: 4,
          child: _categoryBody(),
        )
      ],
    );
  }

  Widget _categoryBody() {
    return Obx(
      () => controller.isCategoriesLoading.isTrue
          ? CustomLoading(
              isItForWidget: true,
              color: kPrimaryColor,
            )
          : controller.subCategories.isEmpty
              ? NoDataFoundWithIcon(
                  icon: Icons.category_outlined,
                  title: langKey.noSubCategoryFound.tr,
                )
              : ListView.separated(
                  padding: EdgeInsets.only(bottom: 10),
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.subCategories.length,
                  itemBuilder: (_, index) {
                    SubCategory subCategory = controller.subCategories[index];
                    return _buildSubCategoryItem(subCategory);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12);
                  },
                ),
    );
  }

  Widget _buildSubCategoryItem(SubCategory? subCategory) {
    // var height = AppConstant.getSize().height;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: () {
          Get.to(() => SearchDetailsView(
            searchQuery: "",
                subCategoryID: subCategory.id,
                calledToGoBackOnce: true,
              ));
        },
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  title: "${subCategory!.name}",
                  size: AppResponsiveness.getTextSize13_16(),
                  textAlign: TextAlign.center,
                  weight: FontWeight.bold,
                ),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

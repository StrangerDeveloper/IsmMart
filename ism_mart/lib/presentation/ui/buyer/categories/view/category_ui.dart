import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class CategoriesUI extends GetView<CategoryController> {
  const CategoriesUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (state == null) {
        return CustomLoading(isDarkMode: Get.isDarkMode);
      }
      if (state is List<CategoryModel>) {
        return _build(state: state);
      }
      return NoDataFoundWithIcon(
        icon: Icons.category_outlined,
        title: langKey.noCategoryFound.tr,
      );
    },
        onLoading: CustomLoading(isDarkMode: Get.isDarkMode),
        onEmpty: NoDataFoundWithIcon(
          icon: Icons.category_outlined,
          title: langKey.noCategoryFound.tr,
        ));
  }

  Widget _build({state}) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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

  AppBar _appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSvgLogo(),
          Obx(
            () => Expanded(
              flex: 6,
              child: SearchBar(searchText: controller.selectedCategory.value),
            ),
          ),
        ],
      ),
    );
  }

  //having split but different design
  _buildBodyNew({List<CategoryModel>? categoryList}) {
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
                  //width: 50,
                  constraints: BoxConstraints(minHeight: 150),
                  alignment: Alignment.center,
                  //padding: const EdgeInsets.all(8.0),
                  //margin: const EdgeInsets.symmetric(vertical: 5.0),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                      color: categoryModel.isPressed!
                          ? kTransparent
                          : kPrimaryColor,
                      border:
                          categoryModel.isPressed! ? Border.all() : Border(),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: CustomText(
                      title: categoryModel.name,
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
        //),
        kDivider,
        Expanded(flex: 4, child: _categoryBody())
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
              : ListView.builder(
                  itemCount: controller.subCategories.length,
                  itemBuilder: (_, index) {
                    SubCategory subCategory = controller.subCategories[index];
                    return _buildSubCategoryItem(subCategory);
                  },
                ),
    );
  }

  Widget _buildSubCategoryItem(SubCategory? subCategory) {
    // var height = AppConstant.getSize().height;
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.searchRoute,
            arguments: {"searchText": "${subCategory.name}"});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: CustomText(
                title: "${subCategory!.name}",
                //color: kWhiteColor,
                size: AppResponsiveness.getTextSize13_16(),
                textAlign: TextAlign.center,
                weight: FontWeight.bold,
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

/*Widget _buildSubCategoryItemNew(SubCategory? subCategory) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.searchRoute,
            arguments: {"searchText": "${subCategory.name}"});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            //shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(50),
            color: kWhiteColor,
            border: Border.all(color: kPrimaryColor),
            boxShadow: [
              BoxShadow(
                color: kLightGreyColor,
                blurRadius: 10,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: CustomText(
              title: subCategory!.name,
              //color: kWhiteColor,
              size: 11,
              textAlign: TextAlign.center,
              weight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }*/
}

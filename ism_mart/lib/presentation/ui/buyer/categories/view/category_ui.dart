import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

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
      return const NoDataFound(
        text: "No Categories Found",
      );
    }, onLoading: CustomLoading(isDarkMode: Get.isDarkMode));
  }

  Widget _build({state}) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: _appBar(),
        body: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50]!,
                ),
                child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: state.length,
                  itemBuilder: (_, index) {
                    CategoryModel categoryModel = state[index];
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                          color: categoryModel.isPressed!
                              ? kPrimaryColor.withOpacity(0.6)
                              : Colors.blueGrey[50]!,
                          border: categoryModel.isPressed!
                              ? Border.all(color: kPrimaryColor)
                              : null),
                      child: InkWell(
                        onTap: () {
                          controller.getSubcategory(categoryModel);
                        },
                        child: CustomText(
                          title: categoryModel.name,
                          color: categoryModel.isPressed!
                              ? kWhiteColor
                              : kDarkColor,
                          weight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            //),
            kDivider,
            Expanded(flex: 4, child: _categoryBody())
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
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

  Widget _categoryBody() {
    return Obx(
      () => controller.isCategoriesLoading.isTrue
          ? CustomLoading(
              isItForWidget: true,
              color: kPrimaryColor,
            )
          : controller.subCategories.isEmpty
              ? NoDataFound(text: "no_sub_category_found".tr)
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: controller.subCategories.length,
                  itemBuilder: (_, index) {
                    SubCategory subCategory = controller.subCategories[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes.searchRoute,
                            arguments: {"searchText": "${subCategory.name}"});
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        //color:kWhiteColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomNetworkImage(
                                imageUrl: AppConstant.defaultImgUrl, width: 50),
                            CustomText(
                              title: subCategory.name,
                              //color: kWhiteColor,
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

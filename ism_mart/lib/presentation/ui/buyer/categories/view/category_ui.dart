import 'package:flip_card/flip_card.dart';
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
    }, onLoading: CustomLoading(isDarkMode: Get.isDarkMode));
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
                CustomText(title: langKey.categories.tr, style: headline1.copyWith(fontSize: 22),),
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

  //having split for categories and sub Categories
  _buildBody({state}) {
    return Row(
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
                      color:
                          categoryModel.isPressed! ? kWhiteColor : kDarkColor,
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
    );
  }

  //having split but different design
  _buildBodyNew({List<CategoryModel>? categoryList}) {
    return Row(
      children: [
        Container(
          width: 50,
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
                  width: 50,
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

  //final  expansionTile = new GlobalKey();
  //its card expanded for subcategories
  _buildSingleCardBodyNew({List<CategoryModel>? categoryList}) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //childAspectRatio: 3 / 2,
        ),
        itemCount: categoryList!.length,
        itemBuilder: (_, index) {
          CategoryModel model = categoryList[index];
          double width = AppConstant.getSize().height;
          //return _buildFlipCard(model: model);

          return InkWell(
            onTap: () {
              model.isPressed = !model.isPressed!;
              controller.getSubcategory(model);
              controller.update();
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: const EdgeInsets.all(5.0),
              //width: model.isPressed! ? width * 0.4 : width * 0.8,
              //height: model.isPressed! ? width * 3 : width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      //height: 90,
                      //width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      //padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(color: kLightGreyColor, width: 1),
                      ),
                      child: CustomNetworkImage(imageUrl: model.image),
                    ),
                  ),
                  CustomText(
                    title: model.name,
                    maxLines: 2,
                    size: 14,
                    textAlign: TextAlign.center,
                    weight: FontWeight.w600,
                  ),
                  if (model.isPressed!)
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        height: width * 2,
                        child: Card(
                          child: _categoryBody(model: model),
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }

  _buildFlipCard({CategoryModel? model}) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    return FlipCard(
      // key: cardKey,
      controller: controller.flipCardController,
      front: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              //height: 90,
              //width: double.infinity,
              clipBehavior: Clip.hardEdge,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              //padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(color: kLightGreyColor, width: 1),
              ),
              child: CustomNetworkImage(imageUrl: model!.image),
            ),
          ),
          CustomText(
            title: model.name,
            maxLines: 2,
            size: 14,
            textAlign: TextAlign.center,
            weight: FontWeight.w600,
          ),
        ],
      ),
      //flipOnTouch: true,
      onFlip: () {
        model.isPressed = !model.isPressed!;
        controller.getSubcategory(model);
        //cardKey.currentState!.toggleCard();
        controller.update();
      },

      back: _subCategoryFlipCardBack(model, cardKey),
    );
  }

  Widget _subCategoryFlipCardBack(CategoryModel? model,
      [GlobalKey<FlipCardState>? cardKey]) {
    /*if (!model.isPressed!) {
      controller.flipCardController.toggleCard();
      controller.update();
      //return Container();
    }*/
    return Obx(() {
      if (!model!.isPressed!) {
        return Container();
      }
      return controller.isCategoriesLoading.isTrue
          ? CustomLoading(
              isItForWidget: true,
              color: kPrimaryColor,
            )
          : controller.subCategories.isEmpty
              ? NoDataFoundWithIcon(icon:Icons.category_outlined,title: langKey.noSubCategoryFound.tr)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: kPrimaryColor,
                            size: 13,
                          ),
                          CustomText(
                            title: "Sub Categories",
                            color: kDarkColor,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    AppConstant.spaceWidget(height: 5),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.subCategories.length,
                        itemBuilder: (_, index) {
                          SubCategory subCategory =
                              controller.subCategories[index];
                          return _buildSubCategoryItem(subCategory);
                        },
                      ),
                    ),
                  ],
                );
    });
  }

  Widget _categoryBody({CategoryModel? model}) {
    return Obx(
      () => controller.isCategoriesLoading.isTrue
          ? CustomLoading(
              isItForWidget: true,
              color: kPrimaryColor,
            )
          : controller.subCategories.isEmpty
              ? NoDataFoundWithIcon(icon:Icons.category_outlined,title: langKey.noSubCategoryFound.tr)
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
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.searchRoute,
            arguments: {"searchText": "${subCategory.name}"});
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(9.0),
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

  Widget _buildSubCategoryItemNew(SubCategory? subCategory) {
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
  }
}

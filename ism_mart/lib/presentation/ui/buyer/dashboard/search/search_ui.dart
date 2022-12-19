import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SearchUI extends GetView<SearchController> {
  const SearchUI( {Key? key, this.isCalledForDeals = false,}) : super(key: key);
  final bool? isCalledForDeals;
  @override
  Widget build(BuildContext context) {
    controller.searchTextController.text =
        Get.arguments != null ? Get.arguments["searchText"].toString() : " ";


    return Hero(
      tag: "productSearchBar",
      child: SafeArea(
        child: Scaffold(
          appBar: _searchAppBar(context),
          body: _body(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _filterBar(),
        ),
      ),
    );
    /* return controller.obx((state) {

    },onLoading: NoDataFound());*/
  }

  _searchAppBar(context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: null,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Search bar
          Expanded(
            flex: 6,
            child: Container(
              height: 36,
              //height: 40.0,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(color: kLightGreyColor),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: TextField(
                  controller: controller.searchTextController,
                  cursorColor: kPrimaryColor,
                  autofocus: false,
                  textInputAction: TextInputAction.search,
                  // onChanged: controller.search,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 4),
                    border: InputBorder.none,
                    icon: const Icon(Icons.search, color: kPrimaryColor),
                    hintText: "What are you looking for?",
                    hintStyle: textTheme.bodyText1!.copyWith(
                      color: kLightColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///Cancel Button
          if(!isCalledForDeals!)
          Expanded(
            child: InkWell(
              onTap: () => Get.back(),
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _body() {
    return Obx(() => controller.isLoading.isTrue
        ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
        : controller.productList.isEmpty
            ? NoDataFound(text: "Search product")
            : _buildProductView(controller.productList));
  }

  Widget _buildProductView(List<ProductModel> list) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, childAspectRatio: 3 / 4),
        itemCount: list.length,
        itemBuilder: (_, index) {
          ProductModel productModel = list[index];
          return _buildProductItem(model: productModel);
        },
      ),
    );
  }

  _buildProductItem({ProductModel? model}) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/product/${model.id}',
              arguments: {"calledFor": "customer"});
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Get.isDarkMode ? Colors.grey.shade700 : Colors.white60,
            border: Border.all(
                color:
                    Get.isDarkMode ? Colors.transparent : Colors.grey.shade200,
                width: 1),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CustomNetworkImage(imageUrl: model!.thumbnail),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: "Sold: ${model.sold!}"),
                        CustomText(
                          title: model.name!,
                          maxLines: 1,
                        ),
                        AppConstant.spaceWidget(height: 5),
                        CustomText(
                          title:
                              "${AppConstant.getCurrencySymbol()}${model.discount != 0 ? model.discountPrice! : model.price}",
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                        if (model.discount != 0)
                          CustomText(
                            title:
                                "${AppConstant.getCurrencySymbol()}${model.price!}",
                            style: theme.textTheme.caption?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                color: kLightGreyColor),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (model.discount != 0)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      title: "${model.discount}% Off",
                      color: kWhiteColor,
                      size: 12,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterBar() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.sort_rounded,
                color: kWhiteColor,
              ),
              label: CustomText(
                title: "Sort",
                color: kWhiteColor,
                weight: FontWeight.bold,
              ),
            ),
          ),
          kVerticalDivider,
          Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: TextButton.icon(
              onPressed: () => showFilterBottomSheet(),
              icon: Icon(
                Icons.filter_alt_rounded,
                color: kWhiteColor,
              ),
              label: CustomText(
                title: "Filter",
                color: kWhiteColor,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showFilterBottomSheet() {
    var baseController = Get.find<BaseController>();
    AppConstant.showBottomSheet(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [

                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => controller.clearFilters(),
                        child: const Text(
                          "Clear Filters",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      InkWell(
                        onTap: () => controller.applyFilter(),
                        child: const Text(
                          "Apply Filters",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),

                  StickyLabel(text: "Categories"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(()=> Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: baseController.categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                category.isPressed = !category.isPressed!;
                                controller.selectedCategoryId(category.id!);
                                baseController.categories.refresh();
                              },
                              child: Container(
                                //width: 100,
                                padding: const EdgeInsets.all(8),
                                //margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: category.isPressed! ? kPrimaryColor: kWhiteColor,
                                    border: Border.all(color: kPrimaryColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: CustomText(title: category.name, size: category.isPressed!?15:13),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  StickyLabel(text: "Price"),
                  //AppConstant.spaceWidget(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 50,
                        child: FormInputFieldWithIcon(
                          controller: controller.minPriceController,
                          iconPrefix: Icons.attach_money_rounded,
                          labelText: 'Min Price',
                          iconColor: kPrimaryColor,
                          enableBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 1.5),
                            //borderRadius: BorderRadius.circular(25.0),
                          ),
                          autofocus: false,
                          textStyle: bodyText1,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        height: 50,
                        child: FormInputFieldWithIcon(
                          controller: controller.maxPriceController,
                          iconPrefix: Icons.attach_money_rounded,
                          labelText: 'Max Price',
                          iconColor: kPrimaryColor,
                          autofocus: false,
                          enableBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 1.5),
                            //borderRadius: BorderRadius.circular(25.0),
                          ),
                          textStyle: bodyText1,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

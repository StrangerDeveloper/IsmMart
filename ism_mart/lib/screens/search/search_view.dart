import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/screens/search/search_viewmodel.dart';
import 'package:ism_mart/search_details/search_details_view.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SearchView extends GetView<SearchViewModel> {
  SearchView({super.key});

  //final SearchViewModel viewModel = Get.put(SearchViewModel(Get.find<ApiProvider>()));
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "productSearchBar",
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[50]!,
          appBar: _searchAppBar(),
          body: Obx(
            () => Stack(
              children: [
                _body(),
                controller.suggestionList.isNotEmpty
                    ? Positioned(
                        top: 1,
                        child: _suggestionList(controller.suggestionList),
                      )
                    : Container()
              ],
            ),
          ),
          //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          //floatingActionButton: _filterBar(),
        ),
      ),
    );
  }

  _searchAppBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 40,
      leading: InkWell(
        onTap: () {
          controller.suggestionList.clear();
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: Container(
        height: 36,
        child: TextField(
          controller: controller.searchTextController,
          onChanged: (value) {
            if (value.isNotEmpty)
              controller.searchProducts(value);
            else
              controller.suggestionList.clear();
          },
          cursorColor: kPrimaryColor,
          autofocus: false,
          maxLines: 1,
          style: TextStyle(
            color: kLightColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(Icons.search, color: kPrimaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kLightGreyColor,
                width: 0.5,
              ), //BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kLightGreyColor,
                width: 0.5,
              ), //BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            fillColor: kWhiteColor,
            contentPadding: EdgeInsets.zero,
            hintText: searchIn.tr,
            hintStyle: TextStyle(
              color: kLightColor,
              fontWeight: FontWeight.w600,
              fontSize: 13.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        StickyLabelWithViewMoreOption(
            title: "Recent Searches", moreOptionText: clear.tr, onTap: () {}),
        AppConstant.spaceWidget(height: 10),
      ],
    );
  }

  _suggestionList(List<ProductModel> list) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: CustomGreyBorderContainer(
        borderColor: kTransparent,
        hasShadow: false,
        height: AppResponsiveness.getHeightByPoints(points: 0.3),
        width: AppResponsiveness.getWidthByPoints(points: 0.95),
        child: UnconstrainedBox(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (_, index) {
                ProductModel model = list[index];
                return ListTile(
                  onTap: () => Get.off(SearchDetailsView(
                    isCalledForDeals: true,
                    passedSearchQuery: model.name ?? "",
                  )),
                  title: CustomText(
                    title: model.name ?? "",
                  ),
                  // tileColor: controller.selectedIndex.value == index
                  //     ? Colors.black12
                  //     : kAccentColor,
                );
              }),
        ),
      ),
    );
  }
}

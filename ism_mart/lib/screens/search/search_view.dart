import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/controllers/buyer/search/custom_search_controller.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/screens/search/search_viewmodel.dart';
import 'package:ism_mart/screens/search_details/search_details_view.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SearchView extends GetView<SearchViewModel> {
  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50]!,
        appBar: _searchAppBar(),
        body: Obx(
          () => Stack(
            children: [
              _body(),
              controller.isSearchingStarted.isTrue
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
    );
  }

  _searchAppBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 30,
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
            controller.isSearchingStarted(false);
            if (value.isNotEmpty) {
              controller.isSearchingStarted(true);
              controller.searchProducts(value);
            } else
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
            title: "Recent Searches",
            moreOptionText: clear.tr,
            onTap: () => controller.clearHistory()),
        AppConstant.spaceWidget(height: 10),
        Expanded(
            child: controller.historyList.isEmpty
                ? NoDataFoundWithIcon(
                    title: noDataFound.tr,
                    icon: Icons.search,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.historyList.length,
                    itemBuilder: (_, index) {
                      String? text = controller.historyList[index];
                      return _singleListViewItem(text: text);
                    })),
      ],
    );
  }

  _suggestionList(List<ProductModel> list) {
    return Padding(
      padding: EdgeInsets.only(left: 50),
      child: SizedBox(
        height: 300,
        width: AppResponsiveness.getWidthByPoints(points: 0.82),
        child: CustomGreyBorderContainer(
          borderColor: kTransparent,
          child: GlobalVariable.showLoader.isTrue
              ? CustomLoading(
                  isItForWidget: true,
                  color: kPrimaryColor,
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    ProductModel model = list[index];
                    return _singleListViewItem(
                        text: model.name ?? "", isCalledForSearch: true);
                  }),
        ),
      ),
    );
  }

  _singleListViewItem({String? text, bool? isCalledForSearch = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (isCalledForSearch!) {
              controller.addHistory(
                  search: controller.searchTextController.text);
            }

            Get.find<CustomSearchController>().filters.clear();
            Get.off(
              () => SearchDetailsView(searchQuery: text),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              title: text,
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade600,
          thickness: 0.1,
        ),
      ],
    );
  }
}

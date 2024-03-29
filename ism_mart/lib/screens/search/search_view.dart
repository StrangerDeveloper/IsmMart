import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/controllers/buyer/search/custom_search_controller.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/screens/search/search_viewmodel.dart';
import 'package:ism_mart/screens/search_details/search_details_view.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class SearchView extends GetView<SearchViewModel> {
  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50]!,
      appBar: _appBar(),
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
    );
  }

  CustomAppBar _appBar() {
    return CustomAppBar(
      leadingWidth: 35,
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
      searchBar: Container(
        height: 36,
        child: TextField(
          controller: controller.searchTextController,
          onSubmitted: (value) {
            controller.addHistory(
                search: controller.searchTextController.text);

            CustomSearchController customSearchController = Get.find();
            customSearchController.productList.clear();
            customSearchController.filters.clear();
            Get.to(() => SearchDetailsView(searchQuery: value),
            );
            controller.searchTextController.clear();
            controller.suggestionList.clear();
          },
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            controller.isSearchingStarted(false);
            if (value.isNotEmpty && value.length >= 2) {
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
            hintText: langKey.searchIn.tr,
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
            title: langKey.recentSearches.tr,
            moreOptionText: langKey.clear.tr,
            onTap: () => controller.clearHistory()),
        AppConstant.spaceWidget(height: 10),
        Expanded(
          child: controller.historyList.isEmpty
              ? NoDataFoundWithIcon(
                  title: langKey.noDataFound.tr,
                  icon: Icons.search,
                )
              : ListView.builder( 
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.historyList.length,
                  itemBuilder: (_, index) {
                    String? text = controller.historyList[index];
                    return _singleListViewItem(text: text);
                  },
                ),
        ),
      ],
    );
  }

  Widget _suggestionList(List<ProductModel> list) {
    return controller.suggestionList.isEmpty
        ? Container()
        : Padding(
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
                              text: model.name ?? "",
                              isCalledForSearch: true,
                              url: model.thumbnail);
                        },
                      ),
              ),
            ),
          );
  }

  Widget _singleListViewItem({
    String? text,
    String? url,
    bool? isCalledForSearch = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (isCalledForSearch!) {
              controller.addHistory(
                  search: controller.searchTextController.text);
            }

            CustomSearchController customSearchController = Get.find();
            customSearchController.productList.clear();
            customSearchController.filters.clear();
            Get.to(
              () => SearchDetailsView(searchQuery: text),
            );
            controller.searchTextController.clear();
            controller.suggestionList.clear();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                Expanded(
                  child: CustomText(
                    maxLines: 1,
                    title: text ?? '',
                    ),
                ),

                url == null
                    ? Container()
                    : SizedBox(
                        width: 35,
                        height: 35,
                        child: CustomNetworkImage(
                          imageUrl: url.toString(),
                        ),
                      )
              ],
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

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ism_mart/controllers/buyer/search/allproducts_model.dart';
// import 'package:ism_mart/controllers/export_controllers.dart';
// import 'package:ism_mart/models/exports_model.dart';
// import 'package:ism_mart/exports/export_presentation.dart';
// import 'package:ism_mart/screens/single_product_details/single_product_details_view.dart';
// import 'package:ism_mart/utils/exports_utils.dart';
// import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

// class AllProductsView extends GetView<CustomSearchController> {
//   const AllProductsView(
//       {Key? key,
//       this.passedSearchQuery,
//       this.isCalledForDeals = false,
//       this.calledForCategory,
//       this.subCategoryID})
//       : super(key: key);

//   final bool? isCalledForDeals;
//   final String? passedSearchQuery;
//   final bool? calledForCategory;
//   final int? subCategoryID;

//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     var h = MediaQuery.of(context).size.height;

//     //  final controller = Get.find<SearchController>();
//     controller.searchTextController.clear();
//     controller.subCategoryID.value = 0;
//     controller.selectedCategory('');
//     String searchQuery = '';
//     if (passedSearchQuery == 'ISMMART Originals') {
//       searchQuery = 'IsmmartOriginal';
//       controller.selectedCategory.value = searchQuery;
//     } else if (passedSearchQuery == 'Popular Products') {
//       searchQuery = 'Latest';
//       controller.selectedCategory.value = searchQuery;
//     } else if (passedSearchQuery == 'Featured Products') {
//       searchQuery = 'Featured';
//       controller.selectedCategory.value = searchQuery;
//     } else {
//       controller.selectedCategory(passedSearchQuery);
//     }

//     if (calledForCategory == null) {
//       null;
//     } else {
//       calledForCategory!
//           ? controller.searchProductsByCategory(searchQuery)
//           : controller.searchWithSubCategory(subCategoryID);
//     }
//     return Hero(
//       tag: "productSearchBar",
//       child: SafeArea(
//         child: WillPopScope(
//           onWillPop: () {
//             return controller.goBack();
//           },
//           child: Scaffold(
//             backgroundColor: Colors.grey[100]!,
//             appBar: _searchAppBar(),
//             body: _body(h, w),
//             //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//             //floatingActionButton: _filterBar(),
//           ),
//         ),
//       ),
//     );
//     /* return controller.obx((state) {

//     },onLoading: NoDataFound());*/
//   }

//   _searchAppBar() {
//     return AppBar(
//       backgroundColor: kAppBarColor,
//       elevation: 0,
//       automaticallyImplyLeading: false,
//       leadingWidth: 40,
//       leading: isCalledForDeals!
//           ? null
//           : InkWell(
//               onTap: () {
//                 controller.productList.clear();
//                 controller.searchLimit = 15;
//                 controller.searchTextController.clear();
//                 controller.goBack();
//               },
//               child: Icon(
//                 Icons.arrow_back_ios_new,
//                 size: 18,
//                 color: kPrimaryColor,
//               ),
//             ),
//       title: Container(
//         height: 36,
//         child: TextField(
//           onTap: () => Get.to(AllProductsView()),
//           controller: controller.searchTextController,
//           //focusNode: controller.focus,
//           onChanged: (value) {
//             if (value != '') {
//               controller.filteredListfunc(value);
//               controller.selectedCategory('');
//               controller.searchProducts(value);
//               controller.searchLimit = 15;
//               //  controller.suggestionSearch();
//             } else if (controller.searchTextController.text.isEmpty ||
//                 controller.filteredlist.length == 0 ||
//                 value == "") {
//               controller.filteredlist.clear();
//             } else {
//               controller.filteredlist.clear();
//             }
//           },
//           cursorColor: kPrimaryColor,
//           autofocus: false,
//           maxLines: 1,
//           style: TextStyle(
//             color: kLightColor,
//             fontWeight: FontWeight.w600,
//             fontSize: 15.0,
//           ),
//           textAlignVertical: TextAlignVertical.center,
//           decoration: InputDecoration(
//             filled: true,
//             prefixIcon: Icon(Icons.search, color: kPrimaryColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: kLightGreyColor,
//                 width: 0.5,
//               ), //BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: kLightGreyColor,
//                 width: 0.5,
//               ), //BorderSide.none,
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//             ),
//             fillColor: kWhiteColor,
//             contentPadding: EdgeInsets.zero,
//             hintText: "Suggestion Search Bar",
//             hintStyle: TextStyle(
//               color: kLightColor,
//               fontWeight: FontWeight.w600,
//               fontSize: 13.0,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _body(h, w) {
//     //print("ProductList: ${controller.productList.length}");
//     /* return GetBuilder<SearchController>(
//         builder: (_) => */ /*controller.isLoading.isTrue
//             ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
//             : */ /*controller.productList.isEmpty
//                 ? Center(
//                     child: NoDataFoundWithIcon(
//                       title: langKey.emptyProductSearch.tr,
//                       subTitle: langKey.emptyProductSearchMsg.tr,
//                     ),
//                   )
//                 : _buildProductView(controller.productList));*/

//     return Obx(() => controller.isLoading.isTrue
//         ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
//         : controller.filteredlist.isEmpty
//             ? Stack(
//                 children: [
//                   Center(
//                     child: NoDataFoundWithIcon(
//                       title: langKey.emptyProductSearch.tr,
//                       subTitle: langKey.emptyProductSearchMsg.tr,
//                     ),
//                   ),
//                 ],
//               )
//             : Stack(
//                 children: [
//                   //   _buildProductView(controller.allProductsList),
//                   Positioned(
//                       top: 1,
//                       child: Obx(
//                         () => controller.filteredlist.isNotEmpty
//                             ? Column(
//                                 children: [
//                                   SizedBox(
//                                       child: CustomText(
//                                           title:
//                                               "${controller.filteredlist.length} item found")),
//                                   Container(
//                                     padding: EdgeInsets.only(left: 40),
//                                     color: Colors.white,
//                                     height: h * .85,
//                                     width: w * .99,
//                                     child: ListView.builder(
//                                       itemCount: controller.filteredlist.length,
//                                       itemBuilder: (context, index) {
//                                         return ListTile(
//                                           onTap: () {
//                                             controller.selectedIndex.value =
//                                                 index;

//                                             controller
//                                                     .searchTextController.text =
//                                                 controller.filteredlist[index]
//                                                     .toString();

//                                             controller.selectedCategory('');
//                                             controller.searchProducts(controller
//                                                 .searchTextController.text);
//                                             controller.searchLimit = 15;

//                                             // controller.suggestionList.clear();
//                                             controller.finalSerach(true);
//                                             Get.back();
//                                           },
//                                           tileColor:
//                                               controller.selectedIndex.value ==
//                                                       index
//                                                   ? Colors.black12
//                                                   : kAccentColor,
//                                           title: CustomText(
//                                             title: controller
//                                                 .filteredlist[index]
//                                                 .toString(),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             : SizedBox(),
//                       )),
//                 ],
//               ));
//   }

//   // Widget _buildProductView(List<AllProductsModel> list) {
//   //   return Column(
//   //     children: [
//   //       ///Filter bar
//   //       ///Material is used for elevation like appbar
//   //       Material(
//   //         elevation: 1,
//   //         child: Container(
//   //           height: AppConstant.getSize().height * 0.05,
//   //           color: kWhiteColor,
//   //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//   //           child: Row(
//   //             children: [
//   //               Expanded(
//   //                 flex: 2,
//   //                 child: CustomText(
//   //                   title: "${list.length} ${langKey.itemsFound.tr}",
//   //                   weight: FontWeight.w600,
//   //                 ),
//   //               ),
//   //               Expanded(
//   //                 flex: 4,
//   //                 child: GestureDetector(
//   //                   onTap: () => Get.to(SearchView()),
//   //                   child: Row(
//   //                     mainAxisAlignment: MainAxisAlignment.end,
//   //                     children: [
//   //                       TextButton.icon(
//   //                         onPressed: () => Get.to(SearchView()),
//   //                         icon: Icon(
//   //                           Icons.sort_rounded,
//   //                           color: kPrimaryColor,
//   //                         ),
//   //                         label: CustomText(
//   //                           title: langKey.sortBy.tr,
//   //                           color: kPrimaryColor,
//   //                           weight: FontWeight.bold,
//   //                         ),
//   //                       ),
//   //                       TextButton.icon(
//   //                         onPressed: () {
//   //                           Get.to(SearchView());
//   //                           // controller.setCategories(baseController.categories);
//   //                           // showFilterBottomSheet();
//   //                         },
//   //                         icon: Icon(
//   //                           Icons.filter_alt_rounded,
//   //                           color: kPrimaryColor,
//   //                         ),
//   //                         label: CustomText(
//   //                           title: langKey.filter.tr,
//   //                           color: kPrimaryColor,
//   //                           weight: FontWeight.bold,
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //       Expanded(
//   //         child: Column(
//   //           children: [
//   //             Expanded(
//   //               child: GridView.builder(
//   //                 padding: EdgeInsets.all(8),
//   //                 controller: controller.scrollController,
//   //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //                     crossAxisCount: AppResponsiveness.getGridItemCount(),
//   //                     mainAxisSpacing: 10,
//   //                     crossAxisSpacing: 10,
//   //                     childAspectRatio:
//   //                         AppResponsiveness.getChildAspectRatioPoint90()
//   //                     // mainAxisExtent:
//   //                     //     AppResponsiveness.getMainAxisExtentPoint25(),
//   //                     ),
//   //                 itemCount: controller.allProductsList.length,
//   //                 itemBuilder: (_, index) {
//   //                   AllProductsModel productModel = list[index];
//   //                   return AllSingleProductItems(productModel: productModel);
//   //                 },
//   //               ),
//   //             ),
//   //             if (controller.isLoadingMore.isTrue)
//   //               CustomLoading(
//   //                 isItForWidget: true,
//   //                 color: kPrimaryColor,
//   //               )
//   //           ],
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   void showFilterBottomSheet() {
//     AppConstant.showBottomSheet(
//       widget: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 5),
//                       child: CustomText(
//                         title: langKey.filter.tr,
//                         weight: FontWeight.bold,
//                         size: 16,
//                       ),
//                     ),
//                     IconButton(
//                       visualDensity: VisualDensity.compact,
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: Icon(Icons.close),
//                     ),
//                   ],
//                 ),
//                 Divider(),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 13),
//             child: CustomText(
//               title: langKey.categories.tr,
//               weight: FontWeight.bold,
//               size: 14,
//             ),
//           ),
//           Obx(
//             () => Container(
//               height: 70,
//               child: ListView.builder(
//                 physics: BouncingScrollPhysics(),
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: controller.categoriesList.length,
//                 itemBuilder: (_, index) {
//                   CategoryModel categoryModel =
//                       controller.categoriesList[index];
//                   return Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
//                     child: InkWell(
//                       onTap: () {
//                         controller.selectedCategoryId(categoryModel.id!);
//                         controller.makeSelectedCategory(categoryModel);
//                       },
//                       borderRadius: BorderRadius.circular(5),
//                       child: Container(
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: categoryModel.isPressed!
//                               ? kPrimaryColor
//                               : kTransparent,
//                           border: categoryModel.isPressed!
//                               ? Border()
//                               : Border.all(),
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: CustomText(
//                           title: categoryModel.name,
//                           color: categoryModel.isPressed!
//                               ? kWhiteColor
//                               : kDarkColor,
//                           weight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 13, top: 10),
//             child: CustomText(
//               title: langKey.price.tr,
//               weight: FontWeight.bold,
//               size: 14,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: FormInputFieldWithIcon(
//                     controller: controller.minPriceController,
//                     iconPrefix: Icons.attach_money_rounded,
//                     labelText: langKey.minPrice.tr,
//                     iconColor: kPrimaryColor,
//                     enableBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: kPrimaryColor,
//                         width: 1.5,
//                       ),
//                     ),
//                     autofocus: false,
//                     textStyle: bodyText1,
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) {},
//                     onSaved: (value) {},
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 Expanded(
//                   child: FormInputFieldWithIcon(
//                     controller: controller.maxPriceController,
//                     iconPrefix: Icons.attach_money_rounded,
//                     labelText: langKey.maxPrice.tr,
//                     iconColor: kPrimaryColor,
//                     autofocus: false,
//                     enableBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: kPrimaryColor,
//                         width: 1.5,
//                       ),
//                     ),
//                     textStyle: bodyText1,
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) {},
//                     onSaved: (value) {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           _filtersBtn(),
//         ],
//       ),
//     );
//   }

//   Widget _filtersBtn() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Expanded(
//             child: CustomTextBtn(
//               onPressed: () => controller.clearFilters(),
//               title: clear.tr,
//               height: 36,
//             ),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: CustomTextBtn(
//               onPressed: () {
//                 controller.applyFilter();
//                 controller.minPriceController.clear();
//                 controller.maxPriceController.clear();
//               },
//               title: langKey.search.tr,
//               height: 36,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void showSortBottomSheet() {
//     AppConstant.showBottomSheet(
//       widget: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 5),
//                       child: CustomText(
//                         title: langKey.sortByPrice.tr,
//                         weight: FontWeight.bold,
//                         size: 16,
//                       ),
//                     ),
//                     IconButton(
//                       visualDensity: VisualDensity.compact,
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: Icon(Icons.close),
//                     ),
//                   ],
//                 ),
//                 Divider(),
//               ],
//             ),
//           ),
//           RadioListTile(
//             visualDensity: const VisualDensity(
//               horizontal: VisualDensity.minimumDensity,
//             ),
//             activeColor: kPrimaryColor,
//             toggleable: true,
//             title: CustomText(
//               title: langKey.lowToHigh.tr,
//               size: 14,
//             ),
//             value: 'low-to-high',
//             onChanged: (String? value) {
//               controller.setSortBy(value!);
//               Get.back();
//             },
//             groupValue: controller.sortBy,
//           ),
//           RadioListTile(
//             visualDensity: const VisualDensity(
//               horizontal: VisualDensity.minimumDensity,
//             ),
//             activeColor: kPrimaryColor,
//             toggleable: true,
//             title: CustomText(
//               title: langKey.highToLow.tr,
//               size: 14,
//             ),
//             value: 'high-to-low',
//             onChanged: (String? value) {
//               controller.setSortBy(value!);
//               Get.back();
//             },
//             groupValue: controller.sortBy,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AllSingleProductItems extends StatelessWidget {
//   const AllSingleProductItems({
//     Key? key,
//     this.allProductsModel,
//     this.productModel,
//     this.isCategoryProducts = false,
//     this.onTap,
//   }) : super(key: key);
//   final AllProductsModel? productModel;
//   final bool? isCategoryProducts;
//   final GestureTapCallback? onTap;
//   final AllProductsModel? allProductsModel;

//   @override
//   Widget build(BuildContext context) {
//     return isCategoryProducts!
//         ? _buildCategoryProductItem(model: productModel, buildContext: context)
//         : _buildProductItemNew(model: productModel, buildContext: context);
//   }

//   _buildCategoryProductItem(
//       {AllProductsModel? model, BuildContext? buildContext}) {
//     return AspectRatio(
//       aspectRatio: 0.85,
//       child: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: GestureDetector(
//           onTap: () {
//             Get.to(() => SingleProductDetailsView(), arguments: [{
//               "calledFor": "customer",
//               "productID": "${model.id}"
//             }]);
//           },
//           child: Container(
//             clipBehavior: Clip.hardEdge,
//             margin: const EdgeInsets.only(right: 4, left: 4),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: Colors.grey.shade100,
//               //border: Border.all(color: Colors.grey.shade200, width: 1),
//               boxShadow: [
//                 BoxShadow(
//                     color: kPrimaryColor.withOpacity(0.2),
//                     offset: const Offset(0, 0),
//                     blurRadius: 8)
//               ],
//             ),
//             child: Stack(
//               //fit: StackFit.expand,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                         height: AppResponsiveness.getHeight90_140(),
//                         width: double.infinity,
//                         child: Center(
//                           child: Stack(
//                             fit: StackFit.expand,
//                             children: [
//                               CustomNetworkImage(
//                                 imageUrl: model!.thumbnail,
//                                 //fit: BoxFit.cover,
//                               ),
//                               if (model.stock! == 0)
//                                 _buildOutOfStockStack(buildContext),
//                             ],
//                           ),
//                         )
//                         //child: CustomNetworkImage(imageUrl: model!.thumbnail),
//                         ),
//                     Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: CustomText(
//                         title: model.name!,
//                         maxLines: 2,
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (model.stock! > 0)
//                   if (model.discount != 0)
//                     Positioned(
//                       top: 0,
//                       right: 0,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         decoration: BoxDecoration(
//                           color: kOrangeColor,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: CustomText(
//                           title: "${model.discount}% ${langKey.OFF.tr}",
//                           color: kWhiteColor,
//                           size: 12,
//                           weight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                 //if (model.stock! == 0) _buildOutOfStockStack(buildContext)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _buildProductItemNew({AllProductsModel? model, BuildContext? buildContext}) {
//     //print("This one is called>>>>>>>>>>>>>>>>>>");
//     return AspectRatio(
//       aspectRatio: 0.8,
//       child: GestureDetector(
//         onTap: onTap ??
//             () {
//           Get.to(() => SingleProductDetailsView(), arguments: [{
//             "calledFor": "customer",
//             "productID": "${model!.id}"
//           }]);
//               // showModalBottomSheet(
//               //     //isDismissible: false,
//               //     isScrollControlled: true,
//               //     context: buildContext!,
//               //     backgroundColor: kWhiteColor,
//               //     enableDrag: true,
//               //     elevation: 0,
//               //     builder: (_) {
//               //       return SafeArea(
//               //         child: Container(
//               //           height: AppResponsiveness.height * 0.91,
//               //           child: SingleProductDetailsView(
//               //             productId: "${model!.id}",
//               //           ),
//               //         ),
//               //       );
//               //     });
//             },
//         child: Container(
//           clipBehavior: Clip.hardEdge,
//           margin: const EdgeInsets.symmetric(horizontal: 5),
//           //padding: const EdgeInsets.all(1),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: Colors.white,
//             border: Border.all(color: kLightGreyColor, width: 1),
//           ),
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                       height: AppResponsiveness.getHeight90_140(),
//                       //width: double.infinity,
//                       child: Center(
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             CustomNetworkImage(
//                               imageUrl: model!.thumbnail,
//                               //fit: BoxFit.cover,
//                             ),
//                             if (model.stock! == 0)
//                               _buildOutOfStockStack(buildContext),
//                           ],
//                         ),
//                       )
//                       //child: CustomNetworkImage(imageUrl: model!.thumbnail),
//                       ),
//                   Padding(
//                     padding: const EdgeInsets.all(6),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         //CustomText(title: "Sold: ${model.sold!}"),
//                         CustomText(
//                           title: model.name!,
//                           size: 16,
//                           weight: FontWeight.w600,
//                         ),
//                         AppConstant.spaceWidget(height: 5),
//                         CustomPriceWidget(title: "${model.discount!}"),
//                         if (model.discount != 0)
//                           CustomPriceWidget(
//                             title: "${model.price!}",
//                             style: bodyText1.copyWith(
//                                 decoration: TextDecoration.lineThrough),
//                           ),

//                         // CustomText(
//                         //   title:
//                         //       "${AppConstant.getCurrencySymbol()} ${model.price!}",
//                         //   style: bodyText1.copyWith(
//                         //       decoration: TextDecoration.lineThrough),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   //AppConstant.spaceWidget(height: 10)
//                 ],
//               ),
//               if (model.stock! > 0)
//                 if (model.discount != 0)
//                   Positioned(
//                     top: 1,
//                     right: 1,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 5, horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: kOrangeColor,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: CustomText(
//                         title: "${model.discount}% ${langKey.OFF.tr}",
//                         color: kWhiteColor,
//                         size: 12,
//                         weight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//               //if (model.stock! == 0) _buildOutOfStockStack(buildContext)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// _buildOutOfStockStack(BuildContext? context) {
//   return Stack(
//     children: [
//       Container(
//         color: Colors.grey.shade200.withOpacity(0.5),
//         width: double.infinity,
//         height: MediaQuery.of(context!).size.height,
//       ),
//       Positioned(
//         top: 1,
//         right: 1,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           decoration: BoxDecoration(
//             color: kOrangeColor,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: CustomText(
//             title: "${langKey.outOfStock.tr}",
//             color: kWhiteColor,
//             size: 12,
//             weight: FontWeight.w600,
//           ),
//         ),
//       ),
//     ],
//   );
// }

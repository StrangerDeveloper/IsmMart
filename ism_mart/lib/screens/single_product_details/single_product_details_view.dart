import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/screens/cart/cart_viewmodel.dart';
import 'package:ism_mart/screens/product_questions/product_questions_view.dart';
import 'package:ism_mart/screens/single_product_details/single_product_details_viewmodel.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SingleProductDetailsView extends StatelessWidget {
  SingleProductDetailsView({super.key});

  final SingleProductDetailsViewModel viewModel =
      Get.put(SingleProductDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => viewModel.popSingleProductView(),
        child: Obx(() => viewModel.productModel.value == ProductModel()
            ? Scaffold(
                body: Center(
                    child: viewModel.productFoundCheck.value
                        ? CustomLoading()
                        : NoInternetView(
                            onPressed: () => viewModel.fetchProduct(),
                          )
                    //  NoDataFoundWithIcon(
                    //     title: langKey.productNotFound.tr,
                    //   ),
                    ),
              )
            : Scaffold(
                appBar: _appBar(),
                backgroundColor: Colors.grey[300]!,
                resizeToAvoidBottomInset: true,
                body: Stack(
                  fit: StackFit.expand,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          _productImages(),

                          /// Product Basic Details.
                          _productBasicDetails(),

                          /// Product features
                          if (viewModel
                              .productModel.value.productFeatures!.isNotEmpty)
                            _productVariantsDetails(),

                          //_vendorStoreDetails(productModel: productModel),

                          ///product description
                          _productAdvanceDetails(),

                          ///product reviews
                          // _productReviews(productModel: productModel),

                          ///Product Questions
                          productQuestions(),

                          // if (Get.arguments != null &&
                          //     Get.arguments["calledFor"] != null &&
                          //     Get.arguments["calledFor"]!.contains("customer"))
                          //   _buildCustomerAlsoViewed(
                          //       controller.subCategoryProductList),
                        ],
                      ),
                    ),
                    Get.arguments[0]["calledFor"] == 'seller'
                        ? Container()
                        : _outOfStockBottom(),
                    LoaderView(),
                  ],
                ),
              )));
  }

  AppBar _appBar() {
    return AppBar(
        actions: Get.arguments[0]["calledFor"] == 'customer'
            ? [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: CartIcon(
                      onTap: () {
                        Get.offNamed(Routes.cartRoute,
                            arguments: {"calledFromSPV": true},
                            preventDuplicates: false);
                      },
                      iconWidget: Icon(
                        IconlyLight.buy,
                        size: 25,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ]
            : null,
        backgroundColor: kAppBarColor,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 21,
            color: kPrimaryColor,
          ),
        ),
        title: CustomText(
          title: langKey.productDetails.tr,
          style: appBarTitleSize.copyWith(fontSize: 18),
        ));
  }

  // SliverAppBar _sliverAppBar(ProductModel productModel) {
  //   return SliverAppBar(
  //     backgroundColor: kAppBarColor,
  //     automaticallyImplyLeading: true,
  //     leadingWidth: 30,
  //     floating: true,
  //     pinned: true,
  //     centerTitle: true,
  //     leading: InkWell(
  //       onTap: () => Get.back(),
  //       child: Icon(
  //         Icons.arrow_back_ios_new,
  //         size: 18,
  //         color: kPrimaryColor,
  //       ),
  //     ),
  //     title: Get.arguments != null &&
  //         Get.arguments["calledFor"] != null &&
  //         Get.arguments["calledFor"]!.contains("seller")
  //         ? CustomText(
  //       title: "Product Details",
  //       style: appBarTitleSize,
  //     )
  //         : Column(
  //       children: [
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Expanded(
  //                 flex: 5,
  //                 child: CustomSearchBar(
  //                   searchText: productModel.name,
  //                   calledFromSPV: true,
  //                 )),
  //             AppConstant.spaceWidget(width: 10),
  //             CartIcon(
  //               onTap: () {
  //                 //called from SingleProductView (SPV)
  //                 Get.offNamed(Routes.cartRoute,
  //                     arguments: {"calledFromSPV": true},
  //                     preventDuplicates: false);
  //               },
  //               iconWidget: Icon(
  //                 IconlyLight.buy,
  //                 size: 25,
  //                 color: kPrimaryColor,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Stack _productImages() {
    viewModel.productModel.value.images!.forEach((element) {
      if (element.url == viewModel.productModel.value.thumbnail) {
        var elementData = element;
        viewModel.productModel.value.images!.remove(element);
        viewModel.productModel.value.images!.insert(0, elementData);
      }
    });
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(Get.context!).size.height * 0.45,
          child: PageView.builder(
            controller: viewModel.pageController,
            onPageChanged: viewModel.changePage,
            itemCount: viewModel.productModel.value.images!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  viewModel.moveToProductImageView(index);
                },
                child: CustomNetworkImage(
                  imageUrl: viewModel.productModel.value.images![index].url,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(Get.context!).size.width,
                  height: MediaQuery.of(Get.context!).size.height * 0.6,
                ),
              );
            },
          ),
        ),
        Obx(
          () => Positioned(
            bottom: 16.0,
            left: 0.0,
            right: 0.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: animatedContainer()),
          ),
        ),
      ],
    );
  }

  Card _productBasicDetails() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: CustomText(
                    title: viewModel.productModel.value.name,
                    maxLines: 3,
                    style: headline3,
                  ),
                ),
                AppConstant.spaceWidget(width: 5),
                Expanded(
                  flex: 2,
                  child: CustomText(
                      title: viewModel.productModel.value.stock == 0
                          ? 'Out Of Stock'
                          : "Stock: ${viewModel.productModel.value.stock}",
                      color: viewModel.productModel.value.stock == 0
                          ? kRedColor
                          : kPrimaryColor,
                      weight: viewModel.productModel.value.stock == 0
                          ? FontWeight.bold
                          : FontWeight.w600),
                ),
              ],
            ),

            ///Price section
            productPriceAndDiscount(),

            ///Categories
            showProductCategories(),

            ///Reviews
            //showProductReviews(),

            ///Store details
            showStoreDetails()
          ],
        ),
      ),
    );
  }

  Padding productPriceAndDiscount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          CustomPriceWidget(
            title: '${viewModel.productModel.value.discountPrice}',
            style: headline2,
          ),
          AppConstant.spaceWidget(width: 10),
          if (viewModel.productModel.value.discount! > 0)
            CustomPriceWidget(
              title: '${viewModel.productModel.value.price}',
              style: headline2.copyWith(
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.w600),
            ),
          AppConstant.spaceWidget(width: 5),
          if (viewModel.productModel.value.discount! > 0)
            CustomText(
                title: "${viewModel.productModel.value.discount}% OFF",
                style: bodyText1.copyWith(
                    fontWeight: FontWeight.w600, color: Colors.redAccent))
        ],
      ),
    );
  }

  Padding showStoreDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () {
          Get.toNamed(
              '/storeDetails/${viewModel.productModel.value.sellerModel!.id}');
        },
        //dense: true,
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: kLightGreyColor.withOpacity(0.15), shape: BoxShape.circle),
          child: Icon(
            Icons.storefront_rounded,
            size: 25,
            color: kPrimaryColor,
          ),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "Sold by ",
                  style: bodyText1.copyWith(color: kLightGreyColor)),
              TextSpan(
                  text:
                      "${viewModel.productModel.value.sellerModel!.storeName ?? viewModel.productModel.value.sellerModel!.user!.firstName ?? viewModel.productModel.value.sellerModel!.user!.name ?? ""}",
                  style: headline3),
            ],
          ),
        ),
        // subtitle: Row(
        //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     const Icon(Icons.star_rounded, color: Colors.amber),
        //     CustomText(
        //       title:
        //           "${productModel.sellerModel!.rating!.toStringAsFixed(1)}",
        //       style: bodyText1,
        //     ),
        //     AppConstant.spaceWidget(width: 10),
        //     CustomText(
        //       title: "${_getPositiveResponse()}",
        //       style: bodyText2,
        //     )
        //   ],
        // ),
        trailing: const Icon(
          Icons.arrow_forward_ios_sharp,
          color: kPrimaryColor,
          size: 13,
        ),
      ),
    );
  }

  Row showProductReviews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.star_rounded, color: Colors.amber),
        AppConstant.spaceWidget(width: 5),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Obx(
                () => CustomText(
                  title:
                      "${viewModel.getRating()} (${viewModel.reviewResponse.value.count})",
                  style: bodyText1,
                ),
              ),
              //5(44)
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 12,
              ),
              AppConstant.spaceWidget(width: 5),
              CustomText(
                title: "${viewModel.productModel.value.sold} Sold",
                style: bodyText1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding showProductCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Wrap(
        children: [
          CustomText(title: "Category: ", style: bodyText2),
          CustomText(
            title: "\t${viewModel.productModel.value.category!.name}",
            style: bodyText1,
            maxLines: 2,
          ),
          AppConstant.spaceWidget(width: 3),
          const Icon(
            Icons.arrow_forward_ios_sharp,
            color: kPrimaryColor,
            size: 12,
          ),
          AppConstant.spaceWidget(width: 3),
          CustomText(
              title: "${viewModel.productModel.value.subCategory!.name}",
              style: bodyText1),
        ],
      ),
    );
  }

  Card _productVariantsDetails() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(title: langKey.productVariant.tr, style: headline2),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: viewModel.productModel.value.productFeatures?.length,
              itemBuilder: (_, index) {
                String? key = viewModel
                    .productModel.value.productFeatures?.entries
                    .elementAt(index)
                    .key;
                return _productVariantWidget(title: key);
              },
            ),
          ],
        ),
      ),
    );
  }

  Column _productVariantWidget({title, bool? isNextBtnClicked = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomText(
          title: title,
          size: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: AppResponsiveness.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: viewModel.productModel.value.productFeatures![title]!
                  .map((e) => isNextBtnClicked!
                      ? _buildChip(featureModel: e)
                      : _singleVariantsListItems(feature: e))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Padding _singleVariantsListItems({ProductFeature? feature}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomGreyBorderContainer(
        //width: feature!.value!.length.toDouble(),
        height: 20,
        bgColor: kPrimaryColor,
        borderColor: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Center(
            child: CustomText(
              title: feature?.value,
              maxLines: 1,
              size: 11,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChip({ProductFeature? featureModel}) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChoiceChip(
          label: CustomText(
              title: featureModel!.value!,
              style: bodyText1.copyWith(color: Colors.white)),
          selected: viewModel.selectedFeatureIDsList.contains(featureModel.id),
          selectedColor: kPrimaryColor,
          onSelected: (isSelected) {
            if (isSelected) {
              viewModel.selectedFeatureIDsList.add(featureModel.id!);
              viewModel.selectedFeatureNamesList.add(featureModel.value!);
            } else {
              viewModel.selectedFeatureIDsList.remove(featureModel.id);
              viewModel.selectedFeatureNamesList.remove(featureModel.value!);
            }
          },
        ),
      ),
    );
  }

  Card _productAdvanceDetails() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title: langKey.description.tr, style: headline2),
                RichText(
                  text: TextSpan(
                    children: [
                      if (viewModel.productModel.value.brand!.isNotEmpty)
                        TextSpan(
                            text:
                                "Brand: ${viewModel.productModel.value.brand},",
                            style: bodyText2),
                      TextSpan(
                          text: "Sku: ${viewModel.productModel.value.sku}",
                          style: bodyText2)
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: viewModel.productModel.value.description,
                    maxLines: viewModel.productModel.value.description!.length,
                    style: bodyText2Poppins,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _productReviews({ProductModel? productModel}) {
  //   double prodRating = controller.reviewResponse!.rating != null
  //       ? controller.reviewResponse!.rating!.toDouble()
  //       : 0.0;
  //   return CustomCard(
  //     margin: const EdgeInsets.symmetric(
  //       horizontal: 8.0,
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           CustomText(title: "Product Reviews", style: headline2),
  //           ListTile(
  //             dense: false,
  //             leading: CustomText(
  //                 title: getRating(controller.reviewResponse!), size: 22),
  //             title: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 RatingBar.builder(
  //                   itemSize: 20,
  //                   ignoreGestures: true,
  //                   initialRating: prodRating,
  //                   //minRating: 1,
  //                   direction: Axis.horizontal,
  //                   allowHalfRating: true,
  //                   itemCount: 5,
  //                   itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
  //                   itemBuilder: (context, _) => Icon(
  //                     Icons.star_rounded,
  //                     color: Colors.amber,
  //                   ),
  //                   onRatingUpdate: (rating) {
  //                     print(rating);
  //                   },
  //                 ),
  //                 CustomText(
  //                   title:
  //                       "Based on ${controller.reviewResponse!.count ?? 0} ratings",
  //                   style: caption,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           kSmallDivider,
  //           Obx(
  //             () => controller.reviewResponse!.reviewsList == null ||
  //                     controller.reviewResponse!.reviewsList!.isEmpty
  //                 ? NoDataFound(text: "No reviews found")
  //                 : Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: controller.reviewResponse!.reviewsList!
  //                         .map((e) => _singleReviewListItem(review: e))
  //                         .toList(),
  //                   ),
  //           ),

  //           /* ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: controller.reviewResponse!.reviewsList!.length,
  //             itemBuilder: (_, index) {
  //               ReviewModel? reviewModel =
  //                   controller.reviewResponse!.reviewsList![index];
  //               return _singleReviewListItem(review: reviewModel);
  //             },
  //           ),*/
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _singleReviewListItem({ReviewModel? review}) {
  //   return Padding(
  //     padding: const EdgeInsets.all(5.0),
  //     child: Container(
  //       //height: AppResponsiveness.getHeight70_80(),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           CustomText(
  //               title:
  //                   "${review!.user!.firstName} ${review.user!.lastName!.isNotEmpty ? review.user!.lastName!.substring(0, 1).capitalizeFirst : ''}."),
  //           RatingBar.builder(
  //             itemSize: 13,
  //             ignoreGestures: true,
  //             initialRating: review.rating!.toDouble(),
  //             //minRating: 1,
  //             direction: Axis.horizontal,
  //             allowHalfRating: true,
  //             itemCount: 5,
  //             itemBuilder: (context, _) => Icon(
  //               Icons.star_rounded,
  //               color: Colors.amber,
  //             ),
  //             onRatingUpdate: (rating) {
  //               print(rating);
  //             },
  //           ),
  //           CustomText(
  //             title: "${review.text}",
  //             size: 12,
  //             maxLines: review.text!.length,
  //             color: kLightColor,
  //           ),
  //           kSmallDivider,
  //           /*AppConstant.spaceWidget(height: 5),
  //           Container(
  //             height: 1,
  //             decoration: BoxDecoration(color: kLightGreyColor),
  //           ),
  //           AppConstant.spaceWidget(height: 5),*/
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // String _getPositiveResponse() {
  //   int min = 70;
  //   int max = 100;
  //
  //   var rnd = new Random();
  //   int r = min + rnd.nextInt(max - min);
  //
  //   return " $r% Positive Response  ";
  // }

  /*List<String> _getServices() {
    return <String>[
      "• Free shipping apply to all orders over shipping \$100",
      "• Guaranteed 100% organic from natural products",
      "• 7 Days returns money back guarantee",
      "• 14 days easy Return",
      "• Cash on Delivery Available",
      "• Warranty not available"
    ];
  }*/

  void showVariationBottomSheet() {
    AppConstant.showBottomSheet(
      widget: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: [
          productPriceAndThumbnail(),
          AppConstant.spaceWidget(height: 10),
          if (viewModel.productModel.value.productFeatures!.isNotEmpty)
            productFeaturesList(),
          kSmallDivider,
          _buildQtyChosen(),
          kSmallDivider,
          _buildBuyNowAndCartBtn(),
          AppConstant.spaceWidget(height: 20),
        ],
      ),
    );
  }

  ListTile productPriceAndThumbnail() {
    return ListTile(
      leading: CustomNetworkImage(
          imageUrl: viewModel.productModel.value.thumbnail ??
              AppConstant.defaultImgUrl,
          height: 60),
      title: CustomText(title: viewModel.productModel.value.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomPriceWidget(
              title: "${viewModel.productModel.value.discountPrice}"),
          if (viewModel.productModel.value.discount! > 0)
            Row(
              children: [
                CustomPriceWidget(
                    title: "${viewModel.productModel.value.price}",
                    style: bodyText1.copyWith(
                        decoration: TextDecoration.lineThrough)),
                AppConstant.spaceWidget(width: 5),
                CustomText(
                    title:
                        "${viewModel.productModel.value.discount}% ${langKey.OFF.tr}",
                    style: bodyText2.copyWith(color: Colors.redAccent))
              ],
            ),
        ],
      ),
    );
  }

  Column productFeaturesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title: langKey.productVariant.tr, style: headline2),
        AppConstant.spaceWidget(height: 5),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viewModel.productModel.value.productFeatures?.length,
          itemBuilder: (_, index) {
            String? key = viewModel.productModel.value.productFeatures?.keys
                .elementAt(index);
            return _productVariantWidget(title: key, isNextBtnClicked: false);
          },
        ),
      ],
    );
  }

  productQuestions() {
    return Obx(
      () => CustomCard(
        margin: const EdgeInsets.fromLTRB(8, 5, 8, 50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: langKey.productQuestions.tr,
                style: headline2,
              ),
              questionListView(),

              ///if vendor, then don't show the ask question button

              if (Get.arguments[0]["calledFor"] != 'customer')
                SizedBox()
              else
                InkWell(
                  onTap: () {
                    Get.to(() => ProductQuestionsView(), arguments: [
                      {
                        "productId": "${viewModel.productID.value}",
                        "productModel": viewModel.productModel.value
                      }
                    ]);
                  },
                  child: CustomGreyBorderContainer(
                    width: double.infinity,
                    height: 30,
                    borderColor: kWhiteColor,
                    child: Center(
                        child: CustomText(
                      title: langKey.askQuestion.tr,
                      color: kRedColor,
                    )),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  questionListView() {
    return viewModel.productQuestions.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoDataFound(text: langKey.noQuestionFound.tr),
          )
        : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.productQuestions.length,
            itemBuilder: (BuildContext context, int index) {
              return questionListViewItem(index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return kSmallDivider;
            },
          );
  }

  Padding questionListViewItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionAnswerItem(
              isQuestion: true,
              title: viewModel.productQuestions[index].question,
              name: viewModel.productQuestions[index].user!.firstName!,
              date: viewModel.productQuestions[index].createdAt,
              index: index),
          if (viewModel.productQuestions[index].answer != null)
            questionAnswerItem(
                title: viewModel.productQuestions[index].answer!.answer,
                name: viewModel.productModel.value.sellerModel!.storeName ??
                    viewModel.productModel.value.sellerModel!.user!.firstName,
                date: viewModel.productQuestions[index].answer!.createdAt,
                index: index),
        ],
      ),
    );
  }

  Padding questionAnswerItem(
      {bool isQuestion = false,
      String? title,
      name,
      date,
      required int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isQuestion
                  ? kRedColor.withOpacity(0.7)
                  : kLightColor.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomText(
                title: isQuestion ? 'Q' : 'A',
                color: kWhiteColor,
              ),
            ),
          ),
          AppConstant.spaceWidget(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  maxLines: title!.length,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: name,
                        style: caption.copyWith(
                          color: kLightColor,
                        ),
                      ),
                      TextSpan(
                        text:
                            " - ${AppConstant.formattedDataTime("dd-MMM-yy", date)}",
                        style: caption.copyWith(
                          color: kLightColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCustomerAlsoViewed(List<ProductModel> list) {
  //   return Obx(
  //     () => list.isEmpty
  //         ? Container()
  //         : Card(
  //             margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: SizedBox(
  //                 height: AppResponsiveness.getBoxHeightPoint30(),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     CustomText(
  //                       title: langKey.peopleAlsoViewed.tr,
  //                       size: 18,
  //                       weight: FontWeight.w600,
  //                     ),
  //                     AppConstant.spaceWidget(height: 10),
  //                     Expanded(
  //                       child: ListView.builder(
  //                         scrollDirection: Axis.horizontal,
  //                         itemCount: list.length,
  //                         itemBuilder: (context, index) {
  //                           ProductModel productModel = list[index];
  //                           return SingleProductItems(
  //                             productModel: productModel,
  //                             onTap: () {
  //                               Get.offNamed('/product/${productModel.id}',
  //                                   preventDuplicates: false,
  //                                   arguments: {"calledFor": "customer"});
  //                             },
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //   );
  // }

  Row _buildQtyChosen() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StickyLabel(text: langKey.quantity.tr),
        ProductQuantityCounter(
          onDecrementPress: () => viewModel.decrement(),
          onIncrementPress: () => viewModel.increment(),
          textEditingController: viewModel.quantityController,
          bgColor: kPrimaryColor,
          textColor: kWhiteColor,
        ),
      ],
    );
  }

  Row _buildBuyNowAndCartBtn() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomTextBtn(
          onPressed: () async {
            await viewModel.addItemLocalCart();
            CartViewModel cartModel = Get.find();
            cartModel.fetchCartItemsFromLocal();
          },
          title: langKey.addToCart.tr,
          width: 320,
          height: 40,
        ),
        /* CustomButton(
          onTap: () async {
            await LocalStorageHelper.clearAllCart();
            //controller.addItemToCart(product: productModel);
            //Get.back();
          },
          text: "Clear Cart",
          width: 120,
          height: 40,
        ),*/
      ],
    );
  }

  List<Widget> animatedContainer() {
    return List.generate(
      viewModel.productModel.value.images!.length,
      (index) => AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: 6.0,
        width: /*controller.sliderIndex.value == index ? 14.0 :*/ 6.0,
        margin: const EdgeInsets.only(right: 4.0),
        decoration: BoxDecoration(
          color:
              viewModel.pageIndex.value == index ? kPrimaryColor : kLightColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  Container _footerBottomBar() {
    return Container(
      height: 55,
      color: Colors.white,
      width: AppResponsiveness.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //_getNavBarItems(icon: Icons.store,),
          ProductQuantityCounter(
            onDecrementPress: () => viewModel.decrement(),
            onIncrementPress: () => viewModel.increment(),
            textEditingController: viewModel.quantityController,
            bgColor: kPrimaryColor,
            textColor: kWhiteColor,
          ),
          CustomTextBtn(
            onPressed: () => showVariationBottomSheet(),
            title: langKey.next.tr,
            width: 100,
            height: 40,
          ),
          //_buildBuyNowAndCartBtn(),
        ],
      ),
    );
  }

  Positioned _outOfStockBottom() {
    return Positioned(
        bottom: 0,
        child: viewModel.productModel.value.stock == 0
            ? IgnorePointer(
                child: BottomAppBar(
                  elevation: 0,
                  height: 48,
                  child: Container(
                    width: AppResponsiveness.width,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        //borderRadius: BorderRadius.all(Radius.circular(12)),
                        border:
                            Border.all(width: 0, color: Colors.grey.shade300)),
                    child: Center(
                      child: CustomText(
                        title: langKey.outOfStock.tr,
                        textAlign: TextAlign.center,
                        size: 18,
                        color: kRedColor,
                      ),
                    ),
                  ),
                ),
              )
            : _footerBottomBar());
  }
}

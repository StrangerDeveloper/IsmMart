import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/exports_ui.dart';
import 'package:ism_mart/screens/product_questions/product_questions_view.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

import '../single_product_full_image/single_product_full_image_view.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({this.productId, this.calledFor = 'customer'});

  final productId;
  final String calledFor;

  @override
  Widget build(BuildContext context) {
    print(controller.imageIndex);
    if (productId == null) {
      return Scaffold(body: Center(child: CustomLoading()));
    } else if (productId != null) {
      controller.fetchProduct(int.parse(productId));
    } else
      controller.fetchProduct(int.parse(Get.parameters['id'] ?? productId));

    /*if (Get.parameters['id'] == null) {
      return const Center(child: CircularProgressIndicator());
    }

    controller.fetchProduct(int.parse(Get.parameters['id']!));*/

    /*if (Get.arguments['id'] == null) {
      return const Center(child: CircularProgressIndicator());
    }

    controller.fetchProduct(int.parse(Get.arguments['id']!));*/
    final isDarkMode = Get.isDarkMode;

    return controller.obx((state) {
      if (state == null) {
        return CustomLoading(isDarkMode: isDarkMode);
      }
      return _build(productModel: state);
    },
        onLoading: CustomLoading(isDarkMode: isDarkMode),
        onError: (error) => NoDataFoundWithIcon(
              title: "No Product Found",
              subTitle: error,
            ),
        onEmpty: NoDataFoundWithIcon(
          title: "No Product Found",
        ));
  }

  Widget _build({ProductModel? productModel}) {
    return WillPopScope(
      onWillPop: () => controller.popSingleProductView(),
      child: Scaffold(
          appBar: AppBar(
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: CartIcon(
                        onTap: () {
                          //called from SingleProductView (SPV)
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
                  ],
                ),
              ],
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
                title: "Product Details",
                style: appBarTitleSize.copyWith(fontSize: 18),
              )),
          backgroundColor: Colors.grey[300]!,
          resizeToAvoidBottomInset: true,
          body: Stack(
            fit: StackFit.expand,
            children: [
              CustomScrollView(
                slivers: [
                  // _sliverAppBar(productModel!),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        productModel!.images!.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  var imagesList = <ProductImages>[];
                                  imagesList.add(ProductImages(
                                      id: 0, url: productModel.thumbnail));
                                  Get.to(() => SingleProductFullImageView(
                                        productImages: imagesList,
                                        initialImage: 0,
                                      ));
                                },
                                child: CustomNetworkImage(
                                  imageUrl: productModel.thumbnail,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(Get.context!).size.width,
                                  height:
                                      MediaQuery.of(Get.context!).size.height *
                                          0.4,
                                ),
                              )
                            : _productImages(imagesList: productModel.images!),

                        /// product name, price etc.
                        _productBasicDetails(productModel: productModel),

                        /// Product features
                        if (productModel.productFeatures!.isNotEmpty)
                          _productVariantsDetails(productModel: productModel),

                        //_vendorStoreDetails(productModel: productModel),

                        ///product description
                        _productAdvanceDetails(productModel: productModel),

                        ///product reviews
                        // _productReviews(productModel: productModel),

                        ///Product Questions
                        productQuestions(productModel: productModel),

                        if (Get.arguments != null &&
                            Get.arguments["calledFor"] != null &&
                            Get.arguments["calledFor"]!.contains("customer"))
                          _buildCustomerAlsoViewed(
                              controller.subCategoryProductList),

                        // AppConstant.spaceWidget(height: 70),
                        //Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              // if(Get.arguments != null &&
              //     Get.arguments["calledFor"] != null &&
              //     Get.arguments["calledFor"]!.contains("customer"))
              calledFor == 'seller'
                  ? Container()
                  : _outOfStockBottom(productModel),
              LoaderView(),
            ],
          )),
    );

    // bottomNavigationBar: Get.arguments != null &&
    //         Get.arguments["calledFor"] != null &&
    //         Get.arguments["calledFor"]!.contains("seller")
    //     ? null
    //     : _footerBottomBar(productModel.stock));
    //   bottomNavigationBar: Get.arguments != null &&
    //           Get.arguments["calledFor"] != null &&
    //           Get.arguments["calledFor"]!.contains("seller")
    //       ? null
    //       :
    // )
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
  //             Get.arguments["calledFor"] != null &&
  //             Get.arguments["calledFor"]!.contains("seller")
  //         ? CustomText(
  //             title: "Product Details",
  //             style: appBarTitleSize,
  //           )
  //         : Column(
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Expanded(
  //                       flex: 5,
  //                       child: CustomSearchBar(
  //                         searchText: productModel.name,
  //                         calledFromSPV: true,
  //                       )),
  //                   AppConstant.spaceWidget(width: 10),
  //                   CartIcon(
  //                     onTap: () {
  //                       //called from SingleProductView (SPV)
  //                       Get.offNamed(Routes.cartRoute,
  //                           arguments: {"calledFromSPV": true},
  //                           preventDuplicates: false);
  //                     },
  //                     iconWidget: Icon(
  //                       IconlyLight.buy,
  //                       size: 25,
  //                       color: kPrimaryColor,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //   );
  // }

  _productImages({List<ProductImages>? imagesList}) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(Get.context!).size.height * 0.45,
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.changePage,
            itemCount: imagesList!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.imageIndex(index);
                  Get.to(() => SingleProductFullImageView(
                        productImages: imagesList,
                        initialImage: index,
                      ));
                },
                child: CustomNetworkImage(
                  imageUrl: imagesList[index].url,
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
              children: List.generate(
                imagesList.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 6.0,
                  width: /*controller.sliderIndex.value == index ? 14.0 :*/ 6.0,
                  margin: const EdgeInsets.only(right: 4.0),
                  decoration: BoxDecoration(
                    color: controller.pageIndex.value == index
                        ? kPrimaryColor
                        : kLightColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _productBasicDetails({ProductModel? productModel}) {
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
                    title: productModel!.name,
                    maxLines: 3,
                    style: headline3,
                  ),
                ),
                AppConstant.spaceWidget(width: 5),
                Expanded(
                  flex: 2,
                  child: CustomText(
                      title: productModel.stock == 0
                          ? 'Out Of Stock'
                          : "Stock: ${productModel.stock}",
                      color:
                          productModel.stock == 0 ? kRedColor : kPrimaryColor,
                      weight: productModel.stock == 0
                          ? FontWeight.bold
                          : FontWeight.w600),
                ),
              ],
            ),
            AppConstant.spaceWidget(height: 10),
            //Price section
            Row(
              children: [
                CustomPriceWidget(
                  title: '${productModel.discountPrice}',
                  style: headline2,
                ),
                AppConstant.spaceWidget(width: 10),
                if (productModel.discount! > 0)
                  CustomPriceWidget(
                    title: '${productModel.price}',
                    style: headline2.copyWith(
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w600),
                  ),
                AppConstant.spaceWidget(width: 5),
                if (productModel.discount! > 0)
                  CustomText(
                      title: "${productModel.discount}% OFF",
                      style: bodyText1.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.redAccent))
              ],
            ),
            AppConstant.spaceWidget(height: 8),

            //Categories
            Wrap(
              children: [
                CustomText(title: "Category: ", style: bodyText2),
                CustomText(
                  title: "\t${productModel.category!.name}",
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
                    title: "${productModel.subCategory!.name}",
                    style: bodyText1),
              ],
            ),
            AppConstant.spaceWidget(height: 8),
            // reviews
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Icon(Icons.star_rounded, color: Colors.amber),
            //     AppConstant.spaceWidget(width: 5),
            //     Expanded(
            //       flex: 2,
            //       child: Row(
            //         children: [
            //           Obx(
            //             () => CustomText(
            //               title:
            //                   "${getRating(controller.reviewResponse)} (${controller.reviewResponse!.count})",
            //               style: bodyText1,
            //             ),
            //           ),
            //           //5(44)
            //           const Icon(
            //             Icons.arrow_forward_ios_sharp,
            //             color: kPrimaryColor,
            //             size: 12,
            //           ),
            //           AppConstant.spaceWidget(width: 5),
            //           CustomText(
            //             title: "${productModel.sold} Sold",
            //             style: bodyText1,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),

            AppConstant.spaceWidget(height: 8),

            ///Store details
            ListTile(
              onTap: () {
                Get.toNamed('/storeDetails/${productModel.sellerModel!.id}');
              },
              //dense: true,
              leading: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: kLightGreyColor.withOpacity(0.15),
                    shape: BoxShape.circle),
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
                            "${productModel.sellerModel!.storeName ?? productModel.sellerModel!.user!.firstName ?? productModel.sellerModel!.user!.name ?? ""}",
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
            )
          ],
        ),
      ),
    );
  }

  _productVariantsDetails({ProductModel? productModel}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(title: "Product Variants", style: headline2),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: productModel?.productFeatures?.length,
              itemBuilder: (_, index) {
                String? key =
                    productModel!.productFeatures?.keys.elementAt(index);
                return _productVariantWidget(
                    title: key,
                    featureList: productModel.productFeatures?[key]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _productVariantWidget(
      {title,
      List<ProductFeature>? featureList,
      bool? isNextBtnClicked = false}) {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: featureList!
                .map((e) => isNextBtnClicked!
                    ? _buildChip(featureModel: e)
                    : _singleVariantsListItems(feature: e))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _singleVariantsListItems({ProductFeature? feature}) {
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

  _productAdvanceDetails({ProductModel? productModel}) {
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
                      if (productModel!.brand!.isNotEmpty)
                        TextSpan(
                            text: "Brand: ${productModel.brand},",
                            style: bodyText2),
                      TextSpan(
                          text: "Sku: ${productModel.sku}", style: bodyText2)
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
                    title: productModel.description,
                    maxLines: productModel.description!.length,
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

  String getRating(ReviewModelResponse? reviewModel) {
    return reviewModel!.rating != null
        ? reviewModel.rating!.toStringAsFixed(1)
        : "0.0";
  }

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

  productQuestions({ProductModel? productModel}) {
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
              questionListView(productModel: productModel),
              //if vender, then don't show the ask question button

              if (calledFor != 'customer')
                SizedBox()
              else
                InkWell(
                  onTap: () {
                    print('Called');
                    Navigator.push(
                        Get.context!,
                        MaterialPageRoute(
                            builder: (context) => ProductQuestionsView(
                                  id: "$productId",
                                )));
                    // Get.to(() => ProductQuestionAnswerUI(
                    //       productModel: productModel,
                    //     ));
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
              // InkWell(
              //   onTap: () {
              //     print('Called');
              //     Navigator.push(Get.context!, MaterialPageRoute(builder: (context)=>ProductQuestionsView(id: "$productId",)));
              //     // Get.to(() => ProductQuestionAnswerUI(
              //     //       productModel: productModel,
              //     //     ));
              //   },
              //   child: CustomGreyBorderContainer(
              //     width: double.infinity,
              //     height: 30,
              //     borderColor: kWhiteColor,
              //     child: Center(
              //         child: CustomText(
              //       title: langKey.askQuestion.tr,
              //       color: kRedColor,
              //     )),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget questionListView({ProductModel? productModel}) {
    return controller.productQuestionsList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: NoDataFound(text: langKey.noQuestionFound.tr),
          )
        : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.productQuestionsList.length,
            itemBuilder: (BuildContext context, int index) {
              return questionListViewItem(productModel: productModel, index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return kSmallDivider;
            },
          );
  }

  Widget questionListViewItem(int index, {ProductModel? productModel}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          questionAnswerItem(
              isQuestion: true,
              title: controller.productQuestionsList[index].question,
              name: controller.productQuestionsList[index].user!.firstName!,
              date: controller.productQuestionsList[index].createdAt,
              index: index),
          if (controller.productQuestionsList[index].answer != null)
            questionAnswerItem(
                title: controller.productQuestionsList[index].answer!.answer,
                name: productModel!.sellerModel!.storeName ??
                    productModel.sellerModel!.user!.firstName,
                date: controller.productQuestionsList[index].answer!.createdAt,
                index: index),
        ],
      ),
    );
  }

  Widget questionAnswerItem(
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

  Widget _buildCustomerAlsoViewed(List<ProductModel> list) {
    return Obx(
      () => list.isEmpty
          ? Container()
          : controller.isLoading.isTrue
              ? CustomLoading(isItForWidget: true)
              : Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: AppResponsiveness.getBoxHeightPoint30(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            title: langKey.peopleAlsoViewed.tr,
                            size: 18,
                            weight: FontWeight.w600,
                          ),
                          AppConstant.spaceWidget(height: 10),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                ProductModel productModel = list[index];
                                return SingleProductItems(
                                  productModel: productModel,
                                  onTap: () {
                                    Get.offNamed('/product/${productModel.id}',
                                        preventDuplicates: false,
                                        arguments: {"calledFor": "customer"});
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

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

  void showVariationBottomSheet({ProductModel? productModel}) {
    AppConstant.showBottomSheet(
      widget: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            leading: CustomNetworkImage(
                imageUrl: productModel!.thumbnail ?? AppConstant.defaultImgUrl,
                height: 60),
            title: CustomText(title: productModel.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomPriceWidget(title: "${productModel.discountPrice}"),
                if (productModel.discount! > 0)
                  Row(
                    children: [
                      CustomPriceWidget(
                          title: "${productModel.price}",
                          style: bodyText1.copyWith(
                              decoration: TextDecoration.lineThrough)),
                      AppConstant.spaceWidget(width: 5),
                      CustomText(
                          title: "${productModel.discount}% ${langKey.OFF.tr}",
                          style: bodyText2.copyWith(color: Colors.redAccent))
                    ],
                  ),
              ],
            ),
          ),
          AppConstant.spaceWidget(height: 10),

          if (productModel.productFeatures!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title: "Product Variants", style: headline2),
                AppConstant.spaceWidget(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productModel.productFeatures?.length,
                  itemBuilder: (_, index) {
                    String? key =
                        productModel.productFeatures?.keys.elementAt(index);
                    return _productVariantWidget(
                        title: key,
                        isNextBtnClicked: false,
                        featureList: productModel.productFeatures?[key]);
                  },
                ),
              ],
            ),
          //   _productVariantWidget(
          //       title: langKey.color.tr,
          //       featureList: productModel.productFeatures!.colors!,
          //       isNextBtnClicked: true,
          //       isCalledForColors: true),
          // if (productModel.productFeatures!.sizes!.isNotEmpty)
          //   _productVariantWidget(
          //     title: langKey.size.tr,
          //     featureList: productModel.productFeatures!.sizes!,
          //     isNextBtnClicked: true,
          //     isCalledForColors: false,
          //   ),

          /* productModel.productFeatures!.sizes!.isEmpty
              ? Container()
              : Column(
                  children: [
                    const StickyLabel(text: "Product Variants"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: productModel.productFeatures!
                          .map((e) => _buildChip(
                              value: e.value, variantsModel: e.categoryField))
                          .toList(),
                    )
                  ],
                ),*/
          kSmallDivider,
          _buildQtyChosen(),
          kSmallDivider,
          _buildBuyNowAndCartBtn(productModel: productModel),
          AppConstant.spaceWidget(height: 20),
        ],
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
          selected: controller.selectedFeatureIDsList.contains(featureModel.id),
          selectedColor: kPrimaryColor,
          onSelected: (isSelected) {
            if (isSelected) {
              controller.selectedFeatureIDsList.add(featureModel.id!);
              controller.selectedFeatureNamesList.add(featureModel.value!);
            } else {
              controller.selectedFeatureIDsList.remove(featureModel.id);
              controller.selectedFeatureNamesList.remove(featureModel.value!);
            }
          },
        ),
      ),
    );
  }

  Widget _buildQtyChosen() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StickyLabel(text: langKey.quantity.tr),
        ProductQuantityCounter(
          onDecrementPress: () => controller.decrement(),
          onIncrementPress: () => controller.increment(),
          textEditingController: controller.quantityController,
          bgColor: kPrimaryColor,
          textColor: kWhiteColor,
        ),
      ],
    );
  }

  Widget _buildBuyNowAndCartBtn({ProductModel? productModel}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomTextBtn(
          onPressed: () async {
            await controller.addItemLocalCart(product: productModel);
            //controller.addItemToCart(product: productModel);
            //Get.back();
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

  _footerBottomBar() {
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
            onDecrementPress: () => controller.decrement(),
            onIncrementPress: () => controller.increment(),
            textEditingController: controller.quantityController,
            bgColor: kPrimaryColor,
            textColor: kWhiteColor,
          ),
          CustomTextBtn(
            onPressed: () =>
                showVariationBottomSheet(productModel: controller.state),
            title: langKey.next.tr,
            width: 100,
            height: 40,
          ),
          //_buildBuyNowAndCartBtn(),
        ],
      ),
    );
  }

  _outOfStockBottom(ProductModel? productModel) {
    return Positioned(
        bottom: 0,
        child: productModel!.stock == 0
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/exports/export_buyers.dart';
import 'package:ism_mart/screens/product_detail/product_detail_viewmodel.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/controllers.dart';
import '../../helper/constants.dart';
import '../../widgets/custom_price_widget.dart';
import '../../widgets/custom_text.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});

  final controllerTwo =
      Get.create<ProductDetailViewModel>(() => ProductDetailViewModel());
  final ProductDetailViewModel viewModel = Get.put(ProductDetailViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  leadingWidth: 50,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: roundButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  actions: [
                    // roundButton(
                    //   icon: Icons.share_outlined,
                    //   onTap: () {},
                    // ),
                    viewModel.isBuyer
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10, right: 15),
                            child: roundButton(
                              showBadge: true,
                              icon: Icons.shopping_cart_outlined,
                              onTap: () {
                                Get.off(() => CartView());
                              },
                            ),
                          )
                        : SizedBox(),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        carousel(),
                        //heart(),
                      ],
                    ),
                  ),
                  expandedHeight: Get.height * 0.43,
                  pinned: false,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        discountPercentageTag(),
                        headingAndCounter(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Obx(
                            () => Text(
                              viewModel.productModel.value.sku ?? 'N/A',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xff929AAB),
                              ),
                            ),
                          ),
                        ),
                        reviewsAndStockStatus(),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 26, bottom: 18),
                        //   child: Row(
                        //     children: [
                        //       sizeList(),
                        //       SizedBox(width: 20),
                        //       colorList(),
                        //     ],
                        //   ),
                        // ),
                        //customDivider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 12),
                          child: heading('Description'),
                        ),
                        Obx(
                          () => Text(
                            viewModel.productModel.value.description ?? 'N/A',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.7,
                              color: Color(0xff24282D),
                            ),
                          ),
                        ),
                        customDivider(),
                        sellerStore(),
                        customDivider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            LoaderView(),
          ],
        ),
        bottomNavigationBar: priceAndCartBtn(),
      ),
    );
  }

  Widget carousel() {
    return Obx(
      () => (viewModel.imageList.isNotEmpty)
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Obx(
                  () => PageView(
                    onPageChanged: (index) {
                      viewModel.indicatorIndex.value = index;
                    },
                    children: List.generate(
                      viewModel.imageList.length,
                      (index) => InkWell(
                        onTap: () {
                          viewModel.moveToProductImageView(index);
                        },
                        child: mainImage(viewModel.imageList[index] ?? ''),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: AnimatedSmoothIndicator(
                    activeIndex: viewModel.indicatorIndex.value,
                    count: viewModel.imageList.length,
                    effect: CustomizableEffect(
                      spacing: 12,
                      dotDecoration: DotDecoration(
                        borderRadius: BorderRadius.circular(30),
                        width: 6,
                        height: 6,
                      ),
                      activeDotDecoration: DotDecoration(
                        borderRadius: BorderRadius.circular(30),
                        dotBorder: DotBorder(
                          padding: 3.2,
                          color: Colors.white,
                        ),
                        width: 6,
                        height: 6,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Image(
              width: double.infinity,
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/no_image_found.jpg',
              ),
            ),
    );
  }

  Widget mainImage(String url) {
    return CachedNetworkImage(
      width: double.infinity,
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/no_image_found.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: CircularProgressIndicator(strokeWidth: 0.5),
        );
      },
    );
  }

  Widget roundButton({
    required void Function()? onTap,
    required IconData icon,
    bool showBadge = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 30,
            width: 30,
            //padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: const Offset(0, 0),
                  blurRadius: 3,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(child: Icon(icon)),
                ),
                if (showBadge)
                  Obx(
                    () => baseController.cartCount.value == 0
                        ? SizedBox()
                        : Container(
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              color: kOrangeColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Obx(
                              () => CustomText(
                                title: "${baseController.cartCount.value}",
                                size: 8,
                                color: kWhiteColor,
                                maxLines: 1,
                              ),
                            ),
                          ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Positioned(
  // top: 5,
  // right: 20,
  // child: Container(
  // alignment: Alignment.center,
  // height: 14,
  // width: 14,
  // decoration: BoxDecoration(
  // color: kOrangeColor,
  // borderRadius: BorderRadius.circular(15),
  // ),
  // child: CustomText(
  // title: "${baseController.cartCount.value}",
  // size: 10,
  // color: kWhiteColor,
  // maxLines: 1,
  // ),
  // ),
  // ),

  Widget heart() {
    return Positioned(
      bottom: 16,
      right: 20,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(9),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffFE3A30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(0, 0),
                blurRadius: 3,
                spreadRadius: 2,
              )
            ],
          ),
          child: SvgPicture.asset(
            'assets/svg/heart.svg',
            height: 15,
          ),
        ),
      ),
    );
  }

  Widget discountPercentageTag() {
    return Obx(
      () => viewModel.productModel.value.discount != 0
          ? Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffFE3A30),
              ),
              child: Text(
                "${viewModel.productModel.value.discount}% Off",
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget headingAndCounter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Obx(
            () => Text(
              viewModel.productModel.value.name ?? 'N/A',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xff24282D),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        viewModel.isBuyer ? counter() : SizedBox(),
      ],
    );
  }

  Widget counter() {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xffF7F7F7),
        ),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                viewModel.decrement();
              },
              child: Icon(
                Icons.remove,
                size: 20,
                color: viewModel.productQuantity.value == 1
                    ? Color(0xffC4C5C4)
                    : Color(0xff3669C9),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Obx(
                () => Text(
                  viewModel.productQuantity.value.toString(),
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff0C1A30),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                viewModel.increment();
              },
              child: Icon(
                Icons.add,
                size: 20,
                color: Color(0xff3669C9),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewsAndStockStatus() {
    return Row(
      children: [
        // Icon(
        //   Icons.star,
        //   color: Color(0xffFFC120),
        //   size: 15,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 3, right: 10),
        //   child: Obx(
        //     () => Text(
        //       '${viewModel.productModel.value.rating ?? 0}',
        //       style: GoogleFonts.dmSans(
        //         fontWeight: FontWeight.w400,
        //         fontSize: 14,
        //         color: Color(0xff24282D),
        //       ),
        //     ),
        //   ),
        // ),
        // Text(
        //   '86 Reviews',
        //   style: GoogleFonts.dmSans(
        //     fontWeight: FontWeight.w400,
        //     fontSize: 14,
        //     color: Color(0xff24282D),
        //     decoration: TextDecoration.underline,
        //   ),
        // ),
        Spacer(),
        viewModel.isBuyer ? stockAvailabilityStatus() : SizedBox(),
      ],
    );
  }

  Widget stockAvailabilityStatus() {
    return Obx(
      () => viewModel.productModel.value.stock == 0
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffFCECEF),
              ),
              child: Text(
                'Out of Stock',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xffFE3A30),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffEEFAF6),
              ),
              child: Text(
                'Available in stock',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xff3A9B7A),
                ),
              ),
            ),
    );
  }

  Widget sizeList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading('Size'),
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Color(0xffEEEEEE),
                ),
              ),
            ),
            margin: EdgeInsets.only(top: 10),
            height: 40,
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.only(left: 6),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.sizeList.length,
                itemBuilder: (context, index) {
                  return Obx(() => GestureDetector(
                        onTap: () {
                          viewModel.selectedSize.value = index;
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: viewModel.selectedSize.value == index
                                ? Color(0xff24282D)
                                : null,
                            border: viewModel.selectedSize.value == index
                                ? null
                                : Border.all(color: Color(0xffEEEEEE)),
                          ),
                          child: Text(
                            viewModel.sizeList[index],
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: viewModel.selectedSize.value == index
                                  ? Colors.white
                                  : Color(0xff929AAB),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget colorList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading('Color'),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 40,
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.only(left: 6),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.colorList.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        viewModel.selectedColor.value = index;
                        print(index);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(
                            int.parse('0xff${viewModel.colorList[index]}'),
                          ),
                          border: Border.all(
                            color: viewModel.selectedColor.value == index
                                ? Color(0xff00D28C)
                                : Color(0xffEEEEEE),
                          ),
                        ),
                        child: viewModel.selectedColor.value == index
                            ? Icon(
                                Icons.check,
                                color: Color(0xff00D28C),
                                size: 15,
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget heading(String value) {
    return Text(
      value,
      style: GoogleFonts.dmSans(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget sellerStore() {
    return InkWell(
      onTap: () {
        Get.toNamed(
            '/storeDetails/${viewModel.productModel.value.sellerModel!.id}');
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
        child: Row(
          children: [
            Obx(
              () => CachedNetworkImage(
                height: 45,
                width: 45,
                imageUrl:
                    viewModel.productModel.value.sellerModel?.storeImage ?? '',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/no_image_found.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 0.5),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        "${viewModel.productModel.value.sellerModel?.storeName ?? viewModel.productModel.value.sellerModel?.user?.firstName ?? viewModel.productModel.value.sellerModel?.user?.name ?? ""}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff24282D),
                        ),
                      ),
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Text(
                          'Official Store',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff24282D),
                          ),
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset('assets/svg/shield_done.svg')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: Color(0xff929AAB),
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget priceAndCartBtn() {
    return Container(
      height: 75,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 0),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Total Price',
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color(0xff929AAB),
                      ),
                    ),
                    Obx(
                      () => viewModel.productModel.value.discount != 0
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CustomPriceWidget(
                                title:
                                    '${viewModel.productModel.value.price ?? 0}',
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: Color(0xffFE3A30),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
                Obx(
                  () => CustomPriceWidget(
                    title: '${viewModel.productModel.value.discountPrice ?? 0}',
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xff24282D),
                    ),
                  ),
                ),
              ],
            ),
          ),
          viewModel.isBuyer ? Flexible(child: addToCartBtn()) : SizedBox(),
        ],
      ),
    );
  }

  Widget addToCartBtn() {
    return Obx(
      () => TextButton(
        onPressed: viewModel.productModel.value.stock == 0
            ? null
            : () {
                viewModel.addUpdateItemToLocalCart();
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/cart.svg'),
            SizedBox(width: 10),
            Text(
              viewModel.productAlreadyAdded.value ? 'Update' : 'Add to cart',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        style: TextButton.styleFrom(
          minimumSize: Size(double.maxFinite, 48),
          disabledBackgroundColor: Colors.black.withOpacity(0.6),
          foregroundColor: Colors.white,
          backgroundColor: viewModel.productAlreadyAdded.value
              ? Color(0xff00D28C)
              : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget customDivider() {
    return Divider(
      color: Color(0xffEEEEEE),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/screens/product_detail/product_detail_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailView extends StatelessWidget {
  ProductDetailView({super.key});

  final ProductDetailViewModel viewModel = Get.put(ProductDetailViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leadingWidth: 50,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: roundButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () {},
              ),
            ),
            actions: [
              roundButton(
                icon: Icons.share_outlined,
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 15),
                child: roundButton(
                  icon: Icons.shopping_cart_outlined,
                  onTap: () {},
                ),
              ),
            ],
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  carousel(),
                  heart(),
                ],
              ),
            ),
            expandedHeight: Get.height * 0.4,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      headingAndCounter(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Vado Odelle Dress',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Color(0xff929AAB),
                          ),
                        ),
                      ),
                      reviewsAndStockStatus(),
                      Padding(
                        padding: const EdgeInsets.only(top: 26, bottom: 18),
                        child: Row(
                          children: [
                            sizeList(),
                            SizedBox(width: 20),
                            colorList(),
                          ],
                        ),
                      ),
                      Divider(color: Color(0xffEEEEEE)),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 12),
                        child: heading('Description'),
                      ),
                      Text(
                        'The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers. ',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.7,
                          color: Color(0xff24282D),
                        ),
                      ),
                      priceAndCartBtn(),
                    ],
                  ),
                ),
                SizedBox(height: 500),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget carousel() {
    return Obx(
      () => (viewModel.imageList.isNotEmpty)
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(
                  onPageChanged: (index) {
                    viewModel.indicatorIndex.value = index;
                  },
                  children: List.generate(
                    viewModel.imageList.length,
                    (index) => mainImage(index),
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
              height: 250,
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/images/no_image_found.jpg',
              ),
            ),
    );
  }

  Widget mainImage(int index) {
    return CachedNetworkImage(
      //height: Get.height * 0.5,
      width: double.infinity,
      imageUrl:
          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80',
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
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(8),
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
        child: FittedBox(
          child: Icon(
            icon,
          ),
        ),
      ),
    );
  }

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

  Widget headingAndCounter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'TMA-2HD Wireless',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: Color(0xff24282D),
            ),
          ),
        ),
        SizedBox(width: 5),
        counter(),
      ],
    );
  }

  Widget counter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffF7F7F7),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.remove,
              size: 20,
              color: Color(0xffC4C5C4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            child: Text(
              '2',
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xff0C1A30),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.add,
              size: 20,
              color: Color(0xff3669C9),
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewsAndStockStatus() {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Color(0xffFFC120),
          size: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3, right: 10),
          child: Text(
            '4.6',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xff24282D),
            ),
          ),
        ),
        Text(
          '86 Reviews',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xff24282D),
            decoration: TextDecoration.underline,
          ),
        ),
        Spacer(),
        Container(
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
      ],
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

  Widget priceAndCartBtn() {
    return Container(
      margin: EdgeInsets.only(top: 14),
      color: Colors.grey.withOpacity(0.2),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xff929AAB),
                  ),
                ),
                Text(
                  '\$11,198.000000',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: Color(0xff24282D),
                  ),
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                SvgPicture.asset('assets/svg/cart.svg'),
                SizedBox(width: 16),
                Text(
                  'Added',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            style: TextButton.styleFrom(
              minimumSize: Size(200, 48),
              backgroundColor: Color(0xff00D28C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/presentation/ui/buyer/dispute_detail/dispute_detail_viewmodel.dart';
import 'package:ism_mart/presentation/widgets/loader_view.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DisputeDetailView extends StatelessWidget {
  DisputeDetailView({Key? key}) : super(key: key);
  final DisputeDetailViewModel viewModel = Get.put(DisputeDetailViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                carousel(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleItem('Id'),
                          titleItem('Status'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => valueItem(
                              viewModel.disputeDetailModel.value.id.toString(),
                            ),
                          ),
                          Obx(
                            () => Padding(
                              padding:
                                  const EdgeInsets.only(top: 4, bottom: 10),
                              child: Text(
                                viewModel.disputeDetailModel.value.status
                                        ?.capitalizeFirst ??
                                    'N/A',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: bodyText1.copyWith(
                                  color: getStatusColor(
                                    viewModel.disputeDetailModel.value.status ??
                                        'N/A',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      titleItem('Title'),
                      Obx(
                        () => valueItem(
                          viewModel.disputeDetailModel.value.title ?? 'N/A',
                        ),
                      ),
                      titleItem('Description'),
                      Obx(
                        () => valueItem(
                          viewModel.disputeDetailModel.value.description ??
                              'N/A',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          LoaderView(),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: Text(
        'Dispute Detail',
        style: appBarTitleSize,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget titleItem(String value) {
    return Text(
      value,
      style: GoogleFonts.lato(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget valueItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 10),
      child: Text(
        value,
        style: GoogleFonts.lato(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget carousel() {
    return Obx(
      () => (viewModel.disputeDetailModel.value.ticketImages?.isNotEmpty ??
              false)
          ? Column(
              children: [
                SizedBox(
                  height: 250,
                  child: PageView(
                    onPageChanged: (index) {
                      viewModel.indicatorIndex.value = index;
                    },
                    children: List.generate(
                      viewModel.disputeDetailModel.value.ticketImages!.length,
                      (index) => carouselImage(index),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.bottomCenter,
                  child: AnimatedSmoothIndicator(
                    activeIndex: viewModel.indicatorIndex.value,
                    count:
                        viewModel.disputeDetailModel.value.ticketImages!.length,
                    effect: ScrollingDotsEffect(
                      spacing: 5,
                      activeDotScale: 1.3,
                      dotHeight: 6,
                      dotWidth: 6,
                      activeDotColor: Colors.black,
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

  Widget carouselImage(int index) {
    return CachedNetworkImage(
      width: double.infinity,
      imageUrl:
          viewModel.disputeDetailModel.value.ticketImages?[index].url != null
              ? viewModel.disputeDetailModel.value.ticketImages![index].url!
              : '',
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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

  Color getStatusColor(String value) {
    switch (value) {
      case "pending":
        return Colors.deepOrange;
      case "active":
      case "completed":
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }
}

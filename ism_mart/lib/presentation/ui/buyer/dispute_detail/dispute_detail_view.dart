import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/presentation/ui/buyer/dispute_detail/dispute_detail_viewmodel.dart';
import 'package:ism_mart/presentation/widgets/loader_view.dart';
import 'package:ism_mart/utils/constants.dart';

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
                image(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        style: headline2,
                      ),
                      Obx(
                        () => Text(
                          viewModel.disputeDetailModel.value.title ?? 'N/A',
                          style: bodyText1,
                        ),
                      ),
                      SizedBox(height: 13),
                      Text(
                        'Description',
                        style: headline2,
                      ),
                      Obx(
                        () => Text(
                          viewModel.disputeDetailModel.value.description ??
                              'N/A',
                          style: bodyText2,
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
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget image() {
    return Obx(
      () => CachedNetworkImage(
        height: 250,
        width: double.infinity,
        imageUrl:
            viewModel.disputeDetailModel.value.ticketImages?.first.url != null
                ? viewModel.disputeDetailModel.value.ticketImages!.first.url!
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
      ),
    );
  }
}

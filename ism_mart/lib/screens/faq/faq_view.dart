import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/base_controller.dart';
import 'package:ism_mart/screens/faq/faq_viewmodel.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/loader_view.dart';

class FaqView extends GetView<BaseController> {
  FaqView({Key? key}) : super(key: key);
  final FaqViewModel viewModel = Get.put(FaqViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: langKey.faqs.tr,),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title(),
                listView(),
              ],
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 16, top: 6),
      child: FittedBox(
        child: Text(
          langKey.frequentlyAsked.tr,
          style: headline1.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.faqsList.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10),
                itemCount: viewModel.faqsList.length,
                itemBuilder: (context, index) {
                  return listViewItem(index);
                },
              ),
            )
          : Center(
              child: Text(
                langKey.noDataFound.tr,
                style: bodyText2.copyWith(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
            ),
    );
  }

  Widget listViewItem(int index) {
    return ExpansionTile(
      backgroundColor: Colors.black.withOpacity(0.03),
      childrenPadding: EdgeInsets.only(left: 16, bottom: 10, right: 24),
      expandedAlignment: Alignment.centerLeft,
      title: Text(
        viewModel.faqsList[index].questions ?? 'N/A',
        textAlign: TextAlign.start,
        style: headline3.copyWith(
          height: 1.3,
          fontSize: 15.5,
        ),
      ),
      children: [
        Text(
          viewModel.faqsList[index].answer ?? 'N/A',
          textAlign: TextAlign.start,
          style: bodyText2Poppins.copyWith(
            height: 1.45,
            fontSize: 12.5,
            color: Colors.black,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }
}
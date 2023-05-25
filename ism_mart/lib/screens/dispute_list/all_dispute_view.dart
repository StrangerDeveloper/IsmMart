import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/screens/dispute_detail/dispute_detail_view.dart';
import 'package:ism_mart/screens/dispute_list/all_dispute_viewmodel.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class AllDisputeView extends StatelessWidget {
  AllDisputeView({Key? key}) : super(key: key);
  final DisputeListViewModel viewModel = Get.put(DisputeListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          listView(),
          LoaderView(),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        langKey.disputes.tr,
        style: appBarTitleSize,
      ),
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

  Widget listView() {
    return Obx(
      () => viewModel.allDisputeList.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: viewModel.allDisputeList.length,
              itemBuilder: (context, index) {
                return listViewItem(index);
              },
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
    return Container(
      margin: EdgeInsets.only(left: 14, right: 14, top: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1.3, 1.3), //(x,y)
            blurRadius: 8,
            spreadRadius: 0.2,
          ),
        ],
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () {
            Get.to(() => DisputeDetailView(), arguments: {
              'id': viewModel.allDisputeList[index].id.toString()
            });
          },
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 5),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              viewModel.allDisputeList[index].title
                                      ?.capitalizeFirst ??
                                  'N/A',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: headline3,
                            ),
                          ),
                          SizedBox(height: 2),
                          Expanded(
                            flex: 1,
                            child: Text(
                              viewModel.allDisputeList[index].status
                                      ?.capitalizeFirst ??
                                  'N/A',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: bodyText1.copyWith(
                                color: getStatusColor(
                                  viewModel.allDisputeList[index].status ?? '',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        viewModel.allDisputeList[index].description
                                ?.capitalizeFirst ??
                            'N/A',
                        style: bodyText1.copyWith(
                          // fontSize: size ?? 13,
                          color: kLightColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(IconlyLight.arrow_right_2)
              ],
            ),
          ),
        ),
      ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/screens/my_orders/vendor_orders_viewmodel.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../utils/constants.dart';

class VendorOrdersView extends StatelessWidget {
  VendorOrdersView({super.key});

  final VendorOrdersViewModel viewModel = Get.put(VendorOrdersViewModel());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Column(
          children: [
            tabBar(),
            tabBarView(),
          ],
        ),
      ),
    );
  }

  TabBar tabBar() {
    return TabBar(
      // onTap: (index) {
      //   viewModel.selectedTabIndex = index;
      // },
      labelStyle: headline4,
      isScrollable: true,
      labelPadding: const EdgeInsets.symmetric(horizontal: 15),
      labelColor: kPrimaryColor,
      indicatorColor: kPrimaryColor,
      tabs: [
        Tab(text: langKey.pending.tr),
        Tab(text: langKey.accepted.tr),
        Tab(text: langKey.shipped.tr),
        Tab(text: langKey.delivered.tr),
        Tab(text: langKey.cancelled.tr),
      ],
    );
  }

  Widget tabBarView() {
    return Expanded(
      child: TabBarView(
        children: [
          Obx(
            () => listView(
              list: viewModel.pendingOrdersList,
              scrollController: viewModel.pendingScrollController,
              showLoader: viewModel.pendingLoader.value,
            ),
          ),
          Obx(
            () => listView(
              list: viewModel.acceptedOrdersList,
              scrollController: viewModel.acceptedScrollController,
              showLoader: viewModel.acceptedLoader.value,
            ),
          ),
          Obx(
            () => listView(
              list: viewModel.shippedOrdersList,
              scrollController: viewModel.shippedScrollController,
              showLoader: viewModel.shippedLoader.value,
            ),
          ),
          Obx(
            () => listView(
              list: viewModel.deliveredOrdersList,
              scrollController: viewModel.deliveredScrollController,
              showLoader: viewModel.deliveredLoader.value,
            ),
          ),
          Obx(
            () => listView(
              list: viewModel.cancelledOrdersList,
              scrollController: viewModel.cancelledScrollController,
              showLoader: viewModel.cancelledLoader.value,
            ),
          ),
        ],
      ),
    );
  }

  Widget listView({
    required List<VendorOrder> list,
    required ScrollController? scrollController,
    required bool showLoader,
  }) {
    return list.isNotEmpty
        ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: list.length,
                  itemBuilder: (BuildContext, index) {
                    return SingleRecentOrderItems(
                      orderModel: list[index].orderModel,
                      calledForBuyerOrderDetails: false,
                    );
                  },
                ),
              ),
              showLoader
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : SizedBox()
            ],
          )
        : NoDataFound(text: langKey.noOrderFound.tr);
  }
}

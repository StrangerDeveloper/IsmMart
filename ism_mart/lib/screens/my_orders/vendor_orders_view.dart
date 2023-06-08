import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
          pendingOrders(),
          acceptedOrders(),
          shippedOrders(),
          deliveredOrders(),
          cancelledOrders(),
        ],
      ),
    );
  }

  Widget pendingOrders() {
    return Obx(
      () => viewModel.pendingOrdersList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: viewModel.pendingScrollController,
                    itemCount: viewModel.pendingOrdersList.length,
                    itemBuilder: (BuildContext, index) {
                      return SingleRecentOrderItems(
                        orderModel:
                            viewModel.pendingOrdersList[index].orderModel,
                        calledForBuyerOrderDetails: false,
                      );
                    },
                  ),
                ),
                viewModel.pendingLoader.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : SizedBox()
              ],
            )
          : NoDataFound(text: langKey.noOrderFound.tr),
    );
  }

  Widget acceptedOrders() {
    return Obx(
      () => viewModel.acceptedOrdersList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: viewModel.acceptedScrollController,
                    itemCount: viewModel.acceptedOrdersList.length,
                    itemBuilder: (BuildContext, index) {
                      return SingleRecentOrderItems(
                        orderModel:
                            viewModel.acceptedOrdersList[index].orderModel,
                        calledForBuyerOrderDetails: false,
                      );
                    },
                  ),
                ),
                viewModel.acceptedLoader.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : SizedBox()
              ],
            )
          : NoDataFound(text: langKey.noOrderFound.tr),
    );
  }

  Widget shippedOrders() {
    return Obx(
      () => viewModel.shippedOrdersList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: viewModel.shippedScrollController,
                    itemCount: viewModel.shippedOrdersList.length,
                    itemBuilder: (BuildContext, index) {
                      return SingleRecentOrderItems(
                        orderModel:
                            viewModel.shippedOrdersList[index].orderModel,
                        calledForBuyerOrderDetails: false,
                      );
                    },
                  ),
                ),
                viewModel.shippedLoader.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : SizedBox()
              ],
            )
          : NoDataFound(text: langKey.noOrderFound.tr),
    );
  }

  Widget deliveredOrders() {
    return Obx(
      () => viewModel.deliveredOrdersList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: viewModel.deliveredScrollController,
                    itemCount: viewModel.deliveredOrdersList.length,
                    itemBuilder: (BuildContext, index) {
                      return SingleRecentOrderItems(
                        orderModel:
                            viewModel.deliveredOrdersList[index].orderModel,
                        calledForBuyerOrderDetails: false,
                      );
                    },
                  ),
                ),
                viewModel.deliveredLoader.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : SizedBox()
              ],
            )
          : NoDataFound(text: langKey.noOrderFound.tr),
    );
  }

  Widget cancelledOrders() {
    return Obx(
      () => viewModel.cancelledOrdersList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: viewModel.cancelledScrollController,
                    itemCount: viewModel.cancelledOrdersList.length,
                    itemBuilder: (BuildContext, index) {
                      return SingleRecentOrderItems(
                        orderModel:
                            viewModel.cancelledOrdersList[index].orderModel,
                        calledForBuyerOrderDetails: false,
                      );
                    },
                  ),
                ),
                viewModel.cancelledLoader.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : SizedBox()
              ],
            )
          : NoDataFound(text: langKey.noOrderFound.tr),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/screens/buyer_orders/buyer_order_viewmodel.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/loader_view.dart';

enum AppBarMenuNames { disputes }

class BuyerOrderView extends StatelessWidget {
  BuyerOrderView({super.key});

  final BuyerOrderViewModel viewModel = Get.put(BuyerOrderViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: langKey.userOrders.tr,
          actionItem: appBarPopupMenu(),
        ),
        backgroundColor: Colors.grey[100]!,
        body: Stack(
          children: [
            Column(
              children: [
                _orderStats(),
                Expanded(child: listView()),
              ],
            ),
            NoInternetView(
              onPressed: () {
                viewModel.getStats();
                viewModel.getOrders();
              },
            ),
            LoaderView(),
          ],
        ),
      ),
    );
  }

  Widget appBarPopupMenu() {
    return PopupMenuButton<AppBarMenuNames>(
      offset: const Offset(-10, 23),
      child: const Padding(
        padding: EdgeInsets.only(right: 12, left: 12),
        child: Icon(Icons.more_horiz_rounded),
      ),
      itemBuilder: (BuildContext context) {
        return [
          popUpMenuItemDesign(
            title: langKey.userOrderDispute.tr,
            value: AppBarMenuNames.disputes,
          ),
        ];
      },
      onSelected: (value) {
        if (value == AppBarMenuNames.disputes) {
          Get.toNamed(Routes.allDispute);
        }
      },
    );
  }

  PopupMenuItem<AppBarMenuNames> popUpMenuItemDesign({
    required String title,
    required AppBarMenuNames value,
  }) {
    return PopupMenuItem(
      //padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 38,
      value: value,
      child: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _orderStats() {
    return SizedBox(
      height: 250, //AppResponsiveness.getBoxHeightPoint22(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Obx(
                      () => CustomOrderStatsItem(
                        onTap: () {},
                        title: langKey.totalOrders.tr,
                        icon: Icons.shopping_cart_outlined,
                        iconColor: kRedColor,
                        value: viewModel.statsModel.value.totalOrders ?? 0,
                      ),
                    ),
                  ),
                  AppConstant.spaceWidget(width: 5),
                  Expanded(
                    flex: 3,
                    child: Obx(
                      () => CustomOrderStatsItem(
                        onTap: () {},
                        title: langKey.pendingOrders.tr,
                        icon: Icons.pending_outlined,
                        iconColor: Colors.orange,
                        value: viewModel.statsModel.value.pendingOrders ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppConstant.spaceWidget(height: 5),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Obx(
                      () => CustomOrderStatsItem(
                        onTap: () {},
                        title: langKey.processingOrders.tr,
                        icon: Icons.local_shipping_outlined,
                        iconColor: Colors.blue,
                        value: viewModel.statsModel.value.activeOrders ?? 0,
                      ),
                    ),
                  ),
                  AppConstant.spaceWidget(width: 5),
                  Expanded(
                    flex: 3,
                    child: Obx(
                      () => CustomOrderStatsItem(
                        onTap: () {},
                        title: langKey.completedOrder.tr,
                        icon: Icons.done_outline_rounded,
                        iconColor: Colors.teal,
                        value: viewModel.statsModel.value.deliveredOrders ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppConstant.spaceWidget(height: 5),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Obx(
                      () => CustomOrderStatsItem(
                        onTap: () {},
                        title: langKey.silverCoins.tr,
                        icon: Icons.price_change_outlined,
                        iconColor: Colors.grey,
                        value: viewModel.statsModel.value.silverCoin ?? 0,
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: Container())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.ordersList.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: viewModel.scrollController,
                    itemCount: viewModel.ordersList.length,
                    itemBuilder: (BuildContext, index) {
                      return SingleRecentOrderItems(
                        orderModel: viewModel.ordersList[index],
                        calledForBuyerOrderDetails: true,
                      );
                    },
                  ),
                ),
                viewModel.showLoader.value
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
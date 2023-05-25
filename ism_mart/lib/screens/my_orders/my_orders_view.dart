import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class MyOrdersUI extends GetView<OrderController> {
  const MyOrdersUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchVendorOrders(status: "pending");
    return controller.obx((state) {
      /*if (state == null) {
        return noDataFound();
      }
      if (state is List<OrderModel> && state.isEmpty) {
        return noDataFound();
      }*/
      return _build(listData: state);
    }, onLoading: CustomLoading(isDarkMode: Get.isDarkMode));
  }

  Widget noDataFound() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        body: Center(
          child: NoDataFoundWithIcon(
            title: langKey.noOrderFound.tr,
          ),
        ),
      ),
    );
  }

  Widget _build({listData}) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100]!,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //_orderStats(),
          _tabBar(),
          listData.isNotEmpty
              ? _tabularView(vendorOrderList: listData)
              : SizedBox(
                  height: AppConstant.getSize().height * 0.7,
                  child: NoDataFoundWithIcon(
                    title: langKey.noOrderFound.tr,
                  ),
                ),
        ],
      ),
    ));
  }

  /*Widget _orderStats()
  {
    return Obx(() => SizedBox(
          height: 200,
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
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: langKey.totalOrders.tr,
                          icon: Icons.shopping_cart_outlined,
                          iconColor: kRedColor,
                          value: controller.orderStats!.totalOrders,
                        ),
                      ),
                      AppConstant.spaceWidget(width: 5),
                      Expanded(
                        flex: 3,
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: langKey.pendingOrders.tr,
                          icon: Icons.pending_outlined,
                          iconColor: Colors.orange,
                          value: controller.orderStats!.pendingOrders,
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
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: langKey.processingOrders.tr,
                          icon: Icons.local_shipping_outlined,
                          iconColor: Colors.blue,
                          value: controller.orderStats!.activeOrders,
                        ),
                      ),
                      AppConstant.spaceWidget(width: 5),
                      Expanded(
                        flex: 3,
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: langKey.completedOrder.tr,
                          icon: Icons.done_outline_rounded,
                          iconColor: Colors.teal,
                          value: controller.orderStats!.deliveredOrders ?? 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }*/

  Widget _tabBar() {
    return Container(
      //width: 100,
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          controller: controller.tabController,
          labelStyle: headline3,
          isScrollable: true,
          physics: const AlwaysScrollableScrollPhysics(),
          labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          labelColor: kPrimaryColor,
          indicatorColor: kPrimaryColor,
          onTap: (value) {
            switch (value) {
              case 0:
                controller.fetchVendorOrders(status: "pending");
                break;
              case 1:
                controller.fetchVendorOrders(status: "accepted");
                break;
              case 2:
                controller.fetchVendorOrders(status: "shipped");
                break;
              case 3:
                controller.fetchVendorOrders(status: "delivered");
                break;
              case 4:
                controller.fetchVendorOrders(status: "cancelled");
                break;
              default:
                controller.fetchVendorOrders(status: "pending");
            }
          },
          tabs: [
            Tab(text: langKey.pending.tr),
            Tab(text: langKey.accepted.tr),
            Tab(text: langKey.shipped.tr),
            Tab(text: langKey.delivered.tr),
            Tab(text: langKey.cancelled.tr),
          ],
        ),
      ),
    );
  }

  Widget _tabularView({vendorOrderList}) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: _buildRecentOrders(list: vendorOrderList),

        /*TabBarView(
          controller: controller.tabController,
          children: [
            _buildRecentOrders(list: vendorOrderList)
            */ /* Obx(() =>
                _buildRecentOrders(list: controller.recentVendorOrdersList)),*/ /*
          ],
        ),*/
      ),
    );
  }

  _buildRecentOrders({List<VendorOrder>? list}) {
    return list!.isEmpty
        ? NoDataFound(text: langKey.noOrderFound.tr)
        : ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (_, index) {
              VendorOrder model = list[index];
              return SingleRecentOrderItems(
                orderModel: model.orderModel,
                calledForBuyerOrderDetails: false,
              );
            },
          );
  }
}
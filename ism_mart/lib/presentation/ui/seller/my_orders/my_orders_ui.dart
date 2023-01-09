import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class MyOrdersUI extends GetView<OrderController> {
  const MyOrdersUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchOrders();
    return controller.obx((state) {
      if (state == null) {
        return noDataFound();
      }
      if (state is List<OrderModel> && state.isEmpty) {
        return noDataFound();
      }
      return _build(listData: state);
    }, onLoading: CustomLoading(isDarkMode: Get.isDarkMode));
  }

  Widget noDataFound() {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100]!,
      body: Center(
          child: NoDataFoundWithIcon(
        title: "no_order_found".tr,
      )),
    ));
  }

  Widget _build({listData}) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100]!,
      body: Column(
        children: [
          _orderStats(),
          _tabBar(),
          _tabularView(),
        ],
      ),
    ));
  }

  Widget _orderStats() {
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
                          title: "Total Orders",
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
                          title: "Pending Orders",
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
                          title: "Processing Orders",
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
                          title: "Completed Orders",
                          icon: Icons.done_outline_rounded,
                          iconColor: Colors.teal,
                          value: controller.orderStats!.completedOrders,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _tabBar() {
    return Container(
      child: Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          controller: controller.tabController,
          labelStyle: headline3,
          labelColor: kPrimaryColor,
          indicatorColor: kPrimaryColor,
          tabs: [
            Tab(text: 'User Orders'),
            Tab(text: 'Vendor Orders'),
          ],
        ),
      ),
    );
  }

  Widget _tabularView() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: TabBarView(
          controller: controller.tabController,
          children: [
            Obx(() =>
                _buildRecentOrders(list: controller.recentBuyerOrdersList)),
            Obx(() =>
                _buildRecentOrders(list: controller.recentVendorOrdersList)),
          ],
        ),
      ),
    );
  }

  _buildRecentOrders({List<OrderModel>? list}) {
    return list!.isEmpty
        ? NoDataFound(text: "No Orders Found")
        : ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (_, index) {
              OrderModel model = list[index];
              return SingleRecentOrderItems(orderModel: model);
            },
          );
  }




}

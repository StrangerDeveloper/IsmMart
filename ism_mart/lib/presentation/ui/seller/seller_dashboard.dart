import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SellerDashboard extends GetView<SellersController> {
  const SellerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _orderStats(),
                StickyLabel(text: "recent_orders".tr),
                kSmallDivider,
                Obx(() => controller
                        .orderController.recentBuyerOrdersList.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(Get.context!).size.height * 0.5,
                        child: NoDataFoundWithIcon(title: "no_order_found".tr),
                      )
                    : _buildRecentOrders(
                        list:
                            controller.orderController.recentBuyerOrdersList)),
              ],
            ),
          ),
        ],
      ),
    );
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
                          title: "total_orders".tr,
                          icon: Icons.shopping_cart_outlined,
                          iconColor: kRedColor,
                          value: controller
                              .orderController.orderStats!.totalOrders,
                        ),
                      ),
                      AppConstant.spaceWidget(width: 5),
                      Expanded(
                        flex: 3,
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: "pending_orders".tr,
                          icon: Icons.pending_outlined,
                          iconColor: Colors.orange,
                          value: controller
                              .orderController.orderStats!.pendingOrders,
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
                          title: "Processing_orders".tr,
                          icon: Icons.local_shipping_outlined,
                          iconColor: Colors.blue,
                          value: controller
                              .orderController.orderStats!.activeOrders,
                        ),
                      ),
                      AppConstant.spaceWidget(width: 5),
                      Expanded(
                        flex: 3,
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: "completed_orders".tr,
                          icon: Icons.done_outline_rounded,
                          iconColor: Colors.teal,
                          value: controller
                              .orderController.orderStats!.completedOrders,
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

  _buildRecentOrders({List<OrderModel>? list}) {
    return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list!.length,
            itemBuilder: (_, index) {
              OrderModel model = list[index];
              return SingleRecentOrderItems(orderModel: model);
            },
          );
  }


}

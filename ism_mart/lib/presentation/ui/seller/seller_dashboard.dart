import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

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
                StickyLabel(text: langKey.recentOrders.tr),
                kSmallDivider,
                Obx(
                  () => controller.orderController.isLoading.isTrue
                      ? CustomLoading(isItForWidget: true)
                      : controller
                              .orderController.recentVendorOrdersList.isEmpty
                          ? SizedBox(
                              height: AppConstant.getSize().height * 0.35,
                              child: NoDataFoundWithIcon(
                                  title: langKey.noOrderFound.tr),
                            )
                          : _buildRecentOrders(
                              list: controller
                                  .orderController.recentVendorOrdersList,
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderStats() {
    return Obx(() => SizedBox(
          height: AppResponsiveness.getBoxHeightPoint55(),
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
                          value: controller
                                  .orderController.vendorStats?.totalOrders ??
                              0,
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
                          value: controller
                                  .orderController.vendorStats?.pendingOrders ??
                              0,
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
                          value: controller
                                  .orderController.vendorStats?.activeOrders ??
                              0,
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
                          value: controller.orderController.vendorStats
                                  ?.deliveredOrders ??
                              0,
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
                          title: langKey.totalEarning.tr,
                          icon: Icons.cases_rounded,
                          iconColor: Colors.deepPurple,
                          isPriceWidget: true,
                          value: controller
                                  .orderController.vendorStats?.totalEarning ??
                              0,
                        ),
                      ),
                      AppConstant.spaceWidget(width: 5),
                      Expanded(
                        flex: 3,
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: langKey.cMonthEarning.tr,
                          icon: Icons.monetization_on_rounded,
                          iconColor: Colors.pinkAccent,
                          isPriceWidget: true,
                          value: controller
                                  .orderController.vendorStats?.cMonthEarning ??
                              0,
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
                          title: langKey.pendingAmount.tr,
                          icon: Icons.history_edu_rounded,
                          iconColor: Colors.cyan,
                          isPriceWidget: true,
                          value: controller
                                  .orderController.vendorStats?.pendingAmount ??
                              0,
                        ),
                      ),
                      AppConstant.spaceWidget(width: 5),
                      Expanded(
                        flex: 3,
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: langKey.wallet.tr,
                          icon: Icons.wallet,
                          isPriceWidget: true,
                          iconColor: Colors.blueGrey,
                          value: 0,
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
                          title: langKey.goldCoins.tr,
                          icon: Icons.price_change_outlined,
                          iconColor: Colors.amber,
                          value:
                              controller.orderController.coinsModel?.gold ?? 0,
                        ),
                      ),
                      Expanded(flex: 3, child: Container())
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _buildRecentOrders({List<VendorOrder>? list}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list!.length,
      itemBuilder: (_, index) {
        VendorOrder model = list[index];
        return SingleRecentOrderItems(
          orderModel: model.orderModel,
          calledFromSellerDashboard: true,
          calledForBuyerOrderDetails: false,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/dispute_list/all_dispute_view.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

enum AppBarMenuNames { disputes }

class BuyerOrderViewOld extends GetView<OrderController> {
  const BuyerOrderViewOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.fetchOrders();
    return controller.obx((state) {
      /* if (state == null) {
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
        appBar: appBar(),
        backgroundColor: Colors.grey[100]!,
        body: Column(
          children: [
            _orderStats(),
            Center(child: NoDataFoundWithIcon(title: langKey.noOrderFound.tr)),
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
          Get.to(() => AllDisputeView());
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

  AppBar appBar() {
    return AppBar(
      elevation: 0,
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
      title: CustomText(title: langKey.userOrders.tr, style: appBarTitleSize),
      actions: [
        appBarPopupMenu(),
      ],
    );
  }

  Widget _build({listData}) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.grey[100]!,
        body: Column(
          children: [
            _orderStats(),
            StickyLabel(text: langKey.recentOrders.tr),
            kSmallDivider,
            listData.isEmpty
                ? SizedBox(
                    height: AppConstant.getSize().height * 0.5,
                    child: NoDataFoundWithIcon(title: langKey.noOrderFound.tr),
                  )
                : _buildRecentOrders(list: listData)
            /*Obx(() => controller.recentBuyerOrdersList.isEmpty
                ? SizedBox(
                    height: AppConstant.getSize().height * 0.5,
                    child: NoDataFoundWithIcon(title: langKey.noOrderFound.tr),
                  )
                : _buildRecentOrders(list: controller.recentBuyerOrdersList))*/
            ,
          ],
        ),
      ),
    );
  }

  Widget _orderStats() {
    return Obx(() => SizedBox(
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
                AppConstant.spaceWidget(height: 5),
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomOrderStatsItem(
                          onTap: () {},
                          title: langKey.silverCoins.tr,
                          icon: Icons.price_change_outlined,
                          iconColor: Colors.grey,
                          value: controller.coinsModel?.silver ?? 0,
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

  _buildRecentOrders({List<OrderModel>? list}) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        itemCount: list!.length,
        itemBuilder: (_, index) {
          OrderModel model = list[index];
          return SingleRecentOrderItems(
            orderModel: model,
            calledForBuyerOrderDetails: true,
          );
        },
      ),
    );
  }
}

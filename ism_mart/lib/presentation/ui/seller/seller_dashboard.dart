import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
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
                StickyLabel(text: "recent_orders".tr, textSize: 18),
                kSmallDivider,
                if(controller.orderController.recentOrdersList.isEmpty)
                 SizedBox(
                   height: MediaQuery.of(Get.context!).size.height * 0.5,
                   child: _ordersNotFound(),
                 )
                else
                _buildRecentOrders(list: controller.orderController.recentOrdersList),

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
                      value: controller.orderController.orderStats!.totalOrders,
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
                      value: controller.orderController.orderStats!.pendingOrders,
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
                      value: controller.orderController.orderStats!.activeOrders,
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
                      value: controller.orderController.orderStats!.completedOrders,
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
    return list!.isEmpty
        ? NoDataFound(text: "No Orders Found")
        : ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (_, index) {
        OrderModel model = list[index];
        return _singleRecentOrderItem(model);
      },
    );
  }

  _singleRecentOrderItem(OrderModel? model) {
    return Card(
      color: kWhiteColor,
      margin: const EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Stack(
          children: [
            ListTile(
              title: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      title: '${'order'.tr} #${model!.id}',
                      weight: FontWeight.bold,
                      size: 17),
                  AppConstant.spaceWidget(width: 10),
                  CustomText(
                    title: model.status!.capitalizeFirst,
                    weight: FontWeight.w600,
                    color: getStatusColor(model),
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      title:
                      '${"order_time".tr}: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.createdAt!)}',
                      color: kLightColor),
                  CustomText(
                      title:
                      '${'expected_delivery'.tr}: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.expectedDeliveryDate!)}',
                      color: kLightColor),
                  AppConstant.spaceWidget(height: 10),
                ],
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: CustomPriceWidget(
                title: '${model.totalPrice}',
                style: textTheme.bodyText2,
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: CustomButton(
                onTap: () {},
                text: "details".tr,
                //color: Colors.orangeAccent,
                width: 70,
                height: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getStatusColor(OrderModel? model) {
    switch (model!.status!.toLowerCase()) {
      case "pending":
        return Colors.deepOrange;
      case "active":
      case "completed":
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }

 Widget _ordersNotFound(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.22), shape: BoxShape.circle),
          child: Icon(
            IconlyLight.bag_2,
            size: 40,
            color: kPrimaryColor,
          ),
        ),

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              children: [
                TextSpan(text: '\n${"no_order_found".tr}\n', style: textTheme.headline6),
              ]
          ),),
      ],
    );
  }
}

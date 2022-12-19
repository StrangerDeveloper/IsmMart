import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
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
      appBar: AppBar(
        title: CustomText(
          title: 'my_orders'.tr,
          style: textTheme.headline5,
        ),
      ),
      body: NoDataFound(text: "no_order_found".tr),
    ));
  }

  Widget _build({listData}) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100]!,
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _orderStats(),
              StickyLabel(text: "recent_orders".tr, textSize: 18),
              _buildRecentOrders(list: listData),
            ]),
          ),
        ],
      ),
    ));
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      //expandedHeight: 20.0,
      floating: true,
      pinned: false,
     /* leading: InkWell(
        onTap: ()=>Get.back(),
        child: Icon(Icons.arrow_back_ios_new, size: 18, color: kWhiteColor,),
      ),*/
      backgroundColor: kPrimaryColor,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        //titlePadding: const EdgeInsets.symmetric(horizontal: 30),
        title: CustomText(
          title: 'my_orders'.tr,
            style: textTheme.headline6!.copyWith(color: kWhiteColor)
        ),
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
                      title: 'Order #${model!.id}',
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
                          'Order Time: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.createdAt!)}',
                      color: kLightColor),
                  CustomText(
                      title:
                          'Expected Delivery: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.expectedDeliveryDate!)}',
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
                text: "Details",
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

  _singleRecentOrderItem1(OrderModel? model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kLightGreyColor),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.2),
            offset: Offset(0, 1),
            blurRadius: 8,
          )
        ],
      ),
      child: Stack(
        children: [

          Column(
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      title: 'Order #${model!.id}',
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

              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          title:
                          'Order Time: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.createdAt!)}',
                          color: kLightColor),
                      CustomText(
                          title:
                          'Expected Delivery: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.expectedDeliveryDate!)}',
                          color: kLightColor),
                      AppConstant.spaceWidget(height: 10),
                    ],
                  ),
                ],
              ),
            ],
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
              text: "Details",
              //color: Colors.orangeAccent,
              width: 70,
              height: 30,
            ),
          )
        ],
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

  void showOrderDetails() {
    showDialog(context: Get.context!, builder: (_) => AlertDialog());
  }
}

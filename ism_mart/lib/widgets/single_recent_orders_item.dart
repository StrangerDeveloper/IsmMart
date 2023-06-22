import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/my_orders/orders_bindings.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class SingleRecentOrderItems extends StatelessWidget {
  const SingleRecentOrderItems(
      {Key? key,
      this.orderModel,
      this.calledFromSellerDashboard = false,
      required this.calledForBuyerOrderDetails})
      : super(key: key);
  final OrderModel? orderModel;
  final bool? calledFromSellerDashboard;
  final bool? calledForBuyerOrderDetails;

  @override
  Widget build(BuildContext context) {
    return _singleRecentOrderItem(orderModel!, context);
  }

  _singleRecentOrderItem(OrderModel? model, BuildContext? context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(1, 1),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        title: '${langKey.order.tr} #${model!.id}',
                        style: headline3,
                      ),
                      SizedBox(width: 10),
                      if (model.status != null)
                        CustomText(
                          title: model.status?.capitalizeFirst ?? "",
                          weight: FontWeight.w600,
                          color: AppConstant.getStatusColor(model),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: CustomText(
                      title:
                          '${langKey.orderTime.tr}: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.createdAt!)}',
                      color: kLightColor,
                    ),
                  ),
                  CustomText(
                    title:
                        '${langKey.expectedDelivery.tr}: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.expectedDeliveryDate!)}',
                    color: kLightColor,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                CustomPriceWidget(
                  title: '${model.totalPrice}',
                  style: bodyText1,
                ),
                if (!calledFromSellerDashboard!)
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: CustomTextBtn(
                      radius: 4,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      title: langKey.details.tr,
                      width: 80,
                      height: 30,
                      onPressed: () {
                        Get.to(
                          () => SingleOrderDetailsUI(
                            orderModel: model,
                            calledForBuyerOrderDetails:
                                calledForBuyerOrderDetails,
                          ),
                          binding: OrdersBindings(),
                        );
                      },
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

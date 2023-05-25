import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

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
                    title: '${langKey.order.tr} #${model!.id}',
                    style: headline3,
                  ),
                  AppConstant.spaceWidget(width: 10),
                  if (model.status != null)
                    CustomText(
                      title: model.status?.capitalizeFirst ?? "",
                      weight: FontWeight.w600,
                      color: AppConstant.getStatusColor(model),
                    ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      title:
                          '${langKey.orderTime.tr}: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.createdAt!)}',
                      color: kLightColor),
                  CustomText(
                      title:
                          '${langKey.expectedDelivery.tr}: ${AppConstant.formattedDataTime("MMM dd, yyyy", model.expectedDeliveryDate!)}',
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
                style: bodyText1,
              ),
            ),
            if (!calledFromSellerDashboard!)
              Positioned(
                bottom: 5,
                right: 5,
                child: CustomButton(
                  onTap: () {
                    Get.to(() => SingleOrderDetailsUI(
                          orderModel: model,
                          calledForBuyerOrderDetails:
                              calledForBuyerOrderDetails,
                        ));
                  },
                  text: langKey.details.tr,
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
}

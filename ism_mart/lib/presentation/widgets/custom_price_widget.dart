import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomPriceWidget extends GetView<CurrencyController> {
  const CustomPriceWidget({Key? key, this.title, this.style}) : super(key: key);
  final String? title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: currencyFormat(controller.convertCurrency(currenctPrice: title!)!),
      style: style ?? headline3,
    );
    // return controller.obx((state) {
    //   return CustomText(
    //   title: currencyFormat(title!),
    //   style: style ?? headline3,
    // );
    // });
  }

  String currencyFormat(String value) {
    // String amount = currencyController.currency.value.contains("pkr")
    //     ? num.parse(value).round().toString()
    //     : num.parse(value).toStringAsFixed(2); //;
    int amount = num.parse(value).round();

    print(
        ">>>Value: ${AppConstant.getCurrencySymbol(currencyCode: controller.currency.value)}$amount");
    return NumberFormat.currency(
            locale: 'en_US',
            symbol: AppConstant.getCurrencySymbol(
                currencyCode: controller.currency.value),
            decimalDigits: 0,
            customPattern:
                "${AppConstant.getCurrencySymbol(currencyCode: controller.currency.value)}#,##0")
        .format(amount);
  }
}

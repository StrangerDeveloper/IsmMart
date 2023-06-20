import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_utils.dart';

class CustomPriceWidget extends GetView<CurrencyController> {
  const CustomPriceWidget({Key? key, this.title, this.style}) : super(key: key);
  final String? title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: currencyFormat(controller.convertCurrency(currentPrice: title!)!),
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

    var amount = num.parse(value);
    var decimalDigits = 0;
    if (controller.currency.value.contains("pkr")) {
      amount = amount.round();
      //print(">>>PKR Price: ${amount.toInt()}");
      decimalDigits = 0;
    } else {
      amount = num.parse(amount.toStringAsFixed(2));
      decimalDigits = 2;
    }
    //amount = num.parse(amount.toStringAsFixed(2));
    //decimalDigits = 2;
    // print(
    //     ">>>Value: ${AppConstant.getCurrencySymbol(currencyCode: controller.currency.value)}$amount");
    return NumberFormat.currency(
            locale: languageController.languageKey.value,
            symbol: AppConstant.getCurrencySymbol(
                currencyCode: controller.currency.value),
            decimalDigits: decimalDigits,
            customPattern:
                "${AppConstant.getCurrencySymbol(currencyCode: controller.currency.value)}#,##0")
        .format(amount);
  }
}

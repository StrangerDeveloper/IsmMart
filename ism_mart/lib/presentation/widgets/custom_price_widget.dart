import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomPriceWidget extends StatelessWidget {
  const CustomPriceWidget({Key? key, this.title, this.style}) : super(key: key);
  final String? title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: currencyController.convertCurrency(
            toCurrency: currencyController.currency.value, amount: title),
        builder: (_, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return CustomLoading(
          //     isItBtn: true,
          //   );
          // } else
          // print(
          //     ">>>Price:${snapshot.data.values["result"]} currency:${currencyController.currency.value}");
          if (snapshot.hasError) {
            return CustomText(
              title: "Conversion Error",
              style: style ?? headline3,
            );
          }
          return CustomText(
            title: currencyFormat(title!),
            style: style ?? headline3,
          );
        });
  }

  String currencyFormat(String value) {
    int amount = double.parse(value).round();
    return NumberFormat.currency(
            locale: 'en_US',
            symbol: "Rs ",
            decimalDigits: 0,
            customPattern: "Rs #,##0")
        .format(amount);
  }
}

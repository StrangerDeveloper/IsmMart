import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ism_mart/models/exports_model.dart';

const kLimeGreenColor = Color(0xFFACC254);
const kPrimaryColor = kDarkColor;
const kAppBarColor = kWhiteColor;
const kLightGreenColor = Color(0xFFDCEDC2);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kLightGreyColor = Color(0xFFD1D1D1);
const kLightBlueColor = Color(0xFFE2E8F0);
const kRedColor = Color(0xFFF54141);
const kGoldColor = Color(0xFFFFD700);
const kOrangeColor = Colors.deepOrange;

Color kGrey900 = Colors.grey[900]!;
Color kGrey800 = Colors.grey[800]!;

const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kDefaultPadding = 16.0;
const kLessPadding = 10.0;
const kFixPadding = 12.0;
const kLess = 4.0;

const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 70.0;

const kDivider = Divider(
  color: kLightGreyColor,
  thickness: 3.0,
);

const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 1.0,
);

const kVerticalDivider = VerticalDivider(
  color: kAccentColor,
  width: 1,
  thickness: 0.5,
);

const maxImageUploadSizeInMBs = 2.0;
const fixedRedeemCouponThreshold = 20;

/*var headline1 = GoogleFonts.poppins(
    fontSize: 30, color: kGrey900, fontWeight: FontWeight.bold);
var headline2 = GoogleFonts.poppins(
    fontSize: 25, color: kGrey900, fontWeight: FontWeight.bold);
var headline3 = GoogleFonts.poppins(
    fontSize: 22, color: kGrey900, fontWeight: FontWeight.bold);
var headline4 = GoogleFonts.poppins(
    fontSize: 20, color: kGrey900, fontWeight: FontWeight.bold);
var headline5 = GoogleFonts.poppins(
    fontSize: 18, color: kGrey900, fontWeight: FontWeight.bold);
var headline6 = GoogleFonts.poppins(
    fontSize: 15, color: kGrey900, fontWeight: FontWeight.bold);

var bodyText1 = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
var bodyText2 = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black);
var bodyText3 = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black);

var caption = GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600);

var theme = Theme.of(Get.context!);
TextTheme textTheme = theme.textTheme;*/
var themeNew = Theme.of(Get.context!);
TextTheme textThemeNew = themeNew.textTheme;

var headline1 = GoogleFonts.lato(
    fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold);
var headline2 = GoogleFonts.lato(
    fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800);
var headline3 = GoogleFonts.lato(
    fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700);

var bodyText1 = GoogleFonts.lato(
    fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black);
var bodyText2 = GoogleFonts.lato(
    fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black);
var bodyText2Poppins = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black);

var caption = GoogleFonts.lato(fontSize: 11, fontWeight: FontWeight.w500);

var appBarTitleSize = GoogleFonts.lato(
    color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold);

class AppConstant {
  AppConstant._();

  static const live_pk =
      "pk_live_51LrbOmEmpuNuAXn2Gq2LMtj73x7dlz4uX8UYQn1coVIFDK69qc3d2td9ttdGp5Pnv1u2vrdxyYXNoeuXMk4gbTFu00sENXZzqS";
  static const test_pk =
      "pk_test_51LrbOmEmpuNuAXn2fUnpk1ER8KmDmnjMgWf4bE8Bd7TyQt9pr5IpGGi5y9rBf3cSTj6jNxMUo71bBKb009L7Ws2T000Tf2jBP4";
  static const PUBLISHABLE_KEY = kDebugMode ? test_pk : live_pk;

  static const live_sk =
      "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";
  static const test_sk =
      "sk_test_51M7CqbAqAePi9vIiIaBO0wAHIUmAmrUTTM89z5dx6MfbYK10pFs8YOJgxo3qrz2jXdRsWqbEuVNhaoLS4wkTfU3p00EweFGR7b";

  static const SECRET_KEY = kDebugMode ? test_sk : live_sk;

  static const defaultImgUrl =
      "https://i.ibb.co/dLxHqcR/vecteezy-icon-image-not-found-vector.jpg";

  static searchFieldProp() {
    return TextFieldProps(
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: kPrimaryColor),
          labelText: "Search",
          labelStyle: bodyText1,
          hintText: "Search...",
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: kPrimaryColor, width: 0.5, style: BorderStyle.solid), //B
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: kPrimaryColor, width: 0.8, style: BorderStyle.solid), //B
            borderRadius: BorderRadius.circular(8),
          ),
        ));
  }

  static displaySnackBar(String title, message, {SnackPosition? position}) {
    var bgColor = kLimeGreenColor;
    var icon = Icons.gpp_good_sharp;

    if (title.toLowerCase().contains('error')) {
      bgColor = kRedColor;
      icon = Icons.error_outline;
    }

    Get.snackbar(title, message,
        snackPosition: position ?? SnackPosition.TOP,
        backgroundColor: bgColor,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        colorText: Colors.white);
  }

  static spaceWidget({double? height = 0, double? width = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static showBottomSheet(
      {Widget? widget, isGetXBottomSheet = true, buildContext}) {
    if (isGetXBottomSheet) {
      Get.bottomSheet(
        widget!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        backgroundColor: Colors.white,
      );
    } else {
      Scaffold.of(buildContext).showBottomSheet(
        (context) => widget!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        backgroundColor: Colors.white,
      );
    }
  }

  static int getPercentage(ProductModel productModel) {
    double price = productModel.price!
        .toDouble(); //double.parse(productModel.price!.replaceAll("\$", ""));
    double discount = productModel.discountPrice!.toDouble();
    // double.parse(productModel.discountPrice!.replaceAll("\$", ""));
    double result = ((price - discount) / price) * 100;
    return result.round();
  }

  static String formattedDataTime(String customFormat, DateTime timestamp) {
    var date =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);

    return DateFormat(customFormat).format(date);
  }

  static String getFormattedTime(CurrentRemainingTime? time) {
    return "${time!.days != null && time.days! > 0 ? "${time.days} days &" : ""}"
        "${time.hours != null ? time.hours! < 10 ? "0${time.hours}:" : "${time.hours}:" : ""}"
        "${time.min != null ? time.min! < 10 ? "0${time.min}:" : "${time.min}:" : ""}"
        "${time.sec! < 10 ? "0${time.sec}" : time.sec}";
  }

  static String getCurrencySymbol({String? languageCode}) {
    switch (languageCode) {
      case "us":
        return "\$";
      case "pkr":
        return "Rs.";
      case "uae":
        return "AED";
      default:
        return "Rs";
    }
  }

  static int roundCurrency(String value) {
    return double.parse(value).round();
  }

  static Size getSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static Color getStatusColor(OrderModel? model) {
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

  static Future<File> compressImage(imagePath, {fileLength}) async {
    return await FlutterNativeImage.compressImage(imagePath,
        quality: 100, percentage: getCompressionPercentage(length: fileLength));
  }

  static int getCompressionPercentage({length}) {
    var lengthInMb = length * 0.000001;

    if (lengthInMb < 1) {
      return 40;
    } else if (lengthInMb > 1 && lengthInMb < 2.5) {
      return 25;
    } else {
      return 15;
    }
  }
}

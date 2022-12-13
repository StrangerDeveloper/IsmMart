import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ism_mart/models/exports_model.dart';

const kPrimaryColor = Color(0xFFACC254);
const kLightGreenColor = Color(0xFFDCEDC2);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor = Color(0xFF808080);
const kLightGreyColor = Color(0xFFD1D1D1);
const kRedColor = Color(0xFFF54141);
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

var headline1 = GoogleFonts.poppins(fontSize: 30, color: kGrey900, fontWeight: FontWeight.bold);
var headline2 = GoogleFonts.poppins(fontSize: 25, color: kGrey900,fontWeight: FontWeight.bold);
var headline3 = GoogleFonts.poppins(fontSize: 22,color: kGrey900, fontWeight: FontWeight.bold);
var headline4 = GoogleFonts.poppins(fontSize: 20, color: kGrey900,fontWeight: FontWeight.bold);
var headline5 = GoogleFonts.poppins(fontSize: 18,color: kGrey900, fontWeight: FontWeight.bold);
var headline6 = GoogleFonts.poppins(fontSize: 15, color: kGrey900,fontWeight: FontWeight.bold);

var bodyText1 = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
var bodyText2 = GoogleFonts.poppins(
    fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black);
var bodyText3 = GoogleFonts.poppins(
    fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black);

var caption = GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w600);

var theme = Theme.of(Get.context!);
TextTheme textTheme = theme.textTheme;

class AppConstant {
  AppConstant._();

  static const PUBLISHABLE_KEY =
      "pk_test_51KdtNAHqJCPRIXprSlMz57nwZf7iDT7Wn59LYaU8jhflk9kDhOdm740B5peXYc2tYIYJjtBM8WWOKi6b8Cd1tLz700aPpzaLUp";
  static const SECRET_KEY =
      "sk_test_51KdtNAHqJCPRIXprP3T8H3eIbJyxY883o7nGiyeiFxpcU017yPMeLu0n4aRPjWjXeoajnF1HxxSmGjRhy9xQXgLr00t7bOyMJd";

  static const defaultImgUrl = "http://18.212.34.27:5173/assets/ISSMART.bc4ee033.png";


  static displaySnackBar(String title, message, {SnackPosition? position}) {
    var bgColor = kPrimaryColor;
    var icon = Icons.gpp_good_sharp;

    if (title.toLowerCase().contains('error')) {
      bgColor = kRedColor;
      icon = Icons.error_outline;
    }

    Get.snackbar(title, message,
        snackPosition:position??SnackPosition.BOTTOM,
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

  static showBottomSheet({Widget? widget}) {
    Get.bottomSheet(
      widget!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
    );
  }

  static int getPercentage(ProductModel productModel) {
    double price = productModel.price!.toDouble();//double.parse(productModel.price!.replaceAll("\$", ""));
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


 static String getCurrencySymbol({String? languageCode}){
    switch(languageCode){
      case "us":
        return "\$";
      case "pkr":
        return "Rs.";
      case "uae":
        return "AED";
      default:
        return "\$";
    }
  }
}

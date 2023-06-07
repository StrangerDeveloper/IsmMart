import 'dart:io';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ism_mart/models/exports_model.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

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
const kLightRedColor = Color(0xBBEF5350);
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
var textStylePoppins = GoogleFonts.lato(
  color: Colors.black,
);

class AppConstant {
  AppConstant._();

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

  static const SESSION_EXPIRED = "session is expired";
  static const INVALID_USER = "invalid user recieved";

  static displaySnackBar(String title, message, {SnackPosition? position}) {
    var bgColor = kLimeGreenColor;
    var icon = Icons.gpp_good_sharp;
    var titleNew = title;

    if (title.toLowerCase().contains('error')) {
      titleNew = "Oops!";
      bgColor = kRedColor;
      icon = Icons.error_outline;
    }

    var messageNew = message;
    if (message.toString().toLowerCase().contains(SESSION_EXPIRED)) {
      messageNew =
          "Your session has expired. For security reasons, please sign in again to continue.";
    } else if (message.toString().toLowerCase().contains(INVALID_USER)) {
      messageNew =
          "We're sorry, but we couldn't recognize that user. Please double-check and try again, or contact support for assistance.";
    }

    Get.snackbar(titleNew.capitalizeFirst!.toString(), messageNew.toString(),
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

  static String formatNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(2)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    } else {
      return number.toString();
    }
  }

  static String getCurrencySymbol({String? currencyCode}) {
    switch (currencyCode?.toLowerCase()) {
      case "usd":
        return "\$";
      case "pkr":
        return "Rs ";
      case "aed":
        return "AED ";
      case "gbp":
        return "\£";
      case "eur":
        return "\€";
      case "inr":
        return "\₹";
      case "cny":
        return "\¥";
      case "aud":
        return "A\$";
      case "cad":
        return "CA\$";
      case "jpy":
        return "JP\¥";
      case "sgd":
        return "\$";
      case "try":
        return "\₺";
      case "hkd":
        return "HK\$";
      case "chf":
        return "CHF";

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

  static void showConfirmDeleteDialog(
      {VoidCallback? ontap,
      String? passedHeadingLangKey,
      String? passedBodyLangKey,
      double? givenFontSize}) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.zero,
      titleStyle: TextStyle(fontSize: 0),
      title: '',
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.close,
                    size: 24,
                    color: Colors.grey,
                  )),
            ),
            Icon(
              Icons.highlight_remove_outlined,
              size: 100,
              color: kLightRedColor,
            ),
            AppConstant.spaceWidget(height: 12),
            passedHeadingLangKey == null
                ? Container()
                : CustomText(
                    title: passedHeadingLangKey,
                    style: headline1,
                  ),
            AppConstant.spaceWidget(height: 12),
            CustomText(
              title: passedBodyLangKey,
              weight: FontWeight.w600,
              textAlign: TextAlign.center,
              size: givenFontSize,
            ),
            //buildConfirmDeleteIcon(),
            AppConstant.spaceWidget(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextBtn(
                  onPressed: () => Get.back(),
                  title: langKey.noBtn.tr,
                  width: 100,
                  height: 40,
                ),
                CustomTextBtn(
                  onPressed: ontap,
                  title: langKey.yesBtn.tr,
                  width: 100,
                  height: 40,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static pickImage({calledForProfile = true, calledBuyerProfile = false}) {
    Get.defaultDialog(
      title: langKey.pickFrom.tr,
      contentPadding: const EdgeInsets.all(10),
      titleStyle: appBarTitleSize,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _imageBtn(
            onTap: () => authController.pickOrCaptureImageGallery(0,
                calledForProfile: calledForProfile,
                calledForBuyerProfile: calledBuyerProfile),
            title: langKey.camera.tr,
            icon: Icons.camera_alt_rounded,
            color: Colors.blue,
          ),
          _imageBtn(
            onTap: () => authController.pickOrCaptureImageGallery(
              1,
              calledForBuyerProfile: calledBuyerProfile,
              calledForProfile: calledForProfile,
            ),
            title: langKey.gallery.tr,
            icon: Icons.photo_library_rounded,
            color: Colors.redAccent,
          ),
        ],
      ),
      //onCancel: ()=>Get.back()
    );
  }

  static Widget _imageBtn({onTap, icon, title, color}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          AppConstant.spaceWidget(height: 10),
          CustomText(
            title: title,
            color: color,
          )
        ],
      ),
    );
  }

  static String convertDateFormat1(String stringDate) {
    DateTime inputDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(stringDate);
    String outputDate = DateFormat('dd-MMM-yy').format(inputDate);
    return outputDate;
  }
}

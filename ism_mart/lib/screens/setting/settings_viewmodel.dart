import 'dart:io';

import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:url_launcher/url_launcher.dart';

import '../../helper/constants.dart';
import '../../helper/routes.dart';
import '../../models/user/user_model.dart';

class SettingViewModel extends GetxController {

  Rx<UserModel?> userDetails = UserModel().obs;

  @override
  void onInit() async {
    userDetails.value = await LocalStorageHelper.getStoredUser();
    //print(userDetails.value?.token);
    // authController.getCurrentUser();
    //setUserModel(authController.userModel);

    super.onInit();
  }

  setUserModel(UserModel? model) {
    userDetails.value = model;
  }

  bool? checkVendorAccountStatus() {
    String? status = userDetails.value!.vendor!.status!.toLowerCase();
    if (status.contains("disabled") ||
        status.contains("terminated") ||
        status.contains("suspended")) {
      return false;
    } else {
      return true;
    }
  }

  emailVerificationCheck() async {
    String? verificationDetails =
        await LocalStorageHelper.getEmailVerificationDetails();
    if (verificationDetails != null) {
      DateTime linkTime = DateTime.parse(verificationDetails);
      DateTime currentTime = DateTime.now();
      DateTime fiveMinutesCheck = currentTime.subtract(Duration(minutes: 5));
      if (fiveMinutesCheck.isAfter(linkTime)) {
        LocalStorageHelper.localStorage.remove('emailVerificationTime');
        Get.toNamed(Routes.emailVerificationLinkRoute);
      } else {
        showSnackBar(
            title: langKey.verifyEmail.tr,
            message: langKey.emailVerificationLinkSent.tr);
      }
    } else {
      Get.toNamed(Routes.emailVerificationLinkRoute);
    }
  }

  void showSnackBar({title = 'error', message = 'Something went wrong'}) {
    AppConstant.displaySnackBar(title, message);
  }

  whatsapp() async {
    String contact = "923331832356";
    String text = '';
    String androidUrl = "whatsapp://send?phone=$contact&text=$text";
    String iosUrl = "https://wa.me/$contact?text=${Uri.parse(text)}";

    String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      }
    } catch(e) {
      print('object');
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/local_storage/local_storage_helper.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/setting/settings_viewmodel.dart';
import '../../helper/routes.dart';
import 'choose_email_viewmodel.dart';
import 'package:ism_mart/widgets/back_button.dart';
import 'package:ism_mart/widgets/custom_button.dart';
import 'package:ism_mart/widgets/custom_text.dart';

class ChooseEmail extends StatelessWidget {
  ChooseEmail({super.key});

  final ChooseEmailViewModel viewModel = Get.put(ChooseEmailViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndBackBtn(),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: CustomText(
                  title: langKey.getOnboard.tr + '!',
                  style: newFontStyle2.copyWith(
                    fontSize: 20,
                    color: newColorDarkBlack2,
                  ),
                ),
              ),
              Text(
                langKey.createYourAccount.tr,
                style: newFontStyle0.copyWith(
                  color: newColorLightGrey2,
                ),
              ),
              continueWithSameEmailBtn(),
              continueWithDiffEmailBtn(),
              or(),
              socialButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleAndBackBtn() {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              langKey.signUp.tr,
              style: dmSerifDisplay1.copyWith(
                fontSize: 32,
              ),
            ),
          ),
          CustomBackButton(
            onTap: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget continueWithSameEmailBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 15),
      child: CustomRoundedTextBtn(
        backgroundColor: newColorDarkBlack,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              langKey.continueWithSameEmail.tr,
              style: newFontStyle1.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 9),
            Icon(Icons.arrow_forward_rounded)
          ],
        ),
        onPressed: () => Get.offNamed(Routes.vendorSignUp2),
      ),
    );
  }

  Widget continueWithDiffEmailBtn() {
    return CustomRoundedTextBtn(
      borderSide: BorderSide(color: Color(0xff929AAB), width: 1.8),
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Text(
        langKey.continueWithDiffEmail.tr,
        style: newFontStyle4.copyWith(
          color: Color(0xff929AAB),
        ),
      ),
      onPressed: () async{
        await LocalStorageHelper.deleteUserData();
        SettingViewModel settingViewModel = Get.find();
        authController.setCurrUserToken('');
        authController.setUserModel(UserModel());
        GlobalVariable.userModel = UserModel();
        settingViewModel.userDetails.value = UserModel();
        Get.offNamed(Routes.vendorSignUp1);
      },
    );
  }

  Widget or() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 40),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: newColorLightGrey,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              langKey.or.tr,
              style: newFontStyle4,
            ),
          ),
          Expanded(
            child: Divider(
              color: newColorLightGrey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget socialButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/svg/google_logo.svg'),
          SvgPicture.asset('assets/svg/fb_logo.svg'),
          SvgPicture.asset('assets/svg/instagram_logo.svg'),
          SvgPicture.asset('assets/svg/twitter_logo.svg'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/back_button.dart';
import 'package:ism_mart/widgets/custom_button.dart';
import 'package:ism_mart/widgets/custom_text.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  title: 'Get onboard!',
                  style: newFontStyle2.copyWith(
                    fontSize: 20,
                    color: newColorDarkBlack2,
                  ),
                ),
              ),
              Text(
                'Create your account',
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
              'Continue With same email',
              style: newFontStyle1.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 9),
            Icon(Icons.arrow_forward_rounded)
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget continueWithDiffEmailBtn() {
    return CustomRoundedTextBtn(
      borderSide: BorderSide(color: Color(0xff929AAB), width: 1.8),
      foregroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Text(
        'With different email',
        style: newFontStyle4.copyWith(
          color: Color(0xff929AAB),
        ),
      ),
      onPressed: () {},
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

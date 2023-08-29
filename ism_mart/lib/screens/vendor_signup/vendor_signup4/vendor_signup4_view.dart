import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/vendor_signup/vendor_signup4/vendor_signup4_viewmodel.dart';
import 'package:ism_mart/widgets/back_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class VendorSignUp4View extends StatelessWidget {
  VendorSignUp4View({Key? key}) : super(key: key);
  final VendorSignUp4ViewModel viewModel = Get.put(VendorSignUp4ViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            children: [
              titleAndBackBtn(),
              subtitle(),
              progress(),
              SizedBox(height: 35),
              Text(
                langKey.waitForVerification.tr + '...',
                style: newFontStyle3.copyWith(
                  color: newColorDarkBlack,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: newFontStyle0.copyWith(
                    color: Color(0xff667085),
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: 'Our'),
                    TextSpan(
                      text: ' Vendor Management Team ',
                      style: newFontStyle2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Color(0xff0E1216),
                      ),
                    ),
                    TextSpan(
                      text:
                          'will review your profile and after approval you will receive a confirmation email of your',
                    ),
                    TextSpan(
                      text: ' seller account',
                      style: newFontStyle2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: newColorBlue2,
                      ),
                    ),
                  ],
                ),
              ),
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
              'ISMMART',
              style: GoogleFonts.dmSerifText(
                color: Color(0xff333333),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          CustomBackButton(
            onTap: () {
              if(viewModel.fromSettings.value){
                Get.back();
              } else {
                baseController.changePage(0);
                int count = 0;
                Get.until((route) => count++ >= 2);
                // Get.offNamedUntil(Routes.bottomNavigation, (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget subtitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: langKey.vendor.tr,
                style: newFontStyle2.copyWith(
                  fontSize: 20,
                  color: newColorDarkBlack2,
                ),
              ),
              TextSpan(
                text: ' ${langKey.profile.tr} ',
                style: newFontStyle2.copyWith(
                  fontSize: 20,
                  color: newColorBlue,
                ),
              ),
              TextSpan(
                text: langKey.submitted.tr + '!',
                style: newFontStyle2.copyWith(
                  fontSize: 20,
                  color: newColorDarkBlack2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget progress() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  langKey.vendorAccountCreation.tr,
                  style: newFontStyle1.copyWith(
                    color: newColorBlue2,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  langKey.lastStep.tr,
                  style: newFontStyle1.copyWith(
                    fontSize: 12,
                    color: newColorBlue4,
                  ),
                ),
              ],
            ),
          ),
          new CircularPercentIndicator(
            circularStrokeCap: CircularStrokeCap.round,
            radius: 33,
            lineWidth: 6,
            percent: 1,
            backgroundColor: Color(0xffEBEFF3),
            progressColor: Color(0xff0CBC8B),
            center: new Text(
              "4 of 4",
              style: poppinsH2.copyWith(
                color: newColorBlue2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/vendor_signup/vendor_signup1/vendor_signup1_view.dart';
import 'package:ism_mart/widgets/custom_button.dart';

class BecomeVendor extends StatelessWidget {
  final String? text;
  final String? buttonText;

  BecomeVendor({
    super.key,
    this.text, this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      padding: EdgeInsets.fromLTRB(16, 8, 12, 8),
      color: newColorDarkBlack2,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Text(
              text ?? langKey.joinOurMarketplace.tr,
              style: headline4.copyWith(
                color: Colors.white,
                fontSize: 10,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 20),
          CustomTextBtn(
            backgroundColor: Colors.transparent,
            borderSide: BorderSide(
              color: newColorBlue,
              width: 1.8,
            ),
            radius: 30,
            height: 34,
            width: 145,
            onPressed: () {
              Get.off(() => VendorSignUp1View());
            },
            child: Text(
              buttonText ?? langKey.becomeAVendor.tr,
              style: poppinsH1,
            ),
          )
        ],
      ),
    );
  }
}

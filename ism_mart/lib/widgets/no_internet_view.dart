import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import '../widgets/custom_button.dart';

class NoInternetView extends StatelessWidget {
  NoInternetView({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (GlobalVariable.internetErr.isTrue)
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svg/no_internet.svg', width: 250),
                  SizedBox(height: 30),
                  Text(
                    'No Internet connection',
                    style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Text(
                      'Please check your internet connection\nand try again',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  GlobalVariable.btnPress.value == false
                      ? tryAgainBtn()
                      : SizedBox(),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget tryAgainBtn() {
    return CustomTextBtn(
      child: const Text("Try Again"),
      onPressed: onPressed,
    );
  }
}

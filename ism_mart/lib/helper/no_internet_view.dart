import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';

import '../screens/add_product/add_product_viewmodel.dart';
import '../widgets/custom_button.dart';

class NoInternetView extends StatelessWidget {
  final VoidCallback? onPressed;

  NoInternetView({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final AddProductViewModel viewModel = Get.put(AddProductViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (GlobalVariable.internetErr.isTrue)
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Get.isDarkMode ? Colors.black : Colors.white,
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
                        color: Get.isDarkMode ? Colors.black38 : Colors.grey,
                      ),
                    ),
                  ),
                  GlobalVariable.btnPress.value == true
                      ? SizedBox()
                      : tryAgainBtn(),
                ],
              ),
            )
          : SizedBox(),
    );
  }

  Widget tryAgainBtn() {
    return CustomTextBtn(
      child: const Text("Try Again"),
      // minimumSize: Size(200, 45),
      // backgroundColor: ,
      onPressed: onPressed,
    );
  }
}

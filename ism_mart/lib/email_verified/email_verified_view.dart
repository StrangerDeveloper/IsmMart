import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';

import '../helper/routes.dart';

class EmailVerifedView extends StatefulWidget {
  const EmailVerifedView({super.key});

  @override
  State<EmailVerifedView> createState() => _EmailVerifedViewState();
}

class _EmailVerifedViewState extends State<EmailVerifedView> {
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: s.height * .5,
            width: s.width * .9,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 70.0,
                      child: ClipRRect(
                        child: SvgPicture.asset(
                          'assets/svg/Done.svg',
                          width: 200,
                          height: 200,
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomText(
                  title: "Verified!",
                  size: 22,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: s.width * .15,
                  ),
                  child: CustomText(
                    title:
                        "Congratulations! You have successfully varified the account",
                    size: 15,
                    color: Colors.grey.shade700,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextBtn(
                    //rednring to login when user verify
                    onPressed: () => Get.offAllNamed(Routes.bottomNavigation),
                    title: "Go to Dashboard",
                    height: 60,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

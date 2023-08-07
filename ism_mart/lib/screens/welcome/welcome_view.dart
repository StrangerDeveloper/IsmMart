// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:ism_mart/helper/constants.dart';
// import 'package:ism_mart/helper/global_variables.dart';
// import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
// import 'package:ism_mart/widgets/back_button.dart';
// import 'package:ism_mart/widgets/custom_button.dart';
// import 'package:ism_mart/widgets/custom_loading.dart';
// import 'package:ism_mart/widgets/custom_text.dart';
//
// class WelcomeView extends StatelessWidget {
//   const WelcomeView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             titleAndBackBtn(),
//             Padding(
//               padding: const EdgeInsets.only(top: 20, bottom: 10),
//               child: CustomText(
//                 title: 'Get onboard!',
//                 style: newFontStyle2.copyWith(
//                   fontSize: 20,
//                   color: newColorDarkBlack2,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 25),
//               child: Text(
//                 'Create your account',
//                 style: newFontStyle0.copyWith(
//                   color: newColorLightGrey2,
//                 ),
//               ),
//             ),
//             or(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SvgPicture.asset('assets/svg/google_logo.svg'),
//                 SvgPicture.asset('assets/svg/fb_logo.svg'),
//                 SvgPicture.asset('assets/svg/instagram_logo.svg'),
//                 SvgPicture.asset('assets/svg/twitter_logo.svg'),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget titleAndBackBtn() {
//     return Container(
//       width: double.infinity,
//       child: Stack(
//         alignment: Alignment.centerLeft,
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Text(
//               langKey.signUp.tr,
//               style: dmSerifDisplay1.copyWith(
//                 fontSize: 32,
//               ),
//             ),
//           ),
//           CustomBackButton(
//             onTap: () {
//               Get.back();
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget signUpBtn() {
//     return Obx(
//       () => GlobalVariable.showLoader.value
//           ? CustomLoading(isItBtn: true)
//           : CustomRoundedTextBtn(
//               title: langKey.signUp.tr,
//               onPressed: () {},
//             ),
//     );
//   }
//
//   Widget or() {
//     return Row(
//       children: [
//         Expanded(
//           child: Divider(
//             color: newColorLightGrey,
//             thickness: 1,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             langKey.or.tr,
//             style: newFontStyle4,
//           ),
//         ),
//         Expanded(
//           child: Divider(
//             color: newColorLightGrey,
//             thickness: 1,
//           ),
//         ),
//       ],
//     );
//   }
// }

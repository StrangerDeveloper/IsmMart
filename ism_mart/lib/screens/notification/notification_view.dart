// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconly/iconly.dart';
// import 'package:ism_mart/widgets/export_widgets.dart';
// import 'package:ism_mart/utils/exports_utils.dart';
// import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
//
// class NotificationUI extends StatelessWidget {
//   const NotificationUI({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: _appBar(),
//       body: Center(
//         child: NoDataFoundWithIcon(
//           icon: IconlyLight.notification,
//           title: langKey.noDataFound.tr,
//           iconColor: Colors.lightBlue,
//         ),
//       ),
//     ));
//   }
//
//   _appBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: kPrimaryColor,
//       leading: InkWell(
//         onTap: () => Get.back(),
//         child: Icon(
//           Icons.arrow_back_ios_new,
//           size: 18,
//           color: kWhiteColor,
//         ),
//       ),
//       title: CustomText(
//         title: langKey.notifications.tr,
//         style: appBarTitleSize,
//       ),
//     );
//   }
// }

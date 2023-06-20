import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_buyers.dart';
import '../helper/constants.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  CustomAppBar({
    this.title,
    this.onTap,
    this.actionIcon,
    this.actionItem,
    this.leading,
    this.searchBar
  });

  final GestureTapCallback? onTap;
  final String? title;
  final Icon? actionIcon;
  final dynamic actionItem;
  final Widget? leading;
  final double height = 55;
  final CustomSearchBar? searchBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: leading ?? InkWell(
        onTap: (){
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: kPrimaryColor,
          size: 20,
        ),
      ),
      title: searchBar ?? CustomText(
          title: title?.tr,
          style: appBarTitleSize
      ),
      // iconTheme: IconThemeData(color: kPrimaryColor),
      centerTitle: true,
      backgroundColor: kAppBarColor,
      actions: actionItem ?? null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

// class CustomSimpleAppBar extends CustomAppBar{
//
//   CustomSimpleAppBar({this.title, this.leading});
//
//   final String? title;
//   final Widget? leading;
//
//   @override
//   Widget build(BuildContext context){
//     return AppBar(
//       actions: [],
//       leading: leading == null ? InkWell(
//         onTap: (){
//           Get.back();
//         },
//         child: Icon(
//           Icons.arrow_back_ios,
//           color: kPrimaryColor,
//           size: 20,
//         ),
//       ) : leading,
//       centerTitle: true,
//       title: CustomText(
//         title: title,
//         style: appBarTitleSize,
//       ),
//     );
//   }
// }
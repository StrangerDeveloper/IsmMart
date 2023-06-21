import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final Widget? searchBar;

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
      centerTitle: true,
      backgroundColor: kAppBarColor,
      actions: actionItem ?? null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
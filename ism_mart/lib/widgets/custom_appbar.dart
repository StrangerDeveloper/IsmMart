import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {this.title, this.menuItem, this.action, this.leading, this.searchBar});

  final bool? menuItem;
  final String? title;
  final List<Widget>? action;
  final Widget? leading;
  final double height = 55;
  final Widget? searchBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: leading == null ? menuItem == null ?
          InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
              size: 20,
            ),
          ) : null : leading,
      title: searchBar ?? CustomText(title: title?.tr, style: appBarTitleSize),
      centerTitle: true,
      backgroundColor: kAppBarColor,
      actions: action ?? null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

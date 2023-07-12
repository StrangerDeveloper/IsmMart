import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? menuItem;
  final String? title;
  final List<Widget>? action;
  final Widget? leading;
  final double? height;
  final Widget? searchBar;
  final bool? centerTitle;
  final double? leadingWidth, elevation;
  final void Function()? onTap;

  CustomAppBar({
    this.title,
    this.menuItem,
    this.action,
    this.leading,
    this.height = 55,
    this.searchBar,
    this.centerTitle,
    this.leadingWidth,
    this.elevation = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      elevation: elevation,
      centerTitle: centerTitle,
      backgroundColor: kAppBarColor,
      actions: action,
      title: searchBar ??
          CustomText(
            title: title ?? '',
            style: appBarTitleSize,
          ),
      leading: leading ??
          (menuItem != null
              ? null
              : InkWell(
                  onTap: onTap ??
                      () {
                        Get.back();
                      },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kPrimaryColor,
                    size: 20,
                  ),
                )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);
}

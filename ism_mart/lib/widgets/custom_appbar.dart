import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import 'custom_text.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? menuItem;
  final String? title;
  final List<Widget>? action;
  final Widget? leading;
  final double height = 55;
  final Widget? searchBar;
  final bool? centerTitle;
  final double? leadingWidth;
  final void Function()? onTap;

  CustomAppBar({
    this.title,
    this.menuItem,
    this.action,
    this.leading,
    this.searchBar,
    this.centerTitle,
    this.leadingWidth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: leadingWidth,
      elevation: 0,
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
  Size get preferredSize => Size.fromHeight(height);
}

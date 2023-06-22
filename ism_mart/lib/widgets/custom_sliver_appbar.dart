import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/constants.dart';
import 'custom_text.dart';

class CustomSliverAppBar extends StatelessWidget{
  CustomSliverAppBar({
    this.title,
    this.leading,
    this.floating,
    this.pinned,
    this.expandedHeight,
    this.flexibleSpaceBar,
    this.elevation
  });

  final String? title;
  final Widget? leading;
  final bool? floating, pinned;
  final double? expandedHeight;
  final double? elevation;
  final FlexibleSpaceBar? flexibleSpaceBar;

  Widget build(BuildContext context){
    return SliverAppBar(
        expandedHeight: expandedHeight ?? 14.0,
        floating: floating ?? true,
        elevation: elevation ?? 10,
        pinned: pinned ?? false,
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarColor,
        leading: leading ?? InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: kPrimaryColor,
          ),
        ),
        flexibleSpace: flexibleSpaceBar,
        centerTitle: true,
        title: flexibleSpaceBar == null ? CustomText(
          title: title ?? '',
          style: appBarTitleSize,
        ) : null
    );
  }
}
import 'package:flutter/material.dart';
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
  });

  final String? title;
  final Widget? leading;
  final bool? floating, pinned;
  final double? expandedHeight;
  final FlexibleSpaceBar? flexibleSpaceBar;

  Widget build(BuildContext context){
    return SliverAppBar(
        expandedHeight: expandedHeight ?? 14.0,
        floating: floating ?? true,
        elevation: 10,
        pinned: pinned ?? false,
        automaticallyImplyLeading: false,
        backgroundColor: kAppBarColor,
        leading: leading ?? null,
        flexibleSpace: flexibleSpaceBar,
        centerTitle: true,
        title: flexibleSpaceBar == null ? CustomText(
          title: title,
          style: appBarTitleSize,
        ) : null
    );
  }
}
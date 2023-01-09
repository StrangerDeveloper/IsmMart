import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class NotificationUI extends StatelessWidget {
  const NotificationUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: _appBar(),
      body: Center(
        child: NoDataFoundWithIcon(
          icon: IconlyLight.notification,
          title: 'no_data_found'.tr,
          iconColor: Colors.lightBlue,
        ),
      ),
    ));
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      leading: InkWell(
        onTap: ()=>Get.back(),
        child: Icon(Icons.arrow_back_ios_new, size: 18,  color: kWhiteColor,),
      ),
      title: CustomText(
          title: 'notifications'.tr,
          style: appBarTitleSize),
    );
  }
}

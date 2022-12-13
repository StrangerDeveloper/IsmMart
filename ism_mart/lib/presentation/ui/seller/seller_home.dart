import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/widgets/custom_text.dart';
import 'package:ism_mart/utils/constants.dart';

class SellerHome extends GetView<SellersController> {
  const SellerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("USERS: ${controller.authController.userModel!.firstName}");
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => CustomText(
              title: controller.appBarTitle.value,
              weight: FontWeight.w600,
              size: 15,
            )),
        centerTitle: true,
      ),
      body: PageView(
        controller: controller.pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [...controller.NavScreens],
      ),
      drawer: Drawer(
        elevation: 0,
        width: MediaQuery.of(context).size.width * 0.65,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(
              () => DrawerHeader(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  /* gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.topLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      kLightColor,
                      kPrimaryColor,
                      kPrimaryColor,
                      kLightGreyColor,
                    ],
                  ),*/
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      title: "${controller.authController.userModel?.firstName} ${controller.authController.userModel?.lastName}",
                      size: 20,
                      weight: FontWeight.bold,
                      color: kWhiteColor,
                    ),
                    CustomText(
                      title: controller.authController.userModel?.email,
                      size: 15,
                      weight: FontWeight.w600,
                      color: kWhiteColor,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: controller.getMenuItems().map((e) {
                return _singleDrawerItem(
                  onTap: () {
                    int? page = e['page'] as int?;
                    controller.changePage(page!);
                    controller.appBarTitle(e["title"].toString());
                    Get.back();
                  },
                  title: e['title'],
                  icon: e['icon'],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleDrawerItem({icon, title, onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: CustomText(
        title: title,
        weight: FontWeight.w600,
      ),
    );
  }
}

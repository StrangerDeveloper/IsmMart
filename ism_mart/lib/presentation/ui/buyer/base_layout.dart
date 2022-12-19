import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class BaseLayout extends GetView<BaseController> {
  const BaseLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView(
        controller: controller.bottomNavPageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [...controller.bottomNavScreens],
      ),
      bottomNavigationBar: _buildBottomNavBar(controller),
    );
  }

  _buildBottomNavBar(BaseController navController) {
    return BottomAppBar(
      elevation: kLess,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getNavBarItems(icon: IconlyLight.home, title:"home".tr,page: 0),
              _getNavBarItems(icon: IconlyLight.category, title:"categories".tr,page: 1),
              _getNavBarItems(icon: IconlyLight.bag_2, title:"deals".tr,page: 4),
              controller.cartCount.value <= 0
                  ? _getNavBarItems(icon: IconlyLight.buy,title:"cart".tr, page: 2)
                  : CartIcon(
                      onTap: () {
                        //Get.to(Routes.cartRoute);
                        controller.changePage(2);
                      },
                      iconWidget:
                          _getNavBarItems(icon: IconlyLight.buy, title:"cart".tr, page: 2),
                    ),
              _getNavBarItems(icon: Icons.menu, title:"menu".tr, page: 3),
            ],
          ),
        ),
      ),
    );
  }

  _getNavBarItems({
    icon,
    page,
    title,
  }) {
    //return BottomNavigationBarItem(icon: Icon(icon), label: "$page");

    return GestureDetector(
      onTap: () {
        /*if(page == 4){
          controller.currentPage(page);
          Get.toNamed(Routes.searchRoute, arguments: {"searchText": " "});
        }else*/
          controller.changePage(page);
      },
      child: SizedBox(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: controller.currentPage.value == page ? kPrimaryColor : kLightColor,
              size: 21,
            ),
            CustomText(
              title: title,
              size: 13,
              color: controller.currentPage.value == page ? kPrimaryColor : kLightColor,
            )
          ],
        ),
      ),
    );
  }
}

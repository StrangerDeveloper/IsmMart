import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class BaseLayout extends GetView<BaseController> {
  const BaseLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return controller.onBackPressed(context);
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: PageView(
          controller: controller.bottomNavPageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [...controller.bottomNavScreens],
        ),
        bottomNavigationBar: _buildBottomNavBar(controller),
        //: Work remaining of reward button if needed
        /*floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
          elevation: 5,
          icon: Icon(Icons.shopping_bag, color: kPrimaryColor, ),
          label: CustomText(title: 'Rewards', style: headline3,),
          //foregroundColor: Colors.blueGrey,
          backgroundColor:  Colors.indigo[100]!,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,*/
      ),
    );
  }

  _buildBottomNavBar(BaseController navController) {
    return BottomAppBar(
      elevation: kLess,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getNavBarItems(
              icon: IconlyLight.home,
              title: langKey.home.tr,
              page: 0,
            ),
            _getNavBarItems(
              icon: IconlyLight.category,
              title: langKey.categories.tr,
              page: 1,
            ),
            _getNavBarItems(
              icon: IconlyLight.bag_2,
              title: langKey.deals.tr,
              page: 4,
            ),
            // controller.cartCount.value <= 0
            //     ?
            _getNavBarItems(
                icon: IconlyLight.buy,
                title: langKey.myCart.tr,
                page: 2,
                showBadge: true),

            // : Expanded(
            //     child: CartIcon(
            //     onTap: () {
            //       //Get.to(Routes.cartRoute);
            //       controller.changePage(2);
            //     },
            //     iconWidget: _getNavBarItems(
            //         icon: IconlyLight.buy,
            //         title: langKey.myCart.tr,
            //         page: 2),
            //   )),
            _getNavBarItems(
              icon: Icons.menu,
              title: langKey.menu.tr,
              page: 3,
            ),
          ],
        ),
      ),
    );
  }

  _getNavBarItems({
    icon,
    page,
    title,
    bool? showBadge = false,
  }) {
    //return BottomNavigationBarItem(icon: Icon(icon), label: "$page");

    return Expanded(
      child: InkWell(
        onTap: () {
          /*if(page == 4){
             controller.currentPage(page);
             Get.toNamed(Routes.searchRoute, arguments: {"searchText": " "});
           }else*/
          controller.changePage(page);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: controller.currentPage.value == page
                        ? kPrimaryColor
                        : kLightColor,
                    size: 20,
                  ),
                  SizedBox(height: 3.5),
                  Flexible(
                    child: Text(
                      title,
                      style: GoogleFonts.lato(
                        fontWeight: controller.currentPage.value == page
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: 11.5,
                        color: controller.currentPage.value == page
                            ? kPrimaryColor
                            : kLightColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (showBadge!)
              Obx(
                () => baseController.cartCount.value <= 0
                    ? Container(
                        height: 0,
                      )
                    : Positioned(
                        top: 5,
                        right: 20,
                        child: Container(
                          alignment: Alignment.center,
                          height: 14,
                          width: 14,
                          //padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: kOrangeColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: CustomText(
                            title: "${baseController.cartCount.value}",
                            size: 10,
                            color: kWhiteColor,
                            maxLines: 1,
                          ),
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}

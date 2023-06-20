import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/custom_text.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:iconly/iconly.dart';

class SellerHomeView extends GetView<SellersController> {
  const SellerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: _buildAppBar(),
        //   elevation: 0,
        //   title: Obx(
        //     () => CustomText(
        //         title: controller.appBarTitle.value.tr, style: appBarTitleSize),
        //   ),
        //   iconTheme: IconThemeData(color: kPrimaryColor),
        //   centerTitle: true,
        //   backgroundColor: kAppBarColor,
        //   actions: [
        //     InkWell(
        //       onTap: () async {
        //         controller.clearControllers();
        //         BaseController baseController = Get.find<BaseController>();
        //         await baseController.fetchProducts();
        //         await baseController.fetchProductsByTypes();
        //         Get.back();
        //         //baseController.changePage(0);
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //         child: Icon(
        //           IconlyLight.logout,
        //           color: kRedColor,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
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
                        title:
                            "${authController.userModel?.firstName} ${authController.userModel?.lastName}",
                        size: 20,
                        weight: FontWeight.bold,
                        color: kWhiteColor,
                      ),
                      CustomText(
                        title: authController.userModel?.email,
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
      ),
    );
  }

  _buildAppBar(){
    return CustomAppBar(
      barTitle: controller.appBarTitle.value.tr,
      onTap: ()async{
        controller.clearControllers();
        BaseController baseController = Get.find<BaseController>();
        await baseController.fetchProducts();
        await baseController.fetchProductsByTypes();
        Get.back();
      },
      actionIcon: Icon(
        IconlyLight.logout,
        color: kRedColor,
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

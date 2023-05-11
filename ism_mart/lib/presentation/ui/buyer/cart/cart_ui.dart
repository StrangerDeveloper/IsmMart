import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class CartUI extends GetView<CartController> {
  const CartUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //if (authController.isSessionExpired!) {
    controller.fetchCartItemsFromLocal();
    /*} else {
      controller.fetchCartItems();
    }*/

    return controller.obx((state) {
      if (state == null) {
        return noDataFound();
      }
      if (state is List<CartModel> && state.isEmpty) {
        //controller.fetchCartItemsFromLocal();
        return noDataFound();
      }
      return _build(listData: state);
    },
        onLoading: CustomLoading(isDarkMode: Get.isDarkMode),
        onEmpty: noDataFound());
  }

  Widget noDataFound() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          automaticallyImplyLeading: false,
          leading: (Get.arguments != null && Get.arguments["calledFromSPV"])
              ? InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: kPrimaryColor,
                  ),
                )
              : null,
          title: Row(
            children: [
              buildSvgLogo(),
              AppConstant.spaceWidget(width: 10),
              CustomText(
                title: langKey.myCart.tr,
                style: appBarTitleSize,
                //style: textTheme.headline6!.copyWith(color: kWhiteColor),
              ),
            ],
          ),
        ),
        body: Center(
          child: NoDataFoundWithIcon(
            icon: IconlyLight.buy,
            title: langKey.emptyCart.tr,
            subTitle: langKey.emptyCartMsg.tr,
          ),
        ),
      ),
    );
  }

  Widget _build({List<CartModel>? listData}) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        body: CustomScrollView(
          slivers: [
            _sliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildCartItemSection(cartItemsList: listData),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _checkOutBottomBar(),
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 14.0,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: kAppBarColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Row(
          children: [
            buildSvgLogo(),
            AppConstant.spaceWidget(width: 10),
            Obx(
              () => CustomText(
                title:
                    '${langKey.myCart.tr} (${controller.totalQtyCart.value} ${langKey.items.tr})',
                style: appBarTitleSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemSection({List<CartModel>? cartItemsList}) {
    int selectedItem = 0;
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItemsList!.length,
      itemBuilder: (context, index) {
        CartModel cartModel = cartItemsList[index];
        return SingleCartItems(cartModel: cartModel, index: index);
      },
    );
  }

  _checkOutBottomBar() {
    return BottomAppBar(
      elevation: 22,
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title:
                        "${controller.totalQtyCart.value} ${langKey.items.tr}",
                    style: headline3,
                  ),
                  CustomPriceWidget(
                      title: "${controller.totalCartAmount.value}"),
                ],
              ),
            ),
            AppConstant.spaceWidget(height: 10),
            CustomButton(
              onTap: () async{
                AuthController authController = Get.find();
                await authController.emailVerificationChecks(false);
              },
              text: langKey.proceedToCheckOut.tr,
              color: kPrimaryColor,
              height: 40,
            ),
            //_buildBuyNowAndCartBtn(),
          ],
        ),
      ),
    );
  }
}

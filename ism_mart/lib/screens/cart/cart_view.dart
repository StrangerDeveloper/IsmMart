import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/cart/cart_viewmodel.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);

  final CartViewModel viewModel = Get.put(CartViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: _appBar(),
        body: Obx(() => viewModel.cartItemsList.isEmpty ? Center(
          child: NoDataFoundWithIcon(
            icon: IconlyLight.buy,
            title: langKey.emptyCart.tr,
            subTitle: langKey.emptyCartMsg.tr,
          ),
        ) : SingleChildScrollView(
          physics: ScrollPhysics(),
          child: _buildCartItemSection(),
        ),
        ),
        bottomNavigationBar: viewModel.cartItemsList.isEmpty ? null : _checkOutBottomBar(),
        ),
      );
  }

  AppBar _appBar(){
    return AppBar(
      backgroundColor: kAppBarColor,
      automaticallyImplyLeading: false,
      leading: (Get.arguments != null && Get.arguments["calledFromSPV"]) ?
      InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ) : null,
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
    );
  }

  Widget _buildCartItemSection() {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.cartItemsList.length,
      itemBuilder: (context, index) {
        return SingleCartItems(index: index);
      },
    );
  }

  BottomAppBar _checkOutBottomBar() {
    return BottomAppBar(
      elevation: 22,
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: "${viewModel.totalQtyCart.value} ${langKey.items.tr}",
                    style: headline3,
                  ),
                  CustomPriceWidget(
                      title: "${viewModel.totalCartAmount.value}"),
                ],
              ),
            ),
            AppConstant.spaceWidget(height: 10),
            CustomTextBtn(
              onPressed: () async {
                AuthController authController = Get.find();
                await authController.emailVerificationCheck();
              },
              title: langKey.proceedToCheckOut.tr,
              height: 40,
            ),
            //_buildBuyNowAndCartBtn(),
          ],
        ),
      ),
    );
  }
}
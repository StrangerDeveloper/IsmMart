import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/screens/seller_dashboard/seller_dashboard_viewmodel.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class SellerDashboardView extends StatelessWidget {
  SellerDashboardView({super.key});

  final SellerDashBoardViewModel viewModel =
      Get.put(SellerDashBoardViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: viewModel.scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    orderStats(),
                    StickyLabel(text: langKey.recentOrders.tr),
                    kSmallDivider,
                    listView(),
                  ],
                ),
              ),
              Obx(
                () => (viewModel.showLoader.value)
                    ? SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          padding: EdgeInsets.all(14),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: Container(
                          height: 50,
                        ), // Empty container
                      ),
              ),
            ],
          ),
          Visibility(
            visible: GlobalVariable.userModel?.infoCompleted == 0 ? true : false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black54,
              child: SlideTransition(
                position: viewModel.animation1,
                child: AlertDialog(
                  title: FadeTransition(
                    opacity: viewModel.animation2,
                      child: Center(child: Text(langKey.updateInfo.tr, style: headline1,))),
                  contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  content: FadeTransition(
                    opacity: viewModel.animation2,
                    child: Text(
                      langKey.updateInfoAlertMsg.tr,
                      style: bodyText1,
                    ),
                  ),
                  actions: [
                    FadeTransition(
                      opacity: viewModel.animation2,
                      child: TextButton(
                          onPressed: (){
                            viewModel.animationController1.reverse().whenComplete(() {
                              viewModel.announcementVisibility.value = false;
                            });
                            viewModel.animationController1.addListener(() {
                              viewModel.animation1.value;
                            });
                            },
                          child: Text(
                              langKey.skip.tr,
                            style: headline4,
                          ),
                      ),
                    ),
                    FadeTransition(
                        opacity: viewModel.animation2,
                        child: TextButton(
                            onPressed: (){
                              viewModel.announcementVisibility.value = false;
                              Get.toNamed(Routes.vendorSignUp2);
                            },
                            child: Text(langKey.proceed.tr, style: headline4,),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          NoInternetView(
            onPressed: () {
              viewModel.getStats();
              viewModel.getOrders();
            },
          ),
        ],
      ),
    );
  }

  Widget orderStats() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                CustomOrderStatsItem2(
                  title: langKey.totalOrders.tr,
                  icon: Icons.shopping_cart_outlined,
                  iconColor: kRedColor,
                  value: viewModel.vendorStats.value.totalOrders ?? 0,
                ),
                SizedBox(width: 5),
                CustomOrderStatsItem2(
                  title: langKey.pendingOrders.tr,
                  icon: Icons.pending_outlined,
                  iconColor: Colors.orange,
                  value: viewModel.vendorStats.value.pendingOrders ?? 0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  CustomOrderStatsItem2(
                    title: langKey.processingOrders.tr,
                    icon: Icons.local_shipping_outlined,
                    iconColor: Colors.blue,
                    value: viewModel.vendorStats.value.activeOrders ?? 0,
                  ),
                  SizedBox(width: 5),
                  CustomOrderStatsItem2(
                    title: langKey.completedOrder.tr,
                    icon: Icons.done_outline_rounded,
                    iconColor: Colors.teal,
                    value: viewModel.vendorStats.value.deliveredOrders ?? 0,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                CustomOrderStatsItem2(
                  title: langKey.totalEarning.tr,
                  icon: Icons.cases_rounded,
                  iconColor: Colors.deepPurple,
                  isPriceWidget: true,
                  value: viewModel.vendorStats.value.totalEarning ?? 0,
                ),
                SizedBox(width: 5),
                CustomOrderStatsItem2(
                  title: langKey.goldCoins.tr,
                  icon: Icons.price_change_outlined,
                  iconColor: Colors.amber,
                  value: viewModel.vendorStats.value.goldCoin ?? 0,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  CustomOrderStatsItem2(
                    title: langKey.pendingAmount.tr,
                    icon: Icons.history_edu_rounded,
                    iconColor: Colors.cyan,
                    isPriceWidget: true,
                    value: viewModel.vendorStats.value.pendingAmount ?? 0,
                  ),
                  SizedBox(width: 5),
                  CustomOrderStatsItem2(
                    title: langKey.wallet.tr,
                    icon: Icons.wallet,
                    isPriceWidget: true,
                    iconColor: Colors.blueGrey,
                    value: 0,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                CustomOrderStatsItem2(
                  title: langKey.cMonthEarning.tr,
                  icon: Icons.monetization_on_rounded,
                  iconColor: Colors.pinkAccent,
                  isPriceWidget: true,
                  value: viewModel.vendorStats.value.cMonthEarning ?? 0,
                ),
                Expanded(
                  flex: 0,
                  child: SizedBox(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.ordersList.isNotEmpty
          ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: viewModel.ordersList.length,
              itemBuilder: (BuildContext, index) {
                return SingleRecentOrderItems(
                  orderModel: viewModel.ordersList[index].orderModel,
                  calledFromSellerDashboard: true,
                  calledForBuyerOrderDetails: false,
                );
              },
            )
          : SizedBox(
              height: 200,
              child: NoDataFound(text: langKey.noOrderFound.tr),
            ),
    );
  }
}

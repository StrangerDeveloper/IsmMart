import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SellerDashboard extends GetView<SellersController> {
  const SellerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _topHeaders(),
                  
                Center(child: NoDataFound(text: "You have no orders yet!",)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topHeaders() {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GridView.builder(
            //scrollDirection: Axis.horizontal,
          //padding: const EdgeInsets.all(0.5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //maxCrossAxisExtent: 150,
            crossAxisCount: 2,
            childAspectRatio: 2,
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
          itemCount: controller.getTopCardsData().length,
          itemBuilder: (context, index) {
            var e = controller.getTopCardsData()[index];
            return _singleTopHeaderItem(
                onTap: () {},
                title: e['title'],
                icon: e['icon'],
                count: e['count'],
                iconColor: e['iconColor']);
          }),
    );
  }

  Widget _singleTopHeaderItem({onTap, title,count, icon, iconColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kLightGreyColor),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.2),
              offset: Offset(0, 1),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [
            /// icon with colorful bg
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 25,
                color: iconColor,
              ),
            ),

            AppConstant.spaceWidget(width: 5),
            Flexible(
              //flex: 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: title,
                      weight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      size: 15,
                    ),
                    CustomText(
                      title: "$count",
                      weight: FontWeight.bold,
                      size: 17,
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

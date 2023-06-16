import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key, this.searchText, this.calledFromDashboard = false, this.calledFromSearchDetailsView = false})
      : super(key: key);
  final String? searchText;
  final bool calledFromDashboard, calledFromSearchDetailsView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
    {
      // Get.back();
      /*Get.offNamed(Routes.searchRoute,
              arguments: {"searchText": searchText ?? " "},
              preventDuplicates: true);*/
      // else {
      //baseController.changePage(2);
      if (calledFromDashboard) {
        Get.toNamed(Routes.searchRoute,
            arguments: {"searchText": searchText ?? " "});
      }else if(calledFromSearchDetailsView == true){
        Get.back();
    }else {
          Get.toNamed(Routes.searchRoute,
              arguments: {"searchText": searchText ?? " ", 'isCalledFromDeals': true});
        }
        },
      child: Container(
        height: 34.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: kFixPadding),
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(color: kLightGreyColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: kPrimaryColor),
            Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                searchText != "" ? searchText! : searchIn.tr,
                style: TextStyle(
                  color: kLightColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

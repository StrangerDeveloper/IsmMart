import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({Key? key,
    this.searchText,
    this.calledFromDashboard = false,
    this.calledFromSearchDetailsView = false,
  }) : super(key: key);
  final String? searchText;
  final bool calledFromDashboard, calledFromSearchDetailsView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      if (calledFromDashboard) {
        Get.toNamed(Routes.searchRoute,
            arguments: {"searchText": searchText ?? " "});
      }else if(calledFromSearchDetailsView == true){
        int count = 0;
        Get.offNamedUntil(Routes.searchRoute, (route) => count++ >= 2);
      }
      else {
        Get.offNamed(
            Routes.searchRoute, arguments: {"searchText": searchText ?? " "});
      }
      },
      child: Container(
        height: 34,
        //width: double.infinity,
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
            SizedBox(width: 4),
            Expanded(
              child: Text(
              overflow:  TextOverflow.ellipsis,
                searchText != "" ? searchText! : langKey.searchIn.tr,
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

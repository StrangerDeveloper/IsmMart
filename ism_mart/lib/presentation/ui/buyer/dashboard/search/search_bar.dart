import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, this.searchText, this.calledFromSPV = false}) : super(key: key);
  final String? searchText;
  final bool? calledFromSPV;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "productSearchBar",
      child: GestureDetector(
        onTap: () {
          if(calledFromSPV!){
            Get.offNamed(Routes.searchRoute,
                arguments: {"searchText": searchText ?? " "},
                preventDuplicates: false);
          }else {
            Get.toNamed(Routes.searchRoute,
              arguments: {"searchText": searchText ?? " "});
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
                  searchIn.tr,
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
      ),
    );
  }
}

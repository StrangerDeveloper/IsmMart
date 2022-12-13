import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "productSearchBar",
      child: GestureDetector(
        onTap: () =>
            Get.toNamed(Routes.searchRoute, arguments: {"searchText": "computer"}),
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
            children: const [
              Icon(Icons.search, color: kPrimaryColor),
              Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Text(
                  "What are you looking for?",
                  style: TextStyle(
                    color: kLightColor,
                    fontSize: 12.0,
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

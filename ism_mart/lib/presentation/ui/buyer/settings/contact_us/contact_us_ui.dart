import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class ContactUsUI extends StatelessWidget {
  const ContactUsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getData().map((e) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      //shape: BoxShape.rectangle,
                      border: Border.all(color: kLightGreyColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppConstant.spaceWidget(height: 5),
                          Icon(
                            e["icon"],
                            size: 30,
                            color: kPrimaryColor,
                          ),
                          AppConstant.spaceWidget(height: 8),
                          CustomText(
                            title: e['title'],
                            style: textTheme.headline6,
                          ),
                          AppConstant.spaceWidget(height: 3),
                          if (e['subTitle'] != null)
                            CustomText(
                              title: e['subTitle'],
                              style: textTheme.bodyText1!.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
                            ),
                          AppConstant.spaceWidget(height: 3),
                          CustomText(
                            title: e['description'],
                            style: textTheme.bodyMedium!.copyWith(color: kDarkColor, ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kWhiteColor,
        ),
      ),
      title: CustomText(
          title: 'contact_us'.tr,
          style: textTheme.headline6!.copyWith(color: kWhiteColor)),
    );
  }

  List getData() {
    return [
      {
        'icon': Icons.email_outlined,
        'title': 'Email Us',
        'subTitle': 'businesses@ismmartgroupofcompanies.com',
        'description':
            'Interactively grow empowered for process-centric total linkage.'
      },
      {
        'icon': IconlyBold.calling,
        'title': 'Call Us',
        'subTitle': '+92 311 7216038',
        'description':
            'Distinctively disseminate focused solutions clicks-and-mortar mini-state.'
      },
      {
        'icon': IconlyLight.location,
        'title': 'Location',
        'subTitle': null,
        'description':
            'Emirates Tower, Bhittai Road, F7 Markaz, Islamabad, Pakistan'
      }
    ];
  }
}

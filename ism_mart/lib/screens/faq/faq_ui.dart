import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class FaqUI extends GetView<BaseController> {
  const FaqUI({Key? key}) : super(key: key);

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
              CustomHeader(title: langKey.frequentlyAsked.tr),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.faqsList.map(
                    (FAQModel? faq) {
                      return ExpansionTile(
                        childrenPadding: EdgeInsets.only(left: 16, bottom: 10),
                        expandedAlignment: Alignment.centerLeft,
                        title: Text(
                          faq!.questions!,
                          textAlign: TextAlign.start,
                          style: headline3.copyWith(height: 1.1),
                        ),
                        children: [
                          Text(
                            faq.answer!,
                            textAlign: TextAlign.start,
                            style: bodyText1.copyWith(
                              height: 1.5,
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kAppBarColor,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(title: langKey.faqs.tr, style: appBarTitleSize),
    );
  }

  List getData() {
    return [
      {
        'q': langKey.q1.tr,
        'ans': langKey.ans1,
      },
      {
        'q': langKey.q2.tr,
        'ans': langKey.ans2,
      },
      {
        'q': langKey.q3.tr,
        'ans': langKey.ans3,
      },
      {
        'q': langKey.q4.tr,
        'ans': langKey.ans4,
      },
      {
        'q': langKey.q5.tr,
        'ans': langKey.ans5,
      },
    ];
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/base_controller.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/widgets/custom_text.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class FaqView extends GetView<BaseController> {
  const FaqView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 16, top: 6),
                child: FittedBox(
                  child: Text(
                    langKey.frequentlyAsked.tr,
                    style: headline1.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.faqsList.map(
                        (FAQModel? faq) {
                      return ExpansionTile(
                        backgroundColor: Colors.black.withOpacity(0.03),
                        childrenPadding:
                        EdgeInsets.only(left: 16, bottom: 10, right: 24),
                        expandedAlignment: Alignment.centerLeft,
                        title: Text(
                          faq!.questions!,
                          textAlign: TextAlign.start,
                          style: headline3.copyWith(
                            height: 1.3,
                            fontSize: 15.5,
                          ),
                        ),
                        children: [
                          Container(
                            //color: Colors.red,
                            child: Text(
                              faq.answer!,
                              textAlign: TextAlign.start,
                              style: bodyText2Poppins.copyWith(
                                height: 1.45,
                                fontSize: 12.5,
                                color: Colors.black,
                                fontWeight: FontWeight.w100,
                              ),
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

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(
        title: langKey.faqs.tr,
        style: appBarTitleSize,
      ),
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

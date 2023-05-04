import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

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
              CustomHeader(title: "Frequently Asked Questions"),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: controller.faqsList.map((FAQModel? faq) {
                    return ExpansionTile(
                        childrenPadding: EdgeInsets.only(left: 16),
                        expandedAlignment: Alignment.centerLeft,
                        title: CustomText(
                          title: faq!.questions,
                          style: headline3,
                        ),
                        children: [
                          CustomText(
                            title: faq.answer!,
                            size: 14.5,
                            weight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ]);
                  }).toList(),
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
      title: CustomText(title: 'faq'.tr, style: appBarTitleSize),
    );
  }

  List getData() {
    return [
      {
        'q': 'How does the ISMMART work?',
        'ans':
            'The system will provide a virtual space/store to the sellers who wish to sell something to the market. They can be individual vendors, or some established brands who want to enhance their presence in the digital world. Our vendors will register themselves with us on some Monthly Subscription Charges/ Platform fees. We shall verify the authenticity of vendors by taking their basic information and prepare an agreement with them. Similarly our customers/buyers shall also be registered with us on our ecommerce store. The customers will be able to see the vendor profile, rate them (after getting services), make their purchases and keep themselves updated with the products in the market. For instance we have a vendor/store registered as Ali Electronics which deals with all kind of home appliances. Let say, Ayesha wants to buy an electric kettle and she upon searching finds her desired product on Ali Electronics. She will place her order and make her payment in advance which will be in Company’s Account until the order is completed. Ali Electronics will receive a notification about the order. He will pack the relevant product and will dispatch it through our service (Our defined courier services through our account). Once Miss Ayesha receives the product and verifies that she got the desired product, the payment will be released and will reach the vendor account in defined period of time (15 days).'
      },
      {
        'q': 'Can I cancel my subscription anytime?',
        'ans':
            'Yes. You can cancel your subscription anytime. Your subscription will continue to be active until the end of your current term (month or year) but it will not auto-renew. Unless you delete your account manually, your account and all data will be deleted 60 days from the day your subscription becomes inactive.'
      },
      {
        'q': 'Which payment method you should accept?',
        'ans':
            'Holistic engage sticky niche markets before collaborative collaboration and idea-sharing. Phosphorescently facilitate parallel applications with unique imperatives. Proactively plagiarize functionality deliverables via inexpensive solutions. Collaboratively embrace web-enabled intermediaries rather than diverse testing procedures.'
      },
      {
        'q': 'What are the benefits of using ISMMART affiliate?',
        'ans':
            'Continually impact seamless imperatives for best-of-breed best practices. Phosphorescently facilitate parallel applications with unique imperatives. Proactively plagiarize functionality deliverables via inexpensive solutions. Collaboratively embrace web-enabled intermediaries rather than diverse testing procedures.'
      },
      {
        'q':
            'What is fleet management and how is it different from dynamic scaling?',
        'ans':
            'Distinctively initiate error-free channels with highly efficient ROI. Intrinsic envision world-class data via best-of-breed best practices. Efficiently enable empowered e-tilers after cross-unit services. Uniquely expedite seamless retailers via cooperative interfaces. Monotonically myocardial customer directed meta-services whereas error-free scenarios.'
      },
    ];
  }
}

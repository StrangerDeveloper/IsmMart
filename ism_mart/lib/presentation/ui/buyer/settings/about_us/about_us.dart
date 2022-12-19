import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class AboutUS extends StatelessWidget {
  const AboutUS({Key? key}) : super(key: key);

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
              CustomText(
                  title: "Welcome to ISMMART", style: textTheme.headline3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getData().map((e) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AppConstant.spaceWidget(height: 8),
                      CustomText(title: e['header'], style: textTheme
                          .headline6,),
                      Text(e['body'], style: textTheme.bodyMedium,),
                    ],
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
        onTap: ()=>Get.back(),
        child: Icon(Icons.arrow_back_ios_new, size: 18,  color: kWhiteColor,),
      ),
      title: CustomText(title: 'about_us'.tr,
          style: textTheme.headline6!.copyWith(color: kWhiteColor)),
    );
  }

  List getData() {
    return [
      {
        'header': 'What is ISMMART?',
        'body':
        'ISMMART is an ecommerce platform providing a virtual space to sellers/vendors where they can advertise, market and sell their products or services. The concept of ISMMART was established when we saw a huge trust deficit between sellers and buyers. Considering that problem, we at Shaukat Marwat wanted to provide people with a reliable and trust worthy platform which will ensure utmost security of buyers’ money and services.'
      },
      {
        'header': 'Our Mission:',
        'body':
        'Our Mission is to bring a secure platform where sellers can connect with buyers without any hesitation. We aim to become one of its kind ecommerce stores where people can explore all kind of products and service under one platform. We also intent to create a forum which will enable thousands of individuals to have their own business and create more work force in the country.'
      },
      {
        'header': 'Our Vision:',
        'body':
        'Our vision is to bring a trustworthy store targeting global market and connecting businesses to bring them under one umbrella, as a unit.'
      },
      {
        'header': 'How will the system work?',
        'body': 'The system will provide a virtual space/store to the sellers who wish to sell something to the market. They can be individual vendors, or some established brands who want to enhance their presence in the digital world. Our vendors will register themselves with us on some Monthly Subscription Charges/ Platform fees. We shall verify the authenticity of vendors by taking their basic information and prepare an agreement with them. Similarly our customers/buyers shall also be registered with us on our ecommerce store. The customers will be able to see the vendor profile, rate them (after getting services), make their purchases and keep themselves updated with the products in the market. For instance we have a vendor/store registered as Ali Electronics which deals with all kind of home appliances. Let say, Ayesha wants to buy an electric kettle and she upon searching finds her desired product on Ali Electronics. She will place her order and make her payment in advance which will be in Company’s Account until the order is completed. Ali Electronics will receive a notification about the order. He will pack the relevant product and will dispatch it through our service (Our defined courier services through our account). Once Miss Ayesha receives the product and verifies that she got the desired product, the payment will be released and will reach the vendor account in defined period of time (15 days).'
            'Note: Non Verified & Unregistered Members can only surf the products on ISMMART stores but are not allowed to trade. To ensure quality trading, all customers will need to register before any sale / purchase.'
      },
      {
        'header': 'Refund Policy:',
        'body': 'ISMMART Stores typically process returns within 3 business days once the courier returns the item to our Return Centre. Our customer service team will provide the shipping label as soon as they get your written complaint in accordance with the return policy. The item will be received, and the appropriate quality check will be done, before the refund is completed.'
            'Please note that depending on the payment method, refund times can vary. It can take three to fourteen business days. Along with the money you paid for the returned product, the shipping cost is also repaid.'
            'For example, when Ayesha receives the product, she finds it faulty. She will lodge a complaint at our complaint center, where we shall contact with the vendor for resolution. If her claim is proven right, she will return the faulty item back to the vendor, and her payment (which was kept on hold by ISMMART will be retrieved back to her.'
            'Some Products/Services will be nonrefundable and will be defined in the description of the product/service.'
      },
      {
        'header': 'What makes us Different?',
        'body': 'ISMMART is a unique platform which offers 100 percent security to both the buyer and the vendor.'
            'It provides a virtual space to display , market and sell your products or services under one platform unlike stores that offer only products selling.'
            'For buyers, it is an exclusive forum where they can shop with confident that their money will not be wasted. Our unique return policy ensures that no fraudulent activity happens with the buyer or seller.'
            'We have devised different subscription/membership offers for vendors of different categories.'
      },
    ];
  }
}

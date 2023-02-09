import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneralSettingsDataUI extends StatelessWidget {
  const GeneralSettingsDataUI(
      {Key? key, this.title, this.isContactUsCalled = false})
      : super(key: key);

  final String? title;
  final bool? isContactUsCalled;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              CustomHeader(title: title!),
              if (isContactUsCalled!)
                _buildContactUs()
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: getData().map((e) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppConstant.spaceWidget(height: 8),
                        CustomText(
                          title: "${e['header']}",
                          style: headline2,
                        ),
                        AppConstant.spaceWidget(height: 5),
                        if (e['body'].toString().isNotEmpty)
                          CustomGreyBorderContainer(
                            borderColor: Colors.grey[300]!,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  //_bodyText(text:e['body']),
                                  Text(
                                "${e['body']}",
                                softWrap: true,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: kDarkColor,
                                ),
                              ),
                            ),
                          ),
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
      backgroundColor: kAppBarColor,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(title: title, style: appBarTitleSize),
    );
  }

  Widget _buildContactUs() {
    var formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        //padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          CustomGreyBorderContainer(
            child: Column(
              children: getContactUsData()
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        leading: Icon(
                          e["icon"],
                          size: 30,
                          color: kPrimaryColor,
                        ),
                        title: CustomText(
                          title: e['title'],
                          style: headline3,
                        ),
                        subtitle: CustomText(
                          title: e['description'],
                          maxLines: e['description'].length,
                          style: bodyText1.copyWith(
                            color: kDarkColor,
                          ),
                          //textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          AppConstant.spaceWidget(height: 15),
          CustomGreyBorderContainer(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Column(
                  children: [
                    StickyLabel(text: "For any support just send your query", style: headline1,),
                    AppConstant.spaceWidget(height: 15),
                    FormInputFieldWithIcon(
                      controller: authController.firstNameController,
                      iconPrefix: Icons.person_rounded,
                      labelText: fullName.tr,
                      iconColor: kPrimaryColor,
                      autofocus: false,
                      textStyle: bodyText1,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                      GetUtils.isBlank(value!)! ? fullNameReq.tr : null,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {},
                      onSaved: (value) {},
                    ),
                    AppConstant.spaceWidget(height: 10),
                    FormInputFieldWithIcon(
                      controller: authController.emailController,
                      iconPrefix: Icons.email_rounded,
                      labelText: email.tr,
                      iconColor: kPrimaryColor,
                      autofocus: false,
                      textStyle: bodyText1,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                      !GetUtils.isEmail(value!) ? emailReq.tr : null,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {},
                      onSaved: (value) {},
                    ),
                    AppConstant.spaceWidget(height: 10),
                    FormInputFieldWithIcon(
                      controller: authController.subjectController,
                      iconPrefix: Icons.subject_rounded,
                      labelText: subject.tr,
                      iconColor: kPrimaryColor,
                      autofocus: false,
                      textStyle: bodyText1,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                      GetUtils.isBlank(value!)! ? subjectReq.tr : null,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {},
                      onSaved: (value) {},
                    ),
                    AppConstant.spaceWidget(height: 10),
                    FormInputFieldWithIcon(
                      controller: authController.storeDescController,
                      iconPrefix: Icons.description,
                      labelText: message.tr,
                      iconColor: kPrimaryColor,
                      autofocus: false,
                      textStyle: bodyText1,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                      GetUtils.isBlank(value!)! ? messageReq.tr : null,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      onSaved: (value) {},
                    ),
                    AppConstant.spaceWidget(height: 20),
                    Obx(
                          () => authController.isLoading.isTrue
                          ? CustomLoading(isItBtn: true)
                          : CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await authController.postContactUs();
                          }
                        },
                        text: send.tr,
                        height: 40,
                        width: 150,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: getContactUsData().map((e) {
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
                  style: headline3,
                ),
                AppConstant.spaceWidget(height: 3),
                if (e['subTitle'] != null)
                  CustomText(
                    title: e['subTitle'],
                    style: bodyText1.copyWith(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                AppConstant.spaceWidget(height: 3),
                CustomText(
                  title: e['description'],
                  style: bodyText1.copyWith(
                    color: kDarkColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  List getData() {
    if (title!.contains(termsAndConditions.tr)) {
      print("$title");
      return getTermConditionData();
    } else if (title!.contains(privacyPolicy.tr))
      return getPrivacyData();
    else if (title!.contains(returnAndExchange.tr))
      return getReturnExchangeData();
    return getAboutUsData();
  }

  List getAboutUsData() {
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

  List getContactUsData() {
    return [
      {
        'icon': Icons.email_outlined,
        'title': 'Email',
        'subTitle': null,
        'description': 'businesses@ismmart.com'
      },
      {
        'icon': IconlyBold.calling,
        'title': "Call",
        'subTitle': null,
        'description': '+92 51 111 007 123\n+92 3329999969'
      },
      {
        'icon': IconlyLight.location,
        'title': 'Central Headquarters',
        'subTitle': ":",
        'description':
            '2nd Floor, Emirates Tower, M-13, F7 Markaz, Islamabad. Pakistan'
      },
      {
        'icon': IconlyLight.location,
        'title': 'Global Headquarters',
        'subTitle': ":",
        'description':
            'Tower 42, 25 Old Broad St, Cornhill, London, United Kingdom'
      }
    ];
  }

  List getPrivacyData() {
    String dot = "\u2022";
    return [
      {
        'header': '',
        'body': '\t\t\tISMMART Stores respect your privacy and want to protect your personal information. This privacy statement aims to explain to you how we handle the personal data that we get from users of our platform or site and the services made available on the site.'
            'This policy also outlines your options for how your personal information will be collected, used, and disclosed. You agree to the procedures outlined in this Privacy Policy if you access this platform or site directly or through another website. Please read this Privacy Policy for more information.'
            'ISMMART Stores collect your personal data so that we can offer and constantly improve our products and services.'
      },
      {
        'header': 'Use of Your Personal information',
        'body': '\t\t\tIn general, personal information you submit to us is used either to respond to requests that you make, aid us in serving you better, or market our services. We use your personal information in the following ways:'
            '\n\t$dot Take orders, deliver products, process payments, and communicate with you about orders, products and services, and promotional offerings. Update you on the delivery of the products;'
            '\n\t$dot Collect and use your personal information to comply with certain laws.'
            '\n\t$dot Operate, maintain, and improve our site, products, and services'
            '\n\t$dot Respond to comments and inquiries and provide customer service'
            '\n\t$dot Link or combine user information with other personal information we receive from third parties in order to better understand your needs and offer you better service'
            '\n\t$dot Develop, improve, and enhance marketing for products.'
            '\n\t$dot Identify you as a user in our system through your account/personal profile or other means.'
            '\n\t$dot Conduct automated decision-making processes in accordance with any of these purposes.'
            '\n\t$dot Verify and carry out financial transactions in relation to payments you make and audit the downloading of data from our site.'
            '\n\t\t\t We may store and process your personal information on servers located in various locations. We may also create anonymous data records from your personal information by completely excluding information that would otherwise make the data personally identifiable to you. We use this anonymous data to analyze request and usage patterns so that we may improve the content of our services and optimize site functionality.'
            '\n\t\t\t In addition to this, we reserve the right to share anonymous data with third parties and may use it for any purpose. Users who have had good experiences with our products and services may provide us with testimonials and remarks. We might publish such material. We may use our users’ first and last names to identify them when we post such content. Prior to publishing this data along with the testimonial, we will obtain the user’s consent.'
            '\n\t\t\t We will use this information for any other purpose to which your consent has been obtained; and to conduct automated decision-making processes in accordance with any of these purposes'
      },
      {'header': 'What data we collect and how we collect it?', 'body': ''},
      {
        'header': 'Information you provide:',
        'body':
            'ISMMART Stores receive and store data you give us through your account profile when using our services.'
      },
      {
        'header': 'Automatic information:',
        'body': 'When you use our services, we automatically gather and retain some types of information, including data on how you interact with the products, information, and services offered at ISMMART Stores.'
            'When your web browser or device accesses our website, we, like many other websites, utilise “cookies” and other unique identifiers to collect specific sorts of information.'
      },
      {
        'header': 'Information from other sources:',
        'body':
            'ISMMART Stores may obtain information about you from other sources. For example, our carriers may provide us with updated delivery and address data, which we utilise to update our records and make it simpler to deliver your subsequent purchases.'
      },
      {
        'header': 'General data:',
        'body':
            'Information will be automatically created when using our services. When you use our services, for instance, we may collect information about your general location, the kind of device you use, the Open Device Identification Number, the date and time of your visit, the unique device identifier, the type of browser you are using, the operating system, the Internet Protocol (IP) address, and the domain name. Generally speaking, we utilise this information to operate and enhance the site, as well as to ensure that you receive the most pertinent information possible.'
      },
      {
        'header': 'Profile data:',
        'body':
            'Your username and password, orders related to you, your interests, preferences, feedback and survey responses.'
      },
      {
        'header': 'Log files:',
        'body':
            'As is true of most websites, we gather certain information automatically and store it in log files. This information includes IP addresses, browser type, Internet service provider (ISP), referring/exit pages, operating system, date/time stamp, and click stream data. We use this information to maintain and improve the performance services.'
      },
      {
        'header': 'Analytics:',
        'body': 'To better understand how people interact with the website, we employ analytics services, such as but not restricted to Google Analytics. Cookies are used by analytics services to collect data such as how frequently users visit the site, and we utilise this data to enhance our services and website.'
            'The terms of use and privacy policies of the analytics services, which you should consult for further information about how these companies use this information, place limitations on how they can use and distribute the information they gather.'
      },
      {
        'header': 'Location information:',
        'body':
            'If you have enabled location services on your devices, we may collect your location information to improve the services we offer. If you do not want this information collected, you can disable location services on your device.'
      },
      {
        'header': 'Cookies:',
        'body': 'Cookies are small pieces of information that a website sends to your computer’s hard drive while you are viewing the website. These text files can be used by websites to make the users experience more efficient. We may store these cookies on your device if they are strictly necessary for the operation of this site. For all other types of cookies we need your permission. To that end, this site uses different types of cookies. Some cookies are placed by third party services that appear on our pages. We and some third parties may use both session Cookies (which expire once you close your web browser) and persistent Cookies (which stay on your computer until you delete them) to provide you with a more personal and interactive experience on our services and to market our products.'
            'Marketing cookies are used to track visitors across websites. The intention is to display ads that are relevant and engaging for the individual user and thereby more valuable for publishers and third party advertisers. This tracking is done on an anonymous basis.'
      },
      {
        'header': 'How secure is my information?',
        'body': 'We consider your security and privacy when designing our solutions. By utilising encryption protocols and software, we try to keep the security of your personal information throughout transmission.'
            'When handling credit/debit cards / bank details, we adhere to best industry practices and keep customer personal information secure using physical, electronic, and procedural measures.'
            'Because of our security measures, we can require you to prove your identity before giving you access to personal data.'
            'It is important for you to protect against unauthorized access to your password and to your computers, devices, and applications. We recommend using a unique password for your account that is not used for other online accounts. Be sure to sign off when finished using a shared computer.'
      },
      {
        'header': 'What information can I access?',
        'body':
            'You can access your information, including your name, address, payment options, profile information and purchase history in the account section.'
      },
      {
        'header': 'What information can I access?',
        'body':
            'You can access your information, including your name, address, payment options, profile information and purchase history in the account section.'
      },
      {
        'header': 'Changes to this Privacy Policy',
        'body': 'This Privacy Policy is effective as of 10th October 2022 and will remain in effect except with respect to any changes in its provisions in the future, which will be in effect immediately after being posted on this page.'
            'We reserve the right to update or change our Privacy Policy at any time and you should check this Privacy Policy periodically.'
            '\t Note: If you have any questions about this Privacy Policy, please contact us.'
      },
    ];
  }

  List getTermConditionData() {
    String dot = "\u2022";
    return [
      {
        'header': 'Introduction',
        'body':
            'Welcome to ISMMART Stores, also hereby known as “we” and “us”. These terms and conditions govern your access to and use of our online platform/site, as well as any associated websites, apps, services, or resources. You acknowledge that you have read, understand, and agree to the terms and conditions listed below before using the ISMMART Stores. These terms and conditions may be changed, modified, added, or removed at any moment without previous notice by ISMMART Stores. If no further notification is given, changes become effective when they are posted on the website.'
      },
      {
        'header': 'How the contract is formed between you and ISMMART Stores?',
        'body': '$dot After placing an order, you will receive online notification from us acknowledging that we have received your order. Please note that this does not mean that your order has been accepted. Your order constitutes an offer to us to buy a product. All orders are subject to acceptance by us. The contract will only be formed when you receive the products ordered via this platform.'
            '\n$dot The contract will relate only to those Products which you receive. A contract for any other products which may have been part of your order will be formed when you receive those other.'
      },
      {
        'header': 'Your account',
        'body': '$dot To access certain services offered by the platform, we may require that you create an account with us or provide personal information to complete the creation of an account.\n'
            '$dot You are responsible for maintaining the confidentiality of your user identification, password, account details and related private information. You acknowledge that you have this obligation to maintain the security of your account at all times and to take all reasonable precautions to prevent unauthorized use of your account. You should inform us immediately if you have any reason to believe that your password has become known to anyone else, or if the password is being, or is likely to be, used in an unauthorized manner. You understand and agree that any use of the website, any related services provided, and/or any access to confidential data, information, or communications made possible through the use of your account and password shall be deemed to have been made by you, or as the case may be, to have been made by someone authorized by you.\n'
            '$dot In case of breach or any serious violation of these terms and conditions, we reserve the right to invalidate the username and/or password after serving notice and providing reasonable time to rectify the same or make amends as per terms of this contract.'
      },
      {
        'header': 'Your status',
        'body': 'By placing an order through our site/platform, you warrant that:\n'
            '\t $dot you are legally capable of entering into binding contracts.\n'
            '\t $dot you are at least 18 years old.\n'
            '\t $dot you are not resident in a country where making a payment to our site, in line with these terms and conditions would breach any law.'
      },
      {
        'header': 'Delivery of Products',
        'body':
            'In the case of products, your order will be fulfilled/made ready for receipt (as applicable) within a reasonable time of the date indicated at the time of ordering, unless there are exceptional circumstances.'
      },
      {
        'header': 'Warranty',
        'body':
            'We warrant to you that any product purchased from us through our site will, on delivery, conform to its description, be of satisfactory quality, and be reasonably fit for all the purposes for which products of that kind are commonly supplied. All other warranties, conditions or terms relating to fitness for purpose, merchantability, satisfactory quality or condition whether implied by stature or common law are excluded in so far as permitted by law.'
      },
      {
        'header': 'Cancellation rights',
        'body': '$dot In the case of products, if you are contracting as a consumer, you have a right to cancel your product order for any reason and receive a full refund. You will receive a full refund of the price paid for the products (excluding shipping costs). Your right to cancel a contract relating to the purchase of a product starts from the date when you receive the Product (when the contract is formed). If the products have been delivered to you, you may cancel at any time as per the Return Policy. In the event that you received a product that is damaged on delivery then please inform us in writing as soon as possible. If a product is returned to us damaged and you have not informed us that the product was damaged when you received it then we may refuse your right to cancel or receive.\n'
            '$dot You will not have any right to cancel a contract for the supply of any made-to-order or personalized products, periodicals or magazines, perishable goods, or software, DVDs or CDs which have had their security seal opened.\n'
            '$dot In the case of products, to cancel a contract, you must inform us in writing. If the products have been delivered to you, you must also return the products to us as soon as reasonably practicable, and at your own cost. You have a legal obligation to take reasonable care of the products while they are in your hands.'
      },
      {
        'header': 'Transfer of rights and obligations',
        'body': '$dot We may transfer our rights and obligations under these terms and conditions to another organization, but that will not affect your rights or our obligations under the contract.\n'
            '$dot You may only transfer your rights and obligations under your contract with us if we agree to this in writing.'
      },
      {
        'header': 'Price',
        'body': '$dot Price of the products and our delivery charges will be as quoted on our platform/site from time to time, except in cases of obvious.\n'
            '$dot Product prices include GST/FED/VAT, where applicable. However, if the rate of GST/FED/VAT changes between the date of your order and the date of delivery, we will adjust the price accordingly.\n'
            'Product prices and delivery charges are liable to change at any time, but changes will not affect orders for products which you then take steps to fulfil/receive within a reasonable time.'
      },
      {
        'header': 'Refunds',
        'body':
            'If an order is cancelled in accordance with paragraph 6 above, then we will refund the amounts owed in accordance with our Refund Policy.'
      },
      {
        'header': 'How we use your information?',
        'body':
            'Please read the Privacy Policy for details on how we will use your information. By agreeing and accepting these terms and conditions you hereby agree and accept the terms of our Privacy Policy.'
      },
      {
        'header': 'Our liability to a Business',
        'body': '$dot If we fail to comply with these terms and conditions, we shall only be liable to you for the purchase price of the products and not any losses that you will suffer as a result of our failure to comply (whether arising in contract, delict (including negligence), breach of statutory duty or otherwise).\n'
            '$dot We will not be liable for losses that result from our failure to comply with these terms and conditions that fall into the following categories even if such losses were in our contemplation as at the date that the contract constituted by these terms and conditions was formed between us of being a foreseeable consequence of our breach.\n'
            '$dot loss of income or revenue.\n'
            '$dot loss of business. \n'
            '$dot loss of profits.\n'
            '$dot loss of anticipated savings \n'
            '$dot loss of data\n'
            '$dot waste of management or office\n'
            'Note: This paragraph does not apply if you are contracting as a consumer.'
      },
      {
        'header': 'Our liability to a Consumer',
        'body': '$dot If we fail to comply with these terms and conditions, we are responsible for loss or damage you suffer that is a foreseeable result of our breach of the terms and conditions or our negligence. Loss or damage is foreseeable if it was an obvious consequence of our breach or it was otherwise contemplated by you and us at the time we entered into the relevant. \n'
            '$dot We only supply the products to you for domestic and private use. You agree not to use the product for any commercial, business or re-sale purposes, and we have no liability to you for any loss of profit, loss of business, business interruption, or loss of business.\n'
            'Note: This paragraph does not apply if you are contracting as a business.'
      },
      {
        'header': 'Our contract with you if you are a Business',
        'body': '$dot These terms and conditions and any document expressly referred to in them constitute the whole agreement between us and supersede all previous discussions, correspondence, negotiations, previous arrangement, understanding or agreement between us relating to the subject matter hereof. \n'
            '$dot We each acknowledge that, in entering into a contract, neither of us relies on, or will have any remedies in respect of, any representation or warranty (whether made innocently or negligently) that is not set out in these terms and conditions or the documents referred to in, \n'
            '$dot Each of us agrees that our only liability in respect of those representations and warranties that are set out in this agreement (whether made innocently or negligently) will be for breach of. \n'
            '$dot Nothing in this paragraph limits or excludes any liability for\n'
            'Note: If you are contracting as a consumer, this paragraph does not apply.'
      },
      {
        'header': 'Our contract with you if you are a consumer',
        'body': 'f you are contracting as a consumer, we intend to rely upon these terms and conditions and any document expressly referred to in them in relation to the subject matter of any contract. While we accept responsibility for statements and representations made by our duly authorized agents, please make sure you ask for any variations from these terms and conditions to be confirmed in writing.'
            'Note: If you are contracting in the course of business, this paragraph does not apply.'
      },
      {
        'header': 'Notices',
        'body': '$dot Any notice to be sent by you or by us in connection with these terms and condition can be sent by letter or by email. Notices to us should be sent to one of the following addresses:\n'
            '\t\t$dot 2nd Floor, Emirates Tower, F7 Markaz, Islamabad.\n'
            '\t\t$dot Email: businesses@shaukatmarwatgroup.com\n'
            '\t\t$dot We will send notices to you by email to the email address that you supplied at the time of signing up to our platform\n'
            '\t\t$dot Either of us can change the address for notices by telling the other in writing the new address, but the previous address will continue to remain valid for 7 days after the change is made.'
      },
      {
        'header': 'Third party rights',
        'body':
            'A person who is not party to these terms and conditions or a contract shall not have any rights under or in connection with them.'
      },
      {
        'header': 'Waiver',
        'body':
            'The failure of either party to exercise or enforce any right conferred on that party by these terms and conditions shall not be deemed to be a waiver of any such right or operate to bar the exercise or enforcement thereof at any time or times thereafter. No waiver by us of any of these terms and conditions will be effective unless it is expressly stated to be a waiver and is communicated to you in writing in accordance with paragraph 16 above.'
      },
      {
        'header': 'Severability',
        'body':
            'If any court or competent authority decides that any of the provisions of these terms and conditions or any provisions of a contract are invalid, unlawful or unenforceable to any extent, the term will, to that extent only, be severed from the remaining terms, which will continue to be valid to the fullest extent permitted by law.'
      },
      {
        'header': 'Force Majeure',
        'body':
            'We reserve the right to defer the date of delivery or to cancel a contract for all circumstances beyond its reasonable control, including but not limited to any strike, lockout, disorder, fire, explosion, accident or stoppage of or affecting our business or work and which prevents or hinders the delivery of the goods or the performance of service.'
      },
      {
        'header': 'Law and jurisdiction',
        'body': '$dot These terms and conditions and any dispute or claim arising out of or in connection with them or their subject matter or formation (including non-contractual disputes or claims) will be governed by Pakistan law. You should understand that by ordering any of our product, you agree to be bound by these terms and conditions.\n'
            '\tCategories for Registration: 1- Basic Membership- Free of Cost: Can be registered as free members.\n'
            '\t\t$dot Cannot sell anything on ISMMART platform.\n'
            '\t\t$dot Will have only access to the products and stores to visit that are opened by default or kept opened by the Vendors & Businesses to visit.\n'
            '\t\t$dot They can buy anything at their own as a direct customers with mutual understanding with the seller; ISMMART will not be responsible or back up in case of any issues in such deal.\n'
            '\tPremium Membership – Paid Membership: \n'
            '\t\t$dot 5 USD per month with a free one month trial. Yearly subscription charges are 99.5 USD.\n'
            '\t\t$dot Can sell anything on ISMMART platform.\n'
            '\t\t$dot Will have access to all products and stores to visit.\n'
            '\t\t$dot All deals by Premium Members on ISMMART will be backed up by ISMMART. We will be responsible for smooth transactions and delivery of products. ISMMART will guarantee to honor the mutual understanding that both Seller and Buyer have agreed upon.\n'
            '\t\t$dot Premium Members will have worry less access to all businesses worldwide, both as a Seller & Buyer as ISMMART will be directly guaranteeing and verifying such members and any deals they do.\n'
            '\t\t$dot As all Premium Members are scrutinized and are verified through ISMMART verification process, so all such members can do worry less trade with each other, anywhere in the World.\n'
            '\t\t$dot Unlimited deliveries on eligible items.\n'
            '\n\t\t\tNote: All members (Sellers & Buyers) are requested to follow all trading rules and procedures mentioned by ISMMART to avoid any kind of inconvenience in payment or delivery. Commission Fee Structure Transaction value below PKR100,000/- ~ 0.5% Commission Transaction value above PKR100,000/- and below PKR250,00,00/- ~ 1.00% Commission Transaction value above PKR250,00,00/- but below PKR250,00,000/- ~ 1.75% Commission Transaction value above PKR250,00,000/- flat 2.25% Commission For any wholesale transaction a flat 3.5% Commission will be charged.\n'
            '\t\t\tNote: Transaction value excludes shipping and insurance cost.'
      },
    ];
  }

  List getReturnExchangeData() {
    String dot = "\u2022";
    return [
      {
        'header': '',
        'body': '\tCustomer satisfaction is guaranteed!! We guarantee the quality of the products sold through ISMMART Stores, and if you are not happy with your purchase, we will make it right. With the exception of a few conditions listed below, any item purchased from ISMMART Stores may be returned within 14 calendar days from the date shipment is received.'
            '$dot Discounted goods/products cannot be exchanged or returned for a refund. It can be exchanged or returned only if an obvious flaw is found.'
            '\n$dot Items being returned must be unworn, in its original packaging, with all safety seals and labels still intact/attached. The return will not be qualified for a refund or exchange if these conditions are not met'
            '\n$dot ISMMart Stores reserve the exclusive right/ authority to make exceptions in some circumstances.'
            '\n$dot If an item is returned due to obvious error that comes into our returns policy, customer will not be charged for courier services.'
            '\n$dot The return period for mobile phones, accessories, and other electrical and electronic products is only 5 calendar days beginning on the day the package is received. A replacement item will be given without charge if a flaw is found during the return window. Standard warranties from the manufacturer or supplier will be in effect after the return window has expired.'
      },
      {
        'header': 'How to return?',
        'body':
            'Please get in touch with our customer support centre if an item meets all the requirements specified above.'
      },
    ];
  }
}

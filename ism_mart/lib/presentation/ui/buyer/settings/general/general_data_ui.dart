import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

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
                                "${e['body'].toString()}",
                                softWrap: true,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
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
                          title: e['title'].toString(),
                          style: headline3,
                        ),
                        subtitle: CustomText(
                          title: e['description'].toString(),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Column(
                  children: [
                    StickyLabel(
                      text: langKey.forAnyQueryJust.tr,
                      style: headline1,
                    ),
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
      {'header': langKey.aboutHeader1.tr, 'body': langKey.aboutBody1.tr},
      {'header': langKey.aboutHeader2.tr, 'body': langKey.aboutBody2.tr},
      {'header': langKey.aboutHeader3.tr, 'body': langKey.aboutBody3.tr},
      {'header': langKey.aboutHeader4.tr, 'body': langKey.aboutBody4.tr},
      {'header': langKey.aboutHeader5.tr, 'body': langKey.aboutBody5.tr},
      {'header': langKey.aboutHeader6.tr, 'body': langKey.aboutBody6.tr},
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
    return [
      {'header': langKey.tCHeader1.tr, 'body': langKey.tCBody1.tr},
      {'header': langKey.tCHeader2.tr, 'body': langKey.tCBody2.tr},
      {'header': langKey.tCHeader3.tr, 'body': langKey.tCBody3.tr},
      {'header': langKey.tCHeader4.tr, 'body': langKey.tCBody4.tr},
      {'header': langKey.tCHeader5.tr, 'body': langKey.tCBody5.tr},
      {'header': langKey.tCHeader6.tr, 'body': langKey.tCBody6.tr},
      {'header': langKey.tCHeader7.tr, 'body': langKey.tCBody7.tr},
      {'header': langKey.tCHeader8.tr, 'body': langKey.tCBody8.tr},
      {'header': langKey.tCHeader9.tr, 'body': langKey.tCBody9.tr},
      {'header': langKey.tCHeader10.tr, 'body': langKey.tCBody10.tr},
      {'header': langKey.tCHeader11.tr, 'body': langKey.tCBody11.tr},
      {'header': langKey.tCHeader12.tr, 'body': langKey.tCBody12.tr},
      {'header': langKey.tCHeader13.tr, 'body': langKey.tCBody13.tr},
      {'header': langKey.tCHeader14.tr, 'body': langKey.tCBody14.tr},
      {'header': langKey.tCHeader15.tr, 'body': langKey.tCBody15.tr},
      {'header': langKey.tCHeader16.tr, 'body': langKey.tCBody16.tr},
      {'header': langKey.tCHeader17.tr, 'body': langKey.tCBody17.tr},
      {'header': langKey.tCHeader18.tr, 'body': langKey.tCBody18.tr},
      {'header': langKey.tCHeader19.tr, 'body': langKey.tCBody19.tr},
      {'header': langKey.tCHeader20.tr, 'body': langKey.tCBody20.tr},
      {'header': langKey.tCHeader21.tr, 'body': langKey.tCBody21.tr},
      {'header': '', 'body': ''},
    ];
  }

  /*
These terms and conditions and any dispute or claim arising out of or in connection with them or their subject matter or formation (including non-contractual disputes or claims) will be governed by Pakistan law. You should understand that by ordering any of our product, you agree to be bound by these terms and conditions.
Categories for Registration:
  1- Basic Membership- Free of Cost: Can be registered as free members.
    • Cannot sell anything on ISMMART platform.
    • Will have only access to the products and stores to visit that are opened by default or kept opened by the Vendors & Businesses to visit.
    • They can buy anything at their own as a direct customers with mutual understanding with the seller; ISMMART will not be responsible or back up in case of any issues in such deal.
  2- Premium Membership – Paid Membership:
    • 5 USD per month with a free one month trial. Yearly subscription charges are 99.5 USD.
    • Can sell anything on ISMMART platform.
    • Will have access to all products and stores to visit.
    • All deals by Premium Members on ISMMART will be backed up by ISMMART. We will be responsible for smooth transactions and delivery of products. ISMMART will guarantee to honor the mutual understanding that both Seller and Buyer have agreed upon.
    • Premium Members will have worry less access to all businesses worldwide, both as a Seller & Buyer as ISMMART will be directly guaranteeing and verifying such members and any deals they do.
    • As all Premium Members are scrutinized and are verified through ISMMART verification process, so all such members can do worry less trade with each other, anywhere in the World.
    • Unlimited deliveries on eligible items.\n'
Note: All members (Sellers & Buyers) are requested to follow all trading rules and procedures mentioned by ISMMART to avoid any kind of inconvenience in payment or delivery. Commission Fee Structure Transaction value below PKR100,000/- ~ 0.5% Commission Transaction value above PKR100,000/- and below PKR250,00,00/- ~ 1.00% Commission Transaction value above PKR250,00,00/- but below PKR250,00,000/- ~ 1.75% Commission Transaction value above PKR250,00,000/- flat 2.25% Commission For any wholesale transaction a flat 3.5% Commission will be charged.
Note: Transaction value excludes shipping and insurance cost.
   */

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

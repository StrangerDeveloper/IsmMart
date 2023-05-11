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
        'title': langKey.email.tr,
        'subTitle': null,
        'description': 'businesses@ismmart.com'
      },
      {
        'icon': IconlyBold.calling,
        'title': langKey.call.tr,
        'subTitle': null,
        'description': '+92 51 111 007 123\n+92 3329999969'
      },
      {
        'icon': IconlyLight.location,
        'title': langKey.centralHeadquarters.tr,
        'subTitle': ":",
        'description': langKey.centralHeadquartersValue.tr
      },
      {
        'icon': IconlyLight.location,
        'title': langKey.globalHeadquarters.tr,
        'subTitle': ":",
        'description': langKey.globalHeadquartersValue.tr
      }
    ];
  }

  List getPrivacyData() {
    //String dot = "\u2022";
    return [
      {'header': langKey.privacyHeader1.tr, 'body': langKey.privacyBody1.tr},
      {'header': langKey.privacyHeader2.tr, 'body': langKey.privacyBody2.tr},
      {'header': langKey.privacyHeader3.tr, 'body': langKey.privacyBody3.tr},
      {'header': langKey.privacyHeader4.tr, 'body': langKey.privacyBody4.tr},
      {'header': langKey.privacyHeader5.tr, 'body': langKey.privacyBody5.tr},
      {'header': langKey.privacyHeader6.tr, 'body': langKey.privacyBody6.tr},
      {'header': langKey.privacyHeader7.tr, 'body': langKey.privacyBody7.tr},
      {'header': langKey.privacyHeader8.tr, 'body': langKey.privacyBody8.tr},
      {'header': langKey.privacyHeader9.tr, 'body': langKey.privacyBody9.tr},
      {'header': langKey.privacyHeader10.tr, 'body': langKey.privacyBody10.tr},
      {'header': langKey.privacyHeader11.tr, 'body': langKey.privacyBody11.tr},
      {'header': langKey.privacyHeader12.tr, 'body': langKey.privacyBody12.tr},
      {'header': langKey.privacyHeader13.tr, 'body': langKey.privacyBody13.tr},
      {'header': langKey.privacyHeader14.tr, 'body': langKey.privacyBody14.tr},
      {'header': langKey.privacyHeader15.tr, 'body': langKey.privacyBody15.tr},
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
    //String dot = "\u2022";
    return [
      {
        'header': langKey.exchangeHeader1.tr,
        'body': langKey.exchangeBody1,
      },
      {
        'header': langKey.exchangeHeader2.tr,
        'body': langKey.exchangeBody2,
      },
    ];
  }
}

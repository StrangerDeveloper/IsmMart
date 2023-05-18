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
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
              child: Text(
                title!,
                style: headline1.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (isContactUsCalled!)
              _buildContactUs()
            else
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 5, 22, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getData().map((e) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppConstant.spaceWidget(height: 15),
                        if (e['header'] != '')
                          CustomText(
                            title: "${e['header']}",
                            style: headline2,
                          ),
                        if (e['header'] != '') Divider(),
                        if (e['body'].toString().isNotEmpty)
                          Text(
                            "${e['body'].toString()}",
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              color: kDarkColor,
                              height: 1.7,
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
          ],
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
              //autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      validator: (value) => Validator().name(value),
                      // GetUtils.isBlank(value!)! ? fullNameReq.tr : null,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return emailReq.tr;
                        }
                        return Validator().email(value);
                      },
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
                                  formKey.currentState!.reset();
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
    ];
  }

  List getReturnExchangeData() {
    //String dot = "\u2022";
    return [
      {
        'header': langKey.exchangeHeader1.tr,
        'body': langKey.exchangeBody1.tr,
      },
      {
        'header': langKey.exchangeHeader2.tr,
        'body': langKey.exchangeBody2.tr,
      },
    ];
  }
}

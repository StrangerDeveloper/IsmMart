import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/setting/settings_viewmodel.dart';
import 'package:ism_mart/widgets/custom_sliver_appbar.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);
  final SettingViewModel viewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CustomSliverAppBar(
              expandedHeight: 100.0,
              elevation: 0,
              floating: false,
              pinned: true,
              leading: Container(),
              flexibleSpaceBar: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                title: Text(
                  langKey.settings.tr,
                  style: appBarTitleSize,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _accountSetup(),
            SizedBox(height: 15),
            generalSettings(),
          ],
        ),
      ),
    );
  }

  Widget _accountSetup() {
    return Obx(
      () => viewModel.userDetails.value?.email == null &&
              viewModel.userDetails.value?.token == null
              // authController.isSessionExpired!
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5, top: 20),
                    child: CustomText(
                      title: langKey.account.tr,
                      size: 16,
                    ),
                  ),
                  _account(),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _userCard(),
                verifyEmailLabel(),
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 5),
                  child: CustomText(
                    title: langKey.myAccount.tr,
                    size: 16,
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => viewModel.userDetails.value?.token == null
                      ? Container()
                      : _accountSettings(),
                )
              ],
            ),
    );
  }

  Widget _userCard() {
    return Obx(
      () => viewModel.userDetails.value?.email == null
          ? Container()
          : ListTile(
              visualDensity: VisualDensity.compact,
              onTap: () {
                Get.toNamed(Routes.buyerProfile);
              },
              contentPadding: EdgeInsets.only(left: 30, right: 25),
              trailing: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  Icons.mode_edit_outlined,
                  color: Colors.black,
                  size: 18,
                ),
              ),
              title: CustomText(
                title:
                    "${langKey.welcome.tr} ${viewModel.userDetails.value?.firstName}",
                style: headline2,
              ),
              subtitle: CustomText(
                title: "${viewModel.userDetails.value?.email}",
                style: bodyText1,
              ),
            ),
    );
  }

  Widget verifyEmailLabel() {
    return Obx(
      () => viewModel.userDetails.value?.emailVerified == false
          ? Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () async {
                    await viewModel.emailVerificationCheck();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, bottom: 10, top: 10, right: 10),
                    child: Text(
                      langKey.verifyEmail.tr,
                      style: bodyText1.copyWith(
                        decoration: TextDecoration.underline,
                        color: kRedColor,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : SizedBox(),
    );
  }

  Widget _account() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          Get.toNamed(Routes.loginRoute);
        },
        leading: const Icon(
          IconlyBold.profile,
          size: 30,
        ),
        title: Text(
          "${langKey.signIn.tr} / ${langKey.signUp.tr}",
          style: bodyText1.copyWith(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _accountSettings() {
    return Column(
      children: [
        singleSettingsItem(
          onTap: () async {
            if (viewModel.checkVendorAccountStatus()!) {
              if (viewModel.userDetails.value?.vendor?.status == 'pending') {
                Get.toNamed(Routes.vendorSignUp4, arguments: {
                  'fromSettings': true,
                });
              } else if (viewModel.userDetails.value?.vendor?.status ==
                  'false') {
                Get.toNamed(Routes.chooseEmail);
              } else if (viewModel.userDetails.value?.vendor?.status ==
                  'approved') {
                Get.toNamed(Routes.sellerHomeRoute);
              }
            } else {
              AppConstant.displaySnackBar(
                langKey.errorTitle.tr,
                langKey.youStoreHas.tr,
              );
            }
          },
          icon: Icons.dashboard_rounded,
          color: kPrimaryColor,
          title: langKey.vendorDashboard.tr,
        ),
        singleSettingsItem(
          onTap: () {
            //Get.to(() => BuyerOrderView());
            Get.toNamed(Routes.buyerOrdersRoute);
          },
          icon: IconlyBold.bag,
          color: Colors.teal,
          title: langKey.userOrders.tr,
        ),
      ],
    );
  }

  Widget generalSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, bottom: 8, right: 32),
          child: CustomText(
            title: langKey.general.tr,
            size: 16,
          ),
        ),
        singleSettingsItem(
          onTap: () {
            //_showCurrencyChangeBS();
          },
          icon: Icons.currency_exchange,
          color: Color.fromARGB(255, 160, 235, 94),
          title: langKey.currencyKey.tr,
          value: currencyController.currency.value,
          countryCode: currencyController.countryCode.value,
        ),
        Obx(
          () => singleSettingsItem(
            onTap: () {
              showLanguageBottomSheet();
            },
            icon: Icons.language,
            color: Colors.orange,
            title: langKey.language.tr,
            value: languageController.language.value,
            countryCode: languageController.countryKey.value,
          ),
        ),
        singleSettingsItem(
          onTap: () {
            Get.toNamed(Routes.staticInfo,
                arguments: {'title': langKey.termsAndConditions.tr});
          },
          icon: Icons.rule_outlined,
          color: Colors.indigo,
          title: langKey.termsAndConditions.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.toNamed(
              Routes.staticInfo,
              arguments: {'title': langKey.privacyPolicy.tr},
            );
          },
          icon: IconlyLight.paper,
          color: Colors.purpleAccent,
          title: langKey.privacyPolicy.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.toNamed(
              Routes.staticInfo,
              arguments: {'title': langKey.returnAndExchange.tr},
            );
          },
          icon: Icons.assignment_return_rounded,
          color: Colors.lime,
          title: langKey.returnAndExchange.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.toNamed(
              Routes.staticInfo,
              arguments: {'title': langKey.aboutUs.tr},
            );
          },
          icon: IconlyLight.info_circle,
          color: Colors.pinkAccent,
          title: langKey.aboutUs.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.toNamed(Routes.contactUs);
          },
          icon: Icons.contactless_outlined,
          color: Colors.green,
          title: langKey.contactUs.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.toNamed(Routes.faq);
          },
          icon: Icons.question_answer,
          color: Colors.purple,
          title: langKey.faqs.tr,
        ),
        singleSettingsItem(
          onTap: () {
            viewModel.whatsapp();
          },
          isIcon: false,
          svgIcons: 'assets/svg/whatsapp.svg',
          color: Color(0xff25D366),
          title: langKey.helpCenter.tr,
        ),
        singleSettingsItem(
            onTap: (){
              Get.toNamed(Routes.chatScreen);
              },
            color: Color(0xff70d2f9),
            isIcon: true,
            icon: Icons.chat_outlined,
            title: 'ISMBot'
        ),
        Obx(
          () => viewModel.userDetails.value?.email != null &&
                  viewModel.userDetails.value?.token != null
              // && !authController.isSessionExpired!
              ? singleSettingsItem(
                  onTap: () async {
                    await LocalStorageHelper.deleteUserData();
                    viewModel.userDetails.value = UserModel();
                  },
                  icon: IconlyLight.logout,
                  color: Colors.red,
                  title: langKey.logout.tr,
                )
              : Container(),
        ),
      ],
    );
  }

  showLanguageBottomSheet() {
    AppConstant.showBottomSheet(
      widget: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    langKey.selectLanguage.tr,
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Divider(),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: languageController.optionsLocales.entries.map((item) {
                  return ListTile(
                    onTap: () {
                      languageController.setLanguage(key: item.key);
                      Get.back();
                    },
                    leading: countryFlag(
                      countryCode: item.value['countryCode'],
                      color: item.value['color'],
                    ),
                    title: Text(
                      item.value["description"],
                      style: bodyText1.copyWith(fontWeight: FontWeight.w600),
                    ),
                    trailing: item.value["description"] ==
                            languageController.language.value
                        ? const Icon(Icons.done)
                        : null,
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  // _showCurrencyChangeBS() {
  //   AppConstant.showBottomSheet(
  //     widget: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 5),
  //                 child: Text(
  //                   langKey.selectCurrency.tr,
  //                   style: GoogleFonts.lato(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //               ),
  //               IconButton(
  //                 visualDensity: VisualDensity.compact,
  //                 onPressed: () {
  //                   Get.back();
  //                 },
  //                 icon: Icon(Icons.close),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8),
  //           child: Divider(),
  //         ),
  //         Expanded(
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children:
  //               currencyController.currencyLocales.entries.map((item) {
  //                 return ListTile(
  //                   visualDensity: VisualDensity.compact,
  //                   onTap: () {
  //                     currencyController.setCurrency(key: item.key);
  //                     Get.back();
  //                   },
  //                   leading: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       countryFlag(
  //                           countryCode: item.value['countryCode'],
  //                           color: item.value['color']),
  //                     ],
  //                   ),
  //                   title: Text(item.value["description"],
  //                       style: bodyText1.copyWith(fontWeight: FontWeight.w600)),
  //                   subtitle: CustomText(
  //                     title: item.value["longDesc"],
  //                     color: kLightColor,
  //                     size: 11,
  //                   ),
  //                   trailing: item.value["description"] ==
  //                       currencyController.currency.value
  //                       ? const Icon(Icons.done)
  //                       : null,
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  InkWell singleSettingsItem({
    bool isIcon = true,
    String? svgIcons,
    required onTap,
    IconData? icon,
    required Color color,
    required String title,
    value,
    countryCode,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: isIcon
                  ? Icon(
                      icon,
                      size: 25,
                      color: color,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        svgIcons!,
                        //color: color,
                      ),
                    ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 4,
              child: CustomText(
                title: title,
                size: 14,
                weight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                if (countryCode != null && countryCode != "")
                  countryFlag(
                    countryCode: countryCode,
                    height: 15,
                    width: 25,
                  ),
                if (value != null && value != "")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CustomText(
                      title: value.toString().capitalizeFirst!,
                      style: caption.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container countryFlag({
    String? countryCode,
    Color? color = Colors.amber,
    double? height = 20,
    double? width = 30,
  }) {
    var imageUrl =
        "https://raw.githubusercontent.com/hampusborgos/country-flags/main/png1000px/${countryCode!.toLowerCase()}.png";
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color!.withOpacity(0.3),
        border: Border.all(color: Colors.grey),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}

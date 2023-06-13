import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/screens/buyer_profile/buyer_profile_view.dart';
import 'package:ism_mart/screens/contact_us/contact_us_view.dart';
import 'package:ism_mart/screens/setting/settings_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../update_vendor/update_vendor_view.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);
  final SettingViewModel viewModel = Get.put(SettingViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 100.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: kAppBarColor,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding:
                    const EdgeInsets.symmetric(horizontal: 16),
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

  _accountSetup() {
    return Obx(() => viewModel.userDetails.value?.email == null &&
        viewModel.userDetails.value?.token == null
        ?  Padding(
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
      ) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _userCard(),
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 5),
          child: CustomText(
            title: langKey.myAccount.tr,
            size: 16,
          ),
        ),
        SizedBox(height: 10),
        Obx(() => viewModel.userDetails.value?.token == null ? Container(): _accountSettings())
      ],
    )
    );
  }

  _userCard() {
    return Obx(() => viewModel.userDetails.value?.email == null
          ? Container()
          : Padding(
        padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
        child: ListTile(
          trailing: viewModel.userDetails.value?.emailVerified == true
              ? null
              : InkWell(
            onTap: () async {
              await viewModel.emailVerificationCheck();
            },
            child: Text(
              langKey.verifyEmail.tr,
              style: bodyText1.copyWith(
                  decoration: TextDecoration.underline),
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
      ),
    );
  }

  Container _account() {
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

  Column _accountSettings() {
    return Column(
      children: [
        singleSettingsItem(
          onTap: ()async {
            if (viewModel.checkVendorAccountStatus()!) {
              if (viewModel.userDetails.value!.role!.toLowerCase().contains("vendor")) {
                Get.toNamed(Routes.sellerHomeRoute);
                // authController.newAcc.value = false;
              } else {
                Get.to(() => UpdateVendorView(),
                    arguments: {'isRegisterScreen': true});
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
        singleSettingsItem(
          onTap: () {
            Get.to(() => BuyerProfileView());
          },
          icon: IconlyBold.user_2,
          color: Colors.pink,
          title: 'Buyer Profile',
        ), /* _singleSettingsItem(
            onTap: () => Get.to(() => PremiumMembershipUI()),
            icon: Icons.workspace_premium_outlined,
            iconColor: kOrangeColor,
            title: langKey.membershipPlans.tr),*/
      ],
    );
  }

  Column generalSettings() {
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
        Obx(() => singleSettingsItem(
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
        /*_singleSettingsItem(
            onTap: () => Get.to(() => NotificationUI()),
            icon: IconlyLight.notification,
            iconColor: Colors.lightBlue,
            title: langKey.notifications.tr,),*/
        singleSettingsItem(
          onTap: () {
            Get.to(() =>
                GeneralSettingsView(title: langKey.termsAndConditions.tr));
          },
          icon: Icons.rule_outlined,
          color: Colors.indigo,
          title: langKey.termsAndConditions.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.to(() => GeneralSettingsView(title: langKey.privacyPolicy.tr));
          },
          icon: IconlyLight.paper,
          color: Colors.purpleAccent,
          title: langKey.privacyPolicy.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.to(() => GeneralSettingsView(title: langKey.returnAndExchange.tr));
          },
          icon: Icons.assignment_return_rounded,
          color: Colors.lime,
          title: langKey.returnAndExchange.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.to(() => GeneralSettingsView(title: langKey.aboutUs.tr));
          },
          icon: IconlyLight.info_circle,
          color: Colors.pinkAccent,
          title: langKey.aboutUs.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.to(() => ContactUsView());
          },
          icon: Icons.contactless_outlined,
          color: Colors.green,
          title: langKey.contactUs.tr,
        ),
        singleSettingsItem(
          onTap: () {
            Get.to(() => FaqView());
          },
          icon: Icons.question_answer,
          color: Colors.purple,
          title: langKey.faqs.tr,
        ),
        Obx(() => viewModel.userDetails.value?.email != null &&
            viewModel.userDetails.value?.token != null
              ? singleSettingsItem(
            onTap: () async {
              await LocalStorageHelper.deleteUserData();
              viewModel.userDetails.value = UserModel();
            },
            icon: IconlyLight.logout,
            color: Colors.red,
            title: langKey.logout.tr,
          ) : Container(),
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

  _showCurrencyChangeBS() {
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
                    langKey.selectCurrency.tr,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children:
                currencyController.currencyLocales.entries.map((item) {
                  return ListTile(
                    visualDensity: VisualDensity.compact,
                    onTap: () {
                      currencyController.setCurrency(key: item.key);
                      Get.back();
                    },
                    leading: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        countryFlag(
                            countryCode: item.value['countryCode'],
                            color: item.value['color']),
                      ],
                    ),
                    title: Text(item.value["description"],
                        style: bodyText1.copyWith(fontWeight: FontWeight.w600)),
                    subtitle: CustomText(
                      title: item.value["longDesc"],
                      color: kLightColor,
                      size: 11,
                    ),
                    trailing: item.value["description"] ==
                        currencyController.currency.value
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

  InkWell singleSettingsItem({
    required onTap,
    required IconData icon,
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
              child: Icon(
                icon,
                size: 25,
                color: color,
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
                      title: value.toString().capitalizeFirst,
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

/*_showThemeChangeBottomSheet() {
    var listThemeItems = [
      {
        "icon": Icons.light_mode,
        "iconColor": Colors.blue,
        "title": "Light",
        "isSelected": true,
      },
      {
        "icon": Icons.nightlight,
        "iconColor": Colors.deepOrangeAccent,
        "title": "Dark",
        "isSelected": false,
      },
      {
        "icon": IconlyLight.setting,
        "iconColor": Colors.purple,
        "title": "System",
        "isSelected": false,
      }
    ];
    AppConstant.showBottomSheet(
      widget: SizedBox(
        height: MediaQuery.of(Get.context!).size.height / 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const StickyLabel(
                text: "Select Theme",
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listThemeItems.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var model = listThemeItems[index];
                  return _itemsTheme(model: model);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }*/

/*_itemsTheme({model}) {
    return ListTile(
      onTap: () {
        model["isSelected"] = !model["isSelected"];
        themeController.setTheme(model["title"].toString().toLowerCase());
        //languageController.setLanguage();

      },
      leading: Icon(model["icon"], size: 25, color: model["iconColor"]),
      title: Text(model["title"],
          style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600)),
      trailing: model["isSelected"] ? const Icon(Icons.done) : null,
    );
  }*/
}
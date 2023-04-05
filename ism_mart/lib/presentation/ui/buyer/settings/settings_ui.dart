import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SettingsUI extends GetView<AuthController> {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var authController = Get.find<AuthController>();
    return Obx(
      () => SafeArea(
        child: controller.isLoading.isTrue
            ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
            : NestedScrollView(
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
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _accountSetup(context),
                      AppConstant.spaceWidget(height: 10),
                      const StickyLabel(text: langKey.general),
                      _generalSettings(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _accountSetup(context) {
    return Obx(
      () => controller.userModel!.email != null &&
              !controller.isSessionExpired! &&
              controller.userToken != null
          ? Column(
              children: [
                _userCard(),
                const StickyLabel(text: langKey.myAccount),
                _accountSettings(buildContext: context)
              ],
            )
          : Column(
              children: [
                const StickyLabel(text: langKey.account),
                _account(),
              ],
            ),
    );
  }

  _userCard() {
    return Obx(
      () => controller.userModel!.email == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: CustomText(
                  title:
                      "${langKey.welcome.tr} ${controller.userModel!.firstName}",
                  style: headline2,
                ),
                subtitle: CustomText(
                  title: "${controller.userModel!.email}",
                  style: bodyText1,
                ),
              ),
            ),
    );
  }

  _account() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300]!,
        ),
        child: ListTile(
          onTap: () {
            Get.toNamed(Routes.loginRoute);
            //Get.to(()=> const SignInUI());
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
      ),
    );
  }

  _accountSettings({buildContext}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _singleSettingsItem(
              onTap: () {
                if (checkVendorAccountStatus(controller.userModel?.vendor)!) {
                  if (controller.userModel!.role!
                      .toLowerCase()
                      .contains("vendor")) {
                    Get.toNamed(Routes.sellerHomeRoute);
                  } else {
                    //Get.toNamed(Routes.sellerHomeRoute);
                    AppConstant.showBottomSheet(
                        widget: RegisterVendorUI(),
                        isGetXBottomSheet: false,
                        buildContext: buildContext);
                  }
                } else {
                  AppConstant.displaySnackBar(
                      'error', "Your store has been disabled");
                }
              },
              icon: Icons.dashboard_rounded,
              iconColor: kPrimaryColor,
              title: langKey.vendorDashboard.tr),
          _singleSettingsItem(
              onTap: () => Get.toNamed(Routes.buyerOrdersRoute),
              icon: IconlyBold.bag,
              iconColor: Colors.teal,
              title: langKey.userOrders.tr),
          /* _singleSettingsItem(
              onTap: () => Get.to(() => PremiumMembershipUI()),
              icon: Icons.workspace_premium_outlined,
              iconColor: kOrangeColor,
              title: langKey.membershipPlans.tr),*/
        ],
      ),
    );
  }

  bool? checkVendorAccountStatus(SellerModel? model) {
    String? status = model!.status!.toLowerCase();
    if (status.contains("disabled") ||
        status.contains("terminated") ||
        status.contains("suspended")) return false;
    return true;
  }

  _generalSettings() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          /* _singleSettingsItem(
              onTap: () => _showThemeChangeBottomSheet(),
              icon: IconlyLight.setting,
              iconColor: Colors.deepPurple,
              title: "appearance".tr,
              value: themeController.theme.value),*/

          Obx(
            () => _singleSettingsItem(
                onTap: () => _showLanguageChangeBottomSheet(),
                icon: Icons.language,
                iconColor: Colors.orange,
                title: langKey.language.tr,
                value: languageController.language.value),
          ),
          /*_singleSettingsItem(
              onTap: () => Get.to(() => NotificationUI()),
              icon: IconlyLight.notification,
              iconColor: Colors.lightBlue,
              title: langKey.notifications.tr),*/

          _singleSettingsItem(
              onTap: () => Get.to(() =>
                  GeneralSettingsDataUI(title: langKey.termsAndConditions.tr)),
              icon: Icons.rule_outlined,
              iconColor: Colors.indigo,
              title: langKey.termsAndConditions.tr),
          _singleSettingsItem(
              onTap: () => Get.to(
                  () => GeneralSettingsDataUI(title: langKey.privacyPolicy.tr)),
              icon: IconlyLight.paper,
              iconColor: Colors.purpleAccent,
              title: langKey.privacyPolicy.tr),
          _singleSettingsItem(
              onTap: () => Get.to(() =>
                  GeneralSettingsDataUI(title: langKey.returnAndExchange.tr)),
              icon: Icons.assignment_return_rounded,
              iconColor: Colors.lime,
              title: langKey.returnAndExchange.tr),
          _singleSettingsItem(
              onTap: () => Get.to(
                  () => GeneralSettingsDataUI(title: langKey.aboutUs.tr)),
              icon: IconlyLight.info_circle,
              iconColor: Colors.pinkAccent,
              title: langKey.aboutUs.tr),
          _singleSettingsItem(
              onTap: () => Get.to(() => GeneralSettingsDataUI(
                  isContactUsCalled: true, title: langKey.contactUs.tr)),
              icon: Icons.contactless_outlined,
              iconColor: Colors.green,
              title: langKey.contactUs.tr),
          _singleSettingsItem(
              onTap: () => Get.to(() => FaqUI()),
              icon: Icons.question_answer,
              iconColor: Colors.purple,
              title: langKey.faqs.tr),
          Obx(() => controller.userModel!.email != null &&
                  !controller.isSessionExpired! &&
                  controller.userToken != null
              ? _singleSettingsItem(
                  onTap: () {
                    LocalStorageHelper.deleteUserData();
                    controller.update();
                    authController.update();
                  },
                  icon: IconlyLight.logout,
                  iconColor: Colors.red,
                  title: langKey.logout.tr)
              : Container()),
        ],
      ),
    );
  }

  _singleSettingsItem({required onTap, icon, iconColor, title, value}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 25,
                color: iconColor,
              ),
            ),
            AppConstant.spaceWidget(width: 10),
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
                if (value != null && value != "")
                  CustomText(
                      title: value,
                      style: caption.copyWith(fontWeight: FontWeight.w600)),
                AppConstant.spaceWidget(width: 5),
                const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.black)),
              ],
            )
          ],
        ),
      ),
    );
  }

  _showLanguageChangeBottomSheet() {
    AppConstant.showBottomSheet(
      widget: SizedBox(
        //height: MediaQuery.of(Get.context!).size.height / 2.5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StickyLabel(
                text: langKey.selectLanguage.tr,
              ),
              Column(
                children: languageController.optionsLocales.entries.map((item) {
                  return ListTile(
                    onTap: () {
                      languageController.setLanguage(key: item.key);
                      Get.back();
                    },
                    leading: _countryFlag(
                        countryCode: item.value['countryCode'],
                        color: item.value['color']),
                    title: Text(item.value["description"],
                        style: bodyText1.copyWith(fontWeight: FontWeight.w600)),
                    trailing: item.value["description"] ==
                            languageController.language.value
                        ? const Icon(Icons.done)
                        : null,
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _countryFlag({String? countryCode, Color? color}) {
    var imageUrl =
        "https://raw.githubusercontent.com/hampusborgos/country-flags/main/png1000px/${countryCode!.toLowerCase()}.png";
    return Container(
      height: 45,
      width: 45,
      padding: EdgeInsets.all(8),
      // Border width
      decoration: BoxDecoration(
        color: color!.withOpacity(0.3),
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(imageUrl),
        ),
      ),
      /* child: SvgPicture.network(
        "https://flagicons.lipis.dev/flags/4x3/${countryCode.toLowerCase()}.svg",
        width: 40,
        height: 40,
      ),*/
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

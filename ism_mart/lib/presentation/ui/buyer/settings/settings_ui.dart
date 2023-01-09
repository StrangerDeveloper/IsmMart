import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

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
                          'settings'.tr,
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
                      _accountSetup(),
                      AppConstant.spaceWidget(height: 10),
                      const StickyLabel(text: "general"),
                      _generalSettings(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _accountSetup() {
    return Obx(
      () => controller.userModel!.email != null &&
              !controller.isSessionExpired! &&
              controller.userToken != null
          ? Column(
              children: [
                _userCard(),
                const StickyLabel(text: "my_account"),
                _accountSettings()
              ],
            )
          : Column(
              children: [
                const StickyLabel(text: "account"),
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
                  title: "${"welcome".tr} ${controller.userModel!.firstName}",
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
            "${"login".tr} / ${"register".tr}",
            style: bodyText1.copyWith(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  _accountSettings() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _singleSettingsItem(
              onTap: () {
                if (controller.userModel!.role != null) {
                  if (controller.userModel!.role!
                      .toLowerCase()
                      .contains("vendor")) {
                    Get.toNamed(Routes.sellerHomeRoute);
                  } else {
                    AppConstant.showBottomSheet(widget: _registerSeller());
                  }
                }
              },
              icon: Icons.dashboard_rounded,
              iconColor: kPrimaryColor,
              title: "vendor_dashboard".tr),
          /* _singleSettingsItem(
              onTap: () => Get.toNamed(Routes.buyerOrdersRoute),
              icon: IconlyBold.bag,
              iconColor: Colors.purpleAccent,
              title: "my_orders".tr),*/
          _singleSettingsItem(
              onTap: () => Get.to(() => PremiumMembershipUI()),
              icon: Icons.workspace_premium_outlined,
              iconColor: kOrangeColor,
              title: "membership_plans".tr),
        ],
      ),
    );
  }

  _registerSeller() {
    var formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomText(
              title: "vendor_registration".tr,
              style: appBarTitleSize,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  FormInputFieldWithIcon(
                    controller: controller.ownerNameController,
                    iconPrefix: Icons.store_rounded,
                    labelText: 'owner_name'.tr,
                    iconColor: kPrimaryColor,
                    autofocus: false,
                    textStyle: bodyText1,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => GetUtils.isBlank(value!)!
                        ? "owner_name_required".tr
                        : null,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {},
                    onSaved: (value) {},
                  ),
                  AppConstant.spaceWidget(height: 15),
                  FormInputFieldWithIcon(
                    controller: controller.storeNameController,
                    iconPrefix: Icons.store_rounded,
                    labelText: 'store_name'.tr,
                    iconColor: kPrimaryColor,
                    autofocus: false,
                    textStyle: bodyText1,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => GetUtils.isBlank(value!)!
                        ? "store_name_required!".tr
                        : null,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {},
                    onSaved: (value) {},
                  ),
                  AppConstant.spaceWidget(height: 15),
                  FormInputFieldWithIcon(
                    controller: controller.storeDescController,
                    iconPrefix: Icons.description,
                    labelText: 'description'.tr,
                    iconColor: kPrimaryColor,
                    autofocus: false,
                    textStyle: bodyText1,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => GetUtils.isBlank(value!)!
                        ? "description_required".tr
                        : null,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {},
                    onSaved: (value) {},
                  ),
                  AppConstant.spaceWidget(height: 40),
                  Obx(() => controller.isLoading.isTrue
                      ? CustomLoading(isItBtn: true)
                      : CustomButton(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await controller.registerStore();
                            }
                          },
                          text: "register".tr,
                          height: 40,
                          width: 150,
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                title: "language".tr,
                value: languageController.language.value),
          ),
          /*_singleSettingsItem(
              onTap: () => Get.to(() => NotificationUI()),
              icon: IconlyLight.notification,
              iconColor: Colors.lightBlue,
              title: "notifications".tr),*/

          _singleSettingsItem(
              onTap: () => Get.to(
                  () => GeneralSettingsDataUI(title: 'terms_conditions'.tr)),
              icon: Icons.rule_outlined,
              iconColor: Colors.indigo,
              title: "terms_conditions".tr),
          _singleSettingsItem(
              onTap: () => Get.to(
                  () => GeneralSettingsDataUI(title: 'privacy_policy'.tr)),
              icon: IconlyLight.paper,
              iconColor: Colors.purpleAccent,
              title: "privacy_policy".tr),
          _singleSettingsItem(
              onTap: () => Get.to(
                  () => GeneralSettingsDataUI(title: 'return_exchange'.tr)),
              icon: Icons.assignment_return_rounded,
              iconColor: Colors.lime,
              title: "return_exchange".tr),
          _singleSettingsItem(
              onTap: () =>
                  Get.to(() => GeneralSettingsDataUI(title: 'about_us'.tr)),
              icon: IconlyLight.info_circle,
              iconColor: Colors.pinkAccent,
              title: "about_us".tr),
          _singleSettingsItem(
              onTap: () => Get.to(() => GeneralSettingsDataUI(
                  isContactUsCalled: true, title: "contact_us".tr)),
              icon: Icons.contactless_outlined,
              iconColor: Colors.green,
              title: "contact_us".tr),
          _singleSettingsItem(
              onTap: () => Get.to(() => FaqUI()),
              icon: Icons.question_answer,
              iconColor: Colors.purple,
              title: "faq".tr),
          Obx(() => controller.userModel!.email != null &&
                  !controller.isSessionExpired! &&
                  controller.userToken != null
              ? _singleSettingsItem(
                  onTap: () {
                    LocalStorageHelper.deleteUserData();
                    controller.update();
                  },
                  icon: IconlyLight.logout,
                  iconColor: Colors.red,
                  title: "logout".tr)
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
                      style: caption
                          .copyWith(fontWeight: FontWeight.w600)),
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
        height: MediaQuery.of(Get.context!).size.height / 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StickyLabel(
                text: "select_language".tr,
              ),
              Column(
                children: languageController.optionsLocales.entries.map((item) {
                  return ListTile(
                    onTap: () {
                      languageController.setLanguage(key: item.key);
                      Get.back();
                    },
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

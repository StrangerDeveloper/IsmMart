import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
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
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: false,
                        titlePadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        title: Text(
                          'Settings',
                          style: textTheme.headline6,
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
                      const StickyLabel(text: "General"),
                      _generalSettings(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _accountSetup() {
    return Obx(() => controller.userModel!.email == null
        ? Column(
            children: [
              const StickyLabel(text: "Account"),
              _account(),
            ],
          )
        : Column(
            children: [
              _userCard(),
              const StickyLabel(text: "My Account"),
              _accountSettings()
            ],
          ));
  }

  _userCard() {
    return Obx(
      () => controller.userModel!.email == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: CustomText(
                  title: "Welcome ${controller.userModel!.firstName}",
                  weight: FontWeight.w600,
                  size: 17,
                ),
                subtitle: CustomText(
                  title: "${controller.userModel!.email}",
                  size: 14,
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
            "Login / Register",
            style: textTheme.bodyText1!.copyWith(color: Colors.blue),
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
                    /* AppConstant.displaySnackBar(
                        'error', "Register as Vendor first");
                    Future.delayed(
                      const Duration(seconds: 2),
                      () => AppConstant.showBottomSheet(
                          widget: _registerSeller()),
                    );*/
                  }
                }
              },
              icon: Icons.dashboard_rounded,
              iconColor: kPrimaryColor,
              title: "Vendor Dashboard"),
          _singleSettingsItem(
              onTap: ()=> Get.toNamed(Routes.buyerOrdersRoute),
              icon: IconlyBold.bag,
              iconColor: Colors.purpleAccent,
              title: "My Orders"),
          _singleSettingsItem(
              onTap: () {},
              icon: Icons.credit_card,
              iconColor: Colors.blueGrey,
              title: "Payments"),
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
              title: "Vendor Registration",
              style: headline5,
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                FormInputFieldWithIcon(
                  controller: controller.storeNameController,
                  iconPrefix: Icons.store_rounded,
                  labelText: 'Store Name',
                  iconColor: kPrimaryColor,
                  autofocus: false,
                  textStyle: bodyText1,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => GetUtils.isBlank(value!)!
                      ? "Store Name is Required!"
                      : null,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  onSaved: (value) {},
                ),
                AppConstant.spaceWidget(height: 15),
                FormInputFieldWithIcon(
                  controller: controller.storeDescController,
                  iconPrefix: Icons.description,
                  labelText: 'Store Description',
                  iconColor: kPrimaryColor,
                  autofocus: false,
                  textStyle: bodyText1,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => GetUtils.isBlank(value!)!
                      ? "Store Description is Required!"
                      : null,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  onSaved: (value) {},
                ),
                AppConstant.spaceWidget(height: 40),
                Obx(() => controller.isLoading.isTrue
                    ? CustomLoading(
                        isItForWidget: true,
                        color: kPrimaryColor,
                      )
                    : CustomButton(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await controller.registerStore();
                          }
                        },
                        text: "Register Store",
                        height: 40,
                        width: 150,
                      )),
              ],
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
          _singleSettingsItem(
              onTap: () => _showThemeChangeBottomSheet(),
              icon: IconlyLight.setting,
              iconColor: Colors.deepPurple,
              title: "Appearance",
              value: "Light"),
          _singleSettingsItem(
              onTap: () => _showLanguageChangeBottomSheet(),
              icon: Icons.language,
              iconColor: Colors.orange,
              title: "Language",
              value: "English"),
          _singleSettingsItem(
              onTap: () {},
              icon: IconlyLight.notification,
              iconColor: Colors.lightBlue,
              title: "Notification"),
          _singleSettingsItem(
              onTap: () {},
              icon: IconlyLight.info_circle,
              iconColor: Colors.green,
              title: "About Us"),
          Obx(() => controller.userModel!.email != null
              ? _singleSettingsItem(
                  onTap: () {
                    LocalStorageHelper.deleteUserData();
                  },
                  icon: IconlyLight.logout,
                  iconColor: Colors.red,
                  title: "Logout")
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
                weight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                if (value != null && value != "")
                  CustomText(
                      title: value,
                      style: textTheme.caption!
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

  _showThemeChangeBottomSheet() {
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
  }

  _showLanguageChangeBottomSheet() {
    var listThemeItems = [
      {
        "icon": Icons.location_city_rounded,
        "iconColor": Colors.green[900]!,
        "title": "Arabic",
        "isSelected": false,
      },
      {
        "icon": Icons.location_city_rounded,
        "iconColor": Colors.red,
        "title": "Chinese",
        "isSelected": false,
      },
      {
        "icon": Icons.location_city_rounded,
        "iconColor": Colors.deepPurple,
        "title": "English",
        "isSelected": true,
      },
      {
        "icon": Icons.location_city_rounded,
        "iconColor": Colors.amber,
        "title": "Russian",
        "isSelected": false,
      },
      {
        "icon": Icons.location_city_rounded,
        "iconColor": Colors.green,
        "title": "Urdu",
        "isSelected": false,
      },
    ];
    AppConstant.showBottomSheet(
      widget: SizedBox(
        // height: MediaQuery.of(Get.context!).size.height / 3,
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
  }

  _itemsTheme({model}) {
    return ListTile(
      onTap: () {
        model["isSelected"] = !model["isSelected"];
      },
      leading: Icon(model["icon"], size: 25, color: model["iconColor"]),
      title: Text(model["title"],
          style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600)),
      trailing: model["isSelected"] ? const Icon(Icons.done) : null,
    );
  }
}

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class ChangeAddressUI extends GetView<CheckoutController> {
  const ChangeAddressUI({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100]!,
      appBar: _appbar(),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      StickyLabel(text: langKey.shippingDetails.tr),
                      CustomTextBtn(
                        width: 90,
                        height: 30,
                        onPressed: () {
                          if (controller.shippingAddressList.length >= 3) {
                            AppConstant.displaySnackBar(
                                'error', langKey.maxAddressLimitMsg.tr);
                            return;
                          }
                          controller.clearControllers();
                          AppConstant.showBottomSheet(
                              widget: addNewORUpdateAddressContents());
                        },
                        title: langKey.addNew.tr,
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => controller.shippingAddressList.isEmpty
                      ? _buildNewAddress()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: controller.shippingAddressList.length,
                          itemBuilder: (_, index) {
                            UserModel? userModel =
                                controller.shippingAddressList[index];

                            return _singleAddressListItem(userModel);
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  _appbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kAppBarColor,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(
          title: langKey.shippingAddressDetail.tr, style: appBarTitleSize),
    );
  }

  Widget _buildNewAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: AppResponsiveness.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoDataFoundWithIcon(
              title: langKey.noDefaultAddressFound.tr,
              icon: Icons.location_city_rounded,
            ),
            AppConstant.spaceWidget(height: 10),
            CustomTextBtn(
              width: 150,
              height: 40,
              onPressed: () {
                // Get.back();
                AppConstant.showBottomSheet(
                    widget: addNewORUpdateAddressContents());
              },
              title: langKey.addNewAddress.tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleAddressListItem(UserModel? userModel) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          CustomGreyBorderContainer(
            isSelected: userModel!.defaultAddress!,
            activeColor: kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ListTile(
              onTap: () => controller.changeDefaultShippingAddress(
                  addressId: userModel.id),
              title: CustomText(
                title: userModel.name!,
                style: headline3,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(title: userModel.phone ?? '', style: bodyText1),
                  CustomText(
                      style: bodyText1,
                      title: "${userModel.address!}, "
                          "${userModel.zipCode!}, "
                          "${userModel.city!.name!},"
                          " ${userModel.country!.name!}"),
                ],
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomActionIcon(
                    onTap: () {
                      AppConstant.showBottomSheet(
                          widget: addNewORUpdateAddressContents(
                              userModel: userModel, calledForUpdate: true),
                          isGetXBottomSheet: true);
                    },
                    size: 15,
                    height: 25,
                    width: 25,
                    icon: Icons.edit_rounded,
                    bgColor: kPrimaryColor),
                AppConstant.spaceWidget(width: 5),
                CustomActionIcon(
                    onTap: () => controller.deleteShippingAddress(userModel.id),
                    size: 15,
                    height: 25,
                    width: 25,
                    icon: Icons.delete_rounded,
                    bgColor: kRedColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addNewORUpdateAddressContents(
      {UserModel? userModel, calledForUpdate = false}) {
    var formKey = GlobalKey<FormState>();

    if (calledForUpdate) {
      controller.nameController.text = userModel!.name ?? "";
      controller.addressController.text = userModel.address ?? "";
      controller.phoneController.text = userModel.phone ?? "";
      controller.zipCodeController.text = userModel.zipCode ?? "";
    }

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Column(
            children: [
              CustomText(
                title:
                    "${calledForUpdate ? langKey.updateBtn.tr : langKey.addNew.tr} ${langKey.shipping.tr} ${langKey.address.tr}",
                style: headline2,
              ),
              AppConstant.spaceWidget(height: 15),
              FormInputFieldWithIcon(
                controller: controller.nameController,
                iconPrefix: Icons.person,
                labelText: langKey.fullName.tr,
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return Validator().validateName(value);
                },
                keyboardType: TextInputType.name,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 10),
              FormInputFieldWithIcon(
                controller: controller.phoneController,
                iconPrefix: Icons.phone_iphone_rounded,
                labelText: langKey.phone.tr,
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(?:[+])?\d*'))
                ],
                validator: Validator().validatePhoneNumber,
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 10),
              FormInputFieldWithIcon(
                controller: controller.zipCodeController,
                iconPrefix: Icons.code,
                labelText: langKey.zipCode.tr,
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                 return Validator().validateDefaultTxtField(value);
                },
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 10),

              FormInputFieldWithIcon(
                controller: controller.addressController,
                iconPrefix: Icons.location_on_rounded,
                labelText: langKey.address.tr,
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value){
                  return Validator().validateDefaultTxtField(value);
                },
                keyboardType: TextInputType.name,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 15),

              ///: Countries
              if (!calledForUpdate)
                Column(
                  children: [
                    //Countries
                    Obx(
                      () => DropdownSearch<CountryModel>(
                        popupProps: PopupProps.dialog(
                            showSearchBox: true,
                            dialogProps: DialogProps(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            searchFieldProps: AppConstant.searchFieldProp()),
                        items: controller.authController.countries,
                        itemAsString: (model) => model.name ?? "",
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: bodyText1,
                          dropdownSearchDecoration: InputDecoration(
                            labelText: langKey.selectCountry.tr,
                            labelStyle: bodyText1,
                            hintText: langKey.chooseCountry.tr,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                  style: BorderStyle.solid), //B
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        onChanged: (CountryModel? newValue) {
                          controller.setSelectedCountry(newValue!);
                          //debugPrint(">>> $newValue");
                        },
                        selectedItem:
                            controller.authController.selectedCountry.value,
                      ),
                    ),

                    AppConstant.spaceWidget(height: 15),

                    ///TOO: Sub Cities
                    Obx(
                      () => authController.cities.isEmpty
                          ? Container()
                          : authController.isLoading.isTrue
                              ? CustomLoading(
                                  isItForWidget: true,
                                  color: kPrimaryColor,
                                )
                              : DropdownSearch<CountryModel>(
                                  popupProps: PopupProps.dialog(
                                      showSearchBox: true,
                                      dialogProps: DialogProps(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      searchFieldProps:
                                          AppConstant.searchFieldProp()),
                                  //showSelectedItems: true),

                                  items: controller.authController.cities,
                                  itemAsString: (model) => model.name ?? "",
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    baseStyle: bodyText1,
                                    dropdownSearchDecoration: InputDecoration(
                                      labelText: langKey.selectCity.tr,
                                      labelStyle: bodyText1,
                                      hintText: langKey.chooseCity.tr,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle.solid), //B
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),

                                  onChanged: (CountryModel? newValue) {
                                    controller.setSelectedCity(newValue!);
                                  },
                                  selectedItem: controller
                                      .authController.selectedCity.value,
                                ),
                    ),
                  ],
                ),

              AppConstant.spaceWidget(height: 40),
              Obx(
                () => controller.isLoading.isTrue
                    ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
                    : CustomTextBtn(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (calledForUpdate) {
                              controller.updateShippingAddress(userModel);
                            } else {
                              if (controller.countryId.value > 0 &&
                                  controller.cityId.value > 0) {
                                controller.addShippingAddress();
                              } else {
                                AppConstant.displaySnackBar(
                                  'error',
                                  langKey.plzSelectCountry.tr,
                                );
                              }
                            }
                            Get.back();
                          }
                        },
                        title: calledForUpdate
                            ? langKey.updateBtn.tr
                            : langKey.add.tr,
                        height: 50,
                        width: 300,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

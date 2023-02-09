import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class CheckoutUI extends GetView<CheckoutController> {
  const CheckoutUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: AppBar(
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
          title: CustomText(title: langKey.checkout.tr, style: appBarTitleSize),
        ),
        body: _body(),
      ),
    );
  }

  ///

  Widget _body() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              StickyLabel(text: langKey.shippingDetails.tr),
              Obx(() => controller.defaultAddressModel!.defaultAddress!
                  ? _shippingAddressDetails(controller.defaultAddressModel)
                  : _buildNewAddress()),
              StickyLabel(text: langKey.shippingCost.tr),
              Obx(
                () => Column(
                  children: [
                    _singleShippingCostItem(
                        title: "Standard", price: 250, delivery: 7),
                    _singleShippingCostItem(
                        title: "Free", price: 0, delivery: 14),
                  ],
                ),
              ),
              StickyLabel(text: langKey.orderSummary.tr),
              _buildCartItemSection(),
              _subTotalDetails(),
              Column(
                children: [
                  AppConstant.spaceWidget(height: 20),
                  Obx(() => controller.isLoading.isTrue
                      ? CustomLoading(isItBtn: true)
                      : CustomButton(
                          width: 280,
                          height: 50,
                          onTap: () {
                            if (controller.shippingCost.value == 0 &&
                                controller.totalAmount.value <= 1000) {
                              controller.showSnackBar(
                                  title: "error",
                                  message:
                                      "You cannot use Free Shipping Service under Rs1000");
                              return;
                            } else {
                              if (controller.defaultAddressModel!.id != null) {
                                if (controller
                                    .cartController.cartItemsList.isNotEmpty) {
                                  controller.makePayment(
                                      amount: controller.totalAmount.value
                                          .toString());
                                } else {
                                  controller.showSnackBar(
                                      title: "error",
                                      message: "Cart must not be empty");
                                }
                              } else
                                controller.showSnackBar(
                                    title: "error",
                                    message: langKey.noDefaultAddressFound.tr);
                            }
                          },
                          text: langKey.confirmOrder.tr))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _singleShippingCostItem({title, price, delivery}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Column(
        children: [
          Card(
            child: RadioListTile(
                activeColor: kPrimaryColor,
                toggleable: false,
                //selected: true,
                value: price,
                title: CustomText(
                  title: "$title Delivery",
                ),
                subtitle: CustomText(
                  title: "Delivery: $delivery Days Cost : Rs $price.00",
                ),
                groupValue: controller.shippingCost.value,
                onChanged: (value) {
                  controller.setShippingCost(value!);
                }),
          ),
          if (price == 0)
            CustomText(title: "FREE SHIPPING ON ALL ORDERS ABOVE PKR 1000")
        ],
      ),
    );
  }

  ///TODO: Shipping Details
  ///
  Widget _shippingAddressDetails(UserModel? userModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: CustomText(
                title: userModel!.name!, size: 16, weight: FontWeight.bold),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    title: userModel.phone ?? "",
                    style: bodyText2.copyWith(color: kDarkColor)),
                CustomText(
                    style: bodyText2.copyWith(color: kDarkColor),
                    title: "${userModel.address!}, "
                        "${userModel.zipCode!}, "
                        "${userModel.city!.name!},"
                        " ${userModel.country!.name!}"),
              ],
            ),
            isThreeLine: true,
            dense: false,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // OutlinedButton(onPressed: () => showAddressesDialog(), child: CustomText(title: "Change",),)
                _tileActionBtn(
                    onTap: () => showAddressesDialog(),
                    title: langKey.changeBtn.tr)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _tileActionBtn({onTap, title, txtColor}) {
    return InkWell(
      onTap: onTap,
      child: CustomText(
        title: title,
        weight: FontWeight.w600,
        color: txtColor ?? Colors.blueAccent,
      ),
    );
  }

  Widget _buildNewAddress() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoDataFound(
              text: langKey.noDefaultAddressFound.tr,
              fontSize: 13,
            ),
            OutlinedButton(
                onPressed: () {
                  AppConstant.showBottomSheet(
                      widget: addNewORUpdateAddressContents());
                },
                child: CustomText(
                    title: langKey.addNewAddress.tr, weight: FontWeight.w600))
          ],
        ),
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
                    "${calledForUpdate ? langKey.updateBtn.tr : langKey.addNew.tr} ${langKey.shipping.tr}",
                style: appBarTitleSize,
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
                validator: (value) =>
                    GetUtils.isBlank(value!)! ? langKey.fullNameReq.tr : null,
                keyboardType: TextInputType.name,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 10),
              FormInputFieldWithIcon(
                controller: controller.phoneController,
                iconPrefix: Icons.phone_iphone_rounded,
                labelText: langKey.phone,
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => !GetUtils.isPhoneNumber(value!)
                    ? langKey.phoneReq.tr
                    : null,
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 10),
              FormInputFieldWithIcon(
                controller: controller.zipCodeController,
                iconPrefix: Icons.code,
                labelText: 'Zip Code',
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    GetUtils.isBlank(value!)! ? "Zip code required!" : null,
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
                validator: (value) =>
                    GetUtils.isBlank(value!)! ? "Address is required!" : null,
                keyboardType: TextInputType.name,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 15),

              ///TODO: Countries
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
                            labelText: "Select Country",
                            labelStyle: bodyText1,
                            hintText: "Choose Country",
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
                                      labelText: "Select City",
                                      labelStyle: bodyText1,
                                      hintText: "Choose City",
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
                    : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (calledForUpdate) {

                              controller.updateShippingAddress(userModel);
                            } else {
                              if (controller.countryId.value > 0 &&
                                  controller.cityId.value > 0) {
                                controller.addShippingAddress();
                              } else {
                                AppConstant.displaySnackBar(
                                    'error', "Plz select Country and City");
                              }
                            }
                          }
                        },
                        text: calledForUpdate ? "update".tr : "add".tr,
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

  void showAddressesDialog() {
    Get.defaultDialog(
      title: "Shipping Address details",
      titleStyle: appBarTitleSize,
      content: Column(
        children: [
          Obx(
            () => controller.shippingAddressList.isEmpty
                ? NoDataFound(text: langKey.noAddressFound.tr)
                : SingleChildScrollView(
                    child: Column(
                      children: controller.shippingAddressList.map((element) {
                        if (element.defaultAddress!)
                          controller.shippingAddressId(element.id);
                        return _singleDialogListItem(element);
                      }).toList(),
                    ),
                  ),
          )
        ],
      ),
      confirm: OutlinedButton(
        onPressed: () => controller.changeDefaultShippingAddress(),
        child: CustomText(
          title: langKey.set.tr,
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () {
          if (Get.isDialogOpen!) Get.back();
          AppConstant.showBottomSheet(
              widget: addNewORUpdateAddressContents(), isGetXBottomSheet: true);
        },
        child: CustomText(
          title: langKey.addNewAddress.tr,
        ),
      ),
    );
  }

  Widget _singleDialogListItem(UserModel? userModel) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => Radio(
                      activeColor: kPrimaryColor,
                      toggleable: true,
                      value: userModel!.id,
                      onChanged: (value) {
                        controller.shippingAddressId(value!);
                      },
                      groupValue: controller.shippingAddressId.value,
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: userModel!.name!,
                          style: headline3,
                        ),
                        CustomText(
                            title: userModel.phone ?? '', style: bodyText1),
                        CustomText(
                            style: bodyText1,
                            title: "${userModel.address!}, "
                                "${userModel.zipCode!}, "
                                "${userModel.city!.name!},"
                                " ${userModel.country!.name!}"),
                      ],
                    )),
              ],
            ),
            Positioned(
              top: 0,
              //bottom: 10,
              right: 0,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomActionIcon(
                      onTap: () {
                        print(">>USERSADDRESS: ${userModel.toAddressJson()}");
                        AppConstant.showBottomSheet(
                            widget: addNewORUpdateAddressContents(
                                userModel: userModel, calledForUpdate: true));
                      },
                      size: 15,
                      height: 25,
                      width: 25,
                      icon: Icons.edit_rounded,
                      bgColor: kPrimaryColor),
                  AppConstant.spaceWidget(width: 5),
                  CustomActionIcon(
                      onTap: () =>
                          controller.deleteShippingAddress(userModel.id),
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
      ),
    );
  }

  ///
  ///TODO: Payments Details
  ///
  Widget _buildPaymentDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoDataFound(
              text: "No payment method found",
              fontSize: 13,
            ),
            OutlinedButton(
                onPressed: () {},
                child:
                    CustomText(title: "Add Payments", weight: FontWeight.w600))
          ],
        ),
      ),
    );
  }

  ///
  ///TODO: Order Summery
  ///

  Widget _buildCartItemSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => controller.getCartItemsList().isEmpty
            ? NoDataFound(text: langKey.noCartItemFound.tr)
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.getCartItemsList().length,
                itemBuilder: (context, index) {
                  CartModel cartModel = controller.getCartItemsList()[index];
                  return SingleCartItems(
                    cartModel: cartModel,
                    index: index,
                  );
                },
              ),
      ),
    );
  }

  Widget _subTotalDetails() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AppConstant.spaceWidget(height: 10),

                ///:TODO Coupon Code
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Search bar
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 36,
                        //height: 40.0,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: controller.couponCodeController,
                          cursorColor: kPrimaryColor,
                          autofocus: false,
                          textInputAction: TextInputAction.search,
                          // onChanged: controller.search,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon:
                                Icon(Icons.search, color: kPrimaryColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kLightGreyColor,
                                width: 0.5,
                              ), //BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kLightGreyColor,
                                width: 0.5,
                              ), //BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            fillColor: kWhiteColor,
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Input your coupon code',
                            hintStyle: TextStyle(
                              color: kLightColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///Cancel Button
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {},
                      child: CustomText(
                        title: langKey.apply.tr,
                        weight: FontWeight.w600,
                      ),
                    )),
                  ],
                ),

                AppConstant.spaceWidget(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Subtotal ", style: bodyText1),
                          TextSpan(
                              text:
                                  "(${controller.cartController.totalQtyCart.value} items)",
                              style: caption),
                        ],
                      ),
                    ),
                    CustomPriceWidget(
                        title:
                            "${controller.cartController.totalCartAmount.value}",
                        style: bodyText1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(title: "Shipping Fee", style: bodyText1),
                    Obx(() => CustomPriceWidget(
                        title: "${controller.shippingCost.value}",
                        style: bodyText1)),
                  ],
                ),
                kSmallDivider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Total ", style: headline2),
                          TextSpan(text: "(Inclusive of GST)", style: caption),
                        ],
                      ),
                    ),
                    CustomPriceWidget(title: "${controller.totalAmount.value}"),
                  ],
                ),
                AppConstant.spaceWidget(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

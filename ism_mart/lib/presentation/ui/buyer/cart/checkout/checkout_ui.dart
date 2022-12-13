import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CheckoutUI extends GetView<CheckoutController> {
  const CheckoutUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhiteColor,
          title: CustomText(
            title: 'Checkout',
            style: textTheme.headline5,
          ),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              StickyLabel(text: "Shipping Details"),
              Obx(() => controller.defaultAddressModel!.defaultAddress!
                  ? _shippingAddressDetails(controller.defaultAddressModel)
                  : _buildNewAddress()),
              /*StickyLabel(text: "Payment Details"),
              _buildPaymentDetails(),*/
              StickyLabel(text: "Order Summary"),
              _buildCartItemSection(),
              _subTotalDetails(),
              Column(
                children: [
                  Obx(() => controller.isLoading.isTrue
                      ? CustomLoading(isItBtn: true)
                      : CustomButton(
                          width: 320,
                          height: 40,
                          onTap: () => controller.makePayment(
                              amount: controller
                                  .cartController.totalCartAmount.value
                                  .toString()),
                          text: "Confirm Order"))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
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
                    title: userModel.phone!,
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
                    onTap: () => showAddressesDialog(), title: "Change")
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
              text: "No default address found",
              fontSize: 13,
            ),
            OutlinedButton(
                onPressed: () {
                  AppConstant.showBottomSheet(
                      widget: addNewORUpdateAddressContents());
                },
                child: CustomText(
                    title: "Add new address", weight: FontWeight.w600))
          ],
        ),
      ),
    );
  }

  Widget addNewORUpdateAddressContents(
      {UserModel? userModel, calledForUpdate = false}) {
    var formKey = GlobalKey<FormState>();
    if (calledForUpdate) {
      controller.nameController.text = userModel!.name!;
      controller.addressController.text = userModel.address!;
      controller.phoneController.text = userModel.phone!;
      controller.zipCodeController.text = userModel.zipCode!;
    }

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Column(
            children: [
              CustomText(
                title: "${calledForUpdate ? "Update" : "Add New"} Shipping",
                style: headline5,
              ),
              AppConstant.spaceWidget(height: 15),
              FormInputFieldWithIcon(
                controller: controller.nameController,
                iconPrefix: Icons.person,
                labelText: 'Name',
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    GetUtils.isBlank(value!)! ? "Name is Required!" : null,
                keyboardType: TextInputType.name,
                onChanged: (value) {},
                onSaved: (value) {},
              ),
              AppConstant.spaceWidget(height: 10),
              FormInputFieldWithIcon(
                controller: controller.phoneController,
                iconPrefix: Icons.phone_iphone_rounded,
                labelText: 'Phone Number',
                iconColor: kPrimaryColor,
                autofocus: false,
                textStyle: bodyText1,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => !GetUtils.isPhoneNumber(value!)
                    ? "Invalid Phone format!"
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
                labelText: 'Address',
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
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black87,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton(
                          isExpanded: true,
                          style: bodyText2,
                          hint: Text(
                              '${controller.authController.selectedCountry.value}'),
                          onChanged: (newValue) {
                            debugPrint("Countries $newValue");
                            controller.setSelectedCountry(newValue!.toString());
                          },
                          items: controller.authController.countries
                              .map((countryModel) {
                            String countryName = countryModel.name!;
                            return DropdownMenuItem(
                              child: Text(
                                '$countryName',
                              ),
                              value: countryName,
                            );
                          }).toList(),
                          value:
                              controller.authController.selectedCountry.value,
                        ),
                      ),
                    ),
                    AppConstant.spaceWidget(height: 15),

                    ///TODO: Sub Cities
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black87,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButton(
                          isExpanded: true,
                          style: bodyText2,
                          hint: Text(
                              '${controller.authController.selectedCity.value}'),
                          onChanged: (newValue) {
                            debugPrint("Cities $newValue");
                            controller.setSelectedCity(newValue!.toString());
                          },
                          items: controller.authController.cities
                              .map((countryModel) {
                            String city = countryModel.name!;
                            return DropdownMenuItem(
                              child: Text(
                                '$city',
                              ),
                              value: city,
                            );
                          }).toList(),
                          value: controller.authController.selectedCity.value,
                        ),
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
                        text: calledForUpdate ? "Update" : "Add",
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
      content: Obx(
        () => controller.shippingAddressList.isEmpty
            ? NoDataFound(
                text: "No Other Address Found!",
              )
            : SingleChildScrollView(
                child: Column(
                  children: controller.shippingAddressList.map((element) {
                    if (element.defaultAddress!)
                      controller.shippingAddressId(element.id);
                    return _singleDialogListItem(element);
                  }).toList(),
                ),
              ),
      ),
      confirm: OutlinedButton(
        onPressed: () => controller.changeDefaultShippingAddress(),
        child: CustomText(
          title: "Set",
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () {
          if (Get.isDialogOpen!) Get.back();
          AppConstant.showBottomSheet(
              widget: AppConstant.showBottomSheet(
                  widget: addNewORUpdateAddressContents()));
        },
        child: CustomText(
          title: "Add New Address",
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
                        print("Radio: $value");
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
                            size: 16,
                            weight: FontWeight.bold),
                        CustomText(
                            title: userModel.phone!,
                            style: bodyText2.copyWith(color: kDarkColor)),
                        CustomText(
                            style: bodyText2.copyWith(color: kDarkColor),
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
            ? const NoDataFound(text: "No Cart Item Found")
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
                        height: 35,
                        //height: 40.0,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          border: Border.all(color: kLightGreyColor),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: TextField(
                          controller: controller.couponCodeController,
                          cursorColor: kPrimaryColor,
                          autofocus: false,
                          textInputAction: TextInputAction.search,
                          // onChanged: controller.search,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon:
                                const Icon(Icons.search, color: kPrimaryColor),
                            hintText: "Input your Coupon Code",
                            hintStyle: textTheme.bodyText1!.copyWith(
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
                        title: "Apply",
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
                    CustomPriceWidget(title: "0.0", style: bodyText1),
                  ],
                ),
                kSmallDivider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: "Total ", style: headline5),
                          TextSpan(text: "(Inclusive of GST)", style: caption),
                        ],
                      ),
                    ),
                    CustomPriceWidget(
                        title:
                            "${controller.cartController.totalCartAmount.value}"),
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

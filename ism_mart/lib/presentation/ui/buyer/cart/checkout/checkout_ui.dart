import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
                        title: langKey.standard.tr, price: 250, delivery: 7),
                    _singleShippingCostItem(
                        title: langKey.free.tr, price: 0, delivery: 14),
                  ],
                ),
              ),
              StickyLabel(text: langKey.orderSummary.tr),
              _buildCartItemSection(),
              StickyLabel(text: langKey.paymentMethod.tr),
              _buildPaymentDetails(),
              _subTotalDetails(),
              Column(
                children: [
                  AppConstant.spaceWidget(height: 20),
                  Obx(
                    () => controller.isLoading.isTrue
                        ? CustomLoading(isItBtn: true)
                        : CustomButton(
                            width: 280,
                            height: 50,
                            text: langKey.confirmOrder.tr,
                            onTap: () {
                              if (controller
                                      .cartController.totalCartAmount.value <=
                                  num.parse(currencyController.convertCurrency(
                                      currentPrice: "1000")!)) {
                                controller.showSnackBar(
                                  title: langKey.errorTitle.tr,
                                  message: langKey.toProceedWithPurchase.tr,
                                );
                                //You cannot use Free Shipping Service under Rs1000
                                return;
                              } else if (controller
                                  .isCardPaymentEnabled.isFalse) {
                                controller.showSnackBar(
                                    title: langKey.errorTitle.tr,
                                    message: langKey.preferredPayment.tr);
                                return;
                              } else if (controller
                                  .isCardPaymentEnabled.isFalse) {
                                controller.showSnackBar(
                                  title: langKey.errorTitle.tr,
                                  message: langKey.preferredPayment.tr,
                                );
                                return;
                              } else if (controller.defaultAddressModel!.id ==
                                  null) {
                                controller.showSnackBar(
                                    title: langKey.errorTitle.tr,
                                    message: langKey.noDefaultAddressFound.tr);
                                return;
                              } else if (controller
                                  .getCartItemsList()
                                  .isEmpty) {
                                controller.showSnackBar(
                                    title: langKey.errorTitle.tr,
                                    message: langKey.cartMustNotEmpty.tr);
                                return;
                              } else {
                                controller.makePayment(
                                    amount: controller.totalAmount.value
                                        .toString());
                              }
                            },
                          ),
                  ),
                  AppConstant.spaceWidget(height: 20),
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
          CustomCard(
            child: IgnorePointer(
              ignoring: controller.cartController.totalCartAmount.value <= 1000,
              child: RadioListTile(
                activeColor: kPrimaryColor,
                toggleable: false,
                //selected: true,
                value: price,
                title: CustomText(
                  title: "$title " + langKey.delivery.tr,
                ),
                subtitle: CustomText(
                  title: langKey.delivery.tr +
                      ": $delivery " +
                      langKey.daysCost.tr +
                      " :${convertStaticPrice(price: price!)}",
                ),
                groupValue: controller.shippingCost.value,
                onChanged: (value) {
                  controller.setShippingCost(value!);
                },
              ),
            ),
          ),
          if (price == 0)
            CustomText(
                title:
                    "${langKey.freeShipping.tr} ${convertStaticPrice(price: 1000)}")
        ],
      ),
    );
  }

  String convertStaticPrice({num? price}) {
    num? priceAfter = num.parse(
        currencyController.convertCurrency(currentPrice: price.toString())!);
    return "${AppConstant.getCurrencySymbol(currencyCode: currencyController.currency.value)} ${priceAfter.toStringAsFixed(2)}";
  }

  ///TOO: Shipping Details
  ///
  Widget _shippingAddressDetails(UserModel? userModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomCard(
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
                    onTap: () => Get.toNamed(Routes.changeAddressRoute),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NoDataFound(
              text: langKey.noDefaultAddressFound.tr,
              fontSize: 13,
            ),
            AppConstant.spaceWidget(height: 10),
            CustomButton(
                width: 150,
                height: 40,
                onTap: () => Get.toNamed(Routes.changeAddressRoute),
                text: langKey.addNewAddress.tr),
          ],
        ),
      ),
    );
  }

  ///
  ///TOO: Payments Details
  ///
  Widget _buildPaymentDetails() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _singlePaymentOptionItem(
                  title: langKey.cashOnDelivery.tr,
                  icon: Icons.wallet,
                  value: false,
                  isEnabled: true),
              _singlePaymentOptionItem(
                  title: langKey.creditCard.tr,
                  icon: Icons.credit_card,
                  value: true,
                  isEnabled: false),
              CustomCard(
                color: Colors.white,
                child: Visibility(
                    visible: controller.isCardPaymentEnabled.isTrue,
                    child: CardField(
                        enablePostalCode: true,
                        onCardChanged: (card) async {
                          //await Stripe.instance.createPaymentMethod(params);
                          try {
                            var paymentMethod =
                                await Stripe.instance.createPaymentMethod(
                              params: PaymentMethodParams.card(
                                paymentMethodData: PaymentMethodData(
                                  billingDetails: BillingDetails(
                                    name:
                                        controller.defaultAddressModel?.name ??
                                            "",
                                    email:
                                        controller.defaultAddressModel?.email ??
                                            "",
                                    phone:
                                        controller.defaultAddressModel?.phone ??
                                            "",
                                    address: null,
                                  ),
                                ),
                              ),
                            );
                            debugPrint(
                                ">>>CardPaymentMethod: ${paymentMethod.id}");
                            controller.setPaymentIntentId(paymentMethod.id);
                          } on StripeException catch (e) {
                            print(">>>stripeException: $e");
                          }
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _singlePaymentOptionItem({title, value, icon, isEnabled}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Column(
        children: [
          CustomCard(
            child: IgnorePointer(
              ignoring: isEnabled,
              child: RadioListTile(
                activeColor: kPrimaryColor,
                toggleable: false,
                //selected: true,
                value: title,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: "$title",
                    ),
                    Icon(icon),
                  ],
                ),
                groupValue: controller.paymentType,
                onChanged: (value) {
                  controller.enableCardPayment(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///TOO: Order Summery
  ///

  Widget _buildCartItemSection() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
                    calledFromCheckout: true,
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
        child: CustomCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppConstant.spaceWidget(height: 10),

                ///Redeem Coins
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ///Search for Coins
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
                          style: bodyText1,
                          enabled: controller.coinsModel?.silver != null &&
                              controller.coinsModel!.silver!
                                  .isGreaterThan(fixedRedeemCouponThreshold),
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
                            hintText:
                                '${langKey.wantToRedeem.tr} ${controller.coinsModel?.silver ?? 0} ${langKey.coins.tr}?',
                            hintStyle: TextStyle(
                              color: kLightColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///Apply Button
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {
                        String? value =
                            controller.couponCodeController.text.isEmpty
                                ? "0"
                                : controller.couponCodeController.text;
                        controller.applyRedeemCode(num.parse(value));
                        // if (controller.coinsModel != null &&
                        //     controller.coinsModel!.silver!
                        //         .isGreaterThan(fixedRedeemCouponThreshold) &&
                        //     value.isNotEmpty)
                        //   controller.applyRedeemCode(num.parse(value));
                        // else
                        //   AppConstant.displaySnackBar(
                        //     langKey.errorTitle.tr,
                        //     langKey.needMoreCoins.tr,
                        //   );
                      },
                      child: CustomText(
                        title: langKey.redeemBtn.tr,
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
                          TextSpan(
                              text: langKey.subtotal.tr + ' ',
                              style: bodyText1),
                          TextSpan(
                              text:
                                  "(${controller.cartController.totalQtyCart.value} ${langKey.items.tr})",
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
                AppConstant.spaceWidget(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(title: langKey.shippingFee.tr, style: bodyText1),
                    Obx(() => CustomPriceWidget(
                        title: "${controller.shippingCost.value}",
                        style: bodyText1)),
                  ],
                ),
                AppConstant.spaceWidget(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        title: langKey.prodDiscount.tr, style: bodyText1),
                    Obx(() => CustomPriceWidget(
                        title: "${controller.totalDiscount.value}",
                        style: bodyText1.copyWith(color: Colors.amber))),
                  ],
                ),
                kSmallDivider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: langKey.total.tr + " ", style: headline2),
                          TextSpan(
                              text: "(${langKey.inclusiveOfGst.tr})",
                              style: caption),
                        ],
                      ),
                    ),
                    Obx(
                      () => CustomPriceWidget(
                          title: "${controller.totalAmount.value}"),
                    ),
                    InkWell(
                      onTap: () {
                        moreAboutCostDialog();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 5),
                        child: Text(
                          langKey.moreAboutCost.tr,
                          style: textStylePoppins.copyWith(
                            color: Color(0xffDC2626),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
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

  Future moreAboutCostDialog() async {
    return showDialog(
      // barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            // side: BorderSide(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      langKey.feeChargesExplained.tr,
                      style: textStylePoppins.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                      child: Text(
                        langKey.costDesc1.tr,
                        textAlign: TextAlign.center,
                        style: textStylePoppins.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.local_shipping_outlined),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                langKey.serviceFee.tr,
                                style: textStylePoppins.copyWith(
                                  fontSize: 16,
                                  color: Color(0xffDC2626),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                langKey.costDesc2.tr,
                                style: textStylePoppins.copyWith(
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.miscellaneous_services_outlined),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                langKey.deliveryFee.tr,
                                style: textStylePoppins.copyWith(
                                  fontSize: 16,
                                  color: Color(0xffDC2626),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                langKey.costDesc3.tr,
                                style: textStylePoppins.copyWith(
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text(
                        langKey.costDesc4.tr,
                        textAlign: TextAlign.center,
                        style: textStylePoppins.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.support_agent_outlined,
                          size: 30,
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '+92 3331832356',
                              style: textStylePoppins.copyWith(
                                fontSize: 17,
                                color: Color(0xffDC2626),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              langKey.supportCenter.tr,
                              style: textStylePoppins.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
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
        );
      },
    );
  }
}

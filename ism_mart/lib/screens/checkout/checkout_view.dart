import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/cart/cart_viewmodel.dart';
import 'package:ism_mart/screens/checkout/checkout_viewmodel.dart';
import 'package:ism_mart/screens/payment/payment_view.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/loader_view.dart';

class CheckoutView extends StatefulWidget {
  CheckoutView({Key? key}) : super(key: key);

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final CheckoutViewModel viewModel = Get.put(CheckoutViewModel());

  final CartViewModel cartViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: CustomAppBar(title: langKey.checkout.tr),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  ///Shipping Address Section
                  StickyLabel(text: langKey.shippingDetails.tr),
                  Obx(() => viewModel.noDefaultAddress.value
                      ? _buildNewAddress()
                      : _shippingAddressDetails()),

                  ///Shipping Cost Cards
                  StickyLabel(text: langKey.shippingCost.tr),
                  Obx(
                    () => Column(
                      children: [
                        _singleShippingCostItem(
                            title: langKey.standard.tr,
                            price: 250,
                            delivery: 7),
                        _singleShippingCostItem(
                            title: langKey.free.tr, price: 0, delivery: 14),
                      ],
                    ),
                  ),

                  ///Cart Items
                  StickyLabel(text: langKey.orderSummary.tr),
                  _buildCartItemSection(),

                  ///Payment Methods Cards
                  StickyLabel(text: langKey.paymentMethod.tr),
                  _buildPaymentDetails(),

                  ///Sub-total Card
                  _subTotalDetails(),

                  ///Confirm Order Button
                  _confirmOrderButton(),
                ],
              ),
            ),
            LoaderView(),
          ],
        ),
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
            CustomTextBtn(
              width: 150,
              height: 40,
              onPressed: () {
                Get.toNamed(Routes.changeAddressRoute);
              },
              title: langKey.addNewAddress.tr,
            ),
          ],
        ),
      ),
    );
  }

  Widget _shippingAddressDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomCard(
        color: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: CustomText(
                title: viewModel.userModel.value.name!,
                size: 16,
                weight: FontWeight.bold),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    title: viewModel.userModel.value.phone ?? "",
                    style: bodyText2.copyWith(color: kDarkColor)),
                CustomText(
                    style: bodyText2.copyWith(color: kDarkColor),
                    title: "${viewModel.userModel.value.address!}, "
                        "${viewModel.userModel.value.zipCode!}, "
                        "${viewModel.userModel.value.name!},"
                        " ${viewModel.userModel.value.name!}"),
              ],
            ),
            isThreeLine: true,
            dense: false,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _tileActionBtn(
                  onTap: () {
                    Get.toNamed(Routes.changeAddressRoute);
                  },
                  title: langKey.changeBtn.tr,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _singleShippingCostItem({title, price, delivery}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Column(
        children: [
          CustomCard(
            child: IgnorePointer(
              ignoring: cartViewModel.totalCartAmount.value <= 1000,
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
                      " :${viewModel.convertStaticPrice(price: price!)}",
                ),
                groupValue: viewModel.shippingCost.value,
                onChanged: (value) {
                  viewModel.setShippingCost(value!);
                },
              ),
            ),
          ),
          if (price == 0)
            CustomText(
                title:
                    "${langKey.freeShipping.tr} ${viewModel.convertStaticPrice(price: 1000)}")
        ],
      ),
    );
  }

  Widget _tileActionBtn({onTap, title, txtColor}) {
    return InkWell(
      onTap: onTap,
      child: CustomText(
        title: title,
        weight: FontWeight.w600,
        color: txtColor ?? Colors.blueAccent,
      ),
    );
  }

  _buildPaymentDetails() {
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
                    visible: viewModel.isCardPaymentEnabled.value,
                    child: CardField(
                        enablePostalCode: true,
                        onCardChanged: (card) async {
                          //await Stripe.instance.createPaymentMethod(params);
                          // try {
                          //   var paymentMethod =
                          //       await Stripe.instance.createPaymentMethod(
                          //     params: PaymentMethodParams.card(
                          //       paymentMethodData: PaymentMethodData(
                          //         billingDetails: BillingDetails(
                          //           name:
                          //               controller.defaultAddressModel?.name ??
                          //                   "",
                          //           email:
                          //               controller.defaultAddressModel?.email ??
                          //                   "",
                          //           phone:
                          //               controller.defaultAddressModel?.phone ??
                          //                   "",
                          //           address: null,
                          //         ),
                          //       ),
                          //     ),
                          //   );
                          //   debugPrint(
                          //       ">>>CardPaymentMethod: ${paymentMethod.id}");
                          //   controller.setPaymentIntentId(paymentMethod.id);
                          // } on StripeException catch (e) {
                          //   print(">>>stripeException: $e");
                          // }
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _singlePaymentOptionItem({title, value, icon, isEnabled}) {
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
                groupValue: viewModel.paymentType.value,
                onChanged: (value) {
                  viewModel.enableCardPayment(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemSection() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Obx(
        () => cartViewModel.cartItemsList.isEmpty
            ? NoDataFound(text: langKey.noCartItemFound.tr)
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cartViewModel.cartItemsList.length,
                itemBuilder: (context, index) {
                  return SingleCartItems(
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
                          child: couponTextField()),
                    ),

                    ///Apply Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          viewModel.redeemCoins();
                        },
                        child: CustomText(
                          title: langKey.redeemBtn.tr,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
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
                                  "(${cartViewModel.totalQtyCart.value} ${langKey.items.tr})",
                              style: caption),
                        ],
                      ),
                    ),
                    CustomPriceWidget(
                        title: "${cartViewModel.totalCartAmount.value}",
                        style: bodyText1),
                  ],
                ),
                AppConstant.spaceWidget(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(title: langKey.shippingFee.tr, style: bodyText1),
                    Obx(() => CustomPriceWidget(
                        title: "${viewModel.shippingCost.value}",
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
                        title: "${viewModel.totalDiscount.value}",
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
                          title: "${viewModel.totalAmount.value}"),
                    ),
                  ],
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
          ),
        ),
      ),
    );
  }

  Widget couponTextField() {
    return TextField(
      controller: viewModel.couponCodeController,
      cursorColor: kPrimaryColor,
      autofocus: false,
      style: bodyText1,
      enabled: viewModel.coinsModel.value.silver != null &&
          viewModel.coinsModel.value.silver!
              .isGreaterThan(fixedRedeemCouponThreshold),
      textInputAction: TextInputAction.search,
      // onChanged: controller.search,
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(Icons.search, color: kPrimaryColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightGreyColor,
            width: 0.5,
          ), //BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kLightGreyColor,
            width: 0.5,
          ), //BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        fillColor: kWhiteColor,
        contentPadding: EdgeInsets.zero,
        hintText:
            '${langKey.wantToRedeem.tr} ${viewModel.coinsModel.value.silver ?? 0} ${langKey.coins.tr}?',
        hintStyle: TextStyle(
          color: kLightColor,
          fontWeight: FontWeight.w600,
          fontSize: 13.0,
        ),
      ),
    );
  }

  Widget _confirmOrderButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: CustomTextBtn(
        width: 280,
        height: 50,
        title: langKey.confirmOrder.tr,
        onPressed: () {
          if (cartViewModel.totalCartAmount.value <=
              num.parse(
                  currencyController.convertCurrency(currentPrice: "1000")!)) {
            viewModel.generateOrderId();
            Get.to(PaymentView(
              orderId: viewModel.orderId.value,
              amount: 5,
            ));
            // AppConstant.displaySnackBar(
            //   langKey.errorTitle.tr,
            //   langKey.toProceedWithPurchase.tr,
            // );
            // //You cannot use Free Shipping Service under Rs1000
            // return;
          }
          // else if (viewModel.isCardPaymentEnabled.isFalse) {
          //   AppConstant.displaySnackBar(
          //       langKey.errorTitle.tr, langKey.preferredPayment.tr);
          //   return;
          // }

          else {
            // viewModel.makePayment(
            //     amount: viewModel.totalAmount.value
            //         .toString());
            viewModel.generateOrderId();
            Get.to(PaymentView(
              orderId: viewModel.orderId.value,
              amount: cartViewModel.totalCartAmount.value,
            ));
          }
        },
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
                    Divider(indent: 25, endIndent: 25, height: 20,),
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

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../controllers/controllers.dart';
import '../cart/cart_viewmodel.dart';

class CheckoutViewModel extends GetxController{

  final userModel = UserModel().obs;
  final noDefaultAddress = true.obs;
  final paymentType = ''.obs;
  final isCardPaymentEnabled = false.obs;
  final paymentMethodId = ''.obs;
  final shippingCost = 0.obs;
  final isRedeemedApplied = false.obs;
  final totalDiscount = 0.0.obs;
  final totalAmount = 0.0.obs;
  final coinsModel = CoinsModel().obs;
  TextEditingController couponCodeController = TextEditingController();

  CartViewModel cartViewModel = Get.find();

  @override
  void onInit() {
    getDefaultShippingAddress();
    fetchUserCoins();
    super.onInit();
  }

  setShippingCost(int cost){
    shippingCost.value = cost;
    setTotalAmount();
  }

  getDefaultShippingAddress()async{
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(
        url: "user/getDefaultShippingDetails",
      withAuthorization: true,
      withBearer: true,
    ).then((response) async {
      GlobalVariable.showLoader.value = false;
      if(response['success'] == true && response['data'] != null){
        userModel.value = UserModel.fromJson(response['data']);
        noDefaultAddress.value = false;
      }
    }).catchError((e){
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
    });
  }

  enableCardPayment(String value) {
    paymentType.value = value;
    isCardPaymentEnabled(value.contains("Credit Card") ? true : false);
  }

  setTotalAmount() {
    double netTotal = (cartViewModel.totalCartAmount.value + shippingCost.value) -
            totalDiscount.value;

    totalAmount.value = netTotal;
  }

  redeemCoins(){
    String? value = couponCodeController.text.isEmpty ? "0" : couponCodeController.text;
    applyRedeemCode(num.parse(value));
  }

  applyRedeemCode(num? value) {
    if (coinsModel.value != CoinsModel() &&
        value!.isGreaterThan(0) &&
        coinsModel.value.silver!.isGreaterThan(fixedRedeemCouponThreshold)) {
      isRedeemedApplied(true);
    } else {
      AppConstant.displaySnackBar(
        langKey.errorTitle.tr,
        langKey.needMoreCoins.tr,
      );
      isRedeemedApplied(false);
    }
    totalDiscount(value!.toDouble());
    setTotalAmount();
    /*var netAmount = totalAmount.value - value;
    amountAfterRedeeming(netAmount);*/
  }

  String convertStaticPrice({num? price}) {
    num? priceAfter = num.parse(
        currencyController.convertCurrency(currentPrice: price.toString())!);
    return "${AppConstant.getCurrencySymbol(currencyCode: currencyController.currency.value)} ${priceAfter.toStringAsFixed(2)}";
  }

  fetchUserCoins() async {

    // if (GlobalVariable.userModel!.token!.isNotEmpty) {
      await ApiBaseHelper().getMethod(
          url: 'coin/getUserCoins',
        withBearer: true,
        withAuthorization: true,
      ).then((response) {
        if(response['success'] == true && response['data'] != null){
          coinsModel.value = CoinsModel.fromJson(response['data']);
        }
        else{
          return;
        }
      }).catchError((e){

      });
    }
  }

  // Future<void> makePayment({String? amount}) async {
  //   Future.delayed(Duration(seconds: 2), () async {
  //     if (paymentMethodId.isNotEmpty)
  //       await sendPaymentIntent(paymentId: paymentMethodId.value);
  //     else {
  //       AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.paymentCardFailed.tr);
  //     }
  //   });
  // }

  // sendPaymentIntent({paymentId}) async {
  //   var cartItems = [];
  //   cartViewModel.cartItemsList.forEach((element) {
  //     cartItems.addAll([element.toOrderCreationJson()]);
  //   });
  //   JSON data = {
  //     "shippingPrice": shippingCost.value,
  //     "paymentMethod": "$paymentId",
  //     "redeemCoins": isRedeemedApplied.value,
  //     "cartItems": cartItems,
  //   };
  //   await _orderProvider
  //       .createPaymentIntent(token: authController.userToken, data: data)
  //       .then((ApiResponse? apiResponse) async {
  //     if (apiResponse != null) {
  //       if (apiResponse.success!) {
  //         await Stripe.instance
  //             .confirmPayment(
  //             paymentIntentClientSecret: apiResponse.data["client_secret"],
  //             data: PaymentMethodParams.card(
  //               paymentMethodData: PaymentMethodData(
  //                 billingDetails: BillingDetails(
  //                   name: defaultAddressModel?.name ?? "",
  //                   email: defaultAddressModel?.email ?? "",
  //                   phone: defaultAddressModel?.phone ?? "",
  //                   address: null,
  //                 ),
  //               ),
  //             ))
  //             .then((PaymentIntent paymentIntent) async {
  //           await createOrder(
  //             paymentMethod: isCardPaymentEnabled.isTrue ? "Card" : "COD",
  //             cartItems: cartItems,
  //           );
  //         }).catchError(onError);
  //       } else {
  //         showSnackBar(
  //             title: langKey.errorTitle.tr, message: apiResponse.message!);
  //       }
  //     } else
  //       showSnackBar(
  //         title: langKey.errorTitle,
  //         message: langKey.orderNotCreated.tr,
  //       );
  //   }).catchError(onError);
  // }
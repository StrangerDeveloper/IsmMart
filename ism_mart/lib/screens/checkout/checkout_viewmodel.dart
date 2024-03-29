import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

import '../../controllers/controllers.dart';
import '../cart/cart_viewmodel.dart';

class CheckoutViewModel extends GetxController {
  final userModel = UserModel().obs;
  final noDefaultAddress = true.obs;
  // final paymentType = ''.obs;
//  final isCardPaymentEnabled = false.obs;
  final paymentMethodId = ''.obs;
  final shippingCost = 250.obs;
  final isRedeemedApplied = false.obs;
  final totalDiscount = 0.0.obs;
  final totalAmount = 0.0.obs;
  final coinsModel = CoinsModel().obs;
  TextEditingController couponCodeController = TextEditingController();

  CartViewModel cartViewModel = Get.find();
  RxInt orderId = 0.obs;
  // generateOrderId() {
  //   Random random = Random();
  //   orderId.value = random.nextInt(100000);
  // }

  @override
  void onInit() {
    getDefaultShippingAddress();
    fetchUserCoins();
    setTotalAmount();

    super.onInit();
  }

  setShippingCost(int cost) {
    shippingCost.value = cost;
    setTotalAmount();
  }

  getDefaultShippingAddress() async {
    // GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .getMethod(
      url: "user/getDefaultShippingDetails",
      withAuthorization: true,
      withBearer: true,
    )
        .then((response) async {
      //  GlobalVariable.showLoader.value = false;
      if (response['success'] == true && response['data'] != null) {
        userModel.value = UserModel.fromJson(response['data']);
        noDefaultAddress.value = false;
      }
    }).catchError((e) {
      //  GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
    });
  }

  /*enableCardPayment(String value) {
    paymentType.value = value;
    isCardPaymentEnabled(value.contains("Credit Card") ? true : false);
  }*/

  void setTotalAmount() {
    double netTotal =
        (cartViewModel.totalCartAmount.value + shippingCost.value) -
            totalDiscount.value;
    totalAmount.value = netTotal;
  }

  void redeemCoins() {
    String? value =
        couponCodeController.text.isEmpty ? "0" : couponCodeController.text;
    applyRedeemCode(num.parse(value));
  }

  void applyRedeemCode(num? value) {
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
    await ApiBaseHelper()
        .getMethod(
      url: 'coin/getUserCoins',
      withBearer: true,
      withAuthorization: true,
    )
        .then((response) {
      if (response['success'] == true && response['data'] != null) {
        coinsModel.value = CoinsModel.fromJson(response['data']);
      } else {
        return;
      }
    }).catchError((e) {
      print(e);
    });
  }

  createOrder({paymentMethod = "Card"}) async {
    GlobalVariable.showLoader.value = true;
    JSON data = {
      "paymentMethod": paymentMethod,
      "shippingPrice": shippingCost.value,
      "shippingDetailsId": userModel.value.id,
      "redeemCoins": isRedeemedApplied.value,
      "exchangeRate": currencyController.currencyModel!.exchangeRate ?? 1,
      "cartItems": cartViewModel.cartItemsList,
    };
    await ApiBaseHelper()
        .postMethod(
            url: 'order/createOrder', body: data, withAuthorization: true)
        .then((response) {
      if (response['success'] == true && response['data'] != null) {
        GlobalVariable.showLoader.value = false;
        orderId.value = response['data']['orderId'];
        print(
            "hasnain order id order Id=>${orderId.value}  ${totalAmount.value}");
        AppConstant.displaySnackBar(langKey.success.tr, response['message']);
        LocalStorageHelper.clearAllCart();
        Get.back();
      } else if (response['data'] == null) {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, response['message']);
      } else {
        GlobalVariable.showLoader.value = false;
        print("hasnain order id res=> ${response['data']}");
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.orderNotCreated.tr);
      }
    }).catchError((e) {
      print(e);
    });

//order id
  }

  // void orderIdGenerate() async {
  //   var headers = {
  //     'authorization':
  //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjYsImlhbSI6InZlbmRvciIsInZpZCI6NCwiaWF0IjoxNjg1NDM0MzUwMjI4LCJleHAiOjE2ODU2MDcxNTAyMjh9.BxevcvNZedyC4zazgo9P0vp55CLs6tPpliX2Dzro6jI',
  //     'Content-Type': 'application/json',
  //     'Cookie':
  //         'XSRF-token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjM1NDQsImlhbSI6InZlbmRvciIsInZpZCI6MzUzNywiaWF0IjoxNjg5NjY4NjA2MjY4LCJleHAiOjE2ODk4NDE0MDYyNjh9.BOXSNzghWe8N6BPjqSHs-ISjDMHq9c3zUnVKTHrv7I4'
  //   };
  //   var request = http.Request(
  //       'POST', Uri.parse('https://ismmart-api.com/api/order/createOrder'));
  //   request.body = json.encode({
  //     "paymentMethod": "Card",
  //     "shippingPrice": 250,
  //     "shippingDetailsId": 401,
  //     "redeemCoins": false,
  //     "exchangeRate": 1,
  //     "cartItems": [
  //       {
  //         "productId": 14,
  //         "quantity": 2,
  //         "features": [],
  //         "Product": {
  //           "name": "Nivea Men Scrub",
  //           "thumbnail":
  //               "https://ismmart-bucket.s3.amazonaws.com/file-1671425168354.PNG",
  //           "vendorId": 4,
  //           "discountPrice": 376,
  //           "totalPrice": 752
  //         }
  //       }
  //     ]
  //   });
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();
  //   var data = await http.Response.fromStream(response);
  //   var res = jsonDecode(data.body);
  //   print("hasnain order id => $res");
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  // void showSuccessDialog({OrderResponse? response}) {
  //   Get.defaultDialog(
  //     title: langKey.orderInformation.tr,
  //     titleStyle: appBarTitleSize,
  //     barrierDismissible: false,
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Icon(
  //           Icons.check_circle,
  //           color: kPrimaryColor,
  //           size: 70.0,
  //         ),
  //         AppConstant.spaceWidget(height: 10.0),
  //         CustomText(
  //           title: langKey.paymentSuccessful.tr,
  //           textAlign: TextAlign.center,
  //           weight: FontWeight.w600,
  //         ),
  //         CustomText(
  //           title: "${langKey.orderId.tr} #${response!.data["orderId"]}",
  //           size: 17,
  //           weight: FontWeight.bold,
  //         ),
  //         AppConstant.spaceWidget(height: 10),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             /* CustomButton(
  //               onTap: () {
  //                 Get.offNamed(Routes.buyerOrdersRoute);
  //               },
  //               text: "My Orders",
  //               width: 100,
  //               height: 35,
  //               color: kPrimaryColor,
  //             ),*/
  //             CustomTextBtn(
  //               onPressed: () {
  //                 Get.offAllNamed(Routes.initRoute);
  //                 //Get.back();
  //               },
  //               title: langKey.continueShopping.tr,
  //               width: 200,
  //               height: 40,
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
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
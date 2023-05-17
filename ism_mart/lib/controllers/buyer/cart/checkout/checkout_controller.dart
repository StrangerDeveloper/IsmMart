import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class CheckoutController extends GetxController {
  final OrderProvider _orderProvider;
  final AuthController authController;
  final CartController cartController;

  CheckoutController(
      this._orderProvider, this.authController, this.cartController);

  var countryId = 0.obs;
  var cityId = 0.obs;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var zipCodeController = TextEditingController();

  var couponCodeController = TextEditingController();

  var isLoading = false.obs;

  var shippingAddressId = 0.obs;

  var shippingCost = 0.obs;
  var totalAmount = 0.0.obs;
  var totalDiscount = 0.0.obs;
  var amountAfterRedeeming = 0.0.obs;

  setShippingCost(int cost) {
    shippingCost(cost);
    setTotalAmount();
  }

  setTotalAmount() {
    double netTotal =
        (cartController.totalCartAmount.value + shippingCost.value) -
            totalDiscount.value;

    totalAmount.value = netTotal;
  }

  var isCardPaymentEnabled = false.obs;
  var _paymentType = "".obs;

  enableCardPayment(String? value) {
    _paymentType.value = value!;
    isCardPaymentEnabled(value.contains("Credit Card") ? true : false);
  }

  String? get paymentType => _paymentType.value;

  //bool? get isCreditCardEnabled => _isCardPaymentEnabled.value;
  var _isRedeemApplied = false.obs;

  applyRedeemCode(num? value) {
    if (coinsModel != null &&
        value!.isGreaterThan(0) &&
        coinsModel!.silver!.isGreaterThan(fixedRedeemCouponThreshold)) {
      _isRedeemApplied(true);
      print(">>>Caleedd true");
    } else {
      print(">>>Caleedd");
      AppConstant.displaySnackBar(
        langKey.errorTitle.tr,
        langKey.needMoreCoins.tr,
      );
      _isRedeemApplied(false);
    }
    totalDiscount(value!.toDouble());
    setTotalAmount();
    /*var netAmount = totalAmount.value - value;
    amountAfterRedeeming(netAmount);*/
  }

  @override
  void onInit() {
    // TO: implement onInit
    super.onInit();

    getDefaultAddress();
    getAllShippingAddresses();
  }

  @override
  void onReady() {
    super.onReady();

    ///Set Standard shipping by default
    setShippingCost(250);
    cartController.totalCartAmount.listen((p0) {
      print(">>>Amount: $p0");
      cartController.totalCartAmount(p0);
      setTotalAmount();
    });

    /// fetch users Coins
    // authController.fetchUserCoins();
  }

  CoinsModel? get coinsModel => authController.coinsModel;

  void setSelectedCountry(CountryModel? model) async {
    authController.selectedCountry(model);
    //getCityByCountryName(name);
    countryId(model!.id);
    authController.cities.clear();
    authController.update();
    await authController.getCitiesByCountry(countryId: model.id!);
  }

  void getCityByCountryName(String name) {
    if (authController.countries.isNotEmpty) {
      int? cId = authController.countries
          .firstWhere(
              (element) => element.name!.toLowerCase() == name.toLowerCase(),
              orElse: () => CountryModel())
          .id;
      countryId(cId!);
      authController.getCitiesByCountry(countryId: cId);
    }
  }

  void setSelectedCity(CountryModel model) {
    authController.selectedCity(model);
    cityId(model.id);
    //getCityIdByName(value);
  }

  getCityIdByName(String? city) {
    cityId(authController.cities.isNotEmpty
        ? authController.cities
            .firstWhere(
                (element) => element.name!.toLowerCase() == city!.toLowerCase())
            .id
        : 0);
  }

  getCartItemsList() {
    return cartController.cartItemsList;
  }

  Future<void> addShippingAddress() async {
    UserModel newUserAddress = UserModel(
        name: nameController.text,
        address: addressController.text,
        phone: phoneController.text,
        zipCode: zipCodeController.text,
        countryId: countryId.value,
        cityId: cityId.value,
        token: authController.userToken!);
    isLoading(true);
    await authController.authProvider
        .addShippingAddress(userModel: newUserAddress)
        .then((ApiResponse? apiResponse) {
      isLoading(false);
      if (apiResponse != null) {
        if (apiResponse.success!) {
          AppConstant.displaySnackBar(langKey.success.tr, apiResponse.message);
          clearControllers();
          getDefaultAddress();
          getAllShippingAddresses();
        } else
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, apiResponse.message);
      } else
        AppConstant.displaySnackBar(
          langKey.errorTitle,
          langKey.someThingWentWrong.tr,
        );
    }).catchError(onError);
  }

  var _userDefaultAddressModel = UserModel().obs;

  UserModel? get defaultAddressModel => _userDefaultAddressModel.value;

  getDefaultAddress() async {
    await authController.authProvider
        .getDefaultShippingAddress(token: authController.userToken!)
        .then((user) {
      _userDefaultAddressModel(user);
    }).catchError(onError);
  }

  var shippingAddressList = <UserModel>[].obs;

  getAllShippingAddresses() async {
    await authController.authProvider
        .getShippingAddress(token: authController.userToken!)
        .then((addresses) {
      shippingAddressList.clear();
      shippingAddressList.addAll(addresses);
    }).catchError(onError);
  }

  changeDefaultShippingAddress({addressId}) async {
    isLoading(true);
    await authController.authProvider
        .changeDefaultAddress(
            token: authController.userToken!,
            addressId: addressId ?? shippingAddressId.value)
        .then((ApiResponse? apiResponse) {
      isLoading(false);
      if (apiResponse != null) {
        if (apiResponse.success!) {
          //shippingAddressList.refresh();
          //update();
          getAllShippingAddresses();
          getDefaultAddress();
          //Get.back();
          AppConstant.displaySnackBar("success", apiResponse.message);
          //getAllShippingAddresses();
        } else
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, apiResponse.message);
      } else
        AppConstant.displaySnackBar(
          langKey.errorTitle,
          langKey.someThingWentWrong.tr,
        );
    }).catchError(onError);
  }

  updateShippingAddress(UserModel? userModel) async {
    userModel!.name = nameController.text;
    userModel.address = addressController.text;
    userModel.phone = phoneController.text;
    userModel.zipCode = zipCodeController.text;
    userModel.token = authController.userToken!;

    isLoading(true);
    await authController.authProvider
        .updateShippingAddress(userModel: userModel)
        .then((ApiResponse? apiResponse) {
      isLoading(false);
      if (apiResponse != null) {
        if (apiResponse.success!) {
          //Get.back();
          AppConstant.displaySnackBar("success", apiResponse.message);
          clearControllers();

          getAllShippingAddresses();
          getDefaultAddress();
        } else
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, apiResponse.message);
      } else
        AppConstant.displaySnackBar(
            langKey.errorTitle, langKey.someThingWentWrong.tr);
    }).catchError(onError);

    //update();
  }

  deleteShippingAddress(id) async {
    await authController.authProvider
        .deleteShippingAddress(token: authController.userToken, addressID: id)
        .then((ApiResponse? apiResponse) {
      if (apiResponse != null) {
        if (apiResponse.success!) {
          //Get.back();
          AppConstant.displaySnackBar("success", apiResponse.message);
          getAllShippingAddresses();
        } else
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, apiResponse.message);
      } else
        AppConstant.displaySnackBar(
            langKey.errorTitle, langKey.someThingWentWrong.tr);
    }).catchError(onError);
  }

  //late Map<String, dynamic>? paymentIntent;
  //var paymentIntent = Map<String, dynamic>().obs;
  var _paymentMethodId = "".obs;

  setPaymentIntentId(paymentMethodId) {
    _paymentMethodId(paymentMethodId);
  }

  Future<void> makePayment({String? amount}) async {
    // try {
    isLoading(true);
    Future.delayed(Duration(seconds: 2), () async {
      if (_paymentMethodId.isNotEmpty)
        await sendPaymentIntent(paymentId: _paymentMethodId.value);
      else {
        showSnackBar(
            message: "Payment Information  is not Correct", title: "Error");
        isLoading(false);
        print("Payment intent is null");
      }
    });

    /*  //STEP 1: Create Payment Intent
     // paymentIntent = await createPaymentIntent(amount!, 'PKR');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  appearance: PaymentSheetAppearance(
                      primaryButton: PaymentSheetPrimaryButtonAppearance(
                    shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
                    colors: PaymentSheetPrimaryButtonTheme(
                      light: PaymentSheetPrimaryButtonThemeColors(
                        background: kPrimaryColor,
                        text: kWhiteColor,
                        border: kLightGreyColor,
                      ),
                    ),
                  )),
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // customFlow: true,
                  //Gotten from payment intent
                  //style: ThemeMode.light,
                  merchantDisplayName: 'ISMMART'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();*/
    /*} catch (err) {
      isLoading(false);
      print(">>>MakePaymentError: $err");
      throw Exception(err);
    }*/
  }

  /*createPaymentIntent(String amount, String currency) async {
    try {
      //Request body

      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency
      };

      //Make post request to Stripe
      return _apiProvider.postStripePaymentInfo(data: body);
    } catch (err) {
      isLoading(false);
      throw Exception(err.toString());
    }
  }*/

  /* calculateAmount(String amount) {
    final a = ((double.parse(amount)) * 100).round();
    return a.toString();
  }*/

  /* displayPaymentSheet() async {
    isLoading(false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        //Clear paymentIntent variable after successful payment

        debugPrint("PaymentResponse: ${paymentIntent!['id']}");
        debugPrint("PaymentResponse: ${paymentIntent!['payment_method']}");
        print("PaymentResponse: ${paymentIntent}");

        await sendPaymentIntent(paymentId: paymentIntent!['id']);
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }*/

  void showSnackBar({title, message}) {
    isLoading(false);
    AppConstant.displaySnackBar(title, message);
  }

  sendPaymentIntent({paymentId}) async {
    var cartItems = [];
    cartController.cartItemsList.forEach((element) {
      cartItems.addAll([element.toOrderCreationJson()]);
    });
    JSON data = {
      "shippingPrice": shippingCost.value,
      "paymentMethod": "$paymentId",
      "redeemCoins": _isRedeemApplied.value,
      "cartItems": cartItems,
    };
    await _orderProvider
        .createPaymentIntent(token: authController.userToken, data: data)
        .then((ApiResponse? apiResponse) async {
      if (apiResponse != null) {
        if (apiResponse.success!) {
          await Stripe.instance
              .confirmPayment(
                  paymentIntentClientSecret: apiResponse.data["client_secret"],
                  data: PaymentMethodParams.card(
                    paymentMethodData: PaymentMethodData(
                      billingDetails: BillingDetails(
                        name: defaultAddressModel?.name ?? "",
                        email: defaultAddressModel?.email ?? "",
                        phone: defaultAddressModel?.phone ?? "",
                        address: null,
                      ),
                    ),
                  ))
              .then((PaymentIntent paymentIntent) async {
            await createOrder(
              paymentMethod: isCardPaymentEnabled.isTrue ? "Card" : "COD",
              cartItems: cartItems,
            );
          }).catchError(onError);
        } else {
          showSnackBar(
              title: langKey.errorTitle.tr, message: apiResponse.message!);
        }
      } else
        showSnackBar(
          title: langKey.errorTitle,
          message: langKey.orderNotCreated.tr,
        );
    }).catchError(onError);
  }

  onError(error) {
    isLoading(false);
    debugPrint(">>>>ConfirmPayment: $error");
    showSnackBar(title: langKey.errorTitle, message: error);
  }

  createOrder({paymentMethod = "COD", cartItems}) async {
    JSON data = {
      "paymentMethod": paymentMethod,
      "shippingPrice": shippingCost.value,
      "shippingDetailsId": defaultAddressModel!.id,
      "redeemCoins": _isRedeemApplied.value,
      "cartItems": cartItems,
    };

    await _orderProvider
        .createOrder(token: authController.userToken, data: data)
        .then((OrderResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          showSnackBar(title: langKey.success, message: response.message!);
          showSuccessDialog(response: response);
          // paymentIntent = null;
          LocalStorageHelper.clearAllCart();
        } else
          showSnackBar(title: langKey.errorTitle, message: response.message!);
      } else
        showSnackBar(
          title: langKey.errorTitle,
          message: langKey.orderNotCreated.tr,
        );
    }).catchError(onError);
  }

  void showSuccessDialog({OrderResponse? response}) {
    Get.defaultDialog(
      title: langKey.orderInformation.tr,
      titleStyle: appBarTitleSize,
      barrierDismissible: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            color: kPrimaryColor,
            size: 70.0,
          ),
          AppConstant.spaceWidget(height: 10.0),
          CustomText(
            title: langKey.paymentSuccessful.tr,
            textAlign: TextAlign.center,
            weight: FontWeight.w600,
          ),
          CustomText(
            title: "${langKey.orderId.tr} #${response!.data["orderId"]}",
            size: 17,
            weight: FontWeight.bold,
          ),
          AppConstant.spaceWidget(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /* CustomButton(
                onTap: () {
                  Get.offNamed(Routes.buyerOrdersRoute);
                },
                text: "My Orders",
                width: 100,
                height: 35,
                color: kPrimaryColor,
              ),*/
              CustomButton(
                onTap: () {
                  Get.offAllNamed(Routes.initRoute);
                  //Get.back();
                },
                text: langKey.continueShopping.tr,
                width: 200,
                height: 40,
                color: kPrimaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }

  clearControllers() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    zipCodeController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    clearControllers();
  }
}

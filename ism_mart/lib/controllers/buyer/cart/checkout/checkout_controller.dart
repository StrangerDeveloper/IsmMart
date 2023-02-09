import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CheckoutController extends GetxController {
  final ApiProvider _apiProvider;
  final OrderProvider _orderProvider;
  final AuthController authController;
  final CartController cartController;

  CheckoutController(this._orderProvider, this._apiProvider,
      this.authController, this.cartController);

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

  setShippingCost(int cost){
    shippingCost(cost);
    double totalCart = cartController.totalCartAmount.value;
    double subTotal = totalCart + cost;
    totalAmount(subTotal);
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
  }

  void setSelectedCountry(CountryModel? model) async{
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
        .then((UserResponse? userResponse) {
      isLoading(false);
      if (userResponse != null) {
        if (userResponse.success!) {
          Get.back();
          AppConstant.displaySnackBar("success", userResponse.message);
          clearControllers();
          getDefaultAddress();
          getAllShippingAddresses();
        } else
          AppConstant.displaySnackBar('error', userResponse.message);
      } else
        AppConstant.displaySnackBar('error', "something went wrong!");
    }).catchError((error) {
      isLoading(false);
      debugPrint("RegisterStore: Error $error");
    });
  }

  var _userDefaultAddressModel = UserModel().obs;

  UserModel? get defaultAddressModel => _userDefaultAddressModel.value;

  getDefaultAddress() async {
    await authController.authProvider
        .getDefaultShippingAddress(token: authController.userToken!)
        .then((user) {
      _userDefaultAddressModel(user);
    })/*.catchError((error) {
      debugPrint(">>>>GetDefaultAddress: $error");
    })*/;
  }

  var shippingAddressList = <UserModel>[].obs;

  getAllShippingAddresses() async {
    shippingAddressList.clear();
    await authController.authProvider
        .getShippingAddress(token: authController.userToken!)
        .then((addresses) {
          print(">>>>Addresses: ${addresses.last.toAddressJson()}");
      shippingAddressList.addAll(addresses);
    })/*.catchError((error) {
      debugPrint(">>>>getAllShippingAddresses: $error");
    })*/;
  }

  changeDefaultShippingAddress() async {
    isLoading(true);
    await authController.authProvider
        .changeDefaultAddress(
            token: authController.userToken!,
            addressId: shippingAddressId.value)
        .then((UserResponse? userResponse) {
      isLoading(false);
      if (userResponse != null) {
        if (userResponse.success!) {
          //getDefaultAddress();
          Get.back();
          AppConstant.displaySnackBar("success", userResponse.message);
          //getAllShippingAddresses();
        } else
          AppConstant.displaySnackBar('error', userResponse.message);
      } else
        AppConstant.displaySnackBar('error', "something went wrong!");
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>>changeShippingAddress: Error $error");
    });

    update();
  }

  updateShippingAddress(UserModel? userModel) async {

    print("USERSADDRESS: ${userModel!.toAddressJson()}");
    userModel!.name = nameController.text;
    userModel.address = addressController.text;
    userModel.phone = phoneController.text;
    userModel.zipCode = zipCodeController.text;
    userModel.token = authController.userToken!;



    isLoading(true);
    await authController.authProvider
        .updateShippingAddress(userModel: userModel)
        .then((UserResponse? userResponse) {
      isLoading(false);
      if (userResponse != null) {
        if (userResponse.success!) {
          Get.back();
          AppConstant.displaySnackBar("success", userResponse.message);
          clearControllers();
        } else
          AppConstant.displaySnackBar('error', userResponse.message);
      } else
        AppConstant.displaySnackBar('error', "something went wrong!");
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>>UpdateShippingAddress: Error $error");
    });

    update();
  }

  deleteShippingAddress(id) async {
    await authController.authProvider
        .deleteShippingAddress(token: authController.userToken, addressID: id)
        .then((UserResponse? userResponse) {
      if (userResponse != null) {
        if (userResponse.success!) {
          Get.back();
          AppConstant.displaySnackBar("success", userResponse.message);
        } else
          AppConstant.displaySnackBar('error', userResponse.message);
      } else
        AppConstant.displaySnackBar('error', "something went wrong!");
    }).catchError((error) {
      debugPrint(">>>>DeleteShippingAddress: Error $error");
    });

    update();
  }

  late Map<String, dynamic>? paymentIntent;

  Future<void> makePayment({String? amount}) async {
    try {
      isLoading(true);
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(amount!, 'PKR');

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
                  )
                ),
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'],
                 // customFlow: true,
                  //Gotten from payment intent
                  //style: ThemeMode.light,
                  merchantDisplayName: 'ISMMART'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
     } catch (err) {
      isLoading(false);
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
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
  }

  calculateAmount(String amount) {
    final a = ((double.parse(amount)) * 100).round();
    return a.toString();
  }

  displayPaymentSheet() async {
    isLoading(false);
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment

        debugPrint("PaymentResponse: ${paymentIntent}");

        createOrder(paymentMethod: "Card");
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }

  void showSnackBar({title, message}) {
    AppConstant.displaySnackBar(title, message);
  }

  void createOrder({paymentMethod = "COD"}) {
    JSON data = {
      "paymentMethod": paymentMethod,
      "shippingPrice": 100,
      "shippingDetailsId": defaultAddressModel!.id,
      "cartItems": cartController.cartItemsList.toJson(),
    };

    _orderProvider
        .createOrder(token: authController.userToken, data: data)
        .then((OrderResponse? response) {
      if (response != null) {
        if (response.success!) {
          showSnackBar(title: 'success', message: response.message!);
          showSuccessDialog(response: response);
          paymentIntent = null;

          LocalStorageHelper.clearAllCart();
        } else
          showSnackBar(title: 'error', message: response.message!);
      } else
        showSnackBar(
            title: 'error', message: "Something went wrong! Order Not created");
    });
  }

  void showSuccessDialog({OrderResponse? response}) {
    Get.defaultDialog(
      title: "Order Information",
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
            title: "Payment Successful!, You're Order has been Placed!",
            textAlign: TextAlign.center,
            weight: FontWeight.w600,
          ),
          CustomText(
            title: "OrderID #${response!.data!.orderId!}",
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
                text: "Continue Shopping",
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
    // TODO: implement onClose
    super.onClose();
    clearControllers();
  }
}

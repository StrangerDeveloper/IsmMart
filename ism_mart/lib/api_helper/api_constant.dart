import 'package:flutter/foundation.dart';

class ApiConstant {
  ApiConstant._();

  //static const baseUrl = "https://ism-mart-ecommerce-5.herokuapp.com/api/";
  //static const baseUrl = "http://3.83.164.216:5000/api/";
  ///Development
  //static const baseUrl = "http://18.212.34.27:5000/api/";
  static const baseUrl = kDebugMode
      ? "https://ismmart-api.com/api/"
      : "https://ismmart-backend.com/api/";

  ///Production
  //static const baseUrl = "http://3.6.43.56:5000/api/";
  //static const baseUrl = "https://ismmart-backend.com/api/";

  static const stripeBaseUrl = "https://api.stripe.com/v1/";

  static const SESSION_EXPIRED = "Session is expired";

  static String getBaseUrl({calledStripe = false}) {
    if (calledStripe) return stripeBaseUrl;
    return baseUrl;
  }
}

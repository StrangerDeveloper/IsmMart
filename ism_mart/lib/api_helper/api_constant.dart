class ApiConstant {
  ApiConstant._();

  //static const baseUrl = "https://ism-mart-ecommerce-5.herokuapp.com/api/";
  //static const baseUrl = "http://3.83.164.216:5000/api/";
  ///API-BASE-URL
  //static const baseUrl = "http://18.212.34.27:5000/api/";
  static const testBaseUrl = "https://ismmart-api.com/api/";
  static const liveBaseUrl = "https://ismmart-backend.com/api/";

  ///Production
  //static const baseUrl = "http://3.6.43.56:5000/api/";
  //static const baseUrl = "https://ismmart-backend.com/api/";

  //static const stripeBaseUrl = "https://api.stripe.com/v1/";

  // static const live_pk =
  //     "pk_live_51LrbOmEmpuNuAXn2Gq2LMtj73x7dlz4uX8UYQn1coVIFDK69qc3d2td9ttdGp5Pnv1u2vrdxyYXNoeuXMk4gbTFu00sENXZzqS";
  // static const test_pk =
  //     "pk_test_51LrbOmEmpuNuAXn2fUnpk1ER8KmDmnjMgWf4bE8Bd7TyQt9pr5IpGGi5y9rBf3cSTj6jNxMUo71bBKb009L7Ws2T000Tf2jBP4";
  //
  // static const live_sk =
  //     "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";
  // static const test_sk =
  //     "sk_test_51M7CqbAqAePi9vIiIaBO0wAHIUmAmrUTTM89z5dx6MfbYK10pFs8YOJgxo3qrz2jXdRsWqbEuVNhaoLS4wkTfU3p00EweFGR7b";

  static const live_currency_exchange_api_key =
      "eJAxu0n1qnOeT9Jl6YuYbnuSvgAYq8Cm"; //temporary key
  //"dYkOzqTeDZkENZyxkCiennS5kvUDbcoA";
  static const test_currency_exchange_api_key =
      "GfHmdIjzz5iYzBNC2GbVOpDOWt4cg7XJ";

  // 'O8SwtgaidFLGnv15tOvXenR7f8Zeodfc'
  // //'28ctJvWImBjcvSKiiGTJ3GH3frjz3Nj7'

  // static const SESSION_EXPIRED = "Session is expired";

///////////////////////////////////////////////////////////////////////////
  /// FOR MAKING BUILD 0R APK... Production (Live) APIS
  ///////////////////////////////////////////////////////////////////////////

  // static const baseUrl = liveBaseUrl;
  // static const PUBLISHABLE_KEY = live_pk;
  // static const SECRET_KEY = live_sk;
  // static const CURRENCY_EXCHANGE_API_KEY = live_currency_exchange_api_key;

  static const baseUrl = testBaseUrl;
  //static const PUBLISHABLE_KEY = test_pk;
  //static const SECRET_KEY = test_sk;
  static const CURRENCY_EXCHANGE_API_KEY = test_currency_exchange_api_key;
///////////////////////////////////////////////////////////////////////////
}

<<<<<<< Updated upstream
import 'package:get/get.dart';

class PaymentIntentResponse {
  PaymentIntentResponse({
    this.success,
    this.message,
    this.data,
  });
=======
// class PaymentIntentResponse {
//   PaymentIntentResponse({
//     this.success,
//     this.message,
//     this.data,
//   });
>>>>>>> Stashed changes

//   bool? success;
//   String? message;
//   dynamic data;

<<<<<<< Updated upstream
  factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentIntentResponse(
          success: json["success"],
          message: json["message"],
          data: json["data"] /*== null || (json['data'] is List)
              ? null
              : PaymentIntentModel.fromJson(json["data"])*/);
=======
//   factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
//       PaymentIntentResponse(
//           success: json["success"],
//           message: json["message"],
//           data: json[
//               "data"] /*== null || (json['data'] is List)
//               ? null
//               : PaymentIntentModel.fromJson(json["data"])*/
//           );
>>>>>>> Stashed changes

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data!.toJson(),
//       };
// }

class PaymentIntentModel {
  String? clientSecret;

  PaymentIntentModel({this.clientSecret});

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) =>
      PaymentIntentModel(clientSecret: json["client_secret"]);

  Map<String, dynamic> toJson() => {
        "client_secret": clientSecret,
      };
}

class PaymentIntentModel {
  String? clientSecret;

  PaymentIntentModel({this.clientSecret});

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) =>
      PaymentIntentModel(clientSecret: json["client_secret"]);

  Map<String, dynamic> toJson() => {
        "client_secret": clientSecret,
      };
}

class CurrencyModel {
  final DateTime? date;
  final double? exchangeRate; //based on 1 PKR
  final bool? success;
  final String? from, to;

  CurrencyModel({
    this.date,
    this.exchangeRate,
    this.success,
    this.from,
    this.to,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        exchangeRate: json["result"]?.toDouble(),
        success: json["success"],
      );

  factory CurrencyModel.fromLocalStorageJson(Map<String, dynamic> json) =>
      CurrencyModel(
          exchangeRate: json["result"]?.toDouble(),
          from: json['from'],
          to: json['to']);

  Map<String, dynamic> toJson() => {
        "result": exchangeRate,
        "success": success,
      };

  Map<String, dynamic> toLocalStorageJson() =>
      {"result": exchangeRate, "from": from, "to": to};
}

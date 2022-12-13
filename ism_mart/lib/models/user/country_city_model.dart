List<CountryModel> countryModelFromApiResponse(jsonResponse) => jsonResponse
    .map((data) => data != null ? CountryModel.fromJson(data) : CountryModel())
    .toList();

class CountryModel {
  CountryModel({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.countryId,
    this.createdAt,
    this.updatedAt,
  });

  int? id, countryId;
  String? name;
  String? latitude, longitude;
  DateTime? createdAt, updatedAt;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        countryId: json["countryId"] == null ? null : json["countryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude == null ? 0 : latitude,
        "longitude": longitude == null ? 0.0 : longitude,
        "countryId": countryId == null ? 0.0 : countryId,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

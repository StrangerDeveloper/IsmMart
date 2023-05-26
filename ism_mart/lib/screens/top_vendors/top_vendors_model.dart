class TopVendorsModel {
  int? id;
  String? storeName;
  int? rating;
  String? storeImage;
  String? totalSold;
  int? totalProducts;

  TopVendorsModel(
      {this.id,
      this.storeName,
      this.rating,
      this.storeImage,
      this.totalSold,
      this.totalProducts});

  TopVendorsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['storeName'];
    rating = json['rating'];
    storeImage = json['storeImage'];
    totalSold = json['totalSold'];
    totalProducts = json['totalProducts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storeName'] = this.storeName;
    data['rating'] = this.rating;
    data['storeImage'] = this.storeImage;
    data['totalSold'] = this.totalSold;
    data['totalProducts'] = this.totalProducts;
    return data;
  }
}

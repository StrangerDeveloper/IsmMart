class VendorProduct {
  int? id;
  String? name;
  String? thumbnail;
  int? stock;
  num? price;
  num? discount;
  int? rating;
  String? status;
  int? totalReviews;
  num? discountPrice;

  VendorProduct(
      {this.id,
        this.name,
        this.thumbnail,
        this.stock,
        this.price,
        this.discount,
        this.rating,
        this.status,
        this.totalReviews,
        this.discountPrice});

  VendorProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
    stock = json['stock'];
    price = json['price'];
    discount = json['discount'];
    rating = json['rating'];
    status = json['status'];
    totalReviews = json['totalReviews'];
    discountPrice = json['discountPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    data['stock'] = this.stock;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['totalReviews'] = this.totalReviews;
    data['discountPrice'] = this.discountPrice;
    return data;
  }
}

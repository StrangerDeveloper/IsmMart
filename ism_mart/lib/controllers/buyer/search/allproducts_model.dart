class AllProductsModel {
  int? id;
  String? name;
  int? price;
  String? thumbnail;
  int? stock;
  int? discount;

  AllProductsModel(
      {this.id,
      this.name,
      this.price,
      this.thumbnail,
      this.stock,
      this.discount});

  AllProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    thumbnail = json['thumbnail'];
    stock = json['stock'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['thumbnail'] = this.thumbnail;
    data['stock'] = this.stock;
    data['discount'] = this.discount;
    return data;
  }
}

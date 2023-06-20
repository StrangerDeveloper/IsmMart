import 'package:ism_mart/exports/exports_model.dart';

class SearchProductResponse {
  SearchProductResponse({
    required this.products,
    required this.stores,
  });

  Product products;
  List<SellerModel> stores;

  factory SearchProductResponse.fromJson(Map<String, dynamic> json) {
    return SearchProductResponse(
      products: Product.fromJson(json["products"]),
      stores: List<SellerModel>.from(
          json["stores"].map((x) => SellerModel.fromJson(x))),
    );
  }

  /*factory SearchProductResponse.fromJson(Map<String, dynamic> json) => SearchProductResponse(
    products: Product.fromJson(json["products"]),
    stores: List<SellerModel>.from(json["stores"].map((x) => SellerModel.fromJson(x))),
  );*/

  Map<String, dynamic> toJson() => {
        "products": products.toJson(),
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.count,
    this.productRows,
  });

  int? count;
  List<ProductModel>? productRows;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      count: json["count"],
      productRows: List<ProductModel>.from(
          json["rows"].map((x) => ProductModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(productRows!.map((x) => x.toJson())),
      };
}

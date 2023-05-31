class BuyerProfileNewModel {
  // int? id;
  // String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? image;
  String? address;
  // String? role;
  // bool? emailVerified;
  // Vendor? vendor;
  // Country? country;
  // Country? city;

  BuyerProfileNewModel(
      {
        // this.id,
        // this.email,
        this.firstName,
        this.lastName,
        this.phone,
        this.image,
        this.address,
        // this.role,
        // this.emailVerified,
        // this.vendor,
        // this.country,
        // this.city
      });

  BuyerProfileNewModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
    // role = json['role'];
    // emailVerified = json['email_verified'];
    // vendor =
    // json['Vendor'] != null ? new Vendor.fromJson(json['Vendor']) : null;
    // country =
    // json['Country'] != null ? new Country.fromJson(json['Country']) : null;
    // city = json['City'] != null ? new Country.fromJson(json['City']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    // data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['address'] = this.address;
    // data['role'] = this.role;
    // data['email_verified'] = this.emailVerified;
    // if (this.vendor != null) {
    //   data['Vendor'] = this.vendor!.toJson();
    // }
    // if (this.country != null) {
    //   data['Country'] = this.country!.toJson();
    // }
    // if (this.city != null) {
    //   data['City'] = this.city!.toJson();
    // }
    return data;
  }
}

// class Vendor {
//   int? id;
//   String? storeName;
//   String? storeDesc;
//   String? storeURL;
//   String? storeCategory;
//   int? storeNtn;
//   Null? storePhone;
//   String? storeCity;
//   Null? storeAddress;
//   String? ownerName;
//   int? ownerCnic;
//   String? status;
//   String? visibility;
//   int? rating;
//   String? stripeCustomerId;
//   String? phone;
//   bool? premium;
//   String? membership;
//   String? bankName;
//   String? accountTitle;
//   String? accountNumber;
//   String? storeImage;
//   String? coverImage;
//   String? createdAt;
//
//   Vendor(
//       {this.id,
//         this.storeName,
//         this.storeDesc,
//         this.storeURL,
//         this.storeCategory,
//         this.storeNtn,
//         this.storePhone,
//         this.storeCity,
//         this.storeAddress,
//         this.ownerName,
//         this.ownerCnic,
//         this.status,
//         this.visibility,
//         this.rating,
//         this.stripeCustomerId,
//         this.phone,
//         this.premium,
//         this.membership,
//         this.bankName,
//         this.accountTitle,
//         this.accountNumber,
//         this.storeImage,
//         this.coverImage,
//         this.createdAt});
//
//   Vendor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     storeName = json['storeName'];
//     storeDesc = json['storeDesc'];
//     storeURL = json['storeURL'];
//     storeCategory = json['storeCategory'];
//     storeNtn = json['storeNtn'];
//     storePhone = json['storePhone'];
//     storeCity = json['storeCity'];
//     storeAddress = json['storeAddress'];
//     ownerName = json['ownerName'];
//     ownerCnic = json['ownerCnic'];
//     status = json['status'];
//     visibility = json['visibility'];
//     rating = json['rating'];
//     stripeCustomerId = json['stripeCustomerId'];
//     phone = json['phone'];
//     premium = json['premium'];
//     membership = json['membership'];
//     bankName = json['bankName'];
//     accountTitle = json['accountTitle'];
//     accountNumber = json['accountNumber'];
//     storeImage = json['storeImage'];
//     coverImage = json['coverImage'];
//     createdAt = json['createdAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['storeName'] = this.storeName;
//     data['storeDesc'] = this.storeDesc;
//     data['storeURL'] = this.storeURL;
//     data['storeCategory'] = this.storeCategory;
//     data['storeNtn'] = this.storeNtn;
//     data['storePhone'] = this.storePhone;
//     data['storeCity'] = this.storeCity;
//     data['storeAddress'] = this.storeAddress;
//     data['ownerName'] = this.ownerName;
//     data['ownerCnic'] = this.ownerCnic;
//     data['status'] = this.status;
//     data['visibility'] = this.visibility;
//     data['rating'] = this.rating;
//     data['stripeCustomerId'] = this.stripeCustomerId;
//     data['phone'] = this.phone;
//     data['premium'] = this.premium;
//     data['membership'] = this.membership;
//     data['bankName'] = this.bankName;
//     data['accountTitle'] = this.accountTitle;
//     data['accountNumber'] = this.accountNumber;
//     data['storeImage'] = this.storeImage;
//     data['coverImage'] = this.coverImage;
//     data['createdAt'] = this.createdAt;
//     return data;
//   }
// }
//
// class Country {
//   int? id;
//   String? name;
//
//   Country({this.id, this.name});
//
//   Country.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     return data;
//   }
// }

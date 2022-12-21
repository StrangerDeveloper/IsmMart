import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SellersController extends GetxController {
  final SellersApiProvider _apiProvider;
  final CategoryController categoryController;
  final OrderController orderController;

  SellersController(
      this._apiProvider,this.categoryController, this.orderController);

  var pageViewController = PageController(initialPage: 0);

  var appBarTitle = "Dashboard".obs;
  var isLoading = false.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getToken();
    orderController.fetchOrders();
    fetchMyProducts();

    fetchCategories();
    //myProductsList.bindStream(streamMyProducts());
  }

  var currUserToken = "".obs;

  getToken() async {
    await LocalStorageHelper.getStoredUser().then((user) {
      print("Auth Token: ${user.token}");
      currUserToken(user.token);
    });
  }

  //TODO: fetch MY Products
  var myProductsList = <ProductModel>[].obs;

  fetchMyProducts() async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      await _apiProvider.fetchMyProducts(token: user.token).then((products) {
        myProductsList.clear();
        myProductsList.addAll(products);
      });
    });
  }

  /*Stream<List<ProductModel>> streamMyProducts() {

    return _apiProvider
        .fetchMyProducts(token: authController.userToken)
        .asStream();
  }
*/
  //TODO: Update Product using PATCH request type

  updateProduct({ProductModel? model}) async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      await _apiProvider
          .updateProduct(token: user.token, model: model)
          .then((ProductResponse? response) {
        //myProductsList.addAll(products);
        if (response != null) {
          if (response.success != null) {
            AppConstant.displaySnackBar('success', "${response.message}");
            clearControllers();
          } else {
            AppConstant.displaySnackBar('error', "${response.message}");
          }
        } else
          AppConstant.displaySnackBar('error', "Something went wrong");
      });
    });
  }

  //TODO: END Product

  //TODO: Delete Product

  deleteProduct({int? id}) async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      await _apiProvider
          .deleteProductById(id: id, token: user.token)
          .then((response) {
        if (response.success != null) {
          if (response.success!) {
            AppConstant.displaySnackBar('Success', response.message);
          } else
            AppConstant.displaySnackBar('error', response.message);
        }
      }).catchError((error) {
        debugPrint("DeleteProduct: $error");
        AppConstant.displaySnackBar('error', '$error');
      });
    });
    fetchMyProducts();
    //myProductsList.refresh();
  }

  //TODO: END

  ///TODO: Add product section
  var prodNameController = TextEditingController();
  var prodPriceController = TextEditingController();
  var prodStockController = TextEditingController();
  var prodBrandController = TextEditingController();
  var prodDiscountController = TextEditingController();
  var prodSKUController = TextEditingController();

  static const chooseCategory = "Select Category";
  var selectedCategory = chooseCategory.obs;
  var selectedCategoryID = 1.obs;
  var categoriesList = <CategoryModel>[].obs;


  fetchCategories() async{
    categoriesList.clear();
    categoriesList.insert(0, CategoryModel(name: selectedCategory.value, id: 0));
    if(categoryController.categories.isEmpty){
      await categoryController.fetchCategories();
      fetchCategories();
    }else{
      categoriesList.addAll(categoryController.categories);
      categoriesList.refresh();
    }
  }

  static const chooseSubCategory = "Select sub categories";
  var selectedSubCategory = chooseSubCategory.obs;
  var selectedSubCategoryID = 1.obs;
  var subCategoriesList = <SubCategory>[].obs;

  populateSubCategoriesList(){
    isLoading(true);
    subCategoriesList.clear();
    subCategoriesList.insert(0, SubCategory(name: selectedSubCategory.value, id: 0));

    if(categoryController.subCategories.isNotEmpty){
      isLoading(false);
      subCategoriesList.addAll(categoryController.subCategories);
    }else{
      setSelectedCategory(category: selectedCategory.value);
    }

  }


  addProduct() async {
    isLoading(true);
    //debugPrint("ImagePath: ${imagePath.value}");
    var fileName = imagePath.value.split("/").last;

    //debugPrint("ImagePath: ${File(imagePath.value).lengthSync()}");
    var mpf = MultipartFile(
      File(imagePath.value),
      filename: fileName,
    );
    debugPrint("ImagePath mpf: ${mpf.length}");

    ProductModel newProduct = ProductModel(
        name: prodNameController.text.trim(),
        price: num.parse(prodPriceController.text),
        stock: int.parse(prodStockController.text),
        categoryId: selectedCategoryID.value,
        subCategoryId: selectedSubCategoryID.value,
        sku: prodSKUController.text,
        discount: num.parse(prodDiscountController.text));

    FormData form = FormData({});
    form.files.add(MapEntry(
        "thumbnail", MultipartFile(File(imagePath.value), filename: fileName)));
    form.fields.add(MapEntry("name", newProduct.name!));
    form.fields.add(MapEntry("price", newProduct.price!.toString()));
    form.fields.add(MapEntry("stock", newProduct.stock!.toString()));
    form.fields.add(MapEntry("categoryId", newProduct.categoryId!.toString()));
    form.fields
        .add(MapEntry("subCategoryId", newProduct.subCategoryId!.toString()));
    form.fields.add(MapEntry("discount", newProduct.discount!.toString()));
    form.fields.add(MapEntry("sku", newProduct.sku!));

    await _apiProvider
        .addProduct(token: currUserToken.value, model: form)
        .then((ProductResponse? response) {

      if (response != null) {
        if (response.success != null) {
          AppConstant.displaySnackBar('success', "${response.message}");
        } else {
          debugPrint('Error: ${response.toString()}');
          AppConstant.displaySnackBar('error',
              "${response.message != null ? response.message : "Something went wrong"}");
        }
        isLoading(false);
        fetchMyProducts();
        Get.back();
        clearControllers();
      }
    }).catchError((error) {
      isLoading(false);
      debugPrint("AddProductError: $error");
      AppConstant.displaySnackBar('error', "Something went wrong!");
    });
    //isLoading(false);
  }



  void setSelectedCategory({String? category}) async{
    selectedCategory.value = category!;
    if (!category.contains(chooseCategory)) {
      if (categoriesList.isNotEmpty) {
        CategoryModel? model = categoriesList.firstWhere(
            (element) => element.name!.contains(category),
            orElse: () => CategoryModel());
        debugPrint("SelectedCategory: out ${model.id}");
        if (model.id != null) {
          selectedCategoryID(model.id);
          await categoryController.fetchSubCategories(model);
          populateSubCategoriesList();
        }
      }
    }
  }


  void setSelectedSubCategory({String? subCategory}) {
    selectedSubCategory.value = subCategory!;
    if (!subCategory.contains(chooseSubCategory)) {
      if (categoryController.subCategories.isNotEmpty) {
        int? id = categoryController.subCategories
            .firstWhere((element) => element.name! == subCategory,
                orElse: () => SubCategory())
            .id!;
        selectedSubCategoryID(id.isNaN ? 1 : id);
      }
    }
  }

  /// Profile Image Capture/Pick Section
  ///
  /// callingType
  ///  0 for Camera
  ///  1 for Gallery
  var imagePath = "".obs;
  var _picker = ImagePicker();

  pickOrCaptureImageGallery(int? callingType) async {
    try {
      XFile? imgFile = await _picker.pickImage(
          source: callingType == 0 ? ImageSource.camera : ImageSource.gallery);
      if (imgFile != null) {
        await imgFile
            .length()
            .then((value) => debugPrint("PickedImage: Length: $value"));
        debugPrint("PickedImage: mimeType: ${imgFile.mimeType}");
        debugPrint("PickedImage: Name: ${imgFile.name}");
        imagePath(imgFile.path);
        Get.back();
      }

      //uploadImage(imgFile);
    } catch (e) {
      debugPrint("UploadImage: $e");
    }
  }

  ///END Add Product

//TDO: Seller Home Section
  List<Widget> NavScreens = [
    const SellerDashboard(),
    const MyProducts(),
    const MyOrdersUI(),
    const PremiumMembershipUI(),
    const ProfileUI()
  ];

  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
    //appBarTitle(titles[index]);
    pageViewController.jumpToPage(index);

    /*bottomNavPageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);*/
  }

  List<JSON> getMenuItems() {
    return [
      {
        'title': "Seller Dashboard",
        "icon": Icons.dashboard_outlined,
        "page": 0
      },
      //{'title': "Add Product", "icon": Icons.add_card_outlined, "page": 1},
      {'title': "My Products", "icon": Icons.list_outlined, "page": 1},
      {'title': "My Orders", "icon": Icons.shopping_bag_outlined, "page": 2},
      {'title': "Profile", "icon": Icons.manage_accounts_outlined, "page": 4},
      {
        'title': "Premium Membership",
        "icon": Icons.workspace_premium_outlined,
        "page": 3
      },
    ];
  }

  List<JSON> getTopCardsData() {
    return [
      {
        'title': "Total Orders",
        "icon": Icons.shopping_cart_outlined,
        "iconColor": kRedColor,
        "count":0
      },
      {
        'title': "Pending Orders",
        "icon": Icons.pending_outlined,
        "iconColor": Colors.orange,
        "count":0
      },
      {
        'title': "Processing Orders",
        "icon": Icons.local_shipping_outlined,
        "iconColor": Colors.blue,
        "count":0
      },
      {
        'title': "Completed Orders",
        "icon": Icons.done_outline_rounded,
        "iconColor": Colors.teal,
        "count":0
      },
    ];
  }

  clearControllers() {
    prodNameController.clear();
    prodSKUController.clear();
    prodBrandController.clear();
    prodStockController.clear();
    prodPriceController.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageViewController.dispose();
    clearControllers();
  }
}

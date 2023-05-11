import 'dart:io';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SellersController extends GetxController with StateMixin<ProductModel> {
  final SellersApiProvider _apiProvider;
  final CategoryController categoryController;
  final OrderController orderController;

  SellersController(
      this._apiProvider, this.categoryController, this.orderController);

  var pageViewController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();
  var appBarTitle = vendorDashboard.obs;
  var isLoading = false.obs;

  var discountMessage = "".obs;

  void setDiscount(int? discount) {
    if (discount! > 0 && discount < 10) {
      discountMessage(langKey.discountMinValue.tr);
    } else if (discount >= 90) {
      discountMessage(langKey.discountMaxValue.tr);
    } else {
      discountMessage("");
    }
  }

  @override
  void onReady() {
    super.onReady();
    orderController.fetchVendorOrders(status: "pending");
    fetchMyProducts();
    fetchCategories();

    scrollController..addListener(() => loadMore());
  }

  getProductById(id) async {
    change(null, status: RxStatus.loading());
    await _apiProvider.getProductById(id).then((response) {
      if (response.success!)
        change(ProductModel.fromJson(response.data),
            status: RxStatus.success());
      else {
        change(null, status: RxStatus.empty());
      }
    }).catchError((error) {
      change(null, status: RxStatus.error(error));
    });
  }

  //TOO: fetch MY Products
  var myProductsList = <ProductModel>[].obs;
  int productsLimit = 20;
  int page = 1;

  fetchMyProducts() {
    _apiProvider
        .fetchMyProducts(
            token: authController.userToken, limit: productsLimit, page: page)
        .then((response) {
      myProductsList.clear();
      myProductsList.addAll(response.products!);
    });
  }

  var isLoadingMore = false.obs;

  void loadMore() async {
    if (scrollController.hasClients &&
        isLoadingMore.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      isLoadingMore(true);
      page++;
      await _apiProvider
          .fetchMyProducts(
              token: authController.userToken, limit: productsLimit, page: page)
          .then((response) {
        myProductsList.addAll(response.products!);
        isLoadingMore(false);
      }).catchError(onError);
    }
  }

  //TOO: Update Product using PATCH request type

  updateProduct({ProductModel? model}) async {
    model!.price = int.parse("${prodPriceController.text}");
    model.name = prodNameController.text;
    model.discount = int.parse("${prodDiscountController.text}");
    model.description = prodDescriptionController.text;
    model.stock = int.parse("${prodStockController.text}");

    isLoading(true);
    model!.price = int.parse("${prodPriceController.text}");
    model.name = prodNameController.text;
    model.discount = int.parse(
        "${prodDiscountController.text.isEmpty ? 0 : prodDiscountController.text}");
    model.description = prodDescriptionController.text;
    model.stock = int.parse("${prodStockController.text}");

    await _apiProvider
        .updateProduct(token: authController.userToken, model: model)
        .then((ApiResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          fetchMyProducts();
          Get.back();
          AppConstant.displaySnackBar(
              langKey.success.tr, "${response.message}");
          clearControllers();
        } else {
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, "${response.message}");
        }
      } else
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, someThingWentWrong.tr);
    }).catchError(onError);
  }

  onError(e) async {
    isLoading(false);
    print(">>>SellerController: $e");
    showSnackBar(title: langKey.errorTitle.tr, message: e.toString());
  }

  //TDO: END Product

  //TDO: Delete Product

  deleteProduct({int? id}) async {
    await _apiProvider
        .deleteProductById(id: id, token: authController.userToken)
        .then((response) {
      if (response.success!) {
        if (response.success!) {
          AppConstant.displaySnackBar(langKey.success.tr, response.message);
          fetchMyProducts();
        } else
          AppConstant.displaySnackBar(langKey.errorTitle.tr, response.message);
      }
    }).catchError(onError);
    //fetchMyProducts();
    //myProductsList.refresh();
  }

  //TDO: END

  ///TDO: Add product section
  var prodNameController = TextEditingController();

  var prodStockController = TextEditingController();
  var prodBrandController = TextEditingController();
  var prodDiscountController = TextEditingController();
  var prodDescriptionController = TextEditingController();
  var prodSKUController = TextEditingController();

  var prodPriceController = TextEditingController();
  var priceAfterCommission = 0.obs;

  static const chooseCategory = "Select Category";

  //var selectedCategory = chooseCategory.obs;

  var selectedCategory = CategoryModel().obs;
  var selectedCategoryID = 1.obs;
  var categoriesList = <CategoryModel>[].obs;

  fetchCategories() async {
    categoriesList.clear();
    categoriesList.insert(0, CategoryModel(name: chooseCategory, id: 0));
    if (categoryController.categories.isEmpty) {
      await categoryController.fetchCategories();
      fetchCategories();
    } else {
      categoriesList.addAll(categoryController.categories);
      categoriesList.refresh();
    }
  }

  static const chooseSubCategory = "Select sub categories";

  //var selectedSubCategory = chooseSubCategory.obs;
  var selectedSubCategory = SubCategory().obs;
  var selectedSubCategoryID = 1.obs;
  var subCategoriesList = <SubCategory>[].obs;

  populateSubCategoriesList() {
    isLoading(true);
    subCategoriesList.clear();
    selectedSubCategory(SubCategory(name: chooseSubCategory, id: 0));
    subCategoriesList.insert(0, SubCategory(name: chooseSubCategory, id: 0));

    if (categoryController.subCategories.isNotEmpty) {
      isLoading(false);
      subCategoriesList.addAll(categoryController.subCategories);
    } else {
      setSelectedCategory(category: selectedCategory.value);
    }
  }

  void setSelectedCategory({CategoryModel? category}) async {
    selectedCategory.value = category!;
    if (!category.name!.contains(chooseCategory)) {
      dynamicFieldsValuesList.clear();
      selectedCategoryID(category.id!);
      subCategoriesList.clear();
      await categoryController.fetchSubCategories(category);
      await populateSubCategoriesList();
    }
  }

  void setSelectedSubCategory({SubCategory? subCategory}) {
    selectedSubCategory.value = subCategory!;
    if (!subCategory.name!.contains(chooseSubCategory)) {
      selectedSubCategoryID(subCategory.id!.isNaN ? 1 : subCategory.id!);
      getVariantsFields();
    }
  }

  var productVariantsFieldsList = <ProductVariantsModel>[].obs;

  getVariantsFields() async {
    isLoading(true);
    await _apiProvider
        .getProductVariantsFieldsByCategories(
            catId: selectedCategoryID.value,
            subCatId: selectedSubCategoryID.value)
        .then((fieldsList) {
      isLoading(false);
      productVariantsFieldsList.clear();
      productVariantsFieldsList.addAll(fieldsList);
    });
  }

  var dynamicFieldsValuesList = Map<String, dynamic>().obs;

  onDynamicFieldsValueChanged(String? value, ProductVariantsModel? model) {
    if (dynamicFieldsValuesList.containsValue(value))
      dynamicFieldsValuesList.removeWhere((key, v) => v == value);
    dynamicFieldsValuesList.addIf(
        !dynamicFieldsValuesList.containsValue(value), "${model!.id}", value);
  }

  addProduct() async {
    isLoading(true);
    num discount = prodDiscountController.text.isEmpty
        ? 0
        : num.parse(prodDiscountController.text);
    ProductModel newProduct = ProductModel(
        name: prodNameController.text.trim(),
        price: priceAfterCommission.value,
        stock: int.parse(prodStockController.text),
        categoryId: selectedCategoryID.value,
        subCategoryId: selectedSubCategoryID.value,
        description: prodDescriptionController.text,
        discount: discount);
    await _apiProvider
        .addProductWithHttp(
            token: authController.userToken,
            model: newProduct,
            categoryFieldList: dynamicFieldsValuesList,
            images: pickedImagesList)
        .then((ApiResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          Get.back();
          clearControllers();
          AppConstant.displaySnackBar(
              langKey.success.tr, "${response.message}");
          fetchMyProducts();
        } else {
          debugPrint('Error: ${response.toString()}');
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            "${response.message != null ? response.message : someThingWentWrong.tr}",
          );
        }
      }
    }).catchError((e) {
      debugPrint('Error: ${e.toString()}');
      isLoading(false);
      AppConstant.displaySnackBar(langKey.errorTitle, "${e.message}");
    });
  }

  /// Profile Image Capture/Pick Section
  ///
  /// callingType
  ///  0 for Camera
  ///  1 for Gallery
  var imagePath = "".obs;
  static var _picker = ImagePicker();
  var pickedImagesList = <File>[].obs;
  var imagesSizeInMb = 0.0.obs;

  pickMultipleImages() async {
    await PermissionsHandler().checkPermissions().then((isGranted) async {
      if (isGranted) {
        try {
          List<XFile> images = await _picker.pickMultiImage(imageQuality: 100);
          if (images.isNotEmpty) {
            images.forEach((XFile? file) async {
              await file!.length().then((length) async {
                var lengthInKb = length * 0.000001;
                print(">>>Length: $lengthInKb");
                await AppConstant.compressImage(file.path, fileLength: length)
                    .then((compressedFile) {
                  var lengthInMb = compressedFile.lengthSync() * 0.000001;
                  print(">>>Length after: $lengthInMb");
                  imagesSizeInMb.value += lengthInMb;
                  if (lengthInMb > 2) {
                    showSnackBar(message: langKey.fileMustBe.tr + ' 2MB');
                  } else {
                    //: needs to add check if file exist
                    pickedImagesList.add(compressedFile);
                  }
                });
              });
            });
          } else {
            print("No Images were selected");
          }
        } on PlatformException catch (e) {
          print(e);
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            langKey.invalidImageFormat.tr,
          );
        }
      } else {
        print("called");
        await PermissionsHandler().requestPermissions();
      }
    });
  }

  pickOrCaptureImageGallery(int? callingType) async {
    await PermissionsHandler().checkPermissions().then((isGranted) async {
      if (isGranted) {
        try {
          XFile? imgFile = await _picker.pickImage(
              source:
                  callingType == 0 ? ImageSource.camera : ImageSource.gallery);
          if (imgFile != null) {
            await imgFile.length().then((length) async {
              await AppConstant.compressImage(imgFile.path, fileLength: length)
                  .then((compressedFile) {
                var lengthInMb = compressedFile.lengthSync() * 0.000001;
                if (lengthInMb > 2) {
                  showSnackBar(message: langKey.imageSizeDesc.tr + ' 2MB');
                } else {
                  imagePath(compressedFile.path);
                }
              });
            });
          }
        } catch (e) {
          print("UploadImage: $e");
        }
      } else
        await PermissionsHandler().requestPermissions();
    });
  }

  ///END Add Product

//TDO: Seller Home Section
  List<Widget> NavScreens = [
    const SellerDashboard(),
    const MyProducts(),
    const MyOrdersUI(),
    //const PremiumMembershipUI(),
    const ProfileUI(),
    const StoreProfileUI(),
  ];

  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
    //appBarTitle(titles[index]);
    pageViewController.jumpToPage(index);
  }

  List<JSON> getMenuItems() {
    return [
      {
        'title': vendorDashboard.tr,
        "icon": Icons.dashboard_outlined,
        "page": 0
      },
      //{'title': "Add Product", "icon": Icons.add_card_outlined, "page": 1},
      {'title': myProducts.tr, "icon": Icons.list_outlined, "page": 1},
      {'title': myOrders.tr, "icon": Icons.shopping_bag_outlined, "page": 2},
      {'title': profile.tr, "icon": Icons.manage_accounts_outlined, "page": 3},
      {'title': vendorStoreDetails.tr, "icon": Icons.storefront, "page": 4},
      /*{
        'title': "Premium Membership",
        "icon": Icons.workspace_premium_outlined,
        "page": 3
      },*/
    ];
  }

  List<JSON> getTopCardsData() {
    return [
      {
        'title': "Total Orders",
        "icon": Icons.shopping_cart_outlined,
        "iconColor": kRedColor,
        "count": 0
      },
      {
        'title': "Pending Orders",
        "icon": Icons.pending_outlined,
        "iconColor": Colors.orange,
        "count": 0
      },
      {
        'title': "Processing Orders",
        "icon": Icons.local_shipping_outlined,
        "iconColor": Colors.blue,
        "count": 0
      },
      {
        'title': "Completed Orders",
        "icon": Icons.done_outline_rounded,
        "iconColor": Colors.teal,
        "count": 0
      },
    ];
  }

  void showSnackBar({
    title = langKey.errorTitle,
    message = langKey.someThingWentWrong,
  }) {
    AppConstant.displaySnackBar(title, message);
  }

  clearControllers() {
    prodNameController.clear();
    prodSKUController.clear();
    prodBrandController.clear();
    prodStockController.clear();
    prodPriceController.clear();
    prodDescriptionController.clear();
    prodDiscountController.clear();
    pickedImagesList.clear();
    dynamicFieldsValuesList.clear();
    imagesSizeInMb(0.0);
    priceAfterCommission(0);
  }

  @override
  void onClose() {
    // TOO: implement onClose
    super.onClose();
    pageViewController.dispose();
    clearControllers();
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class SellersController extends GetxController {
  final SellersApiProvider _apiProvider;
  final CategoryController categoryController;
  final OrderController orderController;

  SellersController(
      this._apiProvider, this.categoryController, this.orderController);

  var pageViewController = PageController(initialPage: 0);

  var appBarTitle = vendorDashboard.obs;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    orderController.fetchOrders();
    fetchMyProducts();

    fetchCategories();
    //myProductsList.bindStream(streamMyProducts());
  }

  //TOO: fetch MY Products
  var myProductsList = <ProductModel>[].obs;

  fetchMyProducts() async {
    /*await LocalStorageHelper.getStoredUser().then((user) async {

    });*/
    await _apiProvider
        .fetchMyProducts(token: authController.userToken)
        .then((response) {
      myProductsList.clear();
      myProductsList.addAll(response.products!);
    });
  }

  /*Stream<List<ProductModel>> streamMyProducts() {

    return _apiProvider
        .fetchMyProducts(token: authController.userToken)
        .asStream();
  }
*/
  //TOO: Update Product using PATCH request type

  updateProduct({ProductModel? model}) async {
    await _apiProvider
        .updateProduct(token: authController.userToken, model: model)
        .then((ProductResponse? response) {
      if (response != null) {
        if (response.success != null) {
          AppConstant.displaySnackBar('success', "${response.message}");
          clearControllers();
        } else {
          AppConstant.displaySnackBar('error', "${response.message}");
        }
      } else
        AppConstant.displaySnackBar('error', someThingWentWrong.tr);
    });
  }

  //TDO: END Product

  //TDO: Delete Product

  deleteProduct({int? id}) async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      await _apiProvider
          .deleteProductById(id: id, token: user.token)
          .then((response) {
        if (response.success != null) {
          if (response.success!) {
            AppConstant.displaySnackBar('success', response.message);
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
    //CategoryModel? model = category!;
    if (!category.name!.contains(chooseCategory)) {
      /*if (categoriesList.isNotEmpty) {
        CategoryModel? model = categoriesList.firstWhere(
                (element) => element.name!.contains(category.name!),
            orElse: () => CategoryModel());
        debugPrint("SelectedCategory: out ${model.id}");
        if (model.id != null) {
          selectedCategoryID(model.id);
          await categoryController.fetchSubCategories(model);
          populateSubCategoriesList();
        }
      }*/

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
    //debugPrint("ImagePath: ${imagePath.value}");
    //var fileName = imagePath.value.split("/").last;

    //debugPrint("ImagePath: ${File(imagePath.value).lengthSync()}");
    /*var mpf = MultipartFile(
      File(imagePath.value),
      filename: fileName,
    );*/
    //debugPrint("ImagePath mpf: ${mpf.length}");

    ProductModel newProduct = ProductModel(
        name: prodNameController.text.trim(),
        price: priceAfterCommission.value,
        stock: int.parse(prodStockController.text),
        categoryId: selectedCategoryID.value,
        subCategoryId: selectedSubCategoryID.value,
        description: prodDescriptionController.text,
        discount: num.parse(prodDiscountController.text));

    // var listMultiPart = [];
    // for(XFile file in pickedImagesList){
    //   listMultiPart.add(MultipartFile(File(file.path), filename: file.name));
    // }

    /*pickedImagesList.forEach((element) {
      form.files.add(MapEntry(
          "images", MultipartFile(File(element.path), filename: element.name)));
    });*/

    //MultipartFile(File(element.path), filename: element.name)

    /*form.files.add(MapEntry(
        "images", pickedImagesList.forEach((element)=> MultipartFile(File(element.path), filename: element.name))));
  */


    FormData form = FormData({});
    if (pickedImagesList.isNotEmpty) {
      var mpf = MultipartFile(
        File(pickedImagesList[0].path),
        filename: pickedImagesList[0].name,
      );
      form.files.add(MapEntry("images", mpf));
    }
    form.fields.add(MapEntry("name", newProduct.name!));
    form.fields.add(MapEntry("price", newProduct.price!.toString()));
    form.fields.add(MapEntry("stock", newProduct.stock!.toString()));
    form.fields.add(MapEntry("categoryId", newProduct.categoryId!.toString()));
    form.fields
        .add(MapEntry("subCategoryId", newProduct.subCategoryId!.toString()));
    form.fields.add(MapEntry("discount", newProduct.discount!.toString()));
    //form.fields.add(MapEntry("sku", newProduct.sku!));
    form.fields.add(MapEntry("description", newProduct.description!));

    for (var i = 0; i < dynamicFieldsValuesList.entries.length; i++) {
      form.fields.add(MapEntry("features[$i][id]",
          dynamicFieldsValuesList.entries.elementAt(i).key));
      form.fields.add(MapEntry("features[$i][value]",
          dynamicFieldsValuesList.entries.elementAt(i).value));
    }

    //dynamicFieldsValuesList.map((key, value) => form.fields.add(MapEntry("description", newProduct.description!)););
    // var mpf = MultipartFile(
    //   File(pickedImagesList[0].path),
    //   filename: pickedImagesList[0].name,
    //
    // );
    await _apiProvider
        .addProduct(
            token: authController.userToken,
            formData: form,
            imagesList: pickedImagesList)
        .then((ProductResponse? response) {
      if (response != null) {
        if (response.success != null) {
          AppConstant.displaySnackBar('success', "${response.message}");
        } else {
          debugPrint('Error: ${response.toString()}');
          AppConstant.displaySnackBar('error',
              "${response.message != null ? response.message : someThingWentWrong.tr}");
        }
        Get.back();
        isLoading(false);
        fetchMyProducts();
        clearControllers();
      }
    }).catchError((error) {
      isLoading(false);
      debugPrint("AddProductError: $error");
      AppConstant.displaySnackBar('error', "Something went wrong!");
    });
    //isLoading(false);
  }

  /// Profile Image Capture/Pick Section
  ///
  /// callingType
  ///  0 for Camera
  ///  1 for Gallery
  var imagePath = "".obs;
  var _picker = ImagePicker();
  var pickedImagesList = <XFile>[].obs;

  pickMultipleImages() async {
    if (Platform.isIOS) {
      List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        pickedImagesList.addAll(images);
      } else {
        debugPrint("No Images were selected");
      }
    } else {
      checkPermissions().then((isGranted) async {
        if (isGranted) {
          List<XFile> images = await _picker.pickMultiImage();
          if (images.isNotEmpty) {
            pickedImagesList.addAll(images);
          } else {
            debugPrint("No Images were selected");
          }
        } else {
          requestPhotoAndCameraPermissions();
        }
      });
    }
  }

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
    //const PremiumMembershipUI(),
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
        'title': vendorDashboard.tr,
        "icon": Icons.dashboard_outlined,
        "page": 0
      },
      //{'title': "Add Product", "icon": Icons.add_card_outlined, "page": 1},
      {'title': myProducts.tr, "icon": Icons.list_outlined, "page": 1},
      {'title': myOrders.tr, "icon": Icons.shopping_bag_outlined, "page": 2},
      {'title': profile.tr, "icon": Icons.manage_accounts_outlined, "page": 4},
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

  Future<bool> checkPermissions() async {
    return //await Permission.manageExternalStorage.isGranted &&
        await Permission.storage.isGranted &&
            //await Permission.photos.isGranted &&
            await Permission.camera.isGranted;
  }

  void requestPhotoAndCameraPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.manageExternalStorage,
      Permission.camera,
      Permission.photos,
      Permission.storage,
      //Permission.mediaLibrary,
      //add more permission to request here.
    ].request();
    if (statuses[Permission.manageExternalStorage]!.isDenied &&
        statuses[Permission.camera]!.isDenied &&
        statuses[Permission.photos]!.isDenied) {
      //check each permission status after.
      debugPrint(">>>>permission is denied.");
    }
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
    /*categoriesList.clear();
    categoriesList.insert(
        0, CategoryModel(name: selectedCategory.value, id: 0));
    subCategoriesList.clear();
    subCategoriesList.insert(
        0, SubCategory(name: selectedSubCategory.value, id: 0));*/
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    pageViewController.dispose();
    clearControllers();
  }
}

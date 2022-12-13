import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';

class BaseController extends GetxController {
  BaseController(this._apiProvider);

  final ApiProvider _apiProvider;

  var searchController = TextEditingController();
  var cartCount = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchSliderImages();
    runSliderTimer();

    fetchSliderDiscountProducts();
    fetchCategories();

    getCurrentUser();

    cartCount(LocalStorageHelper.getCartItemsCount());

    LocalStorageHelper.localStorage.listen(() {
      debugPrint("localStorage listening started...");
      cartCount(LocalStorageHelper.getCartItemsCount());
      getCurrentUser();
    });
  }

  //TODO: Current User Info
  var _userModel = UserModel().obs;

  setUserModel(UserModel? userModel) => _userModel(userModel);

  UserModel? get userModel => _userModel.value;

  getCurrentUser() async {
    await LocalStorageHelper.getStoredUser().then((user) {
      setUserModel(user);
    });
  }

  //END Current User

  //TODO:Start Fetch SliderImages Section

  var sliderImages = <SliderModel>[].obs;
  var isSliderLoading = true.obs;

  fetchSliderImages() async {
    isSliderLoading(true);
    await _apiProvider.fetchSliderImages().then((data) {
      sliderImages.addAll(data);
      isSliderLoading(false);
      //runSliderTimer(value);
    }).catchError((error) {
      isSliderLoading(false);
      debugPrint(">>>>FetchSliderImageError $error");
      //fetchSliderImages();
    });
  }

  var sliderIndex = 0.obs;
  late Timer? timer;
  var sliderPageController = PageController(initialPage: 0);

  void runSliderTimer() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (sliderIndex.value < sliderImages.length) {
        sliderIndex.value = sliderIndex.value + 1;
      } else {
        sliderIndex.value = 0;
      }
      if (sliderPageController.hasClients)
        sliderPageController.animateToPage(
          sliderIndex.value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubicEmphasized,
        );
    });
  }

  var discountSliderProductsList = <ProductModel>[].obs;

  fetchSliderDiscountProducts() async {
    isProductsLoading(true);
    _apiProvider.getSliderDiscountProducts().then((data) {
      discountSliderProductsList.addAll(data);
      isProductsLoading(false);
    }).catchError((error) {
      isProductsLoading(false);
      debugPrint(">>>fetchSliderDiscountProducts: $error");
    });;
  }

  //End Fetch SliderImages Section

  //TODO: Start Fetch Top Categories
  var categories = <CategoryModel>[].obs;
  var isCategoriesLoading = false.obs;

  fetchCategories() async {
    isCategoriesLoading(true);
    await _apiProvider.fetchCategories().then((data) {
      categories.addAll(data);
      isCategoriesLoading(false);
    }).catchError((error) {
      debugPrint("FetchCategoriesError $error");
      isCategoriesLoading(false);
    });

    await fetchProducts();
    await fetchProductsByTypes();
  }

  //End Fetch Top Categories

  //TODO: START Fetch Product

  Map<String, dynamic> productsMap = Map<String, dynamic>().obs;
  var isProductsLoading = false.obs;

  fetchProducts() async {
    if (categories.isNotEmpty) {
      productsMap.clear();
      categories.forEach((element) async {
        await _apiProvider.getProductsByCategory(element.id!).then((data) {
          //debugPrint("FetchProducts: inside $data");

          productsMap.putIfAbsent(element.name!, () => data);
          //debugPrint("FetchProducts: inside Ln ${productList.first}");
        });
      });
    }
  }

  /// Fetch Products by Type

  var productsWithTypesMap = Map<String, dynamic>().obs;

  fetchProductsByTypes() async {
    isProductsLoading(true);
    //_clearProductLists();
    productsWithTypesMap.clear();

    _getProductsType().forEach((element) async {
      await _apiProvider.getProductsByType(type: element).then((value) {
        isProductsLoading(false);
        productsWithTypesMap.putIfAbsent(element, () => value);
      }).catchError((error) {
        isProductsLoading(false);
        debugPrint(">>>FetchProductsByType $error");
      });
    });
  }

  List<String> _getProductsType() {
    return [
      "Best Seller",
      "Discounts",
      "Latest",
      "Featured",
      "IsmmartOriginal",
    ];
  }

  var categoryProducts = <ProductModel>[].obs;

  getCategoriesProduct(int? categoryId) async {
    isProductsLoading(true);

    categoryProducts.clear();
    await _apiProvider.getProductsByCategory(categoryId!).then((value) {
      debugPrint("getCategoriesProduct: value $value");
      categoryProducts.addAll(value);
    });
  }

  //END Fetch Product

  //TODO: Start Bottom Navigation setup
  var bottomNavPageController = PageController(initialPage: 0);
  List<Widget> bottomNavScreens = [
    const DashboardUI(),
    const CategoriesUI(),
    const CartUI(),
    const SettingsUI(),
    const SearchUI()
  ];

  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;

    bottomNavPageController.jumpToPage(index);
    /*bottomNavPageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);*/
  }

  //End Bottom Navigation Setup

  //TODO:Start Clear Lists
  _clearLists() {
    sliderImages.clear();
    categories.clear();
  }

  //END Clear Lists

  //TODO:START clear Controllers
  _clearControllers() {
    bottomNavPageController.dispose();
    sliderPageController.dispose();
  }

  //END clear Controllers

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    timer?.cancel();
    _clearLists();
    _clearControllers();
  }
}

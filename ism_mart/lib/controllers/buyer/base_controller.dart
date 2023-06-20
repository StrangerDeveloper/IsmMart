import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/screens/deals/deals_view.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../exports/export_buyers.dart';
import '../../screens/setting/settings_view.dart';

class BaseController extends GetxController {
  BaseController(this._apiProvider);

  final ApiProvider _apiProvider;

  var searchController = TextEditingController();
  var cartCount = 0.obs;

  getAllApiFucnc() {
    fetchSliderImages();
    runSliderTimer();
    fetchSliderDiscountProducts();
    fetchCategories();

    setCartItemCount();
  }

  @override
  void onReady() {
    super.onReady();
    getAllApiFucnc();
    LocalStorageHelper.localStorage.listenKey(LocalStorageHelper.cartItemKey,
        (value) {
      setCartItemCount();
    });
    LocalStorageHelper.localStorage
        .listenKey(LocalStorageHelper.currCurrencyKey, (value) {});
  }

  setCartItemCount() async {
    await LocalStorageHelper.fetchCartItems()
        .then((List<CartModel> list) async {
      if (list.isNotEmpty) {
        setCartCount(list.length);
      } else {
        setCartCount(0);
      }
    });
  }

  setCartCount(int count) {
    cartCount(count);
  }

  //TDO:Start Fetch SliderImages Section

  var sliderImages = <SliderModel>[].obs;
  var isSliderLoading = true.obs;

  fetchSliderImages() async {
    isSliderLoading(true);
    await _apiProvider.fetchSliderImages().then((data) {
      if (data.length == 0) {
        GlobalVariable.internetErr(true);
        GlobalVariable.btnPress(false);
      } else {
        GlobalVariable.internetErr(false);
        sliderImages.clear();
        if (sliderImages.isEmpty) {
          sliderImages.addAll(data);
          Future.delayed(
            Duration(
              seconds: 3,
            ),
            () => GlobalVariable.btnPress(false),
          );
        }
      }

      isSliderLoading(false);
      //runSliderTimer(value);
    }).catchError((error) {
      GlobalVariable.internetErr(true);
      print(" hhh  images err ${GlobalVariable.internetErr.value}");
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
      GlobalVariable.internetErr(true);
      print(" hhh  slider disc err ${GlobalVariable.internetErr.value}");
      isProductsLoading(false);
      debugPrint(">>>fetchSliderDiscountProducts: $error");
    });
    ;
  }

  //End Fetch SliderImages Section

  //TOO: Start Fetch Top Categories
  var categories = <CategoryModel>[].obs;
  var isCategoriesLoading = false.obs;
  int _minNoOfCategoriesRequest = 3;

  fetchCategories() async {
    isCategoriesLoading(true);
    await _apiProvider.fetchCategories().then((data) {
      categories.addAll(data);
      isCategoriesLoading(false);
    }).catchError((error) {
      GlobalVariable.internetErr(true);
      if (_minNoOfCategoriesRequest != 0) {
        _minNoOfCategoriesRequest--;
        fetchCategories();
      } else {
        GlobalVariable.internetErr(true);
        print(" hhh  categories err ${GlobalVariable.internetErr.value}");

        debugPrint("FetchCategoriesError $error");
        isCategoriesLoading(false);
      }
    });

    await fetchProducts();

    await fetchProductsByTypes();
  }

  Map<String, dynamic> productsMap = Map<String, dynamic>().obs;
  var isProductsLoading = false.obs;

  fetchProducts() async {
    await _apiProvider.getAllProducts(limit: 30).then((data) {
      productsMap.putIfAbsent("All Products", () => data);
    });
  }

  /// Fetch Products by Type

  var productsWithTypesMap = Map<String, dynamic>().obs;

  fetchProductsByTypes() async {
    isProductsLoading(true);
    //_clearProductLists();
    productsWithTypesMap.clear();

    _getProductsType().forEach((element) async {
      await _apiProvider
          .getProductsByType(limit: 15, type: element['key'])
          .then((value) {
        isProductsLoading(false);
        productsWithTypesMap.putIfAbsent(element['value'], () => value);
      }).catchError((error) {
        GlobalVariable.internetErr(true);
        isProductsLoading(false);
        debugPrint(">>>FetchProductsByType $error");
      });
    });
  }

  List _getProductsType() {
    return [
      {"key": "Latest", "value": "Popular Products"},
      {"key": "Featured", "value": "Featured Products"},
      {"key": "IsmmartOriginal", "value": "ISMMART Originals"},
      {"key": "Best Seller", "value": "Best Seller"},
      //{"key": "Valentines", "value": "Valentines"},
    ];
  }

  String getProductTypeKeys(value) {
    return _getProductsType().firstWhere(
        (element) => element["value"]!.contains(value),
        orElse: null)['key'];
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

  //TOO: Start Bottom Navigation setup
  var bottomNavPageController = PageController(initialPage: 0);
  List<Widget> bottomNavScreens = [
    const DashboardView(),
    const CategoriesView(),
    DealsView(),
    CartView(),
    SettingsView(),
  ];

  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
    bottomNavPageController.jumpToPage(index);
  }

  Future<bool> onBackPressed(BuildContext context) async {
    if (currentPage == 0) {
      final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(langKey.exitApp.tr),
            content: Text(langKey.exitDialogDesc.tr),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                        foregroundColor: Colors.grey,
                      ),
                      child: Text(
                        langKey.noBtn.tr,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                        foregroundColor: Colors.grey,
                      ),
                      child: Text(
                        langKey.yesBtn.tr,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );

      return value == true;
    } else {
      changePage(0);
      return false;
    }
  }

  _clearLists() {
    sliderImages.clear();
    categories.clear();
  }

  //END Clear Lists

  _clearControllers() {
    bottomNavPageController.dispose();
    sliderPageController.dispose();
  }

  //END clear Controllers

  @override
  void onClose() {
    super.onClose();

    timer?.cancel();
    _clearLists();
    _clearControllers();
  }
}

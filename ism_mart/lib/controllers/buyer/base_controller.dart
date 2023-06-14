import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/search_details/search_details_view.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../exports/export_buyers.dart';

class BaseController extends GetxController {
  BaseController(this._apiProvider);

  final ApiProvider _apiProvider;

  var searchController = TextEditingController();
  var cartCount = 0.obs;

  @override
  void onReady() {
    super.onReady();

    fetchSliderImages();
    runSliderTimer();

    fetchSliderDiscountProducts();
    fetchCategories();

    getAllFAQs();

    //setCartCount(LocalStorageHelper.getCartItemsCount());
    setCartItemCount();
    LocalStorageHelper.localStorage.listenKey(LocalStorageHelper.cartItemKey,
        (value) {
      setCartItemCount();
    });

    // ever(categories, getRandomTextForSearch);
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

    /* if (authController.isSessionExpired!)
      await LocalStorageHelper.fetchCartItems()
          .then((List<CartModel> list) async {
        if (list.isNotEmpty) {
          debugPrint("");
          setCartCount(list.length);
        } else {
          setCartCount(0);
        }
      });
    else if (!authController.isSessionExpired! &&
        authController.userToken!.isNotEmpty) {
      await _apiProvider
          .getCartItems(token: authController.userToken)
          .then((data) {
        setCartCount(data.length);
      });
    } else {
      setCartCount(0);
    }*/
  }

  setCartCount(int count) {
    cartCount(count);
  }

  /*//TDO: Current User Info
  var _userModel = UserModel().obs;

  setUserModel(UserModel? userModel) => _userModel(userModel);

  UserModel? get userModel => _userModel.value;

  getCurrentUser() async {
    await LocalStorageHelper.getStoredUser().then((user) {
      setUserModel(user);
    });
  }*/

  //END Current User

  //TDO:Start Fetch SliderImages Section

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
      if (_minNoOfCategoriesRequest != 0) {
        _minNoOfCategoriesRequest--;
        fetchCategories();
      } else {
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

    // if (categories.isNotEmpty) {
    //   productsMap.clear();
    //   categories.forEach((element) async {
    //     await _apiProvider.getProductsByCategory(element.id!).then((data) {
    //       //debugPrint("FetchProducts: inside $data");
    //       productsMap.putIfAbsent(element.name!, () => data);
    //       //debugPrint("FetchProducts: inside Ln ${productList.first}");
    //     }).catchError((error) {
    //       print(">>>FetchProductByCategory: $error");
    //     });
    //   });
    // }
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

  //TOD:: fetch All FAQ
  var faqsList = <FAQModel>[].obs;

  getAllFAQs() async {
    faqsList.clear();

    await _apiProvider.getAllFaqs(token: authController.userToken).then((faqs) {
      faqsList.addAll(faqs);
    }).catchError((error) {
      print(">>>GetAllFaqs: $error");
    });
  }

  //TOO: Start Bottom Navigation setup
  var bottomNavPageController = PageController(initialPage: 0);
  List<Widget> bottomNavScreens = [
    const DashboardUI(),
    const CategoriesView(),
    const SearchDetailsView(
      passedSearchQuery: "",
      isCalledForDeals: true,
    ),
    CartView(),
    SettingsView(),
  ];

  var currentPage = 0.obs;

  void changePage(int index) {
    // if (index == 3) {
    //   Get.find<CustomSearchController>().searchProducts("");
    //   Get.find<CustomSearchController>().searchTextController.clear();
    // }

    currentPage.value = index;
    bottomNavPageController.jumpToPage(index);
    /*bottomNavPageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);*/
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

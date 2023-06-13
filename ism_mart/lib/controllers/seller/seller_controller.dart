import 'package:ism_mart/screens/change_password/change_password_view.dart';
import 'package:ism_mart/screens/my_products/my_product_view.dart';
import 'package:ism_mart/screens/seller_dashboard/seller_dashboard_view.dart';
import 'package:ism_mart/screens/vendor_detail/vendor_detail_view.dart';
import 'package:ism_mart/screens/vendor_orders/vendor_orders_view.dart';
import 'package:ism_mart/screens/vendor_question/vendor_question_view.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SellersController extends GetxController with StateMixin<ProductModel> {
  final SellersApiProvider apiProvider;
  final CategoryController categoryController;
  final OrderController orderController;

  SellersController(
      this.apiProvider, this.categoryController, this.orderController);

  var pageViewController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();
  var appBarTitle = vendorDashboard.obs;
  var isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    fetchCategories();
  }

  static const chooseCategory = "Select Category";

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
    await apiProvider
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

//TDO: Seller Home Section
  List<Widget> NavScreens = [
    // const SellerDashboardView(),
    SellerDashboardView(),
    MyProductView(),
    VendorOrdersView(),
    //const PremiumMembershipUI(),
    VendorDetailView(),
    VendorQuestionView(),
    ChangePasswordView()
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
      {'title': vendorStoreDetails.tr, "icon": Icons.storefront, "page": 3},
      {
        'title': 'Answer User Questions',
        "icon": Icons.question_mark_sharp,
        "page": 4
      },
      {
        'title': 'Change Password',
        "icon": Icons.description_outlined,
        "page": 5
      },
      /*{
        'title': "Premium Membership",
        "icon": Icons.workspace_premium_outlined,
        "page": 3
      },*/
    ];
  }

  void showSnackBar({
    title = langKey.errorTitle,
    message = langKey.someThingWentWrong,
  }) {
    AppConstant.displaySnackBar(title, message);
  }

  clearControllers() {
    dynamicFieldsValuesList.clear();
    selectedCategory(CategoryModel(name: chooseCategory, id: 0));
    selectedSubCategory(SubCategory(name: chooseSubCategory, id: 0));
  }

  @override
  void onClose() {
    super.onClose();
    pageViewController.dispose();
    clearControllers();
  }
}

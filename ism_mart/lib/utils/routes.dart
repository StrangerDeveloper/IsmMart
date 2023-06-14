import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/exports/exports_ui.dart';
import 'package:ism_mart/screens/all_dispute/all_dispute_view.dart';
import 'package:ism_mart/screens/buyer_orders/buyer_order_view.dart';
import 'package:ism_mart/screens/buyer_profile/buyer_profile_view.dart';
import 'package:ism_mart/screens/change_password/change_password_view.dart';
import 'package:ism_mart/screens/dispute_detail/dispute_detail_view.dart';
import 'package:ism_mart/screens/email_verification/email_verification_view.dart';
import 'package:ism_mart/screens/forgot_password1/forgot_password1_view.dart';
import 'package:ism_mart/screens/my_products/my_product_view.dart';
import 'package:ism_mart/screens/product_questions/product_questions_view.dart';
import 'package:ism_mart/screens/update_vendor/update_vendor_view.dart';
import 'package:ism_mart/screens/vendor_detail/vendor_detail_view.dart';
import 'package:ism_mart/screens/vendor_question/vendor_question_view.dart';

import '../screens/contact_us/contact_us_view.dart';
import '../screens/forgot_password2/forgot_password2_view.dart';
import '../screens/vendor_orders/vendor_orders_view.dart';

class Routes {
  static const initRoute = "/";
  static const addProduct = "/addProduct";
  static const allDispute = "/allDispute";
  static const buyerOrdersRoute = "/buyerOrders";
  static const buyerProfile = "/buyerProfile";
  static const cartRoute = "/cart";
  static const categories = "/categories";
  static const changeAddressRoute = "/changeAddress";
  static const changePassword = "/changePassword";
  static const checkOutRoute = "/checkout";
  static const contactUs = "/contactUs";
  static const dashboard = "/dashboard";
  static const disputeDetail = "/disputeDetail";
  static const emailVerificationLinkRoute = "/emailVerificationLink";
  static const faq = "/faq";
  static const forgotPassword1 = "/forgotPassword1";
  static const forgotPassword2 = "/forgotPassword2";
  static const generalSetting = "/generalSetting";
  static const myProduct = "/myProduct";
  static const productQuestions = "/productQuestions";
  static const searchRoute = "/search";
  static const sellerHomeRoute = "/sellerDash";
  static const settings = "/settings";
  static const loginRoute = "/signIn";
  static const registerRoute = "/register";
  static const updateProduct = "/updateProduct";
  static const updateVendor = "/updateVendor";
  static const vendorDetail = "/vendorDetail";
  static const vendorOrders = "/vendorOrders";
  static const vendorQuestion = "/vendorQuestion";

  //static const aboutUsRoute = "/aboutUs";
  ///Pages with passing :ID
  static const productDetailsRoute = "/product/:id";
  static const orderDetailsRoute = "/orderDetails/:id";
  static const storeDetailsRoute = "/storeDetails/:id";

  static final pages = [
    GetPage(
      name: initRoute,
      page: () => const BottomNavigationView(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: addProduct,
      page: () => AddProductView(),
    ),
    GetPage(
      name: allDispute,
      page: () => AllDisputeView(),
    ),
    GetPage(
      name: buyerOrdersRoute,
      page: () => BuyerOrderView(),
      binding: OrdersBindings(),
    ),
    GetPage(
      name: buyerProfile,
      page: () => BuyerProfileView(),
    ),
    GetPage(
      name: cartRoute,
      page: () => CartView(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: categories,
      page: () => CategoriesView(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: changeAddressRoute,
      page: () => ChangeAddressView(),
      binding: CheckoutBinding(),
      middlewares: [AuthMiddleWare(priority: 1)],
    ),
    GetPage(
      name: changePassword,
      page: () => ChangePasswordView(),
    ),
    GetPage(
      name: checkOutRoute,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
      middlewares: [AuthMiddleWare(priority: 5)],
    ),
    GetPage(
      name: contactUs,
      page: () => ContactUsView(),
    ),
    GetPage(
      name: dashboard,
      page: () => DashboardView(),
    ),
    GetPage(
      name: disputeDetail,
      page: () => DisputeDetailView(),
    ),
    GetPage(
      name: emailVerificationLinkRoute,
      page: () => EmailVerificationView(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: faq,
      page: () => FaqView(),
    ),
    GetPage(
      name: forgotPassword1,
      page: () => ForgotPassword1View(),
    ),
    GetPage(
      name: forgotPassword2,
      page: () => ForgotPassword2View(),
    ),
    GetPage(
      name: generalSetting,
      page: () => GeneralSettingView(),
    ),
    GetPage(
      name: myProduct,
      page: () => MyProductView(),
    ),
    GetPage(
      name: productQuestions,
      page: () => ProductQuestionsView(),
    ),
    GetPage(
      name: searchRoute,
      page: () => SearchView(),
      //binding: SearchBindings(),
      bindings: [
        SearchBindings(),
        ProductBinding(),
      ],
    ),
    GetPage(
      name: sellerHomeRoute,
      page: () => const SellerHomeView(),
      binding: SellerBindings(),
    ),
    GetPage(
      name: settings,
      page: () => SettingsView(),
    ),
    GetPage(
      name: loginRoute,
      page: () => SignInView(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: registerRoute,
      page: () => SignUpView(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: updateProduct,
      page: () => UpdateProductView(),
    ),
    GetPage(
      name: updateVendor,
      page: () => UpdateVendorView(),
    ),
    GetPage(
      name: vendorDetail,
      page: () => VendorDetailView(),
    ),
    GetPage(
      name: vendorOrders,
      page: () => VendorOrdersView(),
    ),
    GetPage(
      name: vendorQuestion,
      page: () => VendorQuestionView(),
    ),
    /////////////////////////////////////////////////////////////////////////
    GetPage(
      name: '/product/:id',
      //arguments: ['calledFor'],
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: '/orderDetails/:id',
      //arguments: ['calledForBuyerOrderDetails'],
      page: () => const SingleOrderDetailsUI(),
      binding: OrdersBindings(),
    ),
    GetPage(
      name: '/storeDetails/:storeId',
      page: () => const SellerStoreDetailView(),
      binding: ProductBinding(),
    )
  ];
}

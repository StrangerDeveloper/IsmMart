import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/exports/exports_ui.dart';
import 'package:ism_mart/screens/buyer_orders/buyer_order_view.dart';
import 'package:ism_mart/screens/email_verification/email_verification_view.dart';

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
  static const emailVerify = "/api/auth/verifyEmail";
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
        binding: BaseBindings()),
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
        name: emailVerificationLinkRoute,
        page: () => EmailVerificationView(),
        binding: BaseBindings()),
    GetPage(
        name: searchRoute,
        page: () => SearchView(),
        //binding: SearchBindings(),
        bindings: [
          SearchBindings(),
          ProductBinding(),
        ]),
    GetPage(
      name: cartRoute,
      page: () => CartView(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: checkOutRoute,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
      middlewares: [AuthMiddleWare(priority: 5)],
    ),
    GetPage(
      name: changeAddressRoute,
      page: () => ChangeAddressView(),
      binding: CheckoutBinding(),
      middlewares: [AuthMiddleWare(priority: 1)],
    ),
    GetPage(
      name: buyerOrdersRoute,
      page: () => BuyerOrderView(),
      binding: OrdersBindings(),
    ),
    GetPage(
        name: sellerHomeRoute,
        page: () => const SellerHomeView(),
        binding: SellerBindings()),
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

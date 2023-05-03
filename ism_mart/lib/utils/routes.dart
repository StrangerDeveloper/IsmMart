import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/ui/buyer/account/forgot_password.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';

class Routes {
  static const initRoute = "/";
  static const loginRoute = "/signIn";
  static const forgotPasswordRoute = "/forgotPassword";
  static const registerRoute = "/register";
  static const categoriesRoute = "/categories";
  static const cartRoute = "/cart";
  static const checkOutRoute = "/checkout";
  static const profileRoute = "/profile";

  static const searchRoute = "/search";
  static const sellerHomeRoute = "/sellerDash";

  static const buyerOrdersRoute = "/buyerOrders";

  static const settingsRoute = "/settings";
  //static const aboutUsRoute = "/aboutUs";

  ///Pages with passing :ID
  static const productDetailsRoute = "/product/:id";
  static const orderDetailsRoute = "/orderDetails/:id";
  static const storeDetailsRoute = "/storeDetails/:id";

  static final pages = [
    /* GetPage(
      name: aboutUsRoute,
      page: () => AboutUS(),
    ),*/
    GetPage(
      name: loginRoute,
      page: () => const SignInUI(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: registerRoute,
      page: () => const SignUpUI(),
      binding: BaseBindings(),
    ),
    GetPage(
        name: forgotPasswordRoute,
        page: () => const ForgotPassword(),
    ),
    GetPage(
        name: initRoute,
        page: () => const BaseLayout(),
        binding: BaseBindings()),
    GetPage(
        name: searchRoute,
        page: () => SearchUI(),
        //binding: SearchBindings(),
        bindings: [
          SearchBindings(),
          ProductBinding(),
        ]),
    GetPage(
      name: cartRoute,
      page: () => CartUI(),
      binding: BaseBindings(),
    ),
    GetPage(
      name: checkOutRoute,
      page: () => CheckoutUI(),
      binding: CheckoutBinding(),
      middlewares: [AuthMiddleWare(priority: 5)],
    ),
    GetPage(
      name: buyerOrdersRoute,
      page: () => BuyerOrdersUI(),
      binding: OrdersBindings(),
    ),
    GetPage(
        name: sellerHomeRoute,
        page: () => const SellerHome(),
        binding: SellerBindings()),
    GetPage(
      name: '/product/:id',
      //arguments: ['calledFor'],
      page: () => const SingleProductView(),
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
      page: () => const SellerStoreDetailsUI(),
      binding: ProductBinding(),
    )
  ];
}

import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/exports/exports_ui.dart';
import 'package:ism_mart/screens/email_verification/email_verification_view.dart';

import '../screens/email_verify/email_verify_view.dart';

class Routes {
  static const initRoute = "/";
  static const loginRoute = "/signIn";
  static const resetPasswordRoute = "/resetPassword";
  static const passwordResetEmailInput = "/inputEmail";
  static const registerRoute = "/register";
  static const emailVerificationLinkRoute = "/emailVerificationLink";
  static const categoriesRoute = "/categories";
  static const cartRoute = "/cart";
  static const checkOutRoute = "/checkout";
  static const changeAddressRoute = "/changeAddress";

  static const profileRoute = "/profile";

  static const searchRoute = "/search";
  static const sellerHomeRoute = "/sellerDash";

  static const buyerOrdersRoute = "/buyerOrders";

  static const settingsRoute = "/settings";
  static const emailVerify = "/api/auth/verifyEmail";

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
        name: resetPasswordRoute,
        page: () => const ResetForgotPassword(),
        binding: BaseBindings()),
    // GetPage(
    //     name: passwordResetEmailInput,
    //     page: () => const ForgotPasswordView(),
    //     binding: BaseBindings()),
    GetPage(
        name: emailVerificationLinkRoute,
        page: () => EmailVerificationView(),
        binding: BaseBindings()),
    GetPage(
        name: emailVerify,
        page: () => const EmailVerifyView(),
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
      page: () => ChangeAddressUI(),
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
      page: () => const SellerStoreDetailsView(),
      binding: ProductBinding(),
    )
  ];
}

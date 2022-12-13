import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';

class Routes {
  static const initRoute = "/";
  static const loginRoute = "/signIn";
  static const registerRoute = "/register";
  static const categoriesRoute = "/categories";
  static const cartRoute = "/cart";
  static const checkOutRoute = "/checkout";
  static const profileRoute = "/profile";
  static const settingsRoute = "/settings";
  static const searchRoute = "/settings";
  static const sellerHomeRoute = "/sellerDash";

  static const buyerOrdersRoute = "/buyerOrders";



  static final pages = [
    /* GetPage(
      name: '/splash',
      page: () => SplashPage(),
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
        name: initRoute,
        page: () => const BaseLayout(),
        binding: BaseBindings()),
    GetPage(
      name: searchRoute,
      page: () => const SearchUI(),
      binding: SearchBindings(),
    ),

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
      page: () => MyOrdersUI(),
      binding: BuyerOrdersBindings(),
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
    )
  ];

/*static Route? onGeneratedRoute(RouteSettings? settings) {
    switch (settings!.name) {
      case dashboardRoute:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
              create: (context)=> BottomNavCubit(),
              ),

              BlocProvider(
                create: (context) => SliderCubit(SliderRepository()),
              ),
            ],
            child: const BaseLayout(),
          ),
        );
      */ /*case categoriesRoute:
        return Navigator.pushNamed(context, categoriesRoute);*/ /*
      default:
        return null;
    }
  }*/
}

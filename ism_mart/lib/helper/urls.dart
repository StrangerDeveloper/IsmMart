class Urls {
  //SignInViewModel
  static String login = "auth/login";

  //SignUpViewModel
  static String signUp = "auth/register";

  //ForgotPasswordViewModel
  static String forgetPassword = "auth/forgetPassword";

  //DisputeDetailViewModel
  static String ticketDetail = "tickets/";
  static String allTickets = "tickets/myTickets";
  static String deleteTickets = "tickets/delete/";

  //ContactUsViewModel
  static String contactUs = "user/contact";

  //productController
  static String deleteQuestion = "product/questions/delete/";
  static String updateQuestion = "product/questions/update/";
  static String addQuestion = "product/questions/add";
  static String addAnswer = "product/answers/add";
  static String updateAnswer = "product/answers/update/";
  static String deleteAnswer = "product/answers/delete/";

  //TopVendorsViewModel
  static String getTopVendors = "getTopVendors?limit=";

  //vendor order update status call at paymentviewModel

  static String updateOrderStatus = "order/updateOrderStatus";
  //allProducts for searc screen
  static String allProducts = "products/all";

  //ProductQuestionsViewModel
  static String getQuestionByProductId = "product/questions/";
  static String getVendorQuestions = "product/questions/vendorQuestions";

  //BuyerProfileViewModel
  static String deleteAccount = "user/deactivate";
  static String getVendorAccountData = "user/profile";
  static String updateVendorData = "user/update";

  //ChangePasswordViewModel
  static String updatePassword = "user/updatePassword";

  //UpdateVendorViewModel
  static String updateVendor = "auth/vendor/register";

  //ForgotPassword2ViewModel
  static String forgetPasswordOtp = "auth/forgetPasswordOtp";

  //MyProductsViewModel
  static String getMyProducts = "vendor/products/myProducts?limit=10&page=";
  static String deleteProduct = "vendor/products/delete/";

  //MyOrdersViewModel
  static String getVendorOrders = "order/vendorOrders?limit=10&";

  //BuyerOrderViewModel
  static String getBuyerOrders = "order/myOrders?limit=10&page=";
  static String getBuyerOrdersStats = "order/userStats";

  //SellerDashBoardViewModel
  static String getSellerOrdersStats = "order/vendorStats";
  static String getVendorOrdersForDashboard =
      "order/vendorOrders?limit=10&page=";

  //FaqViewModel
  static String getFaq = "faq/allFaq";

  //ChangeAddressViewModel
  static String getShippingDetails = "user/getShippingDetails?limit=3";
  static String changeDefaultAddress = "user/changeDefaultAddress/";
  // static String getDefaultShippingDetails = "user/getDefaultShippingDetails";
  static String deleteShippingDetails = "user/deleteShippingDetails/";

  //AddUpdateAddressViewModel
  static String updateShippingDetails = "user/updateShippingDetails";
  static String addShippingDetails = "user/addShippingDetails";
}

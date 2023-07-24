import 'package:get/get.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../checkout/checkout_viewmodel.dart';

class PaymentViewModel extends GetxController {
  final CheckoutViewModel viewModel = Get.put(CheckoutViewModel());
  late WebViewController webViewController;

  RxInt orderId = 0.obs;
  RxDouble amount = (0.0).obs;
  RxString currencyCode = "Rs".obs;
  RxInt no = 0.obs;
  testMethod() {
    no.value++;
  }

  @override
  void onInit() {
    orderId.value = viewModel.orderId.value;
    amount.value = viewModel.totalAmount.value;
    print("hasnain totalAmount => ${viewModel.totalAmount.value}");

    super.onInit();
    webViewController = WebViewController();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    webViewController.reload();
    webViewController
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(kPrimaryColor)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          print("hasnain url=> $url");
        },
      ))
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          AppConstant.displaySnackBar("sucess", message);
        },
      )
      ..loadHtmlString(paymentHtml());
  }

  String paymentHtml() {
    return ''' 
    
    <script
  src="https://code.jquery.com/jquery-1.12.4.min.js"
  integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
  crossorigin="anonymous"
></script>
<script src="https://merchants.bankalfalah.com/merchantportalprelive/HostedCheckoutFiles/HostedCheckoutPayments.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>

<script></script>

<style type="text/css">
  #TransactionForm {
    width: 100%;
    display: flex;
    flex-direction: column;
  }

  .inputLabel {
    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI',
      Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue',
      sans-serif;
    color: #364554;
  }

  .cardInputs {
    border-radius: 30px;
    height: 33px;
    outline: none;
    border: 2px solid #d9d9d9;
    margin-top: 6px;
    padding-left: 15px;
  }
  .cardInputs::placeholder {
    color: #999;
    font-style: italic;
  }
  .cardInputs:focus {
    border-color: black;
  }
  .cardButton {
    border-radius: 8px;
    padding: 10px 15px 10px 15px;
    width: fit-content;
    background-color: black;
    color: White;
    cursor: pointer;
  }
  .cardButton:hover {
    color: #ef4444;
  }

  .CardNumber {
  }

  .CVV {
  }

  .ExpiryMonth {
  }

  .ExpiryYear {
  }

  .CustomerName {
  }

  .CustomerEmailAddress {
  }

  .CustomerMobileNumber {
  }

  .alert {
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    border-radius: 4px;
  }

  .alert-success {
    color: #3c763d;
    background-color: #dff0d8;
    border-color: #d6e9c6;
  }

  .alert-danger {
    color: #a94442;
    background-color: #f2dede;
    border-color: #ebccd1;
  }

  #errorlbl {
    color: crimson;
    font-size: 17px;
  }
</style>
        <script>
     function myFunction() {
       var orderid = "${orderId.value}";
       var amount = " ${amount.value}";
       document.getElementById("myText").innerHTML = orderid + amount;
           console.log("hasnai myfunc call");
           
    Print.postMessage('Hello World being called from Javascript code');
     }
    Print.postMessage('Hello World being called from Javascript code');
   </script>
<div id="dvLoader" style="display: none">
  <img
    style="width: 10%"
    src="https://mvisa.bankalfalah.com/APGONLINE/HostedCheckoutFiles/Loader.gif"
  />
</div>

<div id="dvSuccess" class="alert alert-success" style="display: none">
  <strong>Transaction Successful!</strong> <span id="successMsg"></span>
</div>

<div id="dvFailed" class="alert alert-danger" style="display: none">
  <strong>Transaction Failed!</strong> <span id="failedMsg"></span>
</div>

<form id="TransactionForm">
  <!-- Hosted Fields -->
  <label class="inputLabel" for="">Card Number</label>
  <input
    class="cardInputs CardNumber allow_numeric"
    id="CardNumber"
    name="TransCardNumber"
    type="text"
    placeholder="******"
    value=""
  /><br /><br />
  <label class="inputLabel" for="">CVV</label>
  <input
    class="cardInputs CVV allow_numeric"
    id="CVV"
    name="TransCVV"
    type="text"
    placeholder="*"
    value=""
  /><br /><br />
  <label class="inputLabel" for="">Expiry Month</label>
  <input
    class="cardInputs ExpiryMonth allow_numeric"
    id="ExpiryMonth"
    name="TransExpiryMonth"
    type="text"
    placeholder="Enter 2 digit expiry month eg. 07"
    value=""
  /><br /><br />
  <label class="inputLabel" for="">Expiry Year</label>
  <input
    class="cardInputs ExpiryYear allow_numeric"
    id="ExpiryYear"
    name="TransExpiryYear"
    type="text"
    placeholder="Enter 4 digit expiry year eg. 2012"
    value=""
  /><br /><br />
  <label class="inputLabel" for="">Full Name</label>
  <input
    class="cardInputs CustomerName allow_alphabet"
    id="CustomerName"
    name="TransCustomerName"
    type="text"
    placeholder="Full name"
    value=""
  /><br /><br />
  <label class="inputLabel" for="">Email</label>
  <input
    class="cardInputs CustomerEmailAddress"
    id="CustomerEmailAddress"
    name="TransCustomerEmailAddress"
    type="text"
    placeholder="username@domain.com"
    value=""
  /><br /><br />
  <label class="inputLabel" for="">Phone Number</label>
  <input
    class="cardInputs CustomerMobileNumber allow_numeric"
    id="CustomerMobileNumber"
    name="TransCustomerMobileNumber"
    type="text"
    placeholder="Enter your phone in this format +92****"
    value=""
  /><br /><br />
         <div class="col-sm-5 text-sm-center justify-content-center pt-4 pb-4">
                             <small class="text-sm text-muted">Order number</small>
                             <h5 class="mb-5">${orderId.value}</h5>
                            <small class="text-sm text-muted">Payment amount</small>  </div>
                             <div class="row px-3 justify-content-sm-center">
                                 <h2 class=""><span
                                         class="text-sm font-weight-bold mr-2">\Rs </span><span
                                         class="text-danger" id="myText">${amount.value}</span></h2>
                             </div>
 <button onclick="myFunction()"
    type="button"
    class="btn btn-custon-four btn-danger cardButton"
    id="InitiateTrans"
    name="TransInitiateTrans"
  >
    Confirm Payment</button
  ><br />
  <label class="errorlbl" id="errorlbl"></label>
</form>

<div id="dv3DS"></div>
<script type="text/javascript">
  //payment
  const urlParams = new URLSearchParams(window.location.search);
  const orderId = urlParams.get('orderId');
  const amount = urlParams.get('amount');
   \$(document).ready(function () {
    print(" hasnain in pay funct -----${orderId.value} ${amount.value}") ;
     /Pass Order Id and Transaction Amount below/
     var StoreId = '030848';
     var TransType = '3';
    var OrderId = ${orderId.value}; 
        var Amount = ${amount.value};
     InitializeValues(StoreId, TransType, OrderId, Amount);
      print("hasnain  ");
   });



 
  //callbacks
  function successCallback() {
    
    callApi('Payment Successfull');
    localStorage.setItem(
      'react-use-cart',
      JSON.stringify({
        items: [],
        isEmpty: true,
        totalItems: 0,
        totalUniqueItems: 0,
        cartTotal: 0,
        metadata: {},
      })
    );
    setTimeout(() => {
      window.top.location.replace(`http://localhost:5173/#/order/${orderId}`);
    }, 5000);
  }
  function failedCallback() {
    print("hhh failed call back  =>  ");
    callApi('Payment Failed');
    setTimeout(() => {
      window.top.location.replace(`http://localhost:5173/#/checkout`);
    }, 8000);
  }


    Print.postMessage('Hello World being called from Javascript code');

</script>
    
    
    
     ''';

//      <html>
//         <head>
//           <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
//           <script src="https://merchants.bankalfalah.com/merchantportalprelive/HostedCheckoutFiles/HostedCheckoutPayments.js"></script>
//           <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
//          <style type="text/css">
//       #TransactionForm {
//     width: 100%;
//     display: flex;
//     flex-direction: column;
//   }
//   .inputLabel {
//     font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI',
//       Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue',
//       sans-serif;
//     color: #364554;
//   }

//   .cardInputs {
//     border-radius: 30px;
//     height: 33px;
//     outline: none;
//     border: 2px solid #d9d9d9;
//     margin-top: 6px;
//     padding-left: 15px;
//   }
//   .cardInputs::placeholder {
//     color: #999;
//     font-style: italic;
//   }
//   .cardButton {
//     border-radius: 8px;
//     padding: 10px 15px 10px 15px;
//     width: fit-content;
//     background-color: black;
//     color: White;
//     cursor: pointer;
//   }
//   .cardButton:hover{
//     color: #EF4444;
//   }

//       body {
//       font-family: Arial, sans-serif;
//       background-color: #f2f2f2;
//       padding: 10px;
//     }

//     .form-container {
//       background-color: #fff;
//       border-radius: 5px;
//       padding: 20px;
//       box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
//       max-width: 400px;
//       margin: 0 auto;
//     }

//     .form-container h2 {
//       text-align: center;
//       margin-bottom: 20px;
//     }

//     .form-container input[type="text"] {
//       width: 100%;
//       padding: 10px;
//       margin-bottom: 15px;
//       border: 1px solid #ccc;
//       border-radius: 4px;
//       box-sizing: border-box;
//     }

//     .form-container button {
//       width: 100%;
//       padding: 10px;
//       background-color: #4CAF50;
//       color: white;
//       border: none;
//       border-radius: 4px;
//       cursor: pointer;
//     }

//     .form-container button:hover {
//       background-color: #45a049;
//     }

//     .form-container .error-message {
//       color: crimson;
//       font-size: 14px;
//       margin-top: 10px;
//     }

//       .alert {
//         padding: 15px;
//         margin-bottom: 20px;
//         border: 1px solid transparent;
//         border-radius: 4px;
//       }

//       .alert-success {
//         color: #3c763d;
//         background-color: #dff0d8;
//         border-color: #d6e9c6;
//       }

//       .alert-danger {
//         color: #a94442;
//         background-color: #f2dede;
//         border-color: #ebccd1;
//       }

//       #errorlbl {
//         color: crimson;
//         font-size: 17px;
//       }
//     </style>

//          <script>
//     function myFunction() {
//       var orderid = "${orderId.value}";
//       var amount = " ${amount.value}";
//       document.getElementById("myText").innerHTML = orderid + amount;
//           console.log("hasnai myfunc call");
//     }
//   </script>
//         </head>
//         <body >

//          <div id="dvLoader" style="display: none">
//       <img style="width: 10%" src="https://mvisa.bankalfalah.com/APGONLINE/HostedCheckoutFiles/Loader.gif" />
//     </div>

//     <div id="dvSuccess" class="alert alert-success" style="display: none">
//       <strong>Transaction Successful!</strong> <span id="successMsg"></span>
//     </div>

//     <div id="dvFailed" class="alert alert-danger" style="display: none">
//       <strong>Transaction Failed!</strong> <span id="failedMsg"></span>
//     </div>

//     <form id="TransactionForm" class="form-container">
//       <!-- Hosted Fields -->
//       <input class="CardNumber allow_numeric" id="CardNumber" name="TransCardNumber" type="text" placeholder="Card Number" value="" /><br /><br />
//       <input class="CVV allow_numeric" id="CVV" name="TransCVV" type="text" placeholder="CVV" value="" /><br /><br />
//       <input class="ExpiryMonth allow_numeric" id="ExpiryMonth" name="TransExpiryMonth" type="text" placeholder="Expiry Month" value="" /><br /><br />
//       <input class="ExpiryYear allow_numeric" id="ExpiryYear" name="TransExpiryYear" type="text" placeholder="Expiry Year" value="" /><br /><br />
//       <input class="CustomerName allow_alphabet" id="CustomerName" name="TransCustomerName" type="text" placeholder="Customer Name" value="" /><br /><br />
//       <input class="CustomerEmailAddress" id="CustomerEmailAddress" name="TransCustomerEmailAddress" type="text" placeholder="Customer Email Address" value="" /><br /><br />
//       <input class="CustomerMobileNumber allow_numeric" id="CustomerMobileNumber" name="TransCustomerMobileNumber" type="text" placeholder="Customer Mobile Number" value="" /><br /><br />
//         <div class="col-sm-5 text-sm-center justify-content-center pt-4 pb-4">
//                             <small class="text-sm text-muted">Order number</small>
//                             <h5 class="mb-5">${orderId.value}</h5>
//                             <small class="text-sm text-muted">Payment amount</small>  </div>
//                             <div class="row px-3 justify-content-sm-center">
//                                 <h2 class=""><span
//                                         class="text-sm font-weight-bold mr-2">\Rs </span><span
//                                         class="text-danger" id="myText">${amount.value}</span></h2>
//                             </div>
//       <button onclick="myFunction()" type="button" class="btn btn-custon-four btn-danger" id="InitiateTrans" name="TransInitiateTrans">Initiate</button><br />
//       <label class="errorlbl" id="errorlbl"></label>
//     </form>

//     <div id="dv3DS"></div>
//           <script>

// const urlParams = new URLSearchParams(window.location.search);
//   const orderId = urlParams.get('orderId');
//   const amount = urlParams.get('amount');
//   console.log(orderId, amount);
//   \$(document).ready(function () {
//    print(" hasnain in pay funct -----${orderId.value} ${amount.value}") ;
//     /Pass Order Id and Transaction Amount below/
//     var StoreId = '030848';
//     var TransType = '3';
//     var OrderId = ${orderId.value};
//     var Amount = ${amount.value};
//     InitializeValues(StoreId, TransType, OrderId, Amount);
//      print("hasnain  ");
//   });

//           </script>

//         </body>
//       </html>
//     ''';
  }

//create order id api   /api/order/createOrder

  // getProductQuestions() async {
  //   await ApiBaseHelper()
  //       .getMethod(url: 'product/questions/${productModel.value.id}')
  //       .then((value) {
  //     if (value['success'] == true && value['data'] != null) {
  //       productQuestions.clear();
  //       var data = value['data'] as List;
  //       productQuestions.addAll(data.map((e) => QuestionModel.fromJson(e)));
  //     }
  //   }).catchError((e) {
  //     AppConstant.displaySnackBar(langKey.errorTitle.tr, e.toString());
  //   });
  // }

//InAapp WebView


}

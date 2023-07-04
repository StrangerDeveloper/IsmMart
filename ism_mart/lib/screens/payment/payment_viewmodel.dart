import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewModel extends GetxController {
  late WebViewController webViewController;

  RxInt orderId = 0.obs;
  RxDouble amount = (0.0).obs;

  generateOrderId() {
    Random random = Random();
    orderId.value = random.nextInt(100000);
  }

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://flutter.dev')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
    ;
  }

  @override
  void onReady() {
    webViewController.reload();
    webViewController
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(kPrimaryColor)
      //..setNavigationDelegate(delegate)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          AppConstant.displaySnackBar("sucess", message);
        },
      )
      ..loadHtmlString(paymentHtml());

    print("on ready hasnain $orderId $amount");
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    webViewController.clearCache();
    webViewController.goBack();
    print(" hasnain payment controller close ");
    // TODO: implement onClose
    super.onClose();
  }

  String? htmlContent = '''
    <div id="dvLoader" style="display: none">
      <img style="width: 10%" src="https://mvisa.bankalfalah.com/APGONLINE/HostedCheckoutFiles/Loader.gif" />
    </div>

    <div id="dvSuccess" class="alert alert-success" style="display: none">
      <strong>Transaction Successful!</strong> <span id="successMsg"></span>
    </div>

    <div id="dvFailed" class="alert alert-danger" style="display: none">
      <strong>Transaction Failed!</strong> <span id="failedMsg"></span>
    </div>

    <form id="TransactionForm" class="form-container">
      <!-- Hosted Fields -->
      <input class="CardNumber allow_numeric" id="CardNumber" name="TransCardNumber" type="text" placeholder="Card Number" value="" /><br /><br />
      <input class="CVV allow_numeric" id="CVV" name="TransCVV" type="text" placeholder="CVV" value="" /><br /><br />
      <input class="ExpiryMonth allow_numeric" id="ExpiryMonth" name="TransExpiryMonth" type="text" placeholder="Expiry Month" value="" /><br /><br />
      <input class="ExpiryYear allow_numeric" id="ExpiryYear" name="TransExpiryYear" type="text" placeholder="Expiry Year" value="" /><br /><br />
      <input class="CustomerName allow_alphabet" id="CustomerName" name="TransCustomerName" type="text" placeholder="Customer Name" value="" /><br /><br />
      <input class="CustomerEmailAddress" id="CustomerEmailAddress" name="TransCustomerEmailAddress" type="text" placeholder="Customer Email Address" value="" /><br /><br />
      <input class="CustomerMobileNumber allow_numeric" id="CustomerMobileNumber" name="TransCustomerMobileNumber" type="text" placeholder="Customer Mobile Number" value="" /><br /><br />
      <button type="button" class="btn btn-custon-four btn-danger" id="InitiateTrans" name="TransInitiateTrans">Initiate</button><br />
      <label class="errorlbl" id="errorlbl"></label>
    </form>

    <div id="dv3DS"></div>
  ''';

  String? cssStyles = '''
    <style type="text/css">
      body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      padding: 10px;
    }

    .form-container {
      background-color: #fff;
      border-radius: 5px;
      padding: 20px;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
      max-width: 400px;
      margin: 0 auto;
    }

    .form-container h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    .form-container input[type="text"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
    }

    .form-container button {
      width: 100%;
      padding: 10px;
      background-color: #4CAF50;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .form-container button:hover {
      background-color: #45a049;
    }

    .form-container .error-message {
      color: crimson;
      font-size: 14px;
      margin-top: 10px;
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
  ''';

  String scriptInjectedHtml = "";
  String paymentHtml() {
    return '''

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="https://merchants.bankalfalah.com/merchantportalprelive/HostedCheckoutFiles/HostedCheckoutPayments.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
                                                                                                               rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <style type="text/css">
      body {
      font-family: system-ui, -apple-system, BlinkMacSystemFont, Segoe UI,
      Roboto, Oxygen, Ubuntu, Cantarell, Open Sans, Helvetica Neue,
      sans-serif;
      background-color: #f2f2f2;
      padding: 10px;
    }

    .form-container {
      background-color: #fff;
      border-radius: 5px;
      padding: 20px;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
      max-width: 400px;
      margin: 0 auto;
    }

    .form-container h2 {
      text-align: center;
      margin-bottom: 20px;
    }

    .form-container input[type="text"], input[type="email"] {
      width: 100%;
      padding: 6px;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 5px;
      box-sizing: border-box;
    }

    .form-container button {
      width: 100%;
      padding: 10px;
      background-color: #000000;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .form-container button:hover {
      background-color: #000000;
       border-radius: 6px;
    }

    .form-container .error-message {
      color: crimson;
      font-size: 14px;
      margin-top: 10px;
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
    }
  </script>
</head>
<body>
   <h1>"The value for number is: " <span id="myText"></span></h1>
<div id="dvLoader" style="display: none">
    <img style="width: 10%"
         src="https://mvisa.bankalfalah.com/APGONLINE/HostedCheckoutFiles/Loader.gif"/>
</div>

<div id="dvSuccess" class="alert alert-success" style="display: none">
    <strong>Transaction Successful!</strong> <span id="successMsg"></span>
</div>

<div id="dvFailed" class="alert alert-danger" style="display: none">
    <strong>Transaction Failed!</strong> <span id="failedMsg"></span>
</div>


<form id="TransactionForm" class="form-container">
    <!-- Hosted Fields -->
    <div class="card-header py-3">
        <h4 class="mb-0">Payment details</h4>
        <p class="dis mb-3">Complete your purchase by providing your payment details</p>
    </div>
    <div class="form-floating">
        <input class="CardNumber allow_numeric form-control" id="CardNumber" name="TransCardNumber"
               type="text" placeholder="**** **** **** ****" value=""/>
        <label class="form-label" for="CardNumber">Card Number</label>
    </div>

    <div class="form-floating">
        <input class="CustomerName allow_alphabet form-control" id="CustomerName" name="TransCustomerName"
               type="text" placeholder="Full Name" value=""/>
        <label class="form-label" for="CustomerName">Card Holder Name</label>
    </div>

    <div class="row">
        <div class="col-6">
            <div class="form-floating">
                <input class="ExpiryMonth allow_numeric form-control" id="ExpiryMonth" name="TransExpiryMonth"
                       type="text"
                       placeholder="Expiry Month" value=""/>
                <label class="form-label" for="ExpiryMonth">Month</label>
            </div>
        </div>
        <div class="col-6">
            <div class="form-floating">
                <input class="ExpiryYear allow_numeric form-control" id="ExpiryYear" name="TransExpiryYear"
                       type="text"
                       placeholder="Expiry Year" value=""/>
                <label class="form-label" for="ExpiryYear">Year</label>
            </div>
        </div>
    </div>

    <div class="form-floating">
        <input class="CVV allow_numeric form-control" id="CVV" name="TransCVV" type="text"
               placeholder="CVV"
               value=""/>
        <label class="form-label" for="CVV">CVV</label>
    </div>

    <div class="form-floating">
     <input class="CustomerEmailAddress form-control" id="CustomerEmailAddress" name="TransCustomerEmailAddress"
            type="email" placeholder="Email Address" value=""/>
        <label class="form-label" for="CustomerEmailAddress">Email</label>
    </div>

 <div class="form-floating">
     <input class="CustomerMobileNumber allow_numeric form-control" id="CustomerMobileNumber"
            name="TransCustomerMobileNumber" type="text" placeholder="Phone Number"
            value=""/>
        <label class="form-label" for="CustomerMobileNumber">Phone</label>
    </div>

    <button  onclick="myFunction()" type="button" class="btn btn-custon-four btn-danger cardButton" id="InitiateTrans"
            name="TransInitiateTrans"> Confirm Payment
    </button>
    <br/>
    <label class="errorlbl" id="errorlbl"></label>
</form>

<div id="dv3DS"></div>



          <script>
const urlParams = new URLSearchParams(window.location.search);
  const orderId = urlParams.get('${orderId.value}');
  const amount = urlParams.get('${amount.value}');
  console.log(orderId, amount);
  \$(document).ready(function () {
    /Pass Order Id and Transaction Amount below/
    var StoreId = '030848';
    var TransType = '3';
    var OrderId = orderId;
    var Amount = amount;
    InitializeValues(StoreId, TransType, OrderId, Amount);
  }
);
 </script> 











     
   
       

  </body>
      </html>
    ''';
  }
}

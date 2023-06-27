import 'package:get/get.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewModel extends GetxController {
  late WebViewController webViewController;

  RxInt? orderId = 0.obs;
  RxDouble? amount = (0.0).obs;
  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();
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
          <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
          <script src="https://merchants.bankalfalah.com/merchantportalprelive/HostedCheckoutFiles/HostedCheckoutPayments.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
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
  .cardButton {
    border-radius: 8px;
    padding: 10px 15px 10px 15px;
    width: fit-content;
    background-color: black;
    color: White;
    cursor: pointer;
  }
  .cardButton:hover{
    color: #EF4444;
  }
      
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
        </head>
        <body>
        
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
          <script>

const urlParams = new URLSearchParams(window.location.search);
  const orderId = urlParams.get('orderId');
  const amount = urlParams.get('amount');
  console.log(orderId, amount);
  \$(document).ready(function () {
   print(" hasnain -----${orderId!.value} ${amount!.value}") ;
    /Pass Order Id and Transaction Amount below/
    var StoreId = '030848';
    var TransType = '3';
    var OrderId = 127;
    var Amount = 5;
    InitializeValues(StoreId, TransType, OrderId, Amount);
  });

            // function successCallback() {}
            // function failedCallback() {}

            // (document).ready(function() {
            //   var StoreId = '030848';
            //   var TransType = '3';
            //   var OrderId = 1122334456; // Replace with the actual order ID
            //   var Amount = 5; // Replace with the actual amount
            //   InitializeValues(StoreId, TransType, OrderId, Amount);
            // });
          </script>


        </body>
      </html>
    ''';
  }
}

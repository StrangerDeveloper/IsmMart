import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/deals/deals_view.dart';
import 'package:ism_mart/screens/payment/payment_viewmodel.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_appbar.dart';

import '../checkout/checkout_view.dart';

class PaymentView extends StatefulWidget {
  PaymentView({
    super.key,
    required this.orderId,
    required this.amount,
    required this.currencyCode,
  });
  final int? orderId;
  final double? amount;
  final String? currencyCode;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final PaymentViewModel viewModel = Get.put(PaymentViewModel());

  //webview
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    // viewModel.webViewController.reload();
    // viewModel.orderId(orderId);
    // viewModel.amount(amount);
    viewModel.currencyCode(widget.currencyCode);

    return Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: CustomAppBar(
          backBtn: false,
          menuItem: true,
          action: [],
          title: langKey.checkout.tr,
          elevation: 0.5,
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialData: InAppWebViewInitialData(data: ''' 
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
                             <h5 class="mb-5">${viewModel.orderId.value}</h5>
                            <small class="text-sm text-muted">Payment amount</small>  </div>
                             <div class="row px-3 justify-content-sm-center">
                                 <h2 class=""><span
                                         class="text-sm font-weight-bold mr-2">\Rs </span><span
                                         class="text-danger" id="myText">${viewModel.amount.value}</span></h2>
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
 <br />
<div id="dv3DS"></div>




<script type="text/javascript">
  //payment
  const urlParams = new URLSearchParams(window.location.search);
  const orderId = urlParams.get('orderId');
  const amount = urlParams.get('amount');
   \$(document).ready(function () {
     /Pass Order Id and Transaction Amount below/
     var StoreId = '030848';
     var TransType = '3';
    var OrderId = ${viewModel.orderId.value}; 
        var Amount = ${viewModel.amount.value};
     InitializeValues(StoreId, TransType, OrderId, Amount);
      print("hasnain  ");
      
   });



 
  //callbacks
  function successCallback() {

       window.flutter_inappwebview.callHandler('saveFormData'); 
       window.addEventListener("dvSuccess", function(event) {
       window.flutter_inappwebview.callHandler('saveFormData');
});

  }

  function failedCallback() {
        window.flutter_inappwebview.callHandler('dvFailed');
               window.addEventListener("dvFailed", function(event) {
       window.flutter_inappwebview.callHandler('saveFormData');
});

  }



</script>
    


 '''),
              onWebViewCreated: (controller) {
                webViewController = controller;
                controller.addJavaScriptHandler(
                    handlerName: 'saveFormData',
                    callback: (arguments) {
                      viewModel.updateOrderStatus("Payment Successfull");
                      Get.off(DealsView());
                    });
                controller.addJavaScriptHandler(
                    handlerName: 'dvFailed',
                    callback: (arguments) {
                      viewModel.updateOrderStatus("Payment Failed");
                      Get.off(CheckoutView());
                    });
              },
            ),
          ),
        ])

//       body: Stack(
//         children: [
//           WebViewWidget(
// InAppWebView()

//         //    controller: viewModel.webViewController,

//           ),
//           LoaderView(),
//         ],
//       ),
        );
  }
}

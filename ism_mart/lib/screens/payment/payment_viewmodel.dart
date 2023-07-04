import 'package:get/get.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewModel extends GetxController {
  late WebViewController webViewController;

  RxInt orderId = 0.obs;
  RxDouble amount = (0.0).obs;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();

    webViewController.reload();
    Future.delayed(
        Duration(milliseconds: 500),
        () => webViewController
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
          ..loadHtmlString(paymentHtml()));

    print("on ready hasnain $orderId $amount");
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    webViewController.reload();
    webViewController.clearCache();
    webViewController.goBack();
    print(" hasnain payment controller close ");
    // TODO: implement onClose
    super.onClose();
  }

  String paymentHtml() {
    return '''
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <script src="https://merchants.bankalfalah.com/merchantportalprelive/HostedCheckoutFiles/HostedCheckoutPayments.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <style type="text/css">
        body {
            color: #000;
            overflow-x: hidden;
            height: 100%;
            background-color: #e4dfdf;
            background-repeat: no-repeat;
        }

        .card {
            padding: 30px 25px 35px 50px;
            border-radius: 30px;
            box-shadow: 0px 4px 8px 0px #201f1f;
            margin-top: 50px;
            margin-bottom: 50px;
        }

        .border-line {
            border-right: 1px solid #BDBDBD;
        }

        .text-sm {
            font-size: 13px;
        }

        .text-md {
            font-size: 16px;
        }

        ::placeholder {
            color: grey;
            opacity: 0.8;
        }

        :-ms-input-placeholder {
            color: grey;
        }

        ::-ms-input-placeholder {
            color: grey;
        }

        input {
            padding: 2px 0px;
            border: none;
            border-bottom: 1px solid lightgrey;
            margin-bottom: 5px;
            margin-top: 2px;
            box-sizing: border-box;
            color: #000;
            font-size: 13px;
            letter-spacing: 1px;
            font-weight: 500;
        }

        input:focus {
            -moz-box-shadow: none !important;
            -webkit-box-shadow: none !important;
            box-shadow: none !important;
            border-bottom: 1px solid #050505;
            outline-width: 0;
        }

        button:focus {
            -moz-box-shadow: none !important;
            -webkit-box-shadow: none !important;
            box-shadow: none !important;
            outline-width: 0;
        }

        .btn-red {
            background-color: #0a0a0a;
            color: #fff;
            padding: 8px 25px;
            border-radius: 50px;
            font-size: 18px;
            letter-spacing: 2px;
            border: 2px solid #fff;
        }

        .btn-red:hover {
            color: #EF5350;
            box-shadow: 0 0 0 2px #EF5350;
        }

        .btn-red:focus {
            box-shadow: 0 0 0 2px #EF5350 !important;
        }

        @media screen and (max-width: 575px) {
            .border-line {
                border-right: none;
                border-bottom: 1px solid #EEEEEE;
            }
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
     // var orderid = "${orderId.value}";
      var amount = " ${amount.value}";
      document.getElementById("myText").innerHTML = orderid + amount;
          console.log("hasnai myfunc call");
    }
  </script>
</head>
<body>
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



   <form id="TransactionForm">
    
    <div class="container-fluid px-1 px-md-2 px-lg-4 py-5 mx-auto">
        <div class="row d-flex justify-content-center">
            <div class="col-xl-7 col-lg-8 col-md-9 col-sm-11">
                <div class="card border-0">
                    <div class="row justify-content-center">
                        <h3 class="mb-4">Payment Details</h3>
                    </div>
                    <!--<div class="col-12 justify-content-center">
                        <h3 class="">Payment Details</h3>
                        <small class="mob-4">Complete your purchase by providing your payment details</small> 
                    
                    </div>
                <br>-->

                    <div class="row">
                        <div class="col-sm-7 border-line pb-3">
                            <div class="form-group">
                                <p class="text-muted text-sm mb-0">Name on the card</p>
                                <input class="CustomerName allow_alphabet" id="CustomerName"
                                       name="TransCustomerName"
                                       type="text" placeholder="Full Name" value="" size="15"/>
                            </div>
                            <div class="form-group">
                                <p class="text-muted text-sm mb-0">Card Number</p>
                                <div class="row px-3">
                                    <input  class="CardNumber allow_numeric" id="CardNumber" name="TransCardNumber"
                                            type="text"
                                           placeholder="0000 0000 0000 0000" size="18"
                                           minlength="19" maxlength="19">

                                </div>
                            </div>
                            <div class="form-group">
                                <p class="text-muted text-sm mb-0">Expiry date</p>
                                <input class="ExpiryMonth allow_numeric" id="ExpiryMonth"
                                       name="TransExpiryMonth"
                                       type="text"
                                       size="6"
                                       minlength="5" maxlength="5"
                                       placeholder="MM" value=""/>

                                <input class="ExpiryYear allow_numeric" id="ExpiryYear"
                                       name="TransExpiryYear"
                                       type="text"
                                       size="6"
                                       minlength="5" maxlength="5"
                                       placeholder="YY" value=""/>
                         </div>

                         <div class="form-group">
                            <p class="text-muted text-sm mb-0">CVV/CVC</p>
                            <input class="CVV allow_numeric" id="CVV" name="TransCVV" type="text"
                                   placeholder="000"
                                   size="1"
                                   minlength="3" maxlength="3"
                                   value=""/>
                        </div>
                           
                            <div class="form-group">
                                <p class="text-muted text-sm mb-0">Email</p>
                                <input class="CustomerEmailAddress" 
                                id="CustomerEmailAddress" 
                                name="TransCustomerEmailAddress"
                                       type="email" placeholder="example@domain.com" value=""/>
                            </div>

                            <div class="form-group">
                                <p class="text-muted text-sm mb-0">Phone</p>
                                <input class="CustomerMobileNumber allow_numeric" 
                                    id="CustomerMobileNumber"
                                    name="TransCustomerMobileNumber"
                                       type="phone" placeholder="e.g. +923001234567" value="" size="15"/>
                            </div>

                        </div>
                        <div class="col-sm-5 text-sm-center justify-content-center pt-4 pb-4">
                            <small class="text-sm text-muted">Order number</small>
                            <h5 class="mb-5">${orderId.value}</h5>
                            <small class="text-sm text-muted">Payment amount</small>
                            <div class="row px-3 justify-content-sm-center">
                                <h2 class=""><span
                                        class="text-md font-weight-bold mr-2">\Rs</span><span
                                        class="text-danger" id="myText">${amount}</span></h2>
                            </div>
                            <button onclick="myFunction()" type="button" 
                            name="TransInitiateTrans" class="btn btn-red text-center mt-4">PAY</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
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

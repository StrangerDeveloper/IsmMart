import 'package:get/get.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewModel extends GetxController {
  late WebViewController webViewController;

  RxInt orderId = 0.obs;
  RxDouble amount = (0.0).obs;
  RxString currencyCode = "Rs".obs;

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
    super.onReady();
  }

  @override
  void onClose() {
    webViewController.reload();
    webViewController.clearCache();
    webViewController.goBack();
    super.onClose();
  }

  String paymentHtml() {
    return '''
<html>
  <head>
      <meta name="viewport" content="width=device-width, initial-scale=0.8">

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
              background-color: #ffffff;
              background-repeat: no-repeat;
          }

          .card {
              padding: 30px 25px 35px 50px;
              border-radius: 20px;
              box-shadow: 0px 4px 8px 0px #8a8787;
              margin-top: 0px;
              margin-bottom: 20px;
          }

          .border-line {
              border-right: 1px solid #BDBDBD;
          }

          .text-sm {
              font-size: 13px;
          }

          .text-md {
              font-size: 15px;
          }

          ::placeholder {
              color: grey;
              opacity: 0.9;
          }

          :-ms-input-placeholder {
              color: grey;
              opacity: 0.9;
          }

          ::-ms-input-placeholder {
              color: grey;
              opacity: 0.9;
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
              font-weight: 400;
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
              border: 1.5px solid #fff;
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
                                                  type="number"
                                              placeholder="0000 0000 0000 0000" size="18"
                                              minlength="19" maxlength="19">

                                      </div>
                                  </div>
                                  <div class="form-group">
                                      <p class="text-muted text-sm mb-0">Expiry date</p>
                                      <input class="ExpiryMonth allow_numeric" id="ExpiryMonth"
                                          name="TransExpiryMonth"
                                          type="number"
                                          size="6"
                                          minlength="5" maxlength="5"
                                          placeholder="MM" value=""/>

                                      <input class="ExpiryYear allow_numeric" id="ExpiryYear"
                                          name="TransExpiryYear"
                                          type="number"
                                          size="6"
                                          minlength="5" maxlength="5"
                                          placeholder="YY" value=""/>
                              </div>

                              <div class="form-group">
                                  <p class="text-muted text-sm mb-0">CVV/CVC</p>
                                  <input class="CVV allow_numeric" id="CVV" name="TransCVV" type="number"
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
                                              class="text-md font-weight-bold mr-2">${currencyCode.value}</span><span
                                              class="text-danger">${amount.value}</span></h2>
                                  </div>
                                  <button type="button" 
                                  name="TransInitiateTrans" class="btn btn-red text-center mt-4">PAY</button>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
    </form>
    


  <div id="dv3DS"></div>

      <script type="text/javascript">

      //const urlParams = new URLSearchParams(window.location.search);
      const orderId = ${orderId.value}; //urlParams.get('orderId');
      const amount =   ${amount.value};//  urlParams.get('amount');
      console.log(orderId, amount);
      
        \$(document).ready(function () {
                //Pass Order Id and Transaction Amount below
                var StoreId = '030848';
                var TransType = '3';
                var OrderId = orderId;
                var Amount = amount;
                InitializeValues(StoreId, TransType, OrderId, Amount);
            });
      
      
          \$(document).ready(function(){
              //For Card Number formatted input
              var cardNum = document.getElementById('CardNumber');
              cardNum.onkeyup = function (e) {
                  if (this.value == this.lastValue) return;
                  var caretPosition = this.selectionStart;
                  var sanitizedValue = this.value.replace(/[^0-9]/gi, '');
                  var parts = [];
                  for (var i = 0, len = sanitizedValue.length; i < len; i +=4) { 
                      parts.push(sanitizedValue.substring(i, i + 4)); 
                  }
                  for (var i=caretPosition - 1; i>= 0; i--) {
                      var c = this.value[i];
                      if (c < '0' || c> '9') {
                          caretPosition--;
                      }
                  }
                  caretPosition += Math.floor(caretPosition / 4);
                  this.value = this.lastValue = parts.join(' ');
                  this.selectionStart = this.selectionEnd = caretPosition;
              }
          });
          
      </script>

  </body>
</html>
    ''';
  }
}

// import 'package:get/get.dart';
// import 'package:ism_mart/helper/constants.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymentViewModel extends GetxController {
//   late WebViewController webViewController;

//   RxInt orderId = 0.obs;
//   RxDouble amount = (0.0).obs;

//   @override
//   void onInit() {
//     super.onInit();
//     webViewController = WebViewController();
//   }

//   @override
//   void onReady() {
//     // TODO: implement onReady
//     super.onReady();
//     webViewController
//       ..enableZoom(true)
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       // ..setBackgroundColor(kPrimaryColor)
//       //..setNavigationDelegate(delegate)
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           AppConstant.displaySnackBar("sucess", message);
//         },
//       )
//       ..loadHtmlString(paymentHtml());
//   }

//   String paymentHtml() {
//     return '''

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
    
//   </head>
//         <body >
        

//      <div id="dvLoader" style="display: none">
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
//     var Amount = 5;
//     InitializeValues(StoreId, TransType, OrderId, Amount);
//   });

            
//           </script>


//         </body>
//       </html>
//     ''';
//   }
// }




/** //form actual

//     <form id="TransactionForm" class="form-container">
//       <!-- Hosted Fields -->
//       <input class="CardNumber allow_numeric" id="CardNumber" name="TransCardNumber" type="text" placeholder="Card Number" value="" /><br /><br />
//       <input class="CVV allow_numeric" id="CVV" name="TransCVV" type="text" placeholder="CVV" value="" /><br /><br />
//       <input class="ExpiryMonth allow_numeric" id="ExpiryMonth" name="TransExpiryMonth" type="text" placeholder="Expiry Month" value="" /><br /><br />
//       <input class="ExpiryYear allow_numeric" id="ExpiryYear" name="TransExpiryYear" type="text" placeholder="Expiry Year" value="" /><br /><br />
//       <input class="CustomerName allow_alphabet" id="CustomerName" name="TransCustomerName" type="text" placeholder="Customer Name" value="" /><br /><br />
//       <input class="CustomerEmailAddress" id="CustomerEmailAddress" name="TransCustomerEmailAddress" type="text" placeholder="Customer Email Address" value="" /><br /><br />
//       <input class="CustomerMobileNumber allow_numeric" id="CustomerMobileNumber" name="TransCustomerMobileNumber" type="text" placeholder="Customer Mobile Number" value="" /><br /><br />
//       <button onclick="myFunction()" type="button"  class="btn btn-custon-four btn-danger" id="InitiateTrans" name="TransInitiateTrans">Initiate</button><br />
//       <label class="errorlbl" id="errorlbl"></label>
//     </form> **/

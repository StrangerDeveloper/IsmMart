import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

import '../../helper/constants.dart';

class ContactUsViewModel extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController storeDescController = TextEditingController();

  @override
  void onClose() {
    firstNameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    storeDescController.dispose();
    super.onClose();
  }

  List getContactUsData() {
    return [
      {
        'icon': Icons.email_outlined,
        'title': langKey.email.tr,
        'description': 'support@ismmart.com\n'
      },
      {
        'icon': IconlyBold.calling,
        'title': langKey.call.tr,
        'description': '+92 51 111 007 123\n+92 333 1832356'
      },
      {
        'icon': IconlyLight.location,
        'title': langKey.centralHeadquarters.tr,
        'description': langKey.centralHeadquartersValue.tr
      },
      {
        'icon': IconlyLight.location,
        'title': langKey.globalHeadquarters.tr,
        'description': langKey.globalHeadquartersValue.tr
      }
    ];
  }

  void contactUsBtn() {
    GlobalVariable.internetErr(false);
    if (formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "subject": subjectController.text,
        "message": storeDescController.text,
        "website": "support@ismmart.com"
      };

      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .postMethod(url: Urls.contactUs, body: param, withBearer: false)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        print(parsedJson);

        if (parsedJson['success'] == true) {
          GlobalVariable.internetErr(false);

          AppConstant.displaySnackBar(
           langKey.successTitle.tr,
          parsedJson['message'],
          );
        } else {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            parsedJson['message'],
          );
        }
      }).catchError((e) {
      //  GlobalVariable.internetErr(true);
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }
}

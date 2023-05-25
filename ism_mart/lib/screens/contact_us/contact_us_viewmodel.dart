import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/utils/languages/translations_key.dart';
import 'package:ism_mart/widgets/getx_helper.dart';

class ContactUsViewModel extends GetxController {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
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
        'title': email.tr,
        'description': 'businesses@ismmart.com\n'
      },
      {
        'icon': IconlyBold.calling,
        'title': call.tr,
        'description': '+92 51 111 007 123\n+92 3329999969'
      },
      {
        'icon': IconlyLight.location,
        'title': centralHeadquarters.tr,
        'description': centralHeadquartersValue.tr
      },
      {
        'icon': IconlyLight.location,
        'title': globalHeadquarters.tr,
        'description': globalHeadquartersValue.tr
      }
    ];
  }

  void contactUsBtn() {
    if (formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {
        "name": firstNameController.text,
        "email": emailController.text,
        "subject": subjectController.text,
        "message": storeDescController.text
      };

      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .postMethod(url: Urls.contactUs, body: param, withBearer: false)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        print(parsedJson);

        if (parsedJson['success'] == true) {
          GetxHelper.showSnackBar(
              title: successTitle.tr, message: parsedJson['message']);
        } else {
          GetxHelper.showSnackBar(
              title: errorTitle.tr, message: parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }
}

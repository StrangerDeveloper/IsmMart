import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
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
        'title': langKey.email.tr,
        'description': 'businesses@ismmart.com\n'
      },
      {
        'icon': IconlyBold.calling,
        'title': langKey.call.tr,
        'description': '+92 51 111 007 123\n+92 3329999969'
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
          GlobalVariable.internetErr(false);
          GetxHelper.showSnackBar(
            title: langKey.successTitle.tr,
            message: parsedJson['message'],
          );
        } else {
          GetxHelper.showSnackBar(
            title: langKey.errorTitle.tr,
            message: parsedJson['message'],
          );
        }
      }).catchError((e) {
        GlobalVariable.internetErr(true);
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }
}

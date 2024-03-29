import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/screens/vendor_question/vendor_question_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class VendorQuestionViewModel extends GetxController {
  List<VendorQuestionModel> productQuestionsList = <VendorQuestionModel>[].obs;
  final answerFormKey = GlobalKey<FormState>();
  final updateAnswerFormKey = GlobalKey<FormState>();
  TextEditingController answerController = TextEditingController();
  TextEditingController updateAnswerController = TextEditingController();

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  getData() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(url: Urls.getVendorQuestions, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'] as List;
        productQuestionsList.clear();
        productQuestionsList.addAll(data.map((e) => VendorQuestionModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  addAnswer(int index) {
    if (answerFormKey.currentState?.validate() ?? false) {
      Get.back();
      GlobalVariable.showLoader.value = true;

      Map<String, dynamic> param = {
        "questionId": productQuestionsList[index].id,
        "answer": answerController.text,
      };

      ApiBaseHelper()
          .postMethod(
              url: Urls.addAnswer, body: param, withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Answer added successfully") {

          answerController.text = "";
          AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
          getData();
        } else {
          AppConstant.displaySnackBar(langKey.errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }

  updateAnswer(int index) {
    if (updateAnswerFormKey.currentState?.validate() ?? false) {
      Get.back();
      GlobalVariable.showLoader.value = true;
      String questionId = productQuestionsList[index].answer!.id.toString();

      Map<String, dynamic> param = {"answer": updateAnswerController.text};

      ApiBaseHelper()
          .patchMethod(
          url: Urls.updateAnswer + questionId,
          body: param,
          withBearer: false, withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Answer updated successfully") {

          updateAnswerController.text = "";
          AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
          getData();
        } else {
          AppConstant.displaySnackBar(langKey.errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }

  deleteAnswer(int index) {
    GlobalVariable.showLoader.value = true;
    String questionId = productQuestionsList[index].answer!.id.toString();

    ApiBaseHelper()
        .deleteMethod(url: Urls.deleteAnswer + questionId, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['message'] == "Answer deleted successfully") {
        AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
        getData();
      } else {
        AppConstant.displaySnackBar(langKey.errorTitle.tr, parsedJson['message']);
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      print(e);
    });
  }

}

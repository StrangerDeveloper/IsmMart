import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class AnswerQuestionViewModel extends GetxController {
  List<QuestionModel> productQuestionsList = <QuestionModel>[].obs;
  final answerFormKey = GlobalKey<FormState>();
  final updateAnswerFormKey = GlobalKey<FormState>();
  TextEditingController answerController = TextEditingController();
  TextEditingController updateAnswerController = TextEditingController();

  // @override
  // void onInit() {
  //   productId = Get.arguments['productId'];
  //   productModel = Get.arguments['productModel'];
  //   super.onInit();
  // }

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
        productQuestionsList.addAll(data.map((e) => QuestionModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  addAnswer(int index) {
    if (answerFormKey.currentState?.validate() ?? false) {
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
          Get.back();
          answerController.text = "";
          AppConstant.displaySnackBar(success.tr, parsedJson['message']);
          getData();
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }

  updateQuestion(int index) {
    if (updateAnswerFormKey.currentState?.validate() ?? false) {
      GlobalVariable.showLoader.value = true;
      String questionId = productQuestionsList[index].id.toString();

      Map<String, dynamic> param = {"answer": updateAnswerController.text};

      ApiBaseHelper()
          .patchMethod(
          url: Urls.updateAnswer + questionId,
          body: param,
          withBearer: false, withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Answer updated successfully") {
          Get.back();
          updateAnswerController.text = "";
          AppConstant.displaySnackBar(success.tr, parsedJson['message']);
          getData();
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }

  deleteAnswer(int index) {
    GlobalVariable.showLoader.value = true;
    String questionId = productQuestionsList[index].id.toString();

    ApiBaseHelper()
        .deleteMethod(url: Urls.deleteAnswer + questionId, withBearer: false)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['message'] == "Answer deleted successfully") {
        AppConstant.displaySnackBar(success.tr, parsedJson['message']);
        getData();
      } else {
        AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      print(e);
    });
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/product_controller.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/helper/urls.dart';

import 'product_questions_view.dart';

class ProductQuestionsViewModel extends GetxController {
  RxString productId = ''.obs;
  List<QuestionModel> productQuestionsList = <QuestionModel>[].obs;
  final productModel = ProductModel().obs;
  final addQuestionFormKey = GlobalKey<FormState>();
  final updateQuestionFormKey = GlobalKey<FormState>();
  TextEditingController addQuestionController = TextEditingController();
  TextEditingController updateQuestionController = TextEditingController();

  @override
  void onInit() {
    productId.value = Get.arguments[0]['productId'];
    productModel.value = Get.arguments[0]['productModel'];
    super.onInit();
  }

  @override
  void onReady() {
    getQuestionAnswers(productId.value);
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  getQuestionAnswers(String? id) {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(
            url: Urls.getQuestionByProductId + id.toString(), withBearer: false)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['message'] == 'Product questions fetched successfully' ||
          parsedJson['message'] == 'No questions found') {
        productQuestionsList.clear();
        var data = parsedJson['data'] as List;
        productQuestionsList.addAll(data.map((e) => QuestionModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  loginCheck() {
    if (GlobalVariable.userModel == null) {
      return Get.toNamed(Routes.loginRoute);
    } else {
      return ProductQuestionsView().askQuestionBottomSheet();
    }
  }

  addQuestion() {
    if (addQuestionFormKey.currentState?.validate() ?? false) {
      GlobalVariable.showLoader.value = true;

      Map<String, dynamic> param = {
        "productId": productId.value,
        "question": addQuestionController.text,
      };

      ApiBaseHelper()
          .postMethod(
              url: Urls.addQuestion, body: param, withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Product question created successfully") {
          addQuestionController.text = "";
          Get.back();
          AppConstant.displaySnackBar(
              langKey.success.tr, parsedJson['message']);
          /////////////
          getQuestionAnswers(productId.value);
          ProductController controller = Get.find();
          controller.getProductQuestions(productId: productId);
          ////////////
        } else {
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }

  updateQuestion(int index) {
    if (updateQuestionFormKey.currentState?.validate() ?? false) {
      Get.back();
      GlobalVariable.showLoader.value = true;
      String questionId = productQuestionsList[index].id.toString();

      Map<String, dynamic> param = {"question": updateQuestionController.text};

      ApiBaseHelper()
          .patchMethod(
              url: Urls.updateQuestion + questionId,
              body: param,
              withBearer: false,
              withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Product question updated successfully") {
          updateQuestionController.text = "";
          AppConstant.displaySnackBar(
              langKey.success.tr, parsedJson['message']);
          /////////////
          getQuestionAnswers(productId.value);
          ProductController controller = Get.find();
          controller.getProductQuestions(productId: productId);
          ////////////
        } else {
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }

  deleteQuestion(int index) {
    GlobalVariable.showLoader.value = true;
    String questionId = productQuestionsList[index].id.toString();

    ApiBaseHelper()
        .deleteMethod(
            url: Urls.deleteQuestion + questionId, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['message'] == "Question deleted successfully") {
        AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
        getQuestionAnswers(productId.value);
        ProductController controller = Get.find();
        controller.getProductQuestions(productId: productId);
        // Get.to(ProductQuestionsView());
      } else {
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, parsedJson['message']);
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      print(e);
    });
  }
}

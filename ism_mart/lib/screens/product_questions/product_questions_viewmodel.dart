import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/controllers/product_controller.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/screens/product_questions/product_questions_view.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class ProductQuestionsViewModel extends GetxController {
  String productId = "";
  List<QuestionModel> productQuestionsList = <QuestionModel>[].obs;
  ProductModel? productModel;
  final addQuestionFormKey = GlobalKey<FormState>();
  final updateQuestionFormKey = GlobalKey<FormState>();
  TextEditingController addQuestionController = TextEditingController();
  TextEditingController updateQuestionController = TextEditingController();

  @override
  void onInit() {
    productId = Get.arguments['productId'];
    productModel = Get.arguments['productModel'];
    super.onInit();
  }

  @override
  void onReady() {
    getQuestionAnswers();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  getQuestionAnswers() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(
            url: Urls.getQuestionByProductId + productId, withBearer: false)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['message'] == 'Product questions fetched successfully' || parsedJson['message'] == 'No questions found') {
        productQuestionsList.clear();
        var data = parsedJson['data'] as List;
        productQuestionsList.addAll(data.map((e) => QuestionModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  addQuestion() {
    if (addQuestionFormKey.currentState?.validate() ?? false) {
      Get.back();
      GlobalVariable.showLoader.value = true;

      Map<String, dynamic> param = {
        "productId": productId,
        "question": addQuestionController.text,
      };

      ApiBaseHelper()
          .postMethod(
              url: Urls.addQuestion, body: param, withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Product question created successfully") {
          addQuestionController.text = "";
          AppConstant.displaySnackBar(success.tr, parsedJson['message']);
          /////////////
          getQuestionAnswers();
          ProductController controller = Get.find();
          controller.getProductQuestions(productId: productId);
          ////////////
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
          AppConstant.displaySnackBar(success.tr, parsedJson['message']);
          /////////////
          getQuestionAnswers();
          ProductController controller = Get.find();
          controller.getProductQuestions(productId: productId);
          ////////////
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
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
        AppConstant.displaySnackBar(success.tr, parsedJson['message']);
        getQuestionAnswers();
        ProductController controller = Get.find();
        controller.getProductQuestions(productId: productId);
        // Get.to(ProductQuestionsView());
      } else {
        AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      print(e);
    });
  }
}

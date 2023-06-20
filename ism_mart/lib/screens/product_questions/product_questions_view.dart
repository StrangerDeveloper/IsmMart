import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/product_questions/product_questions_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/loader_view.dart';

class ProductQuestionsView extends StatelessWidget {
  ProductQuestionsView({Key? key}) : super(key: key);

  final ProductQuestionsViewModel viewModel = Get.put(ProductQuestionsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: productQuestions.tr,),
      // appBar(),
      body: Stack(
        children: [
          Column(
            children: [
              askQuestionBtn(),
              Expanded(
                child: listView(),
              ),
            ],
          ),
          LoaderView(),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(
        title: productQuestions.tr,
        style: appBarTitleSize,
      ),
    );
  }

  Widget askQuestionBtn() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: CustomTextBtn(
        onPressed: () {
          viewModel.loginCheck();
        },
        child: Text(
          askQuestion.tr,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget listView() {
    return Obx(
      () => viewModel.productQuestionsList.isEmpty
          ? Center(
              child: NoDataFoundWithIcon(
                icon: IconlyLight.search,
                title: noQuestionFound.tr,
              ),
            )
          : ListView.builder(
              // padding: EdgeInsets.zero,
              itemCount: viewModel.productQuestionsList.length,
              itemBuilder: (context, index) {
                return listViewItem(index);
              },
            ),
    );
  }

  Widget listViewItem(int index) {
    return Column(
      children: [
        questionItem(index),
        viewModel.productQuestionsList[index].answer != null
            ? answerItem(index)
            : SizedBox(height: 0),
      ],
    );
  }

  Widget questionItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: (GlobalVariable.userModel?.email ==
                viewModel.productQuestionsList[index].user?.email)
            ? () {
                questionAnswerActionsBottomSheet(index);
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: kRedColor.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomText(
                    title: 'Q',
                    color: kWhiteColor,
                  ),
                ),
              ),
              AppConstant.spaceWidget(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: viewModel.productQuestionsList[index].question,
                      maxLines: viewModel
                          .productQuestionsList[index].question!.length,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: viewModel.productQuestionsList[index].user
                                    ?.firstName ??
                                'N/A',
                            style: caption.copyWith(
                              color: kLightColor,
                            ),
                          ),
                          TextSpan(
                            text: (viewModel.productQuestionsList[index]
                                        .createdAt !=
                                    null)
                                ? " - ${AppConstant.formattedDataTime("dd-MMM-yy", viewModel.productQuestionsList[index].createdAt!)}"
                                : '',
                            style: caption.copyWith(
                              color: kLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              (GlobalVariable.userModel?.email ==
                      viewModel.productQuestionsList[index].user?.email)
                  ? Icon(
                      IconlyLight.more_square,
                      color: kLightColor,
                      size: 18,
                    )
                  : SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }

  Widget answerItem(int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: null,
      // (GlobalVariable.userModel?.email ==
      //         viewModel.productQuestionsList[index].user?.email)
      //     ? () {
      //         //questionAnswerActionsBottomSheet(index);
      //       }
      //     : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: kLightColor.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomText(
                  title: 'A',
                  color: kWhiteColor,
                ),
              ),
            ),
            AppConstant.spaceWidget(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: viewModel.productQuestionsList[index].answer!.answer,
                    maxLines: viewModel.productQuestionsList[index].answer!.answer!.length,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: viewModel.productModel.value.sellerModel?.user?.firstName ??
                              'N/A',
                          style: caption.copyWith(
                            color: kLightColor,
                          ),
                        ),
                        TextSpan(
                          text:
                              " - ${AppConstant.formattedDataTime("dd-MMM-yy", viewModel.productQuestionsList[index].answer!.createdAt!)}",
                          style: caption.copyWith(
                            color: kLightColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // (GlobalVariable.userModel?.email ==
            //         viewModel.productQuestionsList[index].user?.email)
            //     ? Icon(
            //         IconlyLight.more_square,
            //         color: kLightColor,
            //         size: 18,
            //       )
            //     : SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////
  askQuestionBottomSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      context: Get.context!,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Form(
                key: viewModel.addQuestionFormKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StickyLabel(
                            text: addQuestion.tr,
                            style: headline1,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: CustomTextField1(
                          controller: viewModel.addQuestionController,
                          title: question.tr,
                          asterisk: true,
                          minLines: 4,
                          maxLines: 6,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return Validator().validateDefaultTxtField(value);
                          },
                        ),
                      ),
                      CustomTextBtn(
                        child: Text(addQuestion.tr),
                        onPressed: () {
                          viewModel.addQuestion();
                        },
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close),
              )
            ],
          ),
        );
      },
    );
  }

  questionAnswerActionsBottomSheet(int index) {
    showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      questions.tr,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              Divider(),
              BottomSheetItemRow(
                title: updateQuestion.tr,
                icon: IconlyLight.edit,
                isDisabled: false,
                onTap: () {
                  Navigator.of(context).pop();
                  updateQuestionBottomSheet(index);
                },
              ),
              BottomSheetItemRow(
                title: deleteQuestion.tr,
                icon: IconlyLight.delete,
                isDisabled: false,
                onTap: () {
                  Navigator.of(context).pop();
                  showDeleteQuestionDialog(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future showDeleteQuestionDialog(int index) async {
    return showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(deleteQuestion.tr),
          content: Text(deleteQuestionDialogDesc.tr),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: Text(
                      noBtn.tr,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                      foregroundColor: Colors.grey,
                    ),
                    child: Text(
                      yesBtn.tr,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      viewModel.deleteQuestion(index);
                      Navigator.of(Get.context!).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  updateQuestionBottomSheet(int index) {
    viewModel.updateQuestionController.text =
        viewModel.productQuestionsList[index].question ?? '';
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      context: Get.context!,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Form(
                key: viewModel.updateQuestionFormKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StickyLabel(
                            text: updateQuestion.tr,
                            style: headline1,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: CustomTextField1(
                          controller: viewModel.updateQuestionController,
                          title: question.tr,
                          asterisk: true,
                          minLines: 4,
                          maxLines: 6,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return Validator().validateDefaultTxtField(value);
                          },
                        ),
                      ),
                      CustomTextBtn(
                        child: Text(updateBtn.tr),
                        onPressed: () {
                          viewModel.updateQuestion(index);
                        },
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close),
              )
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/vendor_question/vendor_question_viewmodel.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import '../single_product_details/single_product_details_view.dart';

class VendorQuestionView extends StatelessWidget {
  VendorQuestionView({Key? key}) : super(key: key);
  final VendorQuestionViewModel viewModel = Get.put(VendorQuestionViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          listView(),
          LoaderView(),
        ],
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
              itemCount: viewModel.productQuestionsList.length,
              itemBuilder: (context, index) {
                return listViewItem(index);
              },
            ),
    );
  }

  Widget listViewItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () {
          actionsBottomSheet(index);
        },
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            questionItem(index),
            viewModel.productQuestionsList[index].answer != null
                ? answerItem(index)
                : SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  Widget questionItem(int index) {
    return Padding(
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
                  maxLines:
                      viewModel.productQuestionsList[index].question!.length,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '${viewModel.productQuestionsList[index].user?.firstName ?? ''}  -  ',
                        style: caption.copyWith(
                          color: kLightColor,
                        ),
                      ),
                      TextSpan(
                        text:
                            (viewModel.productQuestionsList[index].createdAt !=
                                    null)
                                ? AppConstant.convertDateFormat1(viewModel
                                    .productQuestionsList[index].createdAt!)
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
          Icon(
            IconlyLight.more_square,
            color: kLightColor,
            size: 18,
          ),
        ],
      ),
    );
  }

  Widget answerItem(int index) {
    return Padding(
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
                  maxLines: viewModel
                      .productQuestionsList[index].answer!.answer!.length,
                ),
                Text(
                  (viewModel.productQuestionsList[index].answer?.createdAt !=
                          null)
                      ? AppConstant.convertDateFormat1(viewModel
                          .productQuestionsList[index].answer!.createdAt!)
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
    );
  }

  actionsBottomSheet(int index) {
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
                title: addAnswer.tr,
                icon: Icons.add,
                isDisabled: viewModel.productQuestionsList[index].answer != null
                    ? true
                    : false,
                onTap: viewModel.productQuestionsList[index].answer != null
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        addAnswerBottomSheet(index);
                      },
              ),
              BottomSheetItemRow(
                title: updateAnswer.tr,
                icon: IconlyLight.edit,
                isDisabled: viewModel.productQuestionsList[index].answer != null
                    ? false
                    : true,
                onTap: viewModel.productQuestionsList[index].answer != null
                    ? () {
                        Navigator.of(context).pop();
                        updateAnswerBottomSheet(index);
                      }
                    : null,
              ),
              BottomSheetItemRow(
                title: deleteAnswer.tr,
                icon: IconlyLight.delete,
                isDisabled: viewModel.productQuestionsList[index].answer != null
                    ? false
                    : true,
                onTap: viewModel.productQuestionsList[index].answer != null
                    ? () {
                        Navigator.of(context).pop();
                        viewModel.deleteAnswer(index);
                      }
                    : null,
              ),
              BottomSheetItemRow(
                title: viewProduct.tr,
                icon: Icons.feed_outlined,
                isDisabled: false,
                onTap: () {
                  Navigator.of(context).pop();
                  if (viewModel.productQuestionsList[index].product?.id !=
                      null) {
                    print('Product ID: ${viewModel.productQuestionsList[index].product?.id}');

                    Get.toNamed(Routes.singleProductDetails, arguments: [{
                      "calledFor": "seller",
                      "productID": "${viewModel.productQuestionsList[index].product?.id}"
                    }]);

                    // Get.to(() => SingleProductView(
                    //       productId:
                    //           "${viewModel.productQuestionsList[index].product?.id}",
                    //       calledFor: 'seller',
                    //     ));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  addAnswerBottomSheet(int index) {
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
                key: viewModel.answerFormKey,
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
                            text: addAnswer.tr,
                            style: headline1,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: CustomTextField1(
                          controller: viewModel.answerController,
                          title: answer.tr,
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
                        child: Text(addAnswer.tr),
                        onPressed: () {
                          viewModel.addAnswer(index);
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

  updateAnswerBottomSheet(int index) {
    viewModel.updateAnswerController.text =
        viewModel.productQuestionsList[index].answer?.answer ?? '';
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
                key: viewModel.updateAnswerFormKey,
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
                            text: addAnswer.tr,
                            style: headline1,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: CustomTextField1(
                          controller: viewModel.updateAnswerController,
                          title: answer.tr,
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
                        child: Text(addAnswer.tr),
                        onPressed: () {
                          viewModel.updateAnswer(index);
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

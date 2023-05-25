import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class ProductQuestionAnswerUI extends GetView<ProductController> {
  const ProductQuestionAnswerUI({Key? key, this.productModel})
      : super(key: key);
  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    print(">>> ${productModel!.id}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: _appBar(),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Obx(
                () => controller.productQuestionsList.isEmpty
                    ? NoDataFoundWithIcon(
                        icon: IconlyLight.search,
                        title: langKey.noQuestionFound.tr,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        //physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.productQuestionsList.length,
                        itemBuilder: (_, index) {
                          QuestionModel? model =
                              controller.productQuestionsList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _singleQuestionListItem(
                                    icon: "Q",
                                    //Icons.question_mark,
                                    iconColor: kRedColor,
                                    title: model.question,
                                    firstName: model.user!.firstName!,
                                    date: model.createdAt),
                                AppConstant.spaceWidget(height: 5),
                                if (model.answer != null)
                                  _singleQuestionListItem(
                                      icon: "A",
                                      //Icons.question_answer,
                                      title: model.answer!.answer,
                                      iconColor: kLightColor,
                                      firstName: productModel!
                                              .sellerModel!.storeName ??
                                          productModel!
                                              .sellerModel!.user!.firstName,
                                      date: model.answer!.createdAt),
                                Divider(
                                  color: kLightGreyColor,
                                  thickness: 1.0,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _askQuestionBottomBar(),
            ),
          ],
        ),
        //bottomNavigationBar: _askQuestionBottomBar(),
      ),
    );
  }

  Widget _singleQuestionListItem(
      {icon, iconColor, String? title, firstName, date}) {
    return CustomGreyBorderContainer(
      borderColor: kWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Icon(icon, color: iconColor,),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: iconColor!.withOpacity(0.75),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomText(
                  title: icon,
                  color: kWhiteColor,
                ),
              ),

              /*Icon(
                icon,
                size: 15,
                color: kWhiteColor,
              ),*/
            ),
            AppConstant.spaceWidget(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  maxLines: title!.length,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: firstName,
                          style: caption.copyWith(color: kLightColor)),
                      TextSpan(
                        text:
                            " - ${AppConstant.formattedDataTime("dd-MMM-yy hh:mm a", date)}",
                        style: caption.copyWith(
                          color: kLightColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
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
        title: langKey.productQuestions.tr,
        style: appBarTitleSize,
      ),
    );
  }

  _askQuestionBottomBar() {
    var formKey = GlobalKey<FormState>();
    return CustomCard(
      //elevation: 18,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: controller.questionController,
                    //focusNode: controller.focusNode,
                    cursorColor: kPrimaryColor,
                    autofocus: false,
                    maxLines: 1,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kLightGreyColor,
                          width: 0.5,
                        ), //BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kLightGreyColor,
                          width: 0.5,
                        ), //BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      fillColor: kWhiteColor,
                      //contentPadding: EdgeInsets.zero,
                      hintText: langKey.questionBody.tr,
                      hintStyle: TextStyle(
                        color: kLightColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    controller.postQuestion(productId: productModel!.id);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      border: Border.all(color: Colors.blue.withOpacity(0.35)),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      IconlyBold.send,
                      color: Colors.blue.withOpacity(0.75),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

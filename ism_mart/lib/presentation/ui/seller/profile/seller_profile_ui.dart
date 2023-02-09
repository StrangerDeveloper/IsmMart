import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import '../../../../utils/exports_utils.dart';
import '../../../export_presentation.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class StoreProfileUI extends GetView<AuthController> {
  const StoreProfileUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: controller.isLoading.isTrue
            ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ///Store data
                          CustomGreyBorderContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  //StickyLabel(text: langKey.storeInfo.tr),
                                  SizedBox(
                                    width: AppConstant.getSize().width * 0.9,
                                    height: AppConstant.getSize().height * 0.15,
                                    child: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.black,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: kPrimaryColor
                                                      .withOpacity(0.05),
                                                  offset: Offset(0, 0),
                                                  blurRadius: 1,
                                                )
                                              ]),
                                          child: CustomNetworkImage(
                                            width: AppConstant.getSize().width *
                                                0.89,
                                            imageUrl: controller
                                                .userModel!.vendor?.coverImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 1,
                                          left: 1,
                                          child: Container(
                                            height: 70,
                                            width: 70,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: kPrimaryColor
                                                      .withOpacity(0.22),
                                                  offset: Offset(0, 0),
                                                  blurRadius: 10.78,
                                                ),
                                              ],
                                            ),
                                            child: Obx(
                                              () => CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                backgroundImage: NetworkImage(
                                                    controller.userModel!.vendor
                                                            ?.storeImage ??
                                                        AppConstant
                                                            .defaultImgUrl),
                                              ),
                                            ),
                                          ),
                                        ),
                                        /*Positioned(
                                         top: 1,
                                         right: 1,
                                         child: InkWell(
                                           onTap: () {
                                           },
                                           child: Container(
                                             child: Padding(
                                               padding:
                                               const EdgeInsets.all(2.0),
                                               child: Icon(Icons.photo,
                                                   color: kLightBlueColor),
                                             ),
                                           ),
                                         ),
                                       ),*/
                                        /* Stack(
                                         children: [
                                           Container(
                                             height: 90,
                                             width: 90,
                                             alignment: Alignment.center,
                                             decoration: BoxDecoration(
                                               borderRadius:
                                               BorderRadius.circular(50),
                                               color: Colors.white,
                                               boxShadow: [
                                                 BoxShadow(
                                                   color: kPrimaryColor
                                                       .withOpacity(0.22),
                                                   offset: Offset(0, 0),
                                                   blurRadius: 10.78,
                                                 ),
                                               ],
                                             ),
                                             child: Obx(
                                                   () => CircleAvatar(
                                                 radius: 40,
                                                 backgroundColor: Colors.grey[200],
                                                 backgroundImage: NetworkImage(
                                                     controller.userModel!.vendor?.storeImage ??
                                                         AppConstant.defaultImgUrl),
                                               ),
                                             ),
                                           ),
                                           Positioned(
                                             bottom: 1,
                                             right: 1,
                                             child: InkWell(
                                               onTap: () {
                                               },
                                               child: Container(
                                                 child: Padding(
                                                   padding:
                                                   const EdgeInsets.all(2.0),
                                                   child: Icon(Icons.add_a_photo,
                                                       color: kPrimaryColor),
                                                 ),
                                                 decoration: BoxDecoration(
                                                     border: Border.all(
                                                       width: 3,
                                                       color: Colors.white,
                                                     ),
                                                     borderRadius: BorderRadius.all(
                                                       Radius.circular(50),
                                                     ),
                                                     color: Colors.white,
                                                     boxShadow: [
                                                       BoxShadow(
                                                         offset: Offset(0, 0),
                                                         color: kPrimaryColor
                                                             .withOpacity(0.3),
                                                         blurRadius: 10.78,
                                                       ),
                                                     ]),
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),*/
                                        /*Positioned(
                                           bottom: 10,
                                           left: 10,
                                           child: child),*/
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: controller
                                        .getStoreInfo()
                                        .map(
                                          (profile) => profileCards(
                                              profile["title"],
                                              profile["subtitle"],
                                              profile["icon"]),
                                        )
                                        .toList(),
                                  ),

                                  //Store Information

                                  AppConstant.spaceWidget(height: 10),
                                ],
                              ),
                            ),
                          ),
                          AppConstant.spaceWidget(height: 10),

                          ///Bank Details
                          CustomGreyBorderContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  StickyLabel(text: langKey.bankDetails.tr),
                                  AppConstant.spaceWidget(height: 10),
                                  Obx(
                                    () => Column(
                                      children: controller
                                          .getBankDetails()
                                          .map(
                                            (profile) => profileCards(
                                                profile["title"],
                                                profile["subtitle"],
                                                profile["icon"]),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  //Store Information
                                  AppConstant.spaceWidget(height: 10),
                                ],
                              ),
                            ),
                          ),
                          /*AppConstant.spaceWidget(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                    ()=> controller.isLoading.isTrue?
                                CustomLoading(isItBtn: true,)
                                    :InkWell(
                                  onTap: ()=>{},
                                  child: Container(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      //color: kRedColor,
                                      borderRadius: BorderRadius.circular(8),
                                      //border: Border.all(color: kRedColor),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kRedColor,
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                        )
                                      ],
                                    ),
                                    child: CustomText(title: langKey.deactivateBtn.tr, color: kWhiteColor,),
                                  ),
                                ),
                              ),
                            ],
                          ),*/
                          AppConstant.spaceWidget(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget profileCards(String title, subtitle, icon) {
    return Container(
      // width: 350,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kPrimaryColor.withOpacity(0.7)),
      ),
      margin: EdgeInsets.only(left: 8, top: 12, right: 8, bottom: 3),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
        title: CustomText(
          title: title,
          color: Colors.black54,
          weight: FontWeight.w600,
        ),
        subtitle: CustomText(
          title: subtitle,
          style: bodyText1,
        ),
        leading: Icon(icon),
        /*trailing: InkWell(
          onTap: () => showEditDialog(title, subtitle),
          child: Icon(
            Icons.edit,
            size: 20,
            color: kPrimaryColor.withOpacity(0.8),
          ),
        ),*/
      ),
    );
  }

  void showEditDialog(title, subtitle) {
    controller.editingTextController.text = subtitle;
    var _formKey = GlobalKey<FormState>();
    Get.defaultDialog(
      title: "${langKey.updateBtn} $title",
      titleStyle: appBarTitleSize,
      contentPadding: const EdgeInsets.all(20),
      content: Form(
        key: _formKey,
        child: FormInputFieldWithIcon(
          controller: controller.editingTextController,
          iconPrefix: Icons.title,
          labelText: title,
          autofocus: false,
          iconColor: kPrimaryColor,
          textStyle: bodyText1,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (title.toString().toLowerCase() == "phone")
              return !GetUtils.isPhoneNumber(value!)
                  ? langKey.phoneReq.tr
                  : null;
            return GetUtils.isBlank(value!)!
                ? langKey.titleReq.trParams({"title": "$title"})
                : null;
          },
          keyboardType: title.toString().toLowerCase() == "phone"
              ? TextInputType.phone
              : TextInputType.text,
          onChanged: (value) => null,
          onSaved: (value) => null,
        ),
      ),
      confirm: Obx(
        () => controller.isLoading.isTrue
            ? CustomLoading(isItBtn: true)
            : CustomButton(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await controller.updateUser(
                        title: title,
                        value: controller.editingTextController.text);
                  }
                },
                text: langKey.updateBtn.tr,
                height: 40,
                width: 200,
              ),
      ),
    );
  }
}

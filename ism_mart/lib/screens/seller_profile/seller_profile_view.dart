import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import '../../utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class StoreProfileView extends GetView<AuthController> {
  const StoreProfileView({Key? key}) : super(key: key);

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
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomButton(
                                onTap: () => AppConstant.showBottomSheet(
                                    widget: RegisterVendorUI(
                                      model: controller.userModel?.vendor,
                                      //isCalledForUpdate: true,
                                    ),
                                    isGetXBottomSheet: false,
                                    buildContext: context),
                                text: langKey.updateBtn.tr,
                                width: 110,
                                height: 35,
                              ),
                            ),
                          ),

                          ///Store data
                          CustomGreyBorderContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: AppConstant.getSize().width * 0.9,
                                    height: AppConstant.getSize().height * 0.15,
                                    child: Stack(
                                      alignment: Alignment.bottomLeft,
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
                                            ],
                                          ),
                                          child: CustomNetworkImage(
                                            width: AppConstant.getSize().width *
                                                0.90,
                                            imageUrl: controller.userModel!
                                                    .vendor?.coverImage ??
                                                AppConstant.defaultImgUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        profileImage(),
                                        /* Positioned(
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
                                        /*Stack(
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

  Widget profileImage() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(left: 6, bottom: 6),
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CachedNetworkImage(
          height: 60,
          width: 60,
          imageUrl: controller.userModel!.vendor?.storeImage ?? '',
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          errorWidget: (context, url, error) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/no_image_found.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          placeholder: (context, url) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 0.5),
            );
          },
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
        /* trailing: InkWell(
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
}

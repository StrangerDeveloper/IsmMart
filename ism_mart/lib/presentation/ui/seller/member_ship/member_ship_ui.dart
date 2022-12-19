import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class PremiumMembershipUI extends GetView<MembershipController> {
  const PremiumMembershipUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Column(
                children: [
                  CustomText(
                      title: 'membership_plans'.tr, style: textTheme.headline4),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(title: 'membership_desc'.tr, size: 12),
                  ),
                ],
              ),
              Column(
                children: controller.getPlansData().map((e) {
                  MembershipModel model = MembershipModel.fromJson(e);
                  return _singleMemberShipListItem(model);
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _singleMemberShipListItem(MembershipModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all( color: model.title!.toLowerCase().contains("start")? kPrimaryColor: Colors.grey,),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.2),
              offset: Offset(0, 1),
              blurRadius: 8,
            )
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppConstant.spaceWidget(height: 10),
                CustomText(
                  title: model.title,
                  style: textTheme.caption,
                  textAlign: TextAlign.start,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(text: "${model.price}", style: textTheme.headline3),
                  if (!model.title!.toLowerCase().contains('start'))
                    TextSpan(text: "/mo", style: textTheme.bodyMedium)
                ])),
                kSmallDivider,
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: model.description!.map((e) {
                    return ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: kLightGreyColor,
                      ),
                      title: CustomText(
                        title: e,
                        maxLines: e.length,
                      ),
                    );
                  }).toList(),
                ),
                kSmallDivider,
                CustomButton(
                  onTap: () {},
                  text: model.title!.toLowerCase().contains("start")
                      ? "Subscribed"
                      : "Subscribe",
                  color: model.title!.toLowerCase().contains("start")? kPrimaryColor: Colors.grey,
                  width: 200,
                  height: 40,
                ),
                AppConstant.spaceWidget(height: 20)
              ],
            ),
            if (model.isPopular!)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: CustomText(
                    title: "POPULAR",
                    color: kWhiteColor,
                    size: 12,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/utils/svg_helper.dart';
import 'package:ism_mart/presentation/widgets/form_input_field_with_icon.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/presentation/widgets/custom_button.dart';

class ResendEmailVerificationLink extends GetView<AuthController> {
  ResendEmailVerificationLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildSvgLogo(),
                    InkWell(
                      onTap: () {
                        Get.back();
                        controller.clearLoginController();
                      },
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      langKey.emailVerificationLink.tr,
                      style: headline2,
                    ),
                  ),
                  AppConstant.spaceWidget(height: 90),
                  Center(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppConstant.spaceWidget(height: 20),
                            FormInputFieldWithIcon(
                              controller: controller.emailController,
                              iconPrefix: Icons.email,
                              labelText: langKey.email.tr,
                              iconColor: kPrimaryColor,
                              autofocus: false,
                              textStyle: bodyText1,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return langKey.emailReq.tr;
                                } else
                                  return !GetUtils.isEmail(value)
                                      ? langKey.emailReq.tr
                                      : null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {},
                              onSaved: (value) {},
                            ),
                            AppConstant.spaceWidget(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  onTap: () {
                                    Get.back();
                                  },
                                  text: langKey.cancel.tr,
                                  width: 100,
                                  height: 35,
                                  color: kPrimaryColor,
                                ),
                                CustomButton(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      await controller.resendEmailVerificationLink();
                                      await LocalStorageHelper.storeEmailVerificationLinkSentTime();
                                    }
                                  },
                                  text: langKey.send.tr,
                                  width: 100,
                                  height: 35,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

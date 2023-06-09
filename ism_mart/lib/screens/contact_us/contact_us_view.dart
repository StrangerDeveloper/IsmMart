import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/contact_us/contact_us_viewmodel.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart';
import 'package:ism_mart/utils/validator.dart';
import 'package:ism_mart/widgets/custom_button.dart';
import 'package:ism_mart/widgets/custom_text.dart';
import 'package:ism_mart/widgets/form_input_field_with_icon.dart';
import 'package:ism_mart/widgets/loader_view.dart';

class ContactUsView extends StatelessWidget {

  ContactUsView({Key? key}) : super(key: key);
  final ContactUsViewModel viewModel = Get.put(ContactUsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
            child: Column(
              children: [
                contactDetail(),
                SizedBox(height: 15),
                contactUsForm(),
              ],
            ),
          ),
          LoaderView(),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: CustomText(title: 'Contact Us', style: appBarTitleSize),
    );
  }

  Widget contactDetail() {
    return Column(
      children: viewModel
          .getContactUsData()
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.06),
                      ),
                    ),
                    child: Icon(
                      e["icon"],
                      size: 22,
                      color: kPrimaryColor,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: e['title'].toString().capitalize,
                          style: headline3.copyWith(
                            fontSize: 14.5,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomText(
                          title: e['description'].toString(),
                          style: bodyText2Poppins.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget contactUsForm() {
    return Container(
      margin: EdgeInsets.only(bottom: 15, top: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.black.withOpacity(0.08),
        ),
      ),
      child: Form(
        key: viewModel.formKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                title: forAnyQueryJust.tr,
                style: headline2,
              ),
            ),
            SizedBox(height: 15),
            FormInputFieldWithIcon(
              controller: viewModel.firstNameController,
              iconPrefix: Icons.person_rounded,
              labelText: fullName.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validator().validateName(value),
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 10),
            FormInputFieldWithIcon(
              controller: viewModel.emailController,
              iconPrefix: Icons.email_rounded,
              labelText: email.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return Validator().validateEmail(value);
              },
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 10),
            FormInputFieldWithIcon(
              controller: viewModel.subjectController,
              iconPrefix: Icons.subject_rounded,
              labelText: subject.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? subjectReq.tr : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 10),
            FormInputFieldWithIcon(
              controller: viewModel.storeDescController,
              iconPrefix: Icons.description,
              labelText: message.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? messageReq.tr : null,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 20),
            CustomTextBtn(
              onPressed: () {
                viewModel.contactUsBtn();
              },
              title: send.tr,
              height: 40,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}

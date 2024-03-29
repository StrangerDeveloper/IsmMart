import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/contact_us/contact_us_viewmodel.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/validator.dart';
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:ism_mart/widgets/no_internet_view.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class ContactUsView extends StatelessWidget {
  ContactUsView({Key? key}) : super(key: key);
  final ContactUsViewModel viewModel = Get.put(ContactUsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: langKey.contactUs.tr,
      ),
      // appBar(),
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
          NoInternetView(
            onPressed: () => viewModel.contactUsBtn(),
          ),
          LoaderView(),
        ],
      ),
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
                          title: e['title'].toString().capitalize ?? '',
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
                title: langKey.forAnyQueryJust.tr,
                style: headline2,
              ),
            ),
            SizedBox(height: 15),
            FormInputFieldWithIcon(
              controller: viewModel.firstNameController,
              iconPrefix: Icons.person_rounded,
              labelText: langKey.fName.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validator().validateName(value, errorToPrompt: langKey.FirstNameReq.tr),
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 10),
            FormInputFieldWithIcon(
              controller: viewModel.lastNameController,
              iconPrefix: Icons.person_rounded,
              labelText: langKey.lName.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validator().validateName(value, errorToPrompt: langKey.LastNameReq.tr),
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 10),
            FormInputFieldWithIcon(
              controller: viewModel.phoneController,
              iconPrefix: Icons.phone_android_sharp,
              labelText: langKey.phone.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => Validator().validatePhoneNumber(value),
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 10),
            FormInputFieldWithIcon(
              controller: viewModel.emailController,
              iconPrefix: Icons.email_rounded,
              labelText: langKey.email.tr,
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
              labelText: langKey.subject.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? langKey.subjectReq.tr : null,
              keyboardType: TextInputType.name,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 10),
            FormInputFieldWithIcon(
              controller: viewModel.storeDescController,
              iconPrefix: Icons.description,
              labelText: langKey.message.tr,
              iconColor: kPrimaryColor,
              autofocus: false,
              textStyle: bodyText1,
              maxLines: 5,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  GetUtils.isBlank(value!)! ? langKey.messageReq.tr : null,
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              onSaved: (value) {},
            ),
            AppConstant.spaceWidget(height: 20),
            CustomTextBtn(
              onPressed: () {
                viewModel.contactUsBtn();
              },
              title: langKey.send.tr,
              height: 40,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}

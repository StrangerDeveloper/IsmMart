import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/screens/static_info/static_info_viewmodel.dart';

import '../../exports/exports_utils.dart';
import '../../exports/export_widgets.dart';

class StaticInfoView extends StatelessWidget {
  StaticInfoView({super.key});

  final StaticInfoViewModel viewModel = Get.put(StaticInfoViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                child: Text(
                  viewModel.title,
                  style: headline1.copyWith(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 22, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: viewModel.getData().map((e) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppConstant.spaceWidget(height: 15),
                        if (e['header'] != '')
                          CustomText(
                            title: "${e['header']}",
                            style: headline2,
                          ),
                        if (e['header'] != '') Divider(),
                        if (e['body'].toString().isNotEmpty)
                          Text(
                            "${e['body'].toString()}",
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              color: kDarkColor,
                              height: 1.7,
                            ),
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
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
      title: CustomText(
        title: viewModel.title,
        style: headline2,
      ),
    );
  }
}

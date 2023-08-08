import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import '../helper/constants.dart';

class ImageLayoutContainer extends StatelessWidget {
   ImageLayoutContainer({
    required this.onTap,
    required this.title,
    this.subTitle,
     required this.filePath,
     this. required = true,
     this.errorPrompt = '',
     this.errorVisibility = false,
  });

  final void Function() onTap;
  final String title;
  final String? subTitle;
  final String filePath;
  final bool required;
  final String errorPrompt;
  final bool errorVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: title,
                  style: newFontStyle2.copyWith(
                    color: newColorDarkBlack,
                  ),
                  children: [
                    if(required)
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      )
                  ],
                ),
              ),
              if (subTitle != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    subTitle!,
                    style: newFontStyle0.copyWith(
                      color: newColorBlue4,
                    ),
                  ),
                ),
              Spacer(),
              Text(
                langKey.lessThanMb.tr,
                style: newFontStyle0.copyWith(
                  color: newColorBlue4,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              InkWell(
                onTap: onTap,
                child: Text(
                  langKey.chooseFile.tr,
                  style: newFontStyle0.copyWith(
                    color: red2,
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(width: 4),
              Text(
                filePath == '' ? langKey.noFileChosen.tr : filePath,
                style: newFontStyle0.copyWith(
                  color: newColorBlue4,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Divider(
            color: Color(0xffEEEEEE),
            thickness: 1,
            height: 20,
          ),
          Visibility(
            visible: errorVisibility,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorPrompt,
                style: GoogleFonts.dmSans(
                    color: Colors.red.shade700,
                    fontSize: 12
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

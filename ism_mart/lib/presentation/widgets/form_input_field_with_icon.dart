import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  const FormInputFieldWithIcon(
      {Key? key,
      required this.controller,
      required this.iconPrefix,
      required this.labelText,
      this.suffix,
      this.iconColor,
      this.textStyle,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.minLines = 1,
      this.maxLines = 1,
      this.isExpanded = false,
      this.maxLength,
      this.autofocus,
      this.enableBorder,
      this.textCapitalization = TextCapitalization.none,
      this.maxLengthEnforcement,
      required this.onChanged,
      required this.onSaved, this.autoValidateMode})
      : super(key: key);
  final AutovalidateMode? autoValidateMode;
  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final bool? autofocus;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int minLines;
  final int? maxLines;
  final bool? isExpanded;
  final Color? iconColor;
  final TextStyle? textStyle;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final InputBorder? enableBorder;
  final TextCapitalization? textCapitalization;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus!,
      textCapitalization: textCapitalization!,
      textAlignVertical: TextAlignVertical.top,
      autovalidateMode: autoValidateMode,
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      decoration: InputDecoration(
        filled: false,
        suffix: suffix,
        prefixIcon: Icon(
          iconPrefix,
          color: Colors.black87 ?? kPrimaryColor,
        ),
        labelText: labelText,
        labelStyle: textStyle,
        enabledBorder: enableBorder ?? OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black87??Colors.black45,
            width: 1.0,
          ),
          //borderRadius: BorderRadius.circular(20)
        ),
            /*UnderlineInputBorder(
              borderSide: BorderSide(
                color: iconColor ?? kPrimaryColor,
                width: 2.0,
              ),
              //borderRadius: BorderRadius.circular(20)
            ),*/
        focusedBorder: enableBorder ??
            UnderlineInputBorder(
              borderSide:
                  BorderSide(color: iconColor ?? kPrimaryColor, width: 1.5),
              //borderRadius: BorderRadius.circular(25.0),
            ),
      ),
      controller: controller,
      cursorColor: iconColor,
      style: textStyle,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      expands: isExpanded!,
      maxLines: isExpanded! ? null : maxLines,
      minLines: isExpanded! ? null : minLines,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLength: maxLength,
      validator: validator,
    );
  }
}

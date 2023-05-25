import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  const FormInputFieldWithIcon({
    Key? key,
    required this.controller,
    required this.iconPrefix,
    this.labelText,
    this.hintText,
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
    required this.onSaved,
    this.autoValidateMode,
    this.inputFormatters,
  }) : super(key: key);
  final AutovalidateMode? autoValidateMode;
  final TextEditingController controller;
  final IconData iconPrefix;
  final String? labelText, hintText;
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
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus!,
      textCapitalization: textCapitalization!,
      textAlignVertical: TextAlignVertical.top,
      autovalidateMode: autoValidateMode,
      inputFormatters: inputFormatters,
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      //textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: false,
        suffix: suffix,
        prefixIcon: Icon(
          iconPrefix,
          color: kPrimaryColor,
        ),
        labelText: labelText,
        labelStyle: textStyle,
        hintText: hintText,
        errorMaxLines: 2,
        enabledBorder: enableBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 1, style: BorderStyle.solid), //B
              borderRadius: BorderRadius.circular(8),
            ),
        focusedBorder: enableBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 1, style: BorderStyle.solid), //B
              borderRadius: BorderRadius.circular(8),
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

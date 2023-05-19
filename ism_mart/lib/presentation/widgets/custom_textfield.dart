import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ism_mart/utils/constants.dart';

class CustomTextField1 extends StatelessWidget {
  final String? title;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final AutovalidateMode? autoValidateMode;
  final bool asterisk;
  final bool? showCursor;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Color fillColor;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final double prefixIconSize;
  final double suffixIconSize;
  final EdgeInsetsGeometry contentPadding;

  const CustomTextField1({
    super.key,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 13,
    ),
    this.asterisk = false,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.autoValidateMode,
    this.title,
    this.hint,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.onTap,
    this.minLines,
    this.showCursor,
    this.suffixIcon,
    this.prefixIconSize = 18,
    this.suffixIconSize = 18,
    this.fillColor = Colors.white,
    this.prefixIcon,
    this.errorText,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(
                      //fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      (asterisk)
                          ? const TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                              ),
                            )
                          : const TextSpan(text: '')
                    ],
                  ),
                ),
              ),
        TextFormField(
          onChanged: onChanged,
          showCursor: showCursor,
          readOnly: readOnly,
          autovalidateMode: autoValidateMode,
          obscureText: obscureText,
          validator: validator,
          onTap: onTap,
          style: bodyText1,
          decoration: InputDecoration(
            contentPadding: contentPadding,
            //fillColor: fillColor,
            //filled: true,
            hintText: hint,
            isDense: true,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 1),
            ),
            hintStyle: const TextStyle(color: Colors.black45),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 1),
            ),
          ),
          controller: controller,
          keyboardType: keyboardType,
          minLines: minLines,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

class CountryCodePickerTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final ValueChanged<CountryCode>? onChanged;
  final ValueChanged<String>? onPhoneFieldChange;
  final bool? showCursor;
  final bool readOnly;
  final bool enabled;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  CountryCodePickerTextField({
    this.validator,
    this.autoValidateMode,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
    this.showCursor,
    this.readOnly = false,
    this.enabled = true,
    this.inputFormatters,
    this.errorText,
    this.onPhoneFieldChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      showCursor: showCursor,
      readOnly: readOnly,
      autovalidateMode: autoValidateMode,
      validator: validator,
      onChanged: onPhoneFieldChange,
      decoration: InputDecoration(
        errorText: errorText,
        fillColor: Colors.white,
        prefixIcon: Container(
          margin: EdgeInsets.fromLTRB(1, 1, 10, 1),
          decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1)),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
            ),
            child: CountryCodePicker(
              flagDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
              ),
              searchDecoration: InputDecoration(
                prefixIconColor: Colors.black,
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ), //B
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                    style: BorderStyle.solid,
                  ), //B
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              textStyle: TextStyle(color: Colors.black),
              enabled: enabled,
              onChanged: onChanged,
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: initialValue,
              favorite: ['+92'],
            ),
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(0, 12, 6.5, 12),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          ), //B
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
            style: BorderStyle.solid,
          ), //B
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      controller: controller,
      keyboardType: keyboardType,
    );
  }
}

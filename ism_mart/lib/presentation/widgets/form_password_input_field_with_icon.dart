import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class FormPasswordInputFieldWithIcon extends StatefulWidget {
  const FormPasswordInputFieldWithIcon(
      {Key? key,
      required this.controller,
      required this.iconPrefix,
      required this.labelText,
      required this.validator,
      this.iconColor,
      this.textStyle,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines,
      this.maxLength,
      this.maxLengthEnforcement,
      this.onPasswordVisible,
      required this.onChanged,
      this.onSaved, this.autoValidateMode})
      : super(key: key);
  final AutovalidateMode? autoValidateMode;
  final TextEditingController controller;
  final IconData iconPrefix;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool? obscureText;
  final int minLines;
  final int? maxLines;
  final Color? iconColor;
  final TextStyle? textStyle;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final void Function(bool?)? onPasswordVisible;

  @override
  State<FormPasswordInputFieldWithIcon> createState() =>
      _FormPasswordInputFieldWithIconState();
}

class _FormPasswordInputFieldWithIconState
    extends State<FormPasswordInputFieldWithIcon> {
  RxBool passVisibility = true.obs;

  _toggle() {
    passVisibility.value = !passVisibility.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        autovalidateMode: widget.autoValidateMode,
        decoration: InputDecoration(
            filled: false,
            prefixIcon: Icon(
              widget.iconPrefix,
              color: Colors.black87 ?? Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              //borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.black87??Colors.black45,
                width: 1.0,
              ),
              //borderRadius: BorderRadius.circular(20)
            ),
            fillColor: widget.iconColor ?? kPrimaryColor,
            labelText: widget.labelText,
            labelStyle: widget.textStyle,
            focusColor: widget.iconColor,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: widget.iconColor ?? kPrimaryColor, width: 2.0),
              //borderRadius: BorderRadius.circular(25.0),
            ),
            suffixIcon: widget.obscureText!
                ? GestureDetector(
                    onTap: _toggle,
                    child: Icon(
                      passVisibility.isTrue
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black87??widget.iconColor,
                    ),
                  )
                : null),
        controller: widget.controller,
        cursorColor: widget.iconColor,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        keyboardType: widget.keyboardType,
        obscureText: passVisibility.value,
        style: widget.textStyle,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        maxLength: widget.maxLength,
        validator: widget.validator,
      ),
    );
  }
}

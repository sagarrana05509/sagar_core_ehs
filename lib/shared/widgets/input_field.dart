import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import '../constants/color_constants.dart';
import '../utils/math_utils.dart';

class InputTextField extends StatelessWidget {
  final bool? enable;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Color? textColor;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? errorMaxLines;
  final FocusNode? focusNode;
  final int maxLines;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final EdgeInsets? contentPadding;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final String? errorText;
  final bool isSecure;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  const InputTextField({
    Key? key,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.textColor,
    required this.controller,
    this.textInputType,
    this.errorMaxLines,
    this.maxLines = 1,
    this.maxLength,
    this.contentPadding,
    this.onTap,
    this.textInputAction,
    this.errorText,
    this.isSecure = false,
    this.enable = true,
    this.onChanged,
    this.inputFormatters,
    this.prefixText,
    this.focusNode,
    this.onFieldSubmitted,
    this.textCapitalization,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildStackContainer();
  }

  _buildStackContainer() {
    return MediaQuery(
      data: MediaQuery.of(Get.context!).copyWith(textScaleFactor: 1.0),
      child: TextFormField(
        inputFormatters: inputFormatters,
        enabled: enable,
        initialValue: initialValue,
        controller: controller,
        onTap: onTap,
        cursorColor: ColorConstants.kPrimary,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: textInputType ?? TextInputType.text,
        maxLines: maxLines,
        maxLength: maxLength,
        focusNode: focusNode,
        //   minLines: 1,
        obscureText: isSecure,
        obscuringCharacter: '●',
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: textInputAction ?? TextInputAction.next,
        onChanged: onChanged,
        style: TextStyle(
          debugLabel: labelText,
          fontFamily: 'Poppins',
          letterSpacing: 0.5,
          color: ColorConstants.black,
          fontSize: getFontSize(15),
          fontWeight: FontWeight.w400,
        ),

        decoration: InputDecoration(
          border: InputBorder.none,
          alignLabelWithHint: true,
          counterText: "",
          isDense: true,
          filled: true,
          labelText: labelText,
          errorText: errorText,
          focusColor: ColorConstants.white,

          contentPadding:
              contentPadding ??
              EdgeInsets.symmetric(
                vertical: getSize(16),
                horizontal: getSize(12),
              ),
          hintText: hintText,
          fillColor: ColorConstants.grey,
          errorMaxLines: errorMaxLines ?? 1,
          errorStyle: TextStyle(
            fontSize: getFontSize(12),
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
            letterSpacing: 0.5,
            //letterSpacing: Utils.getSize(0.5),
            color: ColorConstants.redErrorColor,
          ),
          //    prefixIconConstraints: BoxConstraints(maxHeight: getSize(50)),
          labelStyle: TextStyle(
            fontSize: getFontSize(12),
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
            letterSpacing: 0.5,
            //letterSpacing: Utils.getSize(0.5),
            color: textColor ?? ColorConstants.black1,
          ),
          hintStyle: TextStyle(
            //  height: maxLines == 2 ? 2 : 0,
            //fontFamily: "Lexend Deca",
            fontSize: getFontSize(15),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: ColorConstants.black1,
          ),
          suffixIcon: suffixIcon,

          suffixIconConstraints: BoxConstraints(
            maxHeight: getSize(50),
            minWidth: getSize(80),
          ),
          prefixIcon: prefixIcon,
        ),
        onFieldSubmitted: onFieldSubmitted,
        validator: validator,
      ),
    );
  }
}

InputTextField getTextField({
  required String hintText,
  required TextEditingController controller,
  required String? Function(String?) validator,
  dynamic Function(String)? onChanged,
  Widget? suffix,
  bool isSecure = false,
  FocusNode? focusNode,
  Function(String)? onFieldSubmitted,
  TextInputAction? textInputAction,
  TextInputType? textInputType,
  TextCapitalization? textCapitalization,
}) {
  return InputTextField(
    controller: controller,
    hintText: hintText,
    validator: validator,
    onChanged: onChanged,
    suffixIcon: suffix,
    focusNode: focusNode,
    onFieldSubmitted: onFieldSubmitted,
    isSecure: isSecure,
    textCapitalization: textCapitalization,
    textInputAction: textInputAction ?? TextInputAction.next,
    textInputType: textInputType,
  );
}

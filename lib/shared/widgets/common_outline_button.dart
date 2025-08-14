import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/color_constants.dart';
import 'base_text.dart';

class CommonOutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  const CommonOutlineButton({
    super.key,
    required this.onPressed,
    this.width,
    this.height,
    required this.text,
    this.fontWeight,
    required this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? Get.width,
      height: height ?? 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onPressed,

        child: FittedBox(
          child: BaseText(
            text: text,
            fontWeight: fontWeight ?? FontWeight.w400,
            fontSize: fontSize ?? 16,
            textColor: textColor ?? ColorConstants.white,
          ),
        ),
      ),
    );
  }
}

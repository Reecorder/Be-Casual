import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.borderRadius,
      this.buttonSize,
      this.backgroundColor,
      required this.color,
      this.fontSize})
      : super(key: key);
  final String buttonText;
  final Function onPressed;
  final Color color;
  final Color? backgroundColor;
  final double? borderRadius;
  final Size? buttonSize;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10)),
            backgroundColor: color,
            fixedSize: buttonSize ?? const Size(350, 45)),
        onPressed: () {
          onPressed();
        },
        child: Text(buttonText,
            style: TextStyle(
                fontFamily: Fonts.medium,
                fontSize: fontSize ?? 14.0,
                color: Colors.white)));
  }
}

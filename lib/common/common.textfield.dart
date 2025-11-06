
import 'package:be_casual_new2/model/color.model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  CommonTextField(
      {super.key,
      required this.controller,
      required this.hint,
      this.prefixicon,
      this.suffixicon,
      this.color,
      this.changeobsecure,
      this.maxLength,
      this.validator,
      this.textInputType,
      this.obsecure = false});

  final TextEditingController controller;

  final String hint;

  final IconData? prefixicon;
final TextInputType? textInputType;
  final IconData? suffixicon;
  final Color? color;

  final bool obsecure;
  final int? maxLength;
  final Function? changeobsecure;

  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: color,
      validator: validator,
        keyboardType: textInputType,
      controller: controller,
      style: TextStyle(color: AppColors.black.withOpacity(0.9)),
      obscureText: obsecure,
      maxLength: maxLength,
      decoration: InputDecoration(
          label: Text(hint,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.9))),
          suffixIcon: suffixicon != null
              ? GestureDetector(
                  onTap: () {
                    changeobsecure!();
                  },
                  child: Icon(
                    suffixicon,
                    color: AppColors.black.withOpacity(0.9),
                  ))
              : null,
          border: border,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black.withOpacity(0.5))),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: color ?? AppColors.black, width: 2)),
          prefixIcon: null,
          // : Icon(
          //     prefixicon,
          //     color: AppColors.black.withOpacity(0.9),
          //   ),
          isDense: true,
          filled: true,
          fillColor: Colors.white)
    );
  }

  OutlineInputBorder border =
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.black12));
}

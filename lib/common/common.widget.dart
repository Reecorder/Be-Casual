
import 'package:be_casual_new2/model/color.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget spacer({double? height, double? width}) => SizedBox(
      height: height,
      width: width,
    );

/* subtitle style  */
TextStyle get subtitleStyle =>
    TextStyle(color: AppColors.loginScreenColor.withOpacity(0.5), fontSize: 12);

/* divider */
Widget get divider => SizedBox(
      width: Get.width,
      child: Divider(
        thickness: 0.5,
        color: AppColors.primary.withOpacity(0.2),
      ),
    );

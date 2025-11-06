import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonAppbar extends StatelessWidget {
  CommonAppbar({super.key, this.icon, this.title, this.subtitle, this.divider,this.onBackTap,});

  Widget? icon;
  String? title;
  String? subtitle;
  bool? divider = false;
  VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /* back button */
                backButton,
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(children: [
                      /* title */
                      titleWidget,
                      /* subtiltle */
                      subTitleWidget
                    ])),
                /* icon  */
                // iconWidget
                // icon == null ? const SizedBox() : Icon(icon)
                 icon ??  SizedBox(),
              ])),
      spacer(height: 10),
      dividerWidget
    ]);
  }

  /* back button */
  Widget get backButton => InkWell(
        // onTap: () {
        //   Get.back();
        // },
        onTap: onBackTap ?? () => Get.back(), 
        child: const Image(
            image: AssetImage("assets/dashboard/backButton.png"), height: 25),
      );

  /* title */
  Widget get titleWidget => Text(title!,
      style: TextStyle(
          fontSize: 14,
          color: AppColors.primary,
          fontFamily: Fonts.medium,
          fontWeight: FontWeight.w500));

  /* subtitle  */
  Widget get subTitleWidget => Text(subtitle!,
      style: TextStyle(color: AppColors.primary.withOpacity(0.8), fontSize: 10),
      maxLines: 1);

  /* icon */
  // Widget get iconWidget => ;

  Widget get dividerWidget => divider == true
      ? SizedBox(
          width: Get.width,
          child: Divider(
            thickness: 1,
            color: AppColors.loginScreenColor.withOpacity(0.2),
          ),
        )
      : const SizedBox();
}

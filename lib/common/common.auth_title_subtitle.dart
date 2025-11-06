import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:flutter/material.dart';

class CommonAuthTitleSubtitle extends StatelessWidget {
  CommonAuthTitleSubtitle(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.color});

  String title;
  String subTitle;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      /* spacer */
      spacer(height: 10),
      /* title */
      titleText(title: title),
      subTitleText(subTitle: subTitle)
    ]);
  }

  /* title */
  Widget titleText({title}) => Text(title, style: titleStyle);

  /* title style */
  TextStyle get titleStyle =>
      TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 22);

  /* subtitle */
  Widget subTitleText({subTitle}) => Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(subTitle, style: subtitleStyle));

  /* subtitle style  */
  TextStyle get subtitleStyle => TextStyle(
      color: AppColors.loginScreenColor.withOpacity(0.5), fontSize: 12);
}

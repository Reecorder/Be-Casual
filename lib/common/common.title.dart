
import 'package:be_casual_new2/model/color.model.dart';
import 'package:flutter/material.dart';

class CommonTitleRow extends StatelessWidget {
  CommonTitleRow({super.key, required this.title, required this.width, this.size});
  String title;
  double width;
  double? size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /* divider */
        horizontalDivider(width: width),
        /* title */
        titleWidget(title: title),
        /* divider */
        horizontalDivider(width: width)
      ],
    );
  }

  /* horizontal divider */
  Widget horizontalDivider({width}) => SizedBox(
        width: width,
        child: Divider(
          thickness: 1,
          color: AppColors.loginScreenColor.withOpacity(0.2),
        ),
      );

  /* title */
  Widget titleWidget({title}) => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Text(
          title,
          style: titleStyle(size: size),
        ),
      );

  /* title style  */
  TextStyle  titleStyle({size}) => TextStyle(
      color: AppColors.loginScreenColor.withOpacity(0.5), fontSize: size ?? 12);
}

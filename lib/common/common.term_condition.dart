import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:flutter/material.dart';

class CommonTermCondition extends StatelessWidget {
  CommonTermCondition({super.key, required this.color});

  Color color;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      /* term condition title */
      termConditionTitle,
      /* condition + policy row */
      conditionPolicyRow
    ]);
  }

  /* term condition tilte */
  Widget get termConditionTitle => Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 5),
      child: Text(termConditionTitleString, style: subtitleStyle));

  /* term condition title string */
  String termConditionTitleString = 'By continuing, you agree to our';

  /* term condition and privacy policy */
  Widget get conditionPolicyRow =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ...List.generate(
            conditonLists.length,
            (index) => Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(conditonLists[index],
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: Fonts.medium,
                        color: color))))
      ]);
  /* subtitle style  */

  TextStyle get subtitleStyle =>
      TextStyle(color: AppColors.black.withOpacity(0.5), fontSize: 12);

  /* terms option */
  List conditonLists = ["Terms of service", "Privacy Policy", "Content Policy"];
}

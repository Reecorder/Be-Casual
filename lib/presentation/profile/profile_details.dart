import 'package:be_casual_new2/common/common.auth_title_subtitle.dart';
import 'package:be_casual_new2/common/common.button.dart';
import 'package:be_casual_new2/common/common.textfield.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/presentation/profile/location_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          /* detail screen image */
          detailScreenImage,
          Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: authController.profileFormKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* title + subtitle */
                      titleSubtitle,

                      /* spacer */
                      spacer(height: 20),

                      /* profile title */
                      profileTitle,

                      /* spacer */
                      spacer(height: 10),

                      /* name field */
                      nameField,

                      /* spacer */
                      spacer(height: 10),

                      /* phone field */
                      phoneField,

                      /* spacer */
                      spacer(height: 10),

                      /* gender title */
                      genderTitle,

                      /* spacer */
                      spacer(height: 10),

                      /* gender widget  */
                      genderWidget,

                      /* spacer */
                      spacer(height: 20),

                      /* save button */
                      saveButton
                    ]),
              ))
        ])));
  }

  /* detail screen image */
  Widget get detailScreenImage =>
      Image.asset("assets/profile_detail_sceen.png");

  /* title +  subtitle */
  Widget get titleSubtitle => CommonAuthTitleSubtitle(
      title: titleString,
      subTitle: subtitleString,
      color: AppColors.profileDetailScreenColor);

  /* title string */
  String titleString = "Welcome to Your Closet";

  /* subtitle String */
  String subtitleString = "Your Style Awaits Beyond";

  /* profile detail title */
  Widget get profileTitle =>
      CommonTitleRow(title: "Your Details and more", width: 80);

  /* name field */
  Widget get nameField => CommonTextField(
        controller: authController.nameController,
        hint: "Name",
        prefixicon: Feather.user,
        color: AppColors.profileDetailScreenColor,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Name is required";
          }
          return null;
        },
      );

  /* name field */
  Widget get phoneField => CommonTextField(
        controller: authController.phoneController,
        hint: "Phone Number",
        textInputType: TextInputType.phone,
        prefixicon: Feather.phone,
        color: AppColors.profileDetailScreenColor,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "phone no is required";
          }
          return null;
        },
      );

  /* gender title */
  Widget get genderTitle => CommonTitleRow(title: "Gender", width: 130);

  /* gender field */
  Widget get genderWidget => Column(children: [
        ...List.generate(
            authController.genderList.length,
            (index) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: genderTile(index: index))),
      ]);

  /* gender tile */
  Widget genderTile({index}) => InkWell(
      onTap: () {
        authController.changeSelectedCustomerTitle(index);
      },
      child: Container(
          width: Get.width,
          height: 55,
          decoration: decoration,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /* gender text */
                    Expanded(child: Text(authController.genderList[index])),
                    spacer(width: 200),
                    /* gender check box */
                    Expanded(
                        child: Obx(() => selectTitleCheck(
                            onChanged: () {
                              authController.changeSelectedCustomerTitle(index);
                            },
                            isSelected: authController.genderList[index] ==
                                authController.selectedGender.value)))
                  ]))));

  // Common check box
  Widget selectTitleCheck(
          {bool isSelected = false, required Function onChanged}) =>
      Theme(
          data: ThemeData(
              unselectedWidgetColor: AppColors.profileDetailScreenColor),
          child: isSelected
              ? selectedGender
              : Checkbox(
                  checkColor: AppColors.black,
                  activeColor:AppColors.black.withOpacity(0.9),
                  shape: const CircleBorder(),
                  value: isSelected,
                  onChanged: (val) {
                    onChanged();
                  }));

  /* gender box decoration */
  BoxDecoration get decoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
          color: AppColors.profileDetailScreenColor.withOpacity(0.5))
          );

  /* selected radio */
  Widget get selectedGender => CircleAvatar(
      backgroundColor: AppColors.profileDetailScreenColor,
      radius: 9,
      child: CircleAvatar(
          radius: 8,
          backgroundColor: Colors.white,
          child: CircleAvatar(
              backgroundColor: AppColors.profileDetailScreenColor, radius: 5)));

  /* save button */
  Widget get saveButton => CommonButton(
        buttonText: "Save",
        onPressed: () {
          if (authController.profileFormKey.currentState!.validate() &&
              authController.selectedGender.value.isNotEmpty) {
            Get.to(() => LocationDetailScreen());
          } else {
            setState(() {}); 
            // Triggers validation message updates
          }
        },
        borderRadius: 5,
        color: AppColors.profileDetailScreenColor,
      );
}

import 'package:be_casual_new2/common/common.auth_title_subtitle.dart';
import 'package:be_casual_new2/common/common.button.dart';
import 'package:be_casual_new2/common/common.textfield.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/presentation/base_screen/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationDetailScreen extends StatelessWidget {
  LocationDetailScreen({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          /* image */
          locationDetailImage,
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                /* title + subtitle */
                titleSubtitle,

                /* spacer */
                spacer(height: 15),

                /* location title 1 */
                locationTitle1,

                /* spacer */
                spacer(height: 15),

                /* current location field */
                currentLocationField,

                /* spacer */
                spacer(height: 15),

                /* location title 1 */
                locationTitle2,

                /* spacer */
                spacer(height: 15),

                /* address field */
                addressField,

                /* spacer */
                spacer(height: 10),

                /* state field */
                stateField,

                /* spacer */
                spacer(height: 10),

                /* city field */
                cityField,

                /* spacer */
                spacer(height: 10),

                /* zipcode field  */
                zipCodeField,

                /* spacer */
                spacer(height: 20),

                /* save button */
                saveButton
              ]))
        ])));
  }

  /* location detail screen image */
  Widget get locationDetailImage =>
      Image.asset("assets/location_detail_screen.png");

  /* title +  subtitle */
  Widget get titleSubtitle => CommonAuthTitleSubtitle(
      title: titleString,
      subTitle: subtitleString,
      color: AppColors.locationDetailScreenColor);

  /* title string */
  String titleString = "Fashion Forward Entry";

  /* subtitle String */
  String subtitleString = "Your Precise Location Helps a Smooth Delivery";

  /* location detail title 1 */
  Widget get locationTitle1 =>
      CommonTitleRow(title: "Fetch Current Location", width: 80);

  /* current loaction field */
  Widget get currentLocationField => Container(
        width: Get.width,
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
              child: Text(
            "Current Location",
            style: TextStyle(
                color: AppColors.locationDetailScreenColor,
                fontSize: 14,
                fontFamily: Fonts.medium),
          )),
        ),
      );

  /* current location box decoration */
  BoxDecoration get decoration => BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.locationDetailScreenColor, width: 2));

  /* location detail title 2*/
  Widget get locationTitle2 =>
      CommonTitleRow(title: "Enter Locations Manually", width: 80);

  /* name field */
  Widget get addressField => CommonTextField(
        controller: authController.addressController,
        hint: "Full Address",
        prefixicon: null,
        color: AppColors.locationDetailScreenColor,
        validator: (address) {
          if (address == null) {
            return "Address is required";
          }
          return null;
        },
      );

  /* state field */
  Widget get stateField => CommonTextField(
        controller: authController.stateController,
        hint: "State",
        prefixicon: null,
        color: AppColors.locationDetailScreenColor,
        validator: (state) {
          if (state == null) {
            return "State is required";
          }
          return null;
        },
      );

  /* city field */
  Widget get cityField => CommonTextField(
        controller: authController.cityController,
        hint: "City",
        prefixicon: null,
        color: AppColors.locationDetailScreenColor,
        validator: (city) {
          if (city == null) {
            return "City is required";
          }
          return null;
        },
      );
  /* zipcode field */
  Widget get zipCodeField => CommonTextField(
        controller: authController.zipcodeController,
        hint: "Zipcode",
        prefixicon: null,
        color: AppColors.locationDetailScreenColor,
        validator: (code) {
          if (code == null) {
            return "Zipcode is required";
          }
          return null;
        },
      );

  /* save button */
  Widget get saveButton => CommonButton(
      buttonText: "Save",
      onPressed: () {
        // Get.to(() => const BaseScreen());
        authController.register();
      },
      borderRadius: 5,
      color: AppColors.locationDetailScreenColor);
}

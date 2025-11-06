import 'package:be_casual_new2/common/common.appbar.dart';
import 'package:be_casual_new2/common/common.textfield.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/addAddress.controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressScreen extends StatefulWidget {
 const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final controlller = Get.put(AddAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(Get.width, 70), child: appbarWidget),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: controlller.addressKey,
            child: Column(children: [
              /* address fielld */
              addressField,
              spacer(height: 10),
              /* state field */
              stateField,
              spacer(height: 10),
              /* city field */
              cityField,
              spacer(height: 10),
              /* zipcode field */
              zipcodeField,
              spacer(height: 10),
              // confirmationRow,
              /* save button */
              saveButton
            ]),
          ),
        ),
      ),
    );
  }

  /* appbar widget */
  Widget get appbarWidget => CommonAppbar(
        title: "Updating - Address",
        subtitle: "",
        divider: true,
      );

  /* address field */
  Widget get addressField => CommonTextField(
      controller: controlller.addressController,
      hint: "Address",
      color: AppColors.primary,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Address is required";
        }
        return null;
      });

  /* state feild */
  Widget get stateField => CommonTextField(
      controller: controlller.stateController,
      hint: "State",
      color: AppColors.primary,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "State is required";
        }
        return null;
      });

  /* city field */
  Widget get cityField => CommonTextField(
      controller: controlller.cityController,
      hint: "City",
      color: AppColors.primary,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "City is required";
        }
        return null;
      });

  /* zipcode feild */
  Widget get zipcodeField => CommonTextField(
      controller: controlller.zipcodeController,
      hint: "Zipcode",
      color: AppColors.primary,
      textInputType: TextInputType.number,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "zip code is required";
        }
        return null;
      });

  /* confirmation row */
  Widget get saveButton => Obx(() => controlller.addressLoader.value
      ? const Center(child: CircularProgressIndicator())
      : Padding(
          padding: const EdgeInsets.only(top: 30),
          child: InkWell(
            onTap: () {
              // controlller.addAddress();
              if (controlller.addressKey.currentState!.validate()) {
                controlller.addAddress();
              } else {
                Get.snackbar("Error", "Please fill all fields",
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: controlller.isFormValid.value
                          ? AppColors.black.withOpacity(0.9)
                          : Colors.grey,
                      width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Text("Add Address",
                      style: TextStyle(
                          color: Colors.white,
                          // color: controlller.isFormValid.value
                          //     ? AppColors.black.withOpacity(0.9)
                          //     : Colors.grey,
                          fontSize: 14,
                          fontFamily: Fonts.medium)),
                ),
              ),
            ),
          ),
        ));
}

import 'package:be_casual_new2/common/common.button.dart';
import 'package:be_casual_new2/common/common.textfield.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final authController = Get.find<AuthController>();
  final TextEditingController nameController =
      TextEditingController(text: Get.find<AuthController>().userName.value);
  final TextEditingController emailController =
      TextEditingController(text: Get.find<AuthController>().userEmail.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              // Name field
              CommonTextField(controller: nameController, hint: "Name"),
              const SizedBox(height: 16),
              // Email field
              CommonTextField(controller: emailController, hint: "Email"),
             
              const SizedBox(height: 32),
              CommonButton(
                  buttonText: "Submit",
                  // onPressed: () {
                  //   authController.userName.value = nameController.text;
                  //   authController.userEmail.value = emailController.text;
                  //   Get.back();
                  // },
                  onPressed: () {
                    authController.userName.value = nameController.text;
                    authController.userEmail.value = emailController.text;

                    authController.userUpdate();
                    Get.back();
                  },
                  borderRadius: 5,
                  color: AppColors.loginScreenColor)
            ])));
  }
}

import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:be_casual_new2/presentation/authentication/login.dart';
import 'package:be_casual_new2/presentation/profile/edit.profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      /* divider */
      divider,
      spacer(height: 80),
      /* profile image */
      profileImage,
      spacer(height: 20),
      /* name */
      name,
      /* email */
      email,
      spacer(height: 20),
      /* edit profile button  */
      editProfileButton,
      spacer(height: 10),
      divider,
      /* drawer menu items */
      drawerItem,
      /* delete my account  */
      deleteAccountButton
    ]));
  }

  Widget get profileImage => ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset("assets/product/profile_image1.jpg",
          height: 120, fit: BoxFit.cover, width: 100));

  /* name */
  Widget get name =>
      Obx(() => 
      Text(authController.userName.value ?? "Dipika Biswas",
          style: TextStyle(fontFamily: Fonts.medium)));

  Widget get email => Obx(() => Text(
      authController.userEmail.value ?? "dipika.biswas@pixelconsultancy.in",
      style: TextStyle(
          fontFamily: Fonts.medium, decoration: TextDecoration.underline)));

  /* edit profile button */
  Widget get editProfileButton => InkWell(
      onTap: () {
        // Get.to(EditProfileScreen());
        Get.to(() => EditProfileScreen());

      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black12)),
          child: const Padding(
              padding: EdgeInsets.all(8.0), child: Text("Edit Profile"))));

  /* drawer item */
  Widget get drawerItem => Column(children: [
        ...List.generate(
            drawerMenuLists.length,
            (index) => Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                          onTap: () {
                            if (drawerMenuLists[index] == "Logout") {
                              showDialog(
                                  context: Get.context!,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: const Text("Confirm Logout"),
                                        content: const Text(
                                            "Are you sure you want to logout?"),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        insetPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 20),
                                        actions: [
                                          TextButton(
                                              child: const Text("No"),
                                              onPressed: () => Get.back()),
                                          TextButton(
                                              child: const Text("Yes",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              onPressed: () {
                                                Get.to(const LoginScreen());
                                              })
                                        ]);
                                  });
                            }
                          },
                          child: Text(drawerMenuLists[index]))),
                  divider
                ]))
      ]);


  /* delete account button */
  Widget get deleteAccountButton => Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
          onTap: () {
            showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text(
                          "Are you sure you want to delete your account?"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      actions: [
                        TextButton(
                            child: const Text("No"),
                            onPressed: () {
                              Get.back();
                            }),
                        TextButton(
                            child: const Text("Yes",
                                style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              authController.deleteAccountLocally();
                            })
                      ]);
                });
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: const Color(0xFFBB1918).withOpacity(0.5))),
              child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Delete My Account",
                      style: TextStyle(color: Color(0xFFBB1918)))))));

  
}

List drawerMenuLists = [
  "View Cart Details",
  "Search Available Items",
  "Your Order Details",
  "Terms & Conditions",
  "Privacy Policy",
  "Logout"
  // "Delete My Account"
];

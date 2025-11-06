import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/common/common.button.dart';
import 'package:be_casual_new2/common/common.textfield.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:be_casual_new2/common/common.term_condition.dart';
import 'package:be_casual_new2/presentation/authentication/login.dart';
import 'package:be_casual_new2/common/common.auth_title_subtitle.dart';
import 'package:be_casual_new2/presentation/profile/profile_details.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* register screen image */
            Image.asset("assets/register_screen.png"),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: authController.regFormKey,
                child: Column(
                  children: [
                    /* title + subtitle */
                    CommonAuthTitleSubtitle(
                      title: "Embrace Your Elegance",
                      subTitle: "Discover Your Fashion Realm & Sign Up with Us",
                      color: AppColors.registerScreenColor,
                    ),

                    /* spacer */
                    spacer(height: 20),

                    /* register title row */
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: CommonTitleRow(
                        title: "Let’s Log you In or Sign Up",
                        width: 70,
                      ),
                    ),

                    /* spacer */
                    spacer(height: 10),

                    /* email */
                    CommonTextField(
                      controller: authController.regEmailController,
                      hint: "Email",
                      prefixicon: Feather.mail,
                      color: AppColors.registerScreenColor,
                      validator: (email) {
                        if (email == null) {
                          return "Email is required";
                        } else if (!email.isEmail) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),

                    /* spacer */
                    spacer(height: 10),

                    /* password */
                    Obx(
                      () => CommonTextField(
                        controller: authController.regPasswordController,
                        hint: "Password",
                        prefixicon: Icons.lock_outline_rounded,
                        /* suffix icon changed based on the obsecurity */
                        color: AppColors.registerScreenColor,
                        suffixicon:
                            authController.regPasswordObsecure.value
                                // ? Icons.visibility_outlined
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,

                        obsecure: authController.regPasswordObsecure.value,
                        changeobsecure: () {
                          /* changing password obsecure status */
                          authController.changeRegPasswordObsecure;
                        },
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                    ),

                    /* spacer */
                    spacer(height: 10),

                    /* spacer */
                    spacer(height: 20),

                    /* register button */
                    Obx(
                      () =>
                          authController.registerLoader.value
                              ? const Center(child: CircularProgressIndicator())
                              : CommonButton(
                                borderRadius: 5,
                                color: AppColors.registerScreenColor,
                                onPressed: () {
                                  if (authController.regFormKey.currentState!
                                      .validate()) {
                                    Get.to(() => const ProfileDetailScreen());
                                  } else {}
                                },
                                buttonText: "Continue",
                              ),
                    ),

                    /* spacer */
                    spacer(height: 20),

                    /* or option */
                    CommonTitleRow(title: 'or', size: 12, width: 140),

                    /* spacer */
                    spacer(height: 10),

                    /* social media icon */
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Image.network(
                        "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
                      ),
                    ),

                    /* login option */
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: subtitleStyle,
                          ),
                          const SizedBox(width: 8.0),
                          InkWell(
                            onTap: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: Text(
                              "Log In Now",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.registerScreenColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /* spacer */
                    spacer(height: 20),

                    /* term condition */
                    CommonTermCondition(
                      color: AppColors.registerScreenColor.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:be_casual_new2/common/common.auth_title_subtitle.dart';
import 'package:be_casual_new2/common/common.button.dart';
import 'package:be_casual_new2/common/common.term_condition.dart';
import 'package:be_casual_new2/common/common.textfield.dart';
import 'package:be_casual_new2/common/common.title.dart';
import 'package:be_casual_new2/common/common.widget.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/presentation/authentication/register.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: authController.loginKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/login_screen.png"),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CommonAuthTitleSubtitle(
                      title: "Begin Your Style Voyage",
                      subTitle: "Let’s Start Your Fashionable Entrance with Us",
                      color: AppColors.loginScreenColor,
                    ),
                    spacer(height: 20),

                    /* login title row */
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: CommonTitleRow(
                        title: "Let’s Log you In or Sign Up",
                        width: 70,
                      ),
                    ),

                    /* spacer  */
                    spacer(height: 20),

                    /* email field*/
                    CommonTextField(
                      controller: authController.loginEmailController,
                      hint: "Email",
                      prefixicon: Feather.mail,
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

                    /* password field */
                    Obx(
                      () => CommonTextField(
                        controller: authController.loginPasswordController,
                        hint: "Password",
                        prefixicon: Icons.lock_outline_rounded,
                        suffixicon:
                            authController.loginObsecure.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                        obsecure: authController.loginObsecure.value,
                        changeobsecure: () {
                          authController.changeLoginObsecure();
                        },
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                    ),

                    // Obx(
                    //   () => CommonTextField(
                    //     controller: authController.regConfirmPasswordController,
                    //     hint: "Confirm Password",
                    //     prefixicon: Icons.lock_outline_rounded,
                    //   ),
                    // ),

                    /* forgot password */
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.loginScreenColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    /* spacer */
                    spacer(height: 10),
                    /* continue button */
                    Obx(
                      () =>
                          authController.loginLoader.value
                              ? const Center(child: CircularProgressIndicator())
                              : CommonButton(
                                buttonText: "Continue",
                                onPressed: () {
                                  authController.login();
                                },
                                borderRadius: 5,
                                color: AppColors.loginScreenColor,
                              ),
                    ),

                    /* spacer */
                    spacer(height: 20),

                    /* or option */
                    CommonTitleRow(title: 'or', size: 12, width: 140),

                    /* spacer */
                    spacer(height: 10),

                    /* social media login */
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Image.network(
                        "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png",
                      ),
                    ),

                    /* sign up option */
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?", style: subtitleStyle),
                          const SizedBox(width: 8.0),
                          InkWell(
                            onTap: () {
                              Get.to(() => RegisterScreen());
                            },
                            child: Text(
                              "Sign Up Now",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.loginScreenColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /* spacer */
                    spacer(height: 20),

                    /* CommonTermCondition */
                    CommonTermCondition(color: AppColors.registerScreenColor),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

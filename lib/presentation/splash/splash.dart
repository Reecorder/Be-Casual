import 'dart:async';
import 'dart:developer';
import 'package:be_casual_new2/presentation/product/cart/checkout.screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/controller/auth.controller.dart';
import 'package:be_casual_new2/presentation/authentication/login.dart';
import 'package:be_casual_new2/presentation/base_screen/base_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.put(AuthController());
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      checkRoute();
    });
  }

  Future<void> checkRoute() async {
    final id = await getCookie(key: "userId");
    final name = await getCookie(key: "username");
    final user = await getCookie(key: "user");
    final usermail = await getCookie(key: "usermail");
    final usernumber = await getCookie(key: "phone");

    log('user->${user.toString()}');
    log('id->${id.toString()}');
    log('username->${name.toString()}');
    log('usermail->${usermail.toString()}');
    log('usernumber->${usernumber.toString()}');

    if (id != null && user != null) {
      authController.setUserData(
        name: name ?? "Dipika",
        email: usermail ?? "Dipika@gmail.com",
        id: id,
        number: usernumber ?? "8777880505",
      );
      Get.to(() => const BaseScreen());
    } else {
      Get.to(() => const LoginScreen());
      // Get.to(() => const BaseScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/Logo.png"),
              height: 250,
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:be_casual_new2/presentation/authentication/login.dart';
import 'package:be_casual_new2/presentation/base_screen/base_screen.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  /* login screen controllers */
  //____________________________

  /* email controller */
  final loginEmailController = TextEditingController();
  /* password controller */
  final loginPasswordController = TextEditingController();

  /* login absecure */
  RxBool loginObsecure = false.obs;

  /* change login obsecure function */
  // get changeLoginObsecure => loginObsecure.value = !loginObsecure.value;
  void changeLoginObsecure() {
    loginObsecure.value = !loginObsecure.value;
  }

  // Login screen form key
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  // login loader
  RxBool loginLoader = false.obs;

  /* register screen controllers */
  // _______________________________
  /* email controller */
  final regEmailController = TextEditingController();
  /* password controller */
  final regPasswordController = TextEditingController();
  /* confirm password controller */
  final regConfirmPasswordController = TextEditingController();

  /* register password absecure */
  RxBool regPasswordObsecure = false.obs;

  /* change register password obsecure function */
  get changeRegPasswordObsecure =>
      regPasswordObsecure.value = !regPasswordObsecure.value;

  /* register password absecure */
  RxBool regConfirmPasswordObsecure = false.obs;

  /* change register confirm password obsecure function */
  get changeRegConfirmPasswordObsecure =>
      regConfirmPasswordObsecure.value = !regConfirmPasswordObsecure.value;

  // Register screen form key
  GlobalKey<FormState> regFormKey = GlobalKey<FormState>();
  // Register loader
  RxBool registerLoader = false.obs;

  /* profile screen controllers */
  // _____________________________
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  /* name controller */
  final nameController = TextEditingController();
  /* phone controller */
  final phoneController = TextEditingController();

  // List of available gendr
  List<String> genderList = ["Male", "Female", "Others"];

  // Selected gender
  RxString selectedGender = "Male.".obs;

  // Method to check if all required fields are filled
  bool get isFormValid =>
      nameController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      selectedGender.value.isNotEmpty;
  // Update the selected gender
  void changeSelectedCustomerTitle(int index) {
    selectedGender.value = genderList[index];
  }

  /* location screen controllers */
  // ___________________________________
  /* name controller */
  final addressController = TextEditingController();
  /* address controller */
  final stateController = TextEditingController();
  /* city controller */
  final cityController = TextEditingController();
  /* zipcode controller */
  final zipcodeController = TextEditingController();

  RxInt selctedAddress = 0.obs;

  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userId = ''.obs;
  RxString userphoneNumber = ''.obs;

  void setUserData({
    required String name,
    required String email,
    required String id,
    required String number,
  }) {
    userName.value = name;
    userEmail.value = email;
    userId.value = id;
    userphoneNumber.value = number;
  }

  // Register function handles user registration by sending a POST request to the server, processing the response

  void register() async {
    registerLoader.value = true;
    String endpoint = Endpoints.register;
    final requestData = {
      "email": regEmailController.text,
      "password": regPasswordController.text,
      "name": nameController.text,
      "phone": phoneController.text,
      "gender": selectedGender.value,
      // "address":[]
      "address": [
        {
          "fullAddress": addressController.text,
          "city": cityController.text,
          "state": stateController.text,
          "pin": zipcodeController.text,
        },
      ],
    };

    log("Request Data: $requestData");

    try {
      final response = await APIClient(endpoint).post(jsonEncode(requestData));

      if (response != null) {
        log("Response: ${response.data}");

        final user = response.data["data"];
        if (user != null) {
          // Saving the user's ID in a cookie with the key "userId".
          await saveCookie(key: "userId", value: user["id"]);
          // Saving the user data in JSON format to a cookie with the key "user".
          await saveCookie(key: "username", value: user["name"]);
          await saveCookie(key: "usermail", value: user["email"]);
          await saveCookie(key: "user", value: jsonEncode(user));
          log("${user["id"].toString()}");
          log(user["email"].toString());
          log(user["name"].toString());
          log(user["user"].toString());
          Get.snackbar(
            "Success",
            "Registration successful!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.to(() => const BaseScreen());
        } else {
          Get.snackbar(
            "Error",
            "User data not found",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          response?.data["message"] ?? "Registration failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.data}");
      log("Dio Full Error: ${e.toString()}");

      Get.snackbar(
        "Error",
        e.response?.data?["message"] ?? "Invalid request",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    registerLoader.value = false; // Stop loading
  }

  void login() async {
    loginLoader.value = true; // Start loading
    String endpoint = Endpoints.login; // login api endpoint

    final requestData = {
      "email": loginEmailController.text,
      "password": loginPasswordController.text,
    };

    log("Login Request Data: $requestData");

    try {
      //The `requestData` is being encoded to JSON format using `jsonEncode` before sending the request.
      final response = await APIClient(endpoint).post(jsonEncode(requestData));

      if (response != null) {
        log("Login Response: ${response.data}");
        // The "data" field from the response received after making an API request.
        final user = response.data["data"];
        log("User: ${user}");

        if (user != null) {
          await saveCookie(key: "userId", value: user["id"]);
          await saveCookie(key: "username", value: user["name"]);
          await saveCookie(key: "usermail", value: user["email"]);
          await saveCookie(key: "user", value: jsonEncode(user));
          await saveCookie(key: 'phone', value: user["phoneNo"]);

          Get.snackbar(
            "Success",
            "Login successful!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.to(() => const BaseScreen());
        } else {
          Get.snackbar(
            "Error",
            "User data not found",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          response?.data["message"] ?? "Login failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?["message"] ?? "Invalid credentials";

      Get.snackbar(
        "Error",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      log("Dio Error: $errorMessage");
    }

    loginLoader.value = false; // Stop loading
  }

  void deleteAccountLocally() async {
    try {
      // Clear saved cookies
      await Future.wait<void>([
        deleteCookie(key: 'userId'),
        deleteCookie(key: 'username'),
        deleteCookie(key: 'user'),
        deleteCookie(key: 'usermail'),
        deleteCookie(key: 'phone'),
      ]);

      // Clear observable values
      userId.value = '';
      userName.value = '';
      userEmail.value = '';
      userphoneNumber.value = '';

      // Show confirmation
      Get.snackbar(
        "Account Deleted",
        "Your account has been removed locally.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
      await Future.delayed(const Duration(seconds: 2));
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete account data: $e",
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  // loader
  RxBool updateLoader = false.obs;
  void userUpdate() async {
    final String endpoint = Endpoints.update;
    final String? userIdVal = userId.value;
    if (userIdVal == null || userIdVal.isEmpty) {
      Get.snackbar("Error", "User ID is missing");
      return;
    }

    final String name = userName.value ?? 'Dipika Biswas';
    final String email = userEmail.value ?? '';
    final String phone = userphoneNumber.value ?? '';

    final Map<String, dynamic> updateData = {
      "name": name,
      "email": email,
      "phone": phone,
    };

    try {
      final response = await APIClient(
        '$endpoint/$userIdVal',
      ).put(jsonEncode(updateData));

      if (response != null && response.data != null) {
        final updatedUser = response.data["data"];

        userName.value = updatedUser["name"] ?? "";
        userEmail.value = updatedUser["email"] ?? "";
        userphoneNumber.value = updatedUser["phone"] ?? "";

        await saveCookie(key: "username", value: userName.value);
        await saveCookie(key: "usermail", value: userEmail.value);
        await saveCookie(key: "user", value: jsonEncode(updatedUser));

        Get.snackbar(
          "Success",
          "Profile updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong while updating profile",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      log("Update Error: ${e.response?.data}");
      Get.snackbar(
        "Error",
        e.response?.data["message"] ?? "Update failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

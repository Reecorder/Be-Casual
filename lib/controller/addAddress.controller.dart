import 'dart:convert';
import 'dart:developer';

import 'package:be_casual_new2/model/addressmodel.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  final addressController = TextEditingController();
  /* address controller */
  final stateController = TextEditingController();
  /* city controller */
  final cityController = TextEditingController();
  /* zipcode controller */
  final zipcodeController = TextEditingController();

  var isFormValid = false.obs;

  GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  // void validateForm() {
  //   isFormValid.value = addressController.text.isNotEmpty &&
  //       stateController.text.isNotEmpty &&
  //       cityController.text.isNotEmpty &&
  //       zipcodeController.text.isNotEmpty;
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   addressController.addListener(validateForm);
  //   stateController.addListener(validateForm);
  //   cityController.addListener(validateForm);
  //   zipcodeController.addListener(validateForm);
  // }

  RxBool addressLoader = false.obs;
  RxBool addressidLoader = false.obs;
  RxString selectedId = "".obs;
  void addAddress() async {
    addressLoader.value = true;
    String endpoint = Endpoints.addAddress;
    final requestData = {
      "fullAddress": addressController.text,
      "state": stateController.text,
      "city": cityController.text,
      "pin": zipcodeController.text,
      "userId": await getCookie(key: "userId"),
    };
    log("Address Request Data: $requestData");
    try {
      final response = await APIClient(endpoint).post(jsonEncode(requestData));

      if (response != null) {
        log(" Response: ${response.data}");

        final user = response.data["data"];
        log("User: ${user}");
        if (user != null) {
          // Show success message
          Get.back();
          Get.snackbar("Success", " successful!",
              backgroundColor: Colors.green, colorText: Colors.white);

          // Get.back();
          log("Going back...");
          // Get.back();
          log("Should be back.");
        } else {
          Get.snackbar("Error", "data not found",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", response?.data["message"] ?? " failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?["message"] ?? "Invalid ";

      Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);

      log("Dio Error: $errorMessage");
    }

    addressLoader.value = false;
  }

  RxList<AddressModel> addressmodel = <AddressModel>[].obs;

  void addressIdfind() async {
    addressidLoader.value = true;
    String endpoint = Endpoints.addAddressFind;
    try {
      final response =
          await APIClient(endpoint).get(id: await getCookie(key: 'userId'));
      log("API address Response: ${response!.data}");

      if (response.data != null && response.data['data'] != null) {
        final List addressList = response.data['data'];
        final List<AddressModel> fetchedaddress =
            addressList.map((json) => AddressModel.fromJson(json)).toList();
        addressmodel.assignAll(fetchedaddress);
        log("address Count: ${addressmodel.length}");
        log("address city Name: '${addressmodel.first.city}'");
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?["message"] ?? "Something went wrong";
      Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    addressidLoader.value = false;
  }

  RxList<Map<String, String>> savedAddresses = <Map<String, String>>[
    {
      "name": "Joy Bhattacherjee",
      "phone": "+918697604919",
      "addressLine1": "DN-24, Saltlake, Sector 5, Kolkata, India",
      "addressLine2": "Matrix Tower, 10th Floor",
      "addressLine3": "West Bengal, Kolkata, 700009",
    },
    {
      "name": "Static Address 2",
      "phone": "+910000000000",
      "addressLine1": "Somewhere Else",
      "addressLine2": "Building X",
      "addressLine3": "PIN: 123456",
    }
  ].obs;
}

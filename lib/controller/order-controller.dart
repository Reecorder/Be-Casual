
import 'dart:convert';
import 'dart:developer';
import 'package:be_casual_new2/model/order_model.dart';
import 'package:be_casual_new2/presentation/order/order.screen.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList<OrderModel> ordermodel = <OrderModel>[].obs;
  RxBool orderidLoader = false.obs;
  RxBool ordercreateLoader = false.obs;
  void orderIdfind() async {
    orderidLoader.value = true;
    String endpoint = Endpoints.orderidFind;
    try {
      // final response =
      //     await APIClient(endpoint).get(id: "6800b2711b63bdaaa8149486");
      final response =
          await APIClient(endpoint).get(id: await getCookie(key: 'userId'));
      log("API order Response: ${response!.data}");
      final id = await getCookie(key: 'userId');
      log(id.toString());
      if (response.data != null && response.data['data'] != null) {
        final List<dynamic> orderList = response.data['data'];

        final List<OrderModel> fetchedOrders = orderList
            .map((order) => OrderModel.fromJson(order as Map<String, dynamic>))
            .toList();

        ordermodel.assignAll(fetchedOrders);
        log("Order count: ${ordermodel.length}");
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?["message"] ?? "Something went wrong";
      Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    orderidLoader.value = false;
  }

  void cartsCreate() async {
    ordercreateLoader.value = true;
    String endpoint = Endpoints.createorder;
    final requestData = {
      // "user": await getCookie(key: 'userId'),
      // "cart": ordermodel.first.id,
      // "address": ordermodel.first.address!.id,
      // "totalAmount": ordermodel.first.totalAmount,
      // "paymentMethod": ordermodel.first.paymentMethod,
      // "status": ordermodel.first.status,
      "user": await getCookie(key: 'userId'),
      "cart": "67f8d2a4aa30d2909c022d63",
      "address": "6800b5161b63bdaaa814948c",
      "totalAmount": 3999,
      "paymentMethod": "cod",
      "status": "completed"
    };

    log("Order Create Request Data: $requestData");

    try {
      final response = await APIClient(endpoint).post(jsonEncode(requestData));

      if (response != null) {
        log("Response: ${response.data}");

        final user = response.data["data"];
        // log("User: ${user}");
        if (user != null) {
          Get.snackbar("Success", "Order placed successfully!",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.shade100,
              colorText: Colors.white);
              Get.to(OrderScreen(fromTab:true));
        } else {
          Get.snackbar("Error", "data not found",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Error", response?.data["message"] ?? "failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?["message"] ?? "Invalid";

      Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);

      log("Dio Error: $errorMessage");
    }

    ordercreateLoader.value = false;
  }
}

import 'dart:developer';
import 'package:be_casual_new2/model/fetch-cart-model.dart';
import 'package:be_casual_new2/presentation/product/cart/cart.screen.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxBool fetchcartLoading = false.obs;

  RxList<FetchCartModel> fetchcart = <FetchCartModel>[].obs;

// void fetchCart() async {
//   fetchcartLoading.value = true;
//   String endpoint = Endpoints.findcartuser;
//   try {
//     final response = await APIClient(endpoint).get(
//       id: await getCookie(key: 'userId')

//       );
//     log("API Response: ${response!.data}");

//     if (response.data != null &&
//         response.data['data'] != null &&
//         response.data['data']['items'] != null) {

//       final List fetchCartList = response.data['data']['items'];
//       fetchcart.value =
//           fetchCartList.map((json) => FetchCartModel.fromJson(json)).toList();
//       fetchcart.refresh();

//       log("fetch Cart Count: ${fetchcart.length}");

//     }
//   } on DioException catch (e) {
//     final errorMessage =
//         e.response?.data?["message"] ?? "Something went wrong";
//     Get.snackbar("Error", errorMessage,
//         backgroundColor: Colors.red, colorText: Colors.white);
//   }
//   fetchcartLoading.value = false;
// }
  void fetchCart() async {
    fetchcartLoading.value = true;
    fetchcart.clear();
    String endpoint = Endpoints.findcartuser;

    try {
      final response = await APIClient(endpoint).get(
        id: await getCookie(key: 'userId'),
      );
      log("API Response: ${response!.data}");

      if (response.data != null && response.data['data'] != null) {
        // Just one cart object returned by API
        final singleCartData = FetchCartModel.fromJson(response.data['data']);

        // Clear previous and add only this single cart to the list
        fetchcart.value = [singleCartData];
        fetchcart.refresh();

        log("Fetched Cart Data: $fetchcart");

        if (fetchcart.isNotEmpty && fetchcart[0].items!.isNotEmpty) {
          // Get.to(() => FetchCartScreen());
               Get.to(() => const CartScreen(fromTab: true,));
        } else {
          Get.snackbar("Cart is empty", "Your cart has no items",
              backgroundColor: Colors.yellow);
        }
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?["message"] ?? "Something went wrong";
      Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    fetchcartLoading.value = false;
  }

}


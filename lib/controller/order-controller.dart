import 'dart:developer';
import 'package:be_casual_new2/model/order_model.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:be_casual_new2/controller/cart.controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final cartController = Get.find<CartController>();
  RxList<OrderModel> ordermodel = <OrderModel>[].obs;
  RxBool orderidLoader = false.obs;
  RxBool ordercreateLoader = false.obs;
  void orderIdfind() async {
    orderidLoader.value = true;
    String endpoint = Endpoints.orderidFind;
    try {
      // final response =
      //     await APIClient(endpoint).get(id: "6800b2711b63bdaaa8149486");
      final response = await APIClient(
        endpoint,
      ).get(id: await getCookie(key: 'userId'));
      log("API order Response: ${response!.data}");
      final id = await getCookie(key: 'userId');
      log(id.toString());
      if (response.data != null && response.data['data'] != null) {
        final List<dynamic> orderList = response.data['data'];

        final List<OrderModel> fetchedOrders =
            orderList
                .map(
                  (order) => OrderModel.fromJson(order as Map<String, dynamic>),
                )
                .toList();

        // Merge fetched orders with any existing local orders (do not drop local-only orders)
        if (fetchedOrders.isNotEmpty) {
          // Build a map of fetched by orderId (or id) to avoid duplicates
          final fetchedIds =
              <String?>{}..addAll(fetchedOrders.map((o) => o.orderId ?? o.id));

          // Start with fetched orders
          final merged = <OrderModel>[]..addAll(fetchedOrders);

          // Add local orders that are not present in fetched results
          for (final local in ordermodel) {
            final localId = local.orderId ?? local.id;
            if (!fetchedIds.contains(localId)) {
              merged.add(local);
            }
          }

          ordermodel.assignAll(merged);
        } else {
          // fetched list empty: keep any existing local orders (do not clear)
          log(
            'Fetched orders empty; preserving local orders (${ordermodel.length})',
          );
        }

        log("Order count: ${ordermodel.length}");
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?["message"] ?? "Something went wrong";
      Get.snackbar(
        "Error",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    orderidLoader.value = false;
  }

  void cartsCreate() async {
    // Deprecated: use createOrder with parameters. Keep for backward compatibility.
    return;
  }

  /// Create order via API and add created order to [ordermodel].
  /// Returns the created OrderModel on success, or null on failure.
  Future<OrderModel?> createOrder({
    required String userId,
    required String cartId,
    required String addressId,
    required int totalAmount,
    required String paymentMethod,
    String status = 'completed',
  }) async {
    ordercreateLoader.value = true;
    String endpoint = Endpoints.createorder;

    final requestData = {
      "user": userId,
      "cart": cartId,
      "address": addressId,
      "totalAmount": totalAmount,
      "paymentMethod": paymentMethod,
      "status": status,
    };
    log("message==>$requestData");
    try {
      // Pass the request map directly so Dio handles JSON serialization
      final response = await APIClient(endpoint).post(requestData);
      log(
        'Order Create Raw Response: ${response?.data.toString() ?? 'null'} (type: ${response?.data.runtimeType})',
      );
      if (response != null &&
          response.data != null &&
          response.data['data'] != null) {
        final createdJson = response.data['data'] as Map<String, dynamic>;
        final createdOrder = OrderModel.fromJson(createdJson);

        // Insert at top and refresh observers
        ordermodel.insert(0, createdOrder);
        ordermodel.refresh();

        // Clear the cart after successful order
        await cartController.clearCart();

        // Show success message
        Get.snackbar(
          "Success",
          "Order placed successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
        );

        ordercreateLoader.value = false;
        return createdOrder;
      } else {
        final err = response?.data?['message'] ?? 'Failed to create order';
        Get.snackbar(
          "Error",
          err,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?["message"] ?? "Invalid";
      Get.snackbar(
        "Error",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      log("Dio Error: $errorMessage");
    } catch (e) {
      Get.snackbar(
        "Error",
        "Unexpected error",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    ordercreateLoader.value = false;
    return null;
  }
}

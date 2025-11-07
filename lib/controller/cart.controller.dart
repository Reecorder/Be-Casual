import 'dart:developer';
import 'package:be_casual_new2/model/fetch-cart-model.dart';
import 'package:be_casual_new2/model/products.dart';
import 'package:be_casual_new2/presentation/product/cart/cart.screen.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:be_casual_new2/controller/product.controller.dart';
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
  // Local cart data
  RxMap<String, int> productQuantities = <String, int>{}.obs;
  RxDouble totalAmount = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Sync with ProductController's cart on initialization
    try {
      final productController = Get.find<ProductController>();
      productController.cartProducts.forEach((id, product) {
        if (!productQuantities.containsKey(id)) {
          productQuantities[id] = productController.productCounts[id] ?? 1;
        }
      });
      updateTotalAmount();
    } catch (e) {
      print('Error syncing with ProductController: $e');
    }
  }

  void addToCart(String productId, double price) {
    try {
      productQuantities[productId] = (productQuantities[productId] ?? 0) + 1;
      updateTotalAmount();

      print(
        'Added to cart: $productId, Quantities: ${productQuantities.toString()}',
      );
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  void removeFromCart(String productId, double price) {
    try {
      if (productQuantities.containsKey(productId)) {
        if (productQuantities[productId]! > 1) {
          productQuantities[productId] = productQuantities[productId]! - 1;
        } else {
          productQuantities.remove(productId);
        }
        updateTotalAmount();
      }
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  /// Clears the cart after successful order placement
  Future<void> clearCart() async {
    try {
      // Clear local cart data
      productQuantities.clear();
      totalAmount.value = 0;
      fetchcart.clear();
      
      // Clear product controller cart data
      final productController = Get.find<ProductController>();
      productController.cartProducts.clear();
      productController.productCounts.clear();
      
      // Refresh UI
      update();
      productController.update();
    } catch (e) {
      log('Error clearing cart: $e');
    }
  }

  void updateTotalAmount() {
    try {
      double total = 0;
      final productController = Get.find<ProductController>();

      productQuantities.forEach((productId, quantity) {
        final product = productController.products.firstWhere(
          (p) => p.id == productId,
          orElse: () => throw Exception('Product not found'),
        );

        // Convert int to double if needed
        final price =
            (product.discountedPrice ?? product.originalPrice ?? 0).toDouble();
        total += price * quantity;
      });

      totalAmount.value = total;
    } catch (e) {
      print('Error updating total amount: $e');
      totalAmount.value = 0;
    }
  }

  Future<void> fetchCart({bool navigateToCart = true}) async {
    fetchcartLoading.value = true;
    fetchcart.clear();
    String endpoint = Endpoints.findcartuser;

    try {
      final response = await APIClient(
        endpoint,
      ).get(id: await getCookie(key: 'userId'));
      log("API Response: ${response!.data}");

      if (response.data != null && response.data['data'] != null) {
        // Just one cart object returned by API
        final singleCartData = FetchCartModel.fromJson(response.data['data']);

        // Clear previous and add only this single cart to the list
        fetchcart.value = [singleCartData];
        fetchcart.refresh();

        log("Fetched Cart Data: $fetchcart");

        if (fetchcart.isNotEmpty && fetchcart[0].items!.isNotEmpty) {
          if (navigateToCart) {
            // Schedule navigation after the current frame to avoid build errors
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.to(() => const CartScreen(fromTab: true));
            });
          }
        } else {
          if (navigateToCart) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.snackbar(
                "Cart is empty",
                "Your cart has no items",
                backgroundColor: Colors.yellow,
              );
            });
          }
        }
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
    fetchcartLoading.value = false;
  }

  /// Create a cart on the server from current local cart items.
  /// Returns created cart id on success, null on failure.
  Future<String?> createCart() async {
    fetchcartLoading.value = true;
    try {
      final productController = Get.find<ProductController>();
      final userId = await getCookie(key: 'userId');

      final items = <Map<String, dynamic>>[];
      int totalQty = 0;
      int totalPrice = 0;

      productQuantities.forEach((productId, qty) {
        ProductsModel? product;
        try {
          product = productController.products.firstWhere(
            (p) => p.id == productId,
          );
        } catch (_) {
          product = null;
        }
        final price =
            product != null
                ? ((product.discountedPrice ?? product.originalPrice ?? 0)
                    .toInt())
                : 0;
        final selectedSize =
            productController.selectedSizes[productId] ??
            (product != null && product.size != null && product.size!.isNotEmpty
                ? product.size!.first
                : '');

        items.add({
          'product': productId,
          'qty': qty,
          'price': price,
          'selectedSize': selectedSize,
        });

        totalQty += qty;
        totalPrice += price * qty;
      });

      final requestData = {
        'user': userId ?? '',
        'items': items,
        'totalPrice': totalPrice,
        'totalQty': totalQty,
      };
      log("Cart Create Request Data: $requestData");
      // Pass the request map directly so Dio serializes it as JSON.
      final response = await APIClient(Endpoints.cartCreate).post(requestData);
      log(
        'Cart Create Raw Response: ${response?.data} (type: ${response?.data.runtimeType})',
      );
      if (response != null && response.data != null) {
        final respData = response.data;
        // If the entire response is a String, treat it as the cart id and return immediately
        if (respData is String) {
          log('Cart Create returned String (cart id): $respData');
          fetchcartLoading.value = false;
          return respData;
        }
        if (respData is Map<String, dynamic> && respData['data'] != null) {
          final data = respData['data'];
          if (data is Map<String, dynamic>) {
            final created = FetchCartModel.fromJson(data);
            fetchcart.value = [created];
            fetchcart.refresh();
            fetchcartLoading.value = false;
            return created.id;
          } else if (data is String) {
            // API returned just the cart id in the 'data' field
            final cartId = data;
            try {
              final userResp = await APIClient(
                Endpoints.findcartuser,
              ).get(id: await getCookie(key: 'userId'));
              if (userResp != null &&
                  userResp.data != null &&
                  userResp.data['data'] != null) {
                final fetched = FetchCartModel.fromJson(userResp.data['data']);
                fetchcart.value = [fetched];
                fetchcart.refresh();
              }
            } catch (_) {
              // ignore fetch failure; still return id
            }
            fetchcartLoading.value = false;
            return cartId;
          } else {
            // Unknown shape - show message
            final err =
                'Unexpected response shape from cart create (data field)';
            Get.snackbar(
              'Error',
              err,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } else {
          // Unknown shape - show message
          final err = 'Unexpected response shape from cart create (root)';
          Get.snackbar(
            'Error',
            err,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        final err = response?.data?['message'] ?? 'Failed to create cart';
        Get.snackbar(
          'Error',
          err,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } on DioException catch (e) {
      final err = e.response?.data?['message'] ?? 'Something went wrong';
      Get.snackbar(
        'Error',
        err,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unexpected error while creating cart',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      log('createCart error: $e');
    }
    fetchcartLoading.value = false;
    return null;
  }
}

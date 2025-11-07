import 'dart:async';
import 'dart:developer';
import 'package:be_casual_new2/model/products.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/cookie_services.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:be_casual_new2/controller/cart.controller.dart';

class ProductController extends GetxController {
  final reviewController = TextEditingController();

  RxBool productLoading = false.obs;
  RxInt count = 0.obs;
  RxString selectedId = "".obs;
  RxMap<String, int> productCounts = <String, int>{}.obs;

  var selectedAction = ''.obs;

  void selectAction(String action) {
    selectedAction.value = action;
  }

  // In ProductController
  RxMap<String, String> selectedSizes = <String, String>{}.obs;
  void selectSizeForProduct(String productId, String size) {
    selectedSizes[productId] = size;
  }

  // -------------------
  // This is where we store products added to the cart with their quantities
  RxMap<String, ProductsModel> cartProducts = <String, ProductsModel>{}.obs;

  void addToCart(ProductsModel product) {
    // Ensure there's at least 1 quantity when adding to cart
    final pid = product.id ?? '';
    if (productCounts[pid] == null || productCounts[pid] == 0) {
      productCounts[pid] = 1;
    }

    // Ensure selected size exists: if not selected, pick the first available size (if any)
    final currentSize = selectedSizes[pid] ?? '';
    if (currentSize.isEmpty) {
      final fallbackSize =
          product.size != null && product.size!.isNotEmpty
              ? product.size!.first
              : '';
      selectedSizes[pid] = fallbackSize;
    }

    if ((productCounts[pid] ?? 0) > 0) {
      // Ensure the product id is non-nullable when using it as a key in the map
      cartProducts[pid] =
          product; // Fallback to a default key if product.id is null
    } else {
      cartProducts.remove(pid);
    }
  }

  void incrementCount(String productId) {
    // Increment the count first
    productCounts[productId] = (productCounts[productId] ?? 0) + 1;

    // Then, fetch the product (e.g. from the product list or controller) to pass to addToCart
    final product = products.firstWhere((product) => product.id == productId);
    addToCart(
      product,
    ); // Now we're passing the product object instead of the count
    // Sync with CartController quantities
    try {
      final cartController = Get.find<CartController>();
      cartController.productQuantities[productId] = productCounts[productId]!;
      cartController.updateTotalAmount();
      // Also sync to server cart (fire-and-forget). This will create/update the server cart.
      unawaited(cartController.createCart());
    } catch (e) {
      // CartController may not be initialized in some contexts; ignore if not found
      // print('CartController not found to sync counts: $e');
    }
  }

  void decrementCount(String productId) {
    if ((productCounts[productId] ?? 0) > 0) {
      productCounts[productId] = productCounts[productId]! - 1;

      // Fetch the product to pass to addToCart
      final product = products.firstWhere((product) => product.id == productId);
      addToCart(product); // Pass the actual product object
      // Sync with CartController quantities
      try {
        final cartController = Get.find<CartController>();
        if ((productCounts[productId] ?? 0) > 0) {
          cartController.productQuantities[productId] =
              productCounts[productId]!;
        } else {
          cartController.productQuantities.remove(productId);
        }
        cartController.updateTotalAmount();
        // Update server cart as well
        unawaited(cartController.createCart());
      } catch (e) {
        // ignore if cart controller not present
      }
    }
  }

  var wishlist = <String, bool>{}.obs;

  void toggleWishlist(String productId) {
    wishlist[productId] = !(wishlist[productId] ?? false);
  }

  RxBool productsidfindLoading = false.obs;
  RxBool allproductsfindLoading = false.obs;
  // Create observable instance of ProductsModel
  RxList<ProductsModel> products = <ProductsModel>[].obs;
  RxBool cartscreateLoading = false.obs;

  void cartsCreate() async {
    // cartscreateLoading.value = true;
    // String endpoint = Endpoints.cartCreate;

    // final requestData = {
    //   "user": await getCookie(key: "userId"),
    //   "items": [
    //     {
    //       "product": products.first.id,
    //       // "qty": 2,
    //       "qty": productCounts[products.first.id] ?? 1,
    //       "price": products.first.originalPrice,
    //       // "selectedSize": products.first.size![selectSizeForProduct.value]
    //         "selectedSize": selectedSizes[products.first.id] ?? "",
    //         //  "selectedSize":selectedIndex.value
    //     }
    //   ]
    // };

    // log("Cart Create Request Data: $requestData");
    cartscreateLoading.value = true;
    String endpoint = Endpoints.cartCreate;

    final cartItems =
        cartProducts.values.map((product) {
          final productId = product.id ?? "";
          return {
            "product": productId,
            "qty": productCounts[productId] ?? 1,
            "price": product.originalPrice,
            "selectedSize": selectedSizes[productId] ?? "",
          };
        }).toList();

    final requestData = {
      "user": await getCookie(key: "userId"),
      "items": cartItems,
    };

    log("Cart Create Request Data: $requestData");
    try {
      // Pass the request map directly to APIClient/Dio so it can serialize JSON.
      final response = await APIClient(endpoint).post(requestData);
      if (response != null) {
        log(" Response: ${response.data}");
        final item = response.data["data"]["items"];
        log("items: ${item}");
        if (item != null) {
          // Show success message
          Get.snackbar(
            "Success",
            "cart create!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // Get.to(() =>  CartScreen(
          // ));
        } else {
          Get.snackbar(
            "Error",
            "items not found",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          response?.data["message"] ?? "failed",
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
    }

    cartscreateLoading.value = false;
  }

  void productsIdfind() async {
    productsidfindLoading.value = true;
    String endpoint = Endpoints.products;
    try {
      products.clear();
      products.refresh();
      final response = await APIClient(endpoint).get(id: selectedId.value);
      // log("API Response: ${response!.data}");

      if (response!.data != null && response.data['data'] != null) {
        final List productsList = response.data['data'];
        final List<ProductsModel> fetchedProducts =
            productsList.map((json) => ProductsModel.fromJson(json)).toList();
        products.assignAll(fetchedProducts);
        // products.clear();
        // products.value =
        //     productsList.map((json) => ProductsModel.fromJson(json)).toList();
        //     // products.clear();
        // // products.refresh();
        if (fetchedProducts.isEmpty) {
          Get.snackbar(
            "No Products Found",
            "This category does not contain any products.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 5),
          );
        }

        log("Parsed products Count: ${products.length}");
        // log("First products Name: '${products.first.name}'");
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
    productsidfindLoading.value = false;
  }

  void allproductsfind() async {
    allproductsfindLoading.value = true;
    String endpoint = Endpoints.products;

    try {
      products.clear();
      products.refresh();
      final response = await APIClient(endpoint).get();

      if (response?.data != null && response!.data['data'] != null) {
        final List productsList = response.data['data'];

        if (productsList.isNotEmpty) {
          final List<ProductsModel> fetchedProducts =
              productsList.map((json) => ProductsModel.fromJson(json)).toList();

          products.assignAll(fetchedProducts);

          log("Parsed products Count: ${products.length}");
          log("First products Name: '${products.first.name}'");
        } else {
          log("No products found in allproductsfind");
          products.clear(); // Set it to empty list
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

    allproductsfindLoading.value = false;
  }
}

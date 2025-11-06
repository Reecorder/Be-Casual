import 'dart:developer';

import 'package:be_casual_new2/model/brands.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandsController extends GetxController {
  RxBool brandsLoading = false.obs;
  // Create observable instance of brandsmodel
  RxList<BrandsModel> brands = <BrandsModel>[].obs;
  RxString selectedId = "".obs;
  void brandsfind() async {
    brandsLoading.value = true;
    String endpoint = Endpoints.brands;
    try {
      brands.clear();
      brands.refresh();
      final response = await APIClient(endpoint).get(id: selectedId.value);
      log("API Response: ${response!.data}");

      if (response.data != null && response.data['data'] != null) {
        //   final List brandsList = response.data['data'];
        //   brands.value = brandsList.map((json) => BrandsModel.fromJson(json)).toList();
        final List brandsList = response.data['data'];

        final List<BrandsModel> fetchedProducts =
            brandsList.map((json) => BrandsModel.fromJson(json)).toList();

        brands.assignAll(fetchedProducts);
        log("Parsed brands Count: ${brands.length}");
        log("First brands Name: '${brands.first.name}'");
        log("First brands url: '${brands.first.logo!.first.url}'");
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?["message"] ?? "Something went wrong";
      Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    brandsLoading.value = false;
  }

  //     if (response!.data != null && response.data['data'] != null) {
  //       final List productsList = response.data['data'];
  //       // products.value =
  //       //     productsList.map((json) => ProductsModel.fromJson(json)).toList();
  //       //     // products.clear();
  //       // // products.refresh();

  //       log("Parsed products Count: ${products.length}");
  //       log("First products Name: '${products.first.name}'");
  //     }
  //   } on DioException catch (e) {
  //     final errorMessage =
  //         e.response?.data?["message"] ?? "Something went wrong";
  //     Get.snackbar("Error", errorMessage,
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }

  //   productsfindLoading.value = false;
  // }
}

import 'dart:developer';

import 'package:be_casual_new2/model/category.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/endpoints.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxBool categoryLoading = false.obs;
 
  // Create observable instance of categoryModel
  RxList<CategoryItem> categories = <CategoryItem>[].obs;

  void categoryfind() async {
    categoryLoading.value = true;
    String endpoint = Endpoints.category;
    try {
      final response = await APIClient(endpoint).get();
      log("API Response: ${response!.data}");

      if (response.data != null && response.data['data'] != null) {
        final List categoryList = response.data['data'];
        categories.value =
            categoryList.map((json) => CategoryItem.fromJson(json)).toList();
        categories.refresh();

        log("Parsed Category Count: ${categories.length}");
        log("First Category Name: '${categories.first.name}'");
      }
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?["message"] ?? "Something went wrong";
      Get.snackbar("Error", errorMessage,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    categoryLoading.value = false;
  }

}

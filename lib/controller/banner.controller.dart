import 'dart:developer';

import 'package:be_casual_new2/model/banner.model.dart';
import 'package:be_casual_new2/services/api.service.dart';
import 'package:be_casual_new2/services/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{

RxBool bannerLoading = false.obs;
RxList<String> banners = <String>[].obs;

void bannerfind() async {
  bannerLoading.value = true;
  String endpoint = Endpoints.banner;
  try {
    final response = await APIClient(endpoint).get();
    log("API Response: ${response!.data}");

    if (response.data != null && response.data['data'] != null) {
      final BannerModel bannerModel = BannerModel.fromJson(response.data);
      banners.value = bannerModel.data ?? [];
      banners.refresh();

      log("Parsed banners Count: ${banners.length}");
      if (banners.isNotEmpty) {
        log("First banner URL: '${banners.first}'");
      }
    }
  } on DioException catch (e) {
    final errorMessage = e.response?.data?["message"] ?? "Something went wrong";
    Get.snackbar("Error", errorMessage,
        backgroundColor: Colors.red, colorText: Colors.white);
  }
  bannerLoading.value = false;
}

}
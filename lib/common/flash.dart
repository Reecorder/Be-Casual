import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashMessage {
  static show(String message) => ScaffoldMessenger.of(Get.context!)
      .showSnackBar(SnackBar(content: Text(message)));
}

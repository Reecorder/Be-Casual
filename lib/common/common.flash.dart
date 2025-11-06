import 'package:be_casual_new2/model/color.model.dart';
import 'package:be_casual_new2/model/fonts.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashMessage {
  static show(String string, 
          {required String title,
          bool isSuccess = false,
          bool isError = false,
          String? message}) =>
      Get.snackbar(title, message ?? "",
          isDismissible: true,
          duration: const Duration(seconds: 5),
          // Showing customised title text
          titleText: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: Fonts.medium,
                  color: isSuccess
                      ? Colors.green
                      : isError
                          ? Colors.red
                          : AppColors.primary)),
          // Showing customised message text
          messageText: message == null
              ? const SizedBox()
              : Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: Fonts.regular,
                      color: Colors.black)));
}
